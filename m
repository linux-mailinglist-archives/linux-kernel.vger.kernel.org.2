Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D613BE423
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhGGIPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:15:04 -0400
Received: from verein.lst.de ([213.95.11.211]:35995 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhGGIPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:15:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A9E468BEB; Wed,  7 Jul 2021 10:12:20 +0200 (CEST)
Date:   Wed, 7 Jul 2021 10:12:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [ide] b7fb14d3ac: EIP:ioread32_rep
Message-ID: <20210707081220.GA31179@lst.de>
References: <20210704150025.GC21572@xsang-OptiPlex-9020> <20210705125756.GA25141@lst.de> <CAHk-=wj_Gfqkdp+K3iCiqMjAZQK_BrRWDs2eOS_BAw=bB=CdRw@mail.gmail.com> <20210706143647.GA28289@lst.de> <CAHk-=wgPyx7tHFNaO2N6bsaB_E6gL+t1uDAmrD91jJw+hiTvrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPyx7tHFNaO2N6bsaB_E6gL+t1uDAmrD91jJw+hiTvrQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 12:08:42PM -0700, Linus Torvalds wrote:
> On Tue, Jul 6, 2021 at 7:36 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Yeah, there's usually a huge offset into the page.  The otherwise
> > similar ATAPI code actually has checks to chunk it up and not cross
> > page boundaries, and copying that over fixes the problem.
> 
> Ok.
> 
> Your patch made me go "I think it should loop until it has transferred
> the full 512 bytes", but maybe the caller loops properly?

Yes, the callers (ata_read_pio_sectors) does).

> Because I'm looking at ata_sff_data_xfer32(), and I think it
> fundamentally would fail the "retry after partial 4-byte transfer".
> 
> Let's imagine that "offset" is 511 bytes off the end of the page, and
> so you'd first do a 511-byte transfer, and then a 1-byte transfer.
> 
> That's not how ata_sff_data_xfer32() works. It would actually first do
> a 508-byte transfer (using that "rep insl" to do 4 bytes at a time),
> and then it would do a 4-byte transfer into a temporary buffer, and
> copy the first three bytes to fill out the 511 bytes in the first
> page.
> 
> If you then loop back to do the last byte, it would do another 4-byte
> transfer into a temporary buffer, and copy the remaining byte - ending
> up with 512 bytes result as asked for.
> 
> Except they wouldn't be the *RIGHT* 512 bytes. It would have done 516
> bytes worth of "inl", and from those 516 bytes it would have filled
> the last 4 bytes with basically random garbage (ok, the first three
> bytes would be ok, but the last byte would not be).
> 
> So I think that ap->ops->sff_data_xfer fundamentally cannot handle a
> page crosser correctly - at least not if it's not 4-byte aligned.
> 
> How does IO to a non-sector-aligned buffer eevr happen? Because I
> think that's broken, and your patch is only hiding further bugs.

Note that in this case this is not an I/O command, but an internal
command.  Either way libata allows the buffers to be dword (4 byte)
aligned, and in this case the internal users relies on that.  Userspace
passthrough could also reproduce this limited alignment.
