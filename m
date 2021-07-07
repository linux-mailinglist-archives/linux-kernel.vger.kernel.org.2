Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40C3BE47F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhGGIiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:38:13 -0400
Received: from verein.lst.de ([213.95.11.211]:36073 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhGGIiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:38:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A40D268BEB; Wed,  7 Jul 2021 10:35:28 +0200 (CEST)
Date:   Wed, 7 Jul 2021 10:35:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [ide] b7fb14d3ac: EIP:ioread32_rep
Message-ID: <20210707083528.GA353@lst.de>
References: <20210704150025.GC21572@xsang-OptiPlex-9020> <20210705125756.GA25141@lst.de> <CAHk-=wj_Gfqkdp+K3iCiqMjAZQK_BrRWDs2eOS_BAw=bB=CdRw@mail.gmail.com> <20210706143647.GA28289@lst.de> <CAHk-=wgPyx7tHFNaO2N6bsaB_E6gL+t1uDAmrD91jJw+hiTvrQ@mail.gmail.com> <20210707081220.GA31179@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707081220.GA31179@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 10:12:20AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 06, 2021 at 12:08:42PM -0700, Linus Torvalds wrote:
> > On Tue, Jul 6, 2021 at 7:36 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Yeah, there's usually a huge offset into the page.  The otherwise
> > > similar ATAPI code actually has checks to chunk it up and not cross
> > > page boundaries, and copying that over fixes the problem.
> > 
> > Ok.
> > 
> > Your patch made me go "I think it should loop until it has transferred
> > the full 512 bytes", but maybe the caller loops properly?
> 
> Yes, the callers (ata_read_pio_sectors) does).

Actually, not it doesn't. Sorry.  So for a non-aligned large request
this won't work.  So we'll need to actually loop here.

This is probably better and fixes the issue as well (and ATAPI
probably needs the same treatment):


diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index ae7189d1a568..40d2dc3b2989 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -637,6 +637,20 @@ unsigned int ata_sff_data_xfer32(struct ata_queued_cmd *qc, unsigned char *buf,
 }
 EXPORT_SYMBOL_GPL(ata_sff_data_xfer32);
 
+static void ata_pio_xfer(struct ata_queued_cmd *qc, struct page *page,
+		unsigned int offset, size_t xfer_size)
+{
+	bool do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	unsigned char *buf;
+
+	buf = kmap_atomic(page);
+	qc->ap->ops->sff_data_xfer(qc, buf + offset, xfer_size, do_write);
+	kunmap_atomic(buf);
+
+	if (!do_write && !PageSlab(page))
+		flush_dcache_page(page);
+}
+
 /**
  *	ata_pio_sector - Transfer a sector of data.
  *	@qc: Command on going
@@ -648,11 +662,9 @@ EXPORT_SYMBOL_GPL(ata_sff_data_xfer32);
  */
 static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
-	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct ata_port *ap = qc->ap;
 	struct page *page;
 	unsigned int offset;
-	unsigned char *buf;
 
 	if (!qc->cursg) {
 		qc->curbytes = qc->nbytes;
@@ -670,13 +682,15 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
-	/* do the actual data transfer */
-	buf = kmap_atomic(page);
-	ap->ops->sff_data_xfer(qc, buf + offset, qc->sect_size, do_write);
-	kunmap_atomic(buf);
+	if (offset + qc->sect_size > PAGE_SIZE) {
+		unsigned int split_len = PAGE_SIZE - offset;
 
-	if (!do_write && !PageSlab(page))
-		flush_dcache_page(page);
+		ata_pio_xfer(qc, page, offset, split_len);
+		ata_pio_xfer(qc, nth_page(page, 1), 0,
+			     qc->sect_size - split_len);
+	} else {
+		ata_pio_xfer(qc, page, offset, qc->sect_size);
+	}
 
 	qc->curbytes += qc->sect_size;
 	qc->cursg_ofs += qc->sect_size;
