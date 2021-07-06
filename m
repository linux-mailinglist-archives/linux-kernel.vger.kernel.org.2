Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B119B3BD860
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhGFOja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:39:30 -0400
Received: from verein.lst.de ([213.95.11.211]:33815 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232452AbhGFOj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:39:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2B0668BFE; Tue,  6 Jul 2021 16:36:47 +0200 (CEST)
Date:   Tue, 6 Jul 2021 16:36:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [ide] b7fb14d3ac: EIP:ioread32_rep
Message-ID: <20210706143647.GA28289@lst.de>
References: <20210704150025.GC21572@xsang-OptiPlex-9020> <20210705125756.GA25141@lst.de> <CAHk-=wj_Gfqkdp+K3iCiqMjAZQK_BrRWDs2eOS_BAw=bB=CdRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_Gfqkdp+K3iCiqMjAZQK_BrRWDs2eOS_BAw=bB=CdRw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 01:00:09PM -0700, Linus Torvalds wrote:
> It might perhaps be worth adding some kind of
> 
>      WARN_ON_ONCE(offset & 511);
> 
> in the callchain somewhere for that ata_queued_cmd(). But at that
> point I no longer know the code.

Yeah, there's usually a huge offset into the page.  The otherwise
similar ATAPI code actually has checks to chunk it up and not cross
page boundaries, and copying that over fixes the problem.  The testbot
config then crashes in an infiband driver, but disabling that driver
entirely makes it boot fine:

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index ae7189d1a568..018f021c45a3 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -651,7 +651,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct ata_port *ap = qc->ap;
 	struct page *page;
-	unsigned int offset;
+	unsigned int offset, count;
 	unsigned char *buf;
 
 	if (!qc->cursg) {
@@ -670,16 +670,22 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
+	/* don't overrun current sg */
+	count = min(qc->cursg->length - qc->cursg_ofs, qc->sect_size);
+
+	/* don't cross page boundaries */
+	count = min(count, (unsigned int)PAGE_SIZE - offset);
+
 	/* do the actual data transfer */
 	buf = kmap_atomic(page);
-	ap->ops->sff_data_xfer(qc, buf + offset, qc->sect_size, do_write);
+	ap->ops->sff_data_xfer(qc, buf + offset, count, do_write);
 	kunmap_atomic(buf);
 
 	if (!do_write && !PageSlab(page))
 		flush_dcache_page(page);
 
-	qc->curbytes += qc->sect_size;
-	qc->cursg_ofs += qc->sect_size;
+	qc->curbytes += count;
+	qc->cursg_ofs += count;
 
 	if (qc->cursg_ofs == qc->cursg->length) {
 		qc->cursg = sg_next(qc->cursg);
