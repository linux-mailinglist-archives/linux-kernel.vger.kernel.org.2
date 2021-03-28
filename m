Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE7E34BC70
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhC1Mvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 08:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhC1MvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 08:51:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D9F36193F;
        Sun, 28 Mar 2021 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616935870;
        bh=5td7gOwGWp/bcwoGdg50qJ48DE8KSZ4XdbEFraiEF0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6LuLT2VVCq7bdaTGV0CIR+srCkG6wA+m3KxeyQHd15VHkUmyh8patc4B7XzuEwMs
         cbEnOg5pw9hxgDkZLLwtmRxFGHznw4lg/aU4I5CCWvvquhVniV6/7mWZKF0vuDxMm1
         1w5kg6wB/OyliO6aPbBpMbK67H6dsnxIANLnPPnw=
Date:   Sun, 28 Mar 2021 14:51:08 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Xu Jia <xujia39@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH -next] applicom: fix some err codes returned by ac_ioctl
Message-ID: <YGB7vKk6dDoWpcKn@kroah.com>
References: <20210324072031.941791-1-xujia39@huawei.com>
 <CAK8P3a2cWFT7BiePJQjYO-_9QjCvWf1mQPE8NEZ4dXgira=iaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2cWFT7BiePJQjYO-_9QjCvWf1mQPE8NEZ4dXgira=iaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 01:03:50PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 24, 2021 at 8:20 AM Xu Jia <xujia39@huawei.com> wrote:
> >
> > When cmd > 6 or copy_to_user() fail, The variable 'ret' would not be
> > returned back. Fix the 'ret' set but not used.
> >
> > Signed-off-by: Xu Jia <xujia39@huawei.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> > diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
> > index 14b2d8034c51..0ab765143354 100644
> > --- a/drivers/char/applicom.c
> > +++ b/drivers/char/applicom.c
> > @@ -839,7 +839,7 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >         Dummy = readb(apbs[IndexCard].RamIO + VERS);
> >         kfree(adgl);
> >         mutex_unlock(&ac_mutex);
> > -       return 0;
> > +       return ret;
> >
> 
> Apparently this has been broken since the driver was first merged in
> linux-2.3.16. I could find no indication of anyone using the driver
> and reporting any problems in the git history and it clearly still has
> the style of drivers writting in the 1990s. On the other hand, this is
> (was) used in some very long-lived systems and you can still
> buy old applicom cards from artisan[1].
> 
> Is there any chance this driver is still used anywhere with modern
> kernels? I suspect we could move it to staging to find out.

No objection from me to move it to staging, want to send a patch or I
can.

thanks,

greg k-h
