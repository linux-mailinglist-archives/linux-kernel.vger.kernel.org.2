Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC07D3E860A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhHJWZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbhHJWZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:25:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90BAC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:24:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j3so23314733plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrhRnlztM32IaZrIGZ9Mi5bnSi+S4AFi7dtGVRZ3+oE=;
        b=lxGFxypI3awP4jFNDHn9zjYNhCggd/GIfQmD8Hl1CdGYU4MNCyFNk9r05maXP8F22G
         HdaczcdSjxSQu4pazGCUjomJ0bST5B9nWtVdqw1Bl4Qx5VxRvquT2As9HgOJsjD626xE
         R1L882FgllHUtXsys4b+sA0gL6I4YGZilh1cXW14V8QPLS0H+JG8J2nF/GTeE0cl0Ht9
         oVad7U14wENl9sBb8SKKAes/kZKHoTxke6i3L+ornLWZ6wmD8NgUq5KrbDG68+aeyPhS
         9+zwpkTfhK6stWLcqmKMdxCIMkHjsvYygE36Bds305cuWqccbqdYlBs7ExOVXEuh9WSK
         wzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrhRnlztM32IaZrIGZ9Mi5bnSi+S4AFi7dtGVRZ3+oE=;
        b=a1FTwI0k4QNoju3qz9ZdG+aa+T6fFIkUtPkeatcRCn+G5SFbyXs9TZaNhyzgNC8FEv
         V1N/6ST+lv4/ik8nCPJQMvWruuXiBFpPKsNu4CdKWX0K/cYc0KKbZU0z/F/Xk2JTg7g9
         DOcE4RaXzeFZnipr7xxRU6Sdh3tu0U37kL/VuenOCibXaitZM21tMEePna9gnFKjnmoD
         092mJ3cRkXK172M30V0JoRlr/v3YQSdPcXSeCR80t4/osXTARZmkrtQT0s00fGg+AFL7
         ueRCCKEto+mnfrtyncWbpP5CaI0SjmOgIWNHFEZYNTYJuuTYu2oPZfINXFzGqFlIfh1c
         5EYQ==
X-Gm-Message-State: AOAM531mxCRVv0R6a+poO+FPwUjgJN4PaDArvwgDytJg32TzeGY+SIij
        o0Lxn2vBb05c+fpVjtqE5sGKtgF3fsXvo01EgV8E6A==
X-Google-Smtp-Source: ABdhPJxYEaa4G0PKpfOtWkOuWJlc/+m01d8/a9mzzT44r+II16GS1SFt58hWCXe5dgu781qx1ubqndrSao0dUKuOrsw=
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr368854pgu.82.1628634280452;
 Tue, 10 Aug 2021 15:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210810074504.957-1-phil@philpotter.co.uk> <CAK8P3a2n6WfsQUKP7W4VytJ6K=CGcfOz-eSc=6FzvkANWkk87A@mail.gmail.com>
 <YRJTgMI5CaG7VdGx@kroah.com>
In-Reply-To: <YRJTgMI5CaG7VdGx@kroah.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 10 Aug 2021 23:24:29 +0100
Message-ID: <CAA=Fs0khyHV4AytW=smDMmKtR2Dv8QazcOBuuNpPfN+Z0nc_AQ@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove rtw_ioctl function
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 at 11:23, gregkh <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 10, 2021 at 10:08:31AM +0200, Arnd Bergmann wrote:
> > On Tue, Aug 10, 2021 at 9:45 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> > > -int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> > > -{
> > > -       struct iwreq *wrq = (struct iwreq *)rq;
> > > -       int ret = 0;
> > > -
> > > -       switch (cmd) {
> > > -       case RTL_IOCTL_WPA_SUPPLICANT:
> > > -               ret = wpa_supplicant_ioctl(dev, &wrq->u.data);
> > > -               break;
> > > -#ifdef CONFIG_88EU_AP_MODE
> > > -       case RTL_IOCTL_HOSTAPD:
> > > -               ret = rtw_hostapd_ioctl(dev, &wrq->u.data);
> > > -               break;
> > > -#endif /*  CONFIG_88EU_AP_MODE */
> > > -       case SIOCDEVPRIVATE:
> > > -               ret = rtw_ioctl_wext_private(dev, &wrq->u);
> > > -               break;
> >
> >
> > I think these functions are all defined 'static' in the same file, so
> > removing the
> > caller will cause a warning about an unused function. Better remove the
> > called functions along with the caller.
>
> I get no build warnings/errors with this patch applied, which is odd.
>
> So I'll take this for now, but a follow-on patch to remove these unused
> functions would be great to have.
>
> thanks,
>
> greg k-h

Dear Greg,

Many thanks, and of course, I shall prepare one now.

Regards,
Phil
