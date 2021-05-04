Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36278373230
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhEDWE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhEDWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:04:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50D0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:03:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i24so12207790edy.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ZgEI9aWWkFYIE59QHU2kpFOTpigrU9CKjmSZ5dbE/Y=;
        b=r8nZe8HMfAQSeJLCiGPHnnuFnmyndNESig7RAjHBt2l2t3c0hRDvafMeLlcn7yw8hI
         HTz6z3h8+eKdD19GuRxU23njZfqUvlqnXFivPBXOO5yoRsudfy38FOYGqjtrS4weSpnL
         biP9bhytjQ074E6wNwT0WZld8lTbtgsq1kOUlyyLuyEU/Y9Xgs9Ebmj8NHf4uULGIq8z
         27MewYhD1K2j3vB7Fmo00950QnNwky/1cLLxcgMHSFlav+vEp2ZvkTzU4suo2LwZRvoy
         coNcAhIo8VPKwdHvCgIwd2iSYRt/X8jCZLcPYnLLFOtd/rpOoES149+z0hztUUB+ez4p
         hnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ZgEI9aWWkFYIE59QHU2kpFOTpigrU9CKjmSZ5dbE/Y=;
        b=r2Pf+Mt4vsTiwxITJZ518GAPiHgIIudGzVkuVVTZaPSkitDFVQPKlkiii7QF6At+dA
         L7LLNPCREkeBTOrF/UXkuTmGJKItLmB0dKtAhMwRECHfYjzmn4izuWlrcqq3aoShWWcm
         vHcPkIXbjsjuFaGHRPuifjqMDJJyNk1aRFGyGRjyjT5p7mGw96YdkIZyBQk1EJJfENGH
         p5gUgv4lj7/47M2yanud4cXhe8h4CIGGFA+j11jLz6nynpufu4lQxGVvXXtKcVSCnRQV
         Lmr6BmnS9ZhqTRTuBbJzDXpolxeVKa0lSSmLXXu2ndp0rrW30je0TdIaAW8LoLxB1gvM
         JDHQ==
X-Gm-Message-State: AOAM533FEdPk1dGJBJ/Jt/qCIcBKjQoie0a2b3VgUMDPCrIwfSs7V0tN
        yw7bjZHh1qFV88v0ZZh6bAzFWgYIDzWnaBUlODM=
X-Google-Smtp-Source: ABdhPJzlYPbhRz/qi3HLCWJ3xtHL2f+uNruVqOL3UrpLLSjaQm1E60DcAi3awCSS3hSTwcYhBLp+rK20rGPDrhQzXjE=
X-Received: by 2002:a05:6402:1354:: with SMTP id y20mr10025342edw.115.1620165808504;
 Tue, 04 May 2021 15:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <e4r4g4R-yjH.A.CJE.0pVkgB@appolonius> <20210504183009.GV6564@kitsune.suse.cz>
 <CABkfQAHfjfBFqnVPzg1w5JFOErr=AsLpQgwzwpUJ2Uc_-cmD_w@mail.gmail.com>
 <20210504190452.GW6564@kitsune.suse.cz> <CABkfQAFpTYFgiA-h+5DBiky3CMtdj71n5+usGGtrTHsYB1xruA@mail.gmail.com>
In-Reply-To: <CABkfQAFpTYFgiA-h+5DBiky3CMtdj71n5+usGGtrTHsYB1xruA@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Wed, 5 May 2021 00:03:14 +0200
Message-ID: <CABkfQAHMUF2u1HKbkk6PfXS=YmYgRWqBBP86Awc34sy1FgT-vA@mail.gmail.com>
Subject: Re: ERROR: modpost: "drm_display_mode_to_videomode"
 [drivers/gpu/drm/bridge/lontium-lt8912b.ko] undefined!
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed proposed at:
https://lore.kernel.org/dri-devel/20210504220207.4004511-1-adrien.grassein@=
gmail.com/T/#u

Thanks,

Le mar. 4 mai 2021 =C3=A0 21:19, Adrien Grassein
<adrien.grassein@gmail.com> a =C3=A9crit :
>
> Ok thanks,
>
> I will investigate this.
>
> Le mar. 4 mai 2021 =C3=A0 21:04, Michal Such=C3=A1nek <msuchanek@suse.de>=
 a =C3=A9crit :
> >
> > Hello,
> >
> > I have only one from ppc64, the other architectures don't have the
> > problem or fail earlier.
> >
> > Thanks
> >
> > Michal
> >
> > On Tue, May 04, 2021 at 08:45:01PM +0200, Adrien Grassein wrote:
> > > Hello,
> > >
> > > I think this is self-evident but could you please send the config to =
confirm?
> > >
> > > Thanks,
> > >
> > > Le mar. 4 mai 2021 =C3=A0 20:30, Michal Such=C3=A1nek <msuchanek@suse=
.de> a =C3=A9crit :
> > > >
> > > > Hello,
> > > >
> > > > I get errors about missing symbol in the lontium-lt8912b module.
> > > >
> > > > Is the problem self-evident or do you need the config as well?
> > > >
> > > > I don't need the driver for anything, it was just auto-enabled beca=
use
> > > > it's new and the change has not been reviewed.
> > > >
> > > > Thanks
> > > >
> > > > Michal
> > > > >
> > > > > Last output:
> > > > >   WRAP    arch/powerpc/boot/zImage.maple
> > > > >   WRAP    arch/powerpc/boot/zImage.pseries
> > > > > make[2]: *** Deleting file 'modules-only.symvers'
> > > > >   MODPOST modules-only.symvers
> > > > > ERROR: modpost: "drm_display_mode_to_videomode" [drivers/gpu/drm/=
bridge/lontium-lt8912b.ko] undefined!
> > > > > make[2]: *** [../scripts/Makefile.modpost:150: modules-only.symve=
rs] Error 1
> > > > > make[1]: *** [/home/abuild/rpmbuild/BUILD/kernel-vanilla-5.12.0.1=
3670.g5e321ded302d/linux-5.12-13670-g5e321ded302d/Makefile:1770: modules] E=
rror 2
> > > > > make: *** [../Makefile:215: __sub-make] Error 2
> > > > > error: Bad exit status from /var/tmp/rpm-tmp.q1oSIp (%build)
