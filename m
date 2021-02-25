Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5D324CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhBYJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbhBYJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:32:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFE9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:31:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i7so4597612wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jt3f5PSlfrfTzXBF41UxrdtI2y14FBGpZCcDyrQYVAQ=;
        b=IJpfGrK76fzW8EuyG7kHKBBEOgSacm7oP/+ohWVEy/DRpR9XmJ7DztCKbGz3bs16j/
         LmzE4BneSaQhfntz+XQDv7xuEpRB/ocVUFeSUr1HcqVrxHDztSzLBFQJ9STxV8fXojwP
         sZlEfAyJWr50BFmOjPfoUkzSvqWyqvdiZiq6hiU8cpxcUW8jUVY6LjEaUvO9z/pBalUS
         FwOw9pnemFoEwJ8cp0nBAo9NAZMAZyNmtcj5OCV88S2LogMA4u89tT838zhsWBKT1prW
         PwRj8pkmw63oC9LvMrSBcarmN+oQBZ7AOeuLuoriwoTc7RT/VmcxqKOqag6F54oi7+iA
         MHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jt3f5PSlfrfTzXBF41UxrdtI2y14FBGpZCcDyrQYVAQ=;
        b=fBvdBTq94cMgTTaO4QEQMBtVgJoVPrircaHrKCc5OfAoU7VTUz7+VWWmH3wZl8pjAL
         SrbQZ1peMuLzYWVmBtzPcIaTVvY5p1AhNuPcaVoqNTGGcOGvnQ0mLHF0HvjIeZJPzacY
         BNchj297ra8jd9gsSbnibKw37wFjLIM8zyJr6w2a/lUFDm30gFx+zX6MezKDKDD6vPDg
         mFwbUcTXAHOxh8qLBIFgMzwab4Jeqi/s1CbJv1uCSrw3oV61S/Kswjb56RwmIXxtxbft
         6MW0BfeAMg0Ehl6LS97DSysSU2qEqFDNc7Xp84cChlp7BfKAIF2bV4PI3Ckx34iKMi+Y
         CMZQ==
X-Gm-Message-State: AOAM533Vav7+81HCtzJi+3K0dHxoOLPsPi+zn+1TXzAqbExKy9WH1p2d
        44cogunHxlKnBonY2RXRu6XPkoqd4Zgx9A==
X-Google-Smtp-Source: ABdhPJzJQp196fp6wfS00p90fvdltaQfTdWBcGPO3FoxTye4Rn/aqAvEgwqNBu2PcIBYkoZs7ADGYQ==
X-Received: by 2002:a1c:a7d3:: with SMTP id q202mr2290120wme.93.1614245482639;
        Thu, 25 Feb 2021 01:31:22 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w13sm7724031wrt.49.2021.02.25.01.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 01:31:22 -0800 (PST)
Date:   Thu, 25 Feb 2021 09:31:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashal@kernel.org, tglx@linutronix.de,
        wangle6@huawei.com, zhengyejian1@huawei.com
Subject: Re: [PATCH] futex: fix dead code in attach_to_pi_owner()
Message-ID: <20210225093120.GD641347@dell>
References: <20210222125352.110124-1-nixiaoming@huawei.com>
 <YDdfASEcv7i/DxHF@kroah.com>
 <71a24b9b-2a65-57a1-55bb-95f7ec3287dd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71a24b9b-2a65-57a1-55bb-95f7ec3287dd@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021, Xiaoming Ni wrote:

> On 2021/2/25 16:25, Greg KH wrote:
> > On Mon, Feb 22, 2021 at 08:53:52PM +0800, Xiaoming Ni wrote:
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > The handle_exit_race() function is defined in commit c158b461306df82
> > >   ("futex: Cure exit race"), which never returns -EBUSY. This results
> > > in a small piece of dead code in the attach_to_pi_owner() function:
> > > 
> > > 	int ret = handle_exit_race(uaddr, uval, p); /* Never return -EBUSY */
> > > 	...
> > > 	if (ret == -EBUSY)
> > > 		*exiting = p; /* dead code */
> > > 
> > > The return value -EBUSY is added to handle_exit_race() in upsteam
> > > commit ac31c7ff8624409 ("futex: Provide distinct return value when
> > > owner is exiting"). This commit was incorporated into v4.9.255, before
> > > the function handle_exit_race() was introduced, whitout Modify
> > > handle_exit_race().
> > > 
> > > To fix dead code, extract the change of handle_exit_race() from
> > > commit ac31c7ff8624409 ("futex: Provide distinct return value when owner
> > >   is exiting"), re-incorporated.
> mainline:
> ac31c7ff8624 futex: Provide distinct return value when owner is exiting
> 
> > > 
> > > Fixes: c158b461306df82 ("futex: Cure exit race")
> 
> stable linux-4.9.y
> 9c3f39860367 futex: Cure exit race
> c27f392040e2 futex: Provide distinct return value when owner is exiting
> 
> > > Cc: stable@vger.kernel.org # 4.9.258-rc1
> > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > > ---
> > >   kernel/futex.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > What is the git commit id of this patch in Linus's tree?
> > 
> > Also, what kernel tree(s) is this supposed to go to?
> > 
> > thanks,
> > 
> > greg k-h
> > .
> > 
> Sorry, the commit id c158b461306df82 in the patch does not exist in the
> linux-stable repository.
> The commit ID is from linux-stable-rc.
> 
> I corrected the commit id in a subsequent email, and added a branch label.
> https://lore.kernel.org/lkml/20210224100923.51315-1-nixiaoming@huawei.com/

Replied to the follow-up.

> Sorry, I forgot to use "--in-reply-to=" when I sent the update patch.
> 
> This issue occurs only in the linux-4.9.y branch v4.9.258

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
