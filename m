Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7B3E9B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhHKX3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbhHKX3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:29:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D7C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:29:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso7649610pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+p/vb8Nh3bZn0qfhOImjTyqVNq1MlM0FRF8GGlBxUc=;
        b=qQWU0Xwu5tF7zhG3txv3x6kiRCSsotxMmRnDbRQVXHCaKlCiWqD10QXUAlMddyU+pk
         xFITmDg4/TAhu0BZVlyWw7e3fX63V7A2035wmSjG/MTqoCcmGMgLwmnZ9Ewt+hk5Urpa
         sD5jkyZvCZ27Dp8HzbQkWYMxWm6rwWmRBOZ8aMC0C+TvniiQ5HSSnyTu1urskro5a5Ar
         42zafCfGhlSf56Hmw8nB5jkdpZ8Vs+v0sDIcvRKtYRp0p975kIYVQ0/phCWZ5BrrpeUf
         gQyBY+H2CskMeZGePvsI636NyaDU9wjTcr0fxO97HHjpUpIzNo+/0Dr5isGtbQJqdzWc
         /ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+p/vb8Nh3bZn0qfhOImjTyqVNq1MlM0FRF8GGlBxUc=;
        b=ZLbiwpw1ocgq34+e5xuflXR9HKoK1aX3HJFg4jmdS/LPWlEkczf+tPZVCvsVd60cp1
         NIM1RQ5b/5FnacsuAqezjsqKwhMtWBnGDJZBtl3EDSV3lj0kDfV01bNbNTElmSV+7gvM
         D9AEA8Qd30XMTewuV1qu8GtnDQty806oD9bLEDioy5YBWjHxFn4GwPP25zr3eVRI6Uh+
         ST6KGrVYWYPJX7X1vjs96+O3wuuMgJSU29pfN2tnPBqd/vAl54KeM6GUL0DkEKqzWuOw
         se5nstOIXkpmpFjK30+cL0Nnij6cKtOVZDiGJwflUcnI+Q4m/ARheDy2mGRrtu+/NJrj
         zfsA==
X-Gm-Message-State: AOAM533Y1xfpBPPIds9Go+WysCmP7vFAxhMZq1heyaLdl71Wq6GHRXvm
        9K3kQKXomI7V5+GKCV7fof/EKHFCbt3Uy1ETI9JznFU1fAKP+w==
X-Google-Smtp-Source: ABdhPJzcBaCYUrXG7U8HwgdTdWC/E8gWuT4Ng7D5uFteTeqCoXOELTwCbYpl0dJO594uus5VXzsLAP02mG5aSZyTlQ4=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr1118476pgo.208.1628724553856;
 Wed, 11 Aug 2021 16:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210810235047.177883-1-phil@philpotter.co.uk>
 <20210810235047.177883-2-phil@philpotter.co.uk> <YRN+6yLnjQTM6LJU@kroah.com>
In-Reply-To: <YRN+6yLnjQTM6LJU@kroah.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 12 Aug 2021 00:29:03 +0100
Message-ID: <CAA=Fs0k+ZuW4OQUCn3gqiqQUOiF6N7ycS8wunPOVt2rrWEC56w@mail.gmail.com>
Subject: Re: [PATCH 1/8] staging: r8188eu: remove unused functions from os_dep/ioctl_linux.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 08:40, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 11, 2021 at 12:50:40AM +0100, Phillip Potter wrote:
> > Remove unused functions that are now no longer called as a result of the
> > removal of rtw_ioctl in a previous patch. This includes functions not
> > directly called from rtw_ioctl, but anything in that specific
> > call-chain.
> >
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 1538 ++----------------
> >  1 file changed, 127 insertions(+), 1411 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > index 4e21801cbfcf..1ccc5f8de1ee 100644
> > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > @@ -1539,7 +1539,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
> >       wrqu->essid.length = len;
> >       wrqu->essid.flags = 1;
> >
> > -exit:
>
> This is not a "function", but a label that was not used.
>
> I'll take this but be more careful next time in the description of
> patches as to what they are doing...
>
> thanks,
>
> greg k-h

Dear Greg,

Sorry about that, I had even made a mental note to mention the label
explicitly, but it somehow slipped out of my head. I dealt with this
in the same patch as it was one of the build warnings I uncovered.
Thank you for taking the patches.

Regards,
Phil
