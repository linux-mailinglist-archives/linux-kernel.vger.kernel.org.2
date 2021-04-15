Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB2360329
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhDOHUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhDOHUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:20:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07B6C61103;
        Thu, 15 Apr 2021 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618471184;
        bh=6yA3ZP7QlU0O7VefE5uCcyXZQdn2vdNBzoNCgVzhAH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4EGm6D9qx4YMmIfc4mX90pvDkJQaQUxvxPvT3bkLwNI8RS9qrFP1kjaEwRZi8b1u
         GCM3x7sirPfh7DlE/+4N9TyZcBqJGMggr4/TSkeLHQ7J1hJfDfHTBn9OFUQdJxiE18
         R6YDZ8PsnZCtnJY5Npaq9Uf1Xhf66z0TNDxAdahY=
Date:   Thu, 15 Apr 2021 09:19:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Colin King <colin.king@canonical.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Ofir Bitton <obitton@habana.ai>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] habanalabs/gaudi: Fix uninitialized return code rc
 when read size is zero
Message-ID: <YHfpDvLvzwEFT5BT@kroah.com>
References: <20210412161012.1628202-1-colin.king@canonical.com>
 <CAK8P3a2pSRu0OKDNrNJSdviRgcv8Lw1mwZr5opv=UbtHLps2oQ@mail.gmail.com>
 <CAFCwf10S8WhEZtpwD=2AgbgopMahxHofp-yXvsZ4GWkrctPRAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10S8WhEZtpwD=2AgbgopMahxHofp-yXvsZ4GWkrctPRAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 10:08:26AM +0300, Oded Gabbay wrote:
> On Mon, Apr 12, 2021 at 9:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Apr 12, 2021 at 6:11 PM Colin King <colin.king@canonical.com> wrote:
> > >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > In the case where size is zero the while loop never assigns rc and the
> > > return value is uninitialized. Fix this by initializing rc to zero.
> > >
> > > Addresses-Coverity: ("Uninitialized scalar variable")
> > > Fixes: 639781dcab82 ("habanalabs/gaudi: add debugfs to DMA from the device")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> > > index 8730b691ec61..b751652f80a8 100644
> > > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > > @@ -6252,7 +6252,7 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
> > >         dma_addr_t dma_addr;
> > >         void *kernel_addr;
> > >         bool is_eng_idle;
> > > -       int rc, dma_id;
> > > +       int rc = 0, dma_id;
> > >
> > >         kernel_addr = hdev->asic_funcs->asic_dma_alloc_coherent(
> > >                                                 hdev, SZ_2M,
> >
> >
> > In general, I don't like adding initializations during the declaration as that
> > tends to hide warnings for the cases where a later initialization is
> > missing. In this case it looks correct though.
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I don't mind taking this patch for eliminating the warning but fyi,
> the caller function (hl_dma_size_write) checks that the size is not
> zero. If the size is zero, we never reach this function.
> 
> Greg, do you mind applying it directly to your -next branch ? I don't
> have anything pending and I'm too lazy sending a pull request on a
> single patch ;)
> 
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

I can grab it from this thread, thanks!

greg k-h
