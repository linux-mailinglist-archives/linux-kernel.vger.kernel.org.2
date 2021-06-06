Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD20939CE2C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFFItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:49:07 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:41628 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:49:06 -0400
Received: by mail-ej1-f54.google.com with SMTP id ho18so10456554ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvh6MEtvVWMlRewCXrhxu3/PUZtiVlDvYPuCTtfaY8g=;
        b=MoyoSqG508f5ZZdMrDqrIv4nTOOy8hGTiZci9eV5WtN65+mdFvyEvtwGg96r2D12Yo
         BSWQ3mqy+FZT6xUYewMrRfO5sKLUyLJK2YzuUhWnhKau4naipGVNoUYgUQS/cNst8ARZ
         /yMzXxQO60ty7pZLJaoxIxqkcdCKaq0i/XgZQP39OVybgT99juvBoZplBXlKeSgMHw3e
         HrdY3/9KsQSz1qbsDi/xLTvPTlc2rn7nzz5+x9Ly8UUb9OtM0X0Mmn6OdVUrZ3wHBAXq
         FOBQz4UA6XrV5i6Lc92EJklui9gpZN3XgopVwvJSC4OhHC4qyyqVGcvnbLaEHSKtHC3U
         z5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvh6MEtvVWMlRewCXrhxu3/PUZtiVlDvYPuCTtfaY8g=;
        b=CYsaaXOuBsV1ADx3OLvoe8HmupaC08wfh6LMteEE5zeFxVpzFpUy/kMWnO6HQ+8NiU
         ScjpxiG7K8DTrXm4r+ov4hyv4cD8w+DdiSVERLo1cDC9T4pIW/w/Hlfs5NcD8CQoxnMZ
         NjYqthSQNmWyxch+kSNZOxllgBAmIbfZ9xjg+0ZwWWY+qm0PAfa2vRCMmrv25mtVJQeZ
         epS5+FM1wgy9wKovlULZNs0M05QmhwbWKkoFnfZXjJnJZY3eEjrPujV7u5ZWb4vAMTau
         xbSXAPjmAQ8wruvKVTfRgL1f6IBpfm3Jxbdpxl0kZmVvURlKkzzMwtVm7X2IKXJXsq2N
         nW+w==
X-Gm-Message-State: AOAM533sVZr/VYDZua/6RvbaEXnkkuClFssxSkt/isoAMOyWZPejDoiU
        LcOivwI8eNiWXDXMzKC3GPHXnFc3n9qAGA==
X-Google-Smtp-Source: ABdhPJx7IY22Uwds+zWFhKE84x/W9uv4or3bZjOkRn3IvfVAttKz3pPm2AIeJCGC+MRKGVWXq8Zfew==
X-Received: by 2002:a17:906:3016:: with SMTP id 22mr12459078ejz.28.1622969159887;
        Sun, 06 Jun 2021 01:45:59 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id f21sm6101770edr.45.2021.06.06.01.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 01:45:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix uninitialized variable
Date:   Sun, 06 Jun 2021 10:45:58 +0200
Message-ID: <7256195.zb9d8qvCYo@linux.local>
In-Reply-To: <CAKe_nd0fNE=+CP4O0cUtOPO5vRC8_gHxjLtH80r_4GO2MW5u4g@mail.gmail.com>
References: <20210606070021.116284-1-wlooi@ucalgary.ca> <10029109.FgdUXNWx4t@linux.local> <CAKe_nd0fNE=+CP4O0cUtOPO5vRC8_gHxjLtH80r_4GO2MW5u4g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, June 6, 2021 10:09:39 AM CEST Wenli Looi wrote:
> On Sun, Jun 6, 2021 at 1:00 AM Fabio M. De Francesco
> 
> <fmdefrancesco@gmail.com> wrote:
> > On Sunday, June 6, 2021 9:51:35 AM CEST Wenli Looi wrote:
> > > On Sun, Jun 6, 2021 at 12:13 AM Greg Kroah-Hartman
> > > 
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Sun, Jun 06, 2021 at 12:00:21AM -0700, Wenli Looi wrote:
> > > > > Uninitialized struct with invalid pointer causes BUG and prevents 
access
> > > > > point from working. Access point works once I apply this patch.
> > > > > 
> > > > > https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> > > > > has more details.
> > > > > 
> > > > > Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> > > > > ---
> > > > > 
> > > > >  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > > > b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c index 
2fb80b6eb..
> > 
> > 7308e1185
> > 
> > > > > 100644
> > > > > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > > > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > > > @@ -2384,7 +2384,7 @@ void rtw_cfg80211_indicate_sta_assoc(struct
> > 
> > adapter *padapter,
> > 
> > > > > u8 *pmgmt_frame,> >
> > > > > 
> > > > >       DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
> > > > >       
> > > > >       {
> > > > > 
> > > > > -             struct station_info sinfo;
> > > > > +             struct station_info sinfo = {};
> > > > 
> > > > What caused this bug to show up?  Did it happen from some other 
commit?
> > > > 
> > > > Are you sure that all of the fields are being cleared properly here,
> > > > what about any "holes" in the structure?
> > > > 
> > > > thanks,
> > > > greg k-h
[CUT]
> > > 
> > > Do you think kzalloc() would be preferable?
> > 
> > You cannot use kzalloc there: 'sinfo' is instantiated automatically on the
> > stack. The example you took had a pointer to the struct.
> 
> The stack variable could be replaced with code like:
> 
> struct station_info *sinfo;if (!sinfo)
>
Why that "if (!sinfo" before kzalloc?
>
> sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
> ...
> cfg80211_new_sta(..., sinfo, ...);
> kfree(sinfo);
> 
> which is what the linked code basically does. I'm not sure if this is 
preferred?
>
I don't know that code, but I think that:

(1) It is generally preferred that big structures should be allocated 
dinamically: kernel stack is a scarce resource.
(2) Passing address of variables from the stack to other functions is 
generally a good source of troubles.

I think you are closer to the proper solution.

Fabio 
>
> > 
> > > Sorry, I'm not familiar with "holes" in the struct.




