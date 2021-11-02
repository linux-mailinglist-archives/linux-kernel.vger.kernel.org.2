Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D6C4428F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhKBH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:57:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C5C061714;
        Tue,  2 Nov 2021 00:55:20 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id d204so50961190ybb.4;
        Tue, 02 Nov 2021 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYt4XdhIV9mCaGivgxKhV13JsWC7QyPYPD/Uf0f0VIs=;
        b=hi+WlcUukqlLODfpjwW2VnRDHE+wHoBCu0sK/EMuhpL+IaT1POHTsscxNKlv74QBwj
         tNLpz/ca1nZ/tivSKZGvUUtk22P4h61lKWrGLhjjevFOf7qfOdHUbpSeSgkOw7YSLxFg
         hzdDcpHnvUVDY62fxsF7w+DzhZSgxmA0V8qx7PQIo2X+1o0kiyi8jq2PPuHSAWQVnQZt
         bLfXJmkiWh3sg6fZbxvSTnNNs3LQ484HCKq3N2QQ4Zxtc/3d4tSd7U6IJbb3YUVQbCCa
         MMe16MR2nUVK9xkT5V+qQg2bKNTCdfN0HMqXYFpEO5oWHLsa9zmeRSxNjNSeljAlkQh4
         gMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYt4XdhIV9mCaGivgxKhV13JsWC7QyPYPD/Uf0f0VIs=;
        b=DvvRJ4NwoOUJKt2jhrjI2HIfjYHQJK3kAfg04gTI2Q0dYuvzBRwkMlWZrpu/LGyK3c
         fL5M/hzFJSEY7b7JGybD8ikcenL8qlJXYxOIJdHiKEkg4WRydudIoaz6u+19v9ZhWYEC
         PsLCg3ThWQNuihwoeopKS0joYgpQ+bqJOoljvtq59iVz1UZI+KWgq5BBjZ9UEu5gihIW
         fRriYtPhuCDaSMV/q8uhe9wZCAIxwyHqpv5+JUCsdiDJPSg8LznM2KbcdiBHiOSL4OJP
         mDYB6H4QlfiVsUz99F0Rg9NmxAeJCAunRxqrm7lP1JsXAQE6n3BpzFQZsIHAtMsbPu+F
         UdQQ==
X-Gm-Message-State: AOAM531PW0yoHQjPt6q864uRtDWUVcU5t/Rh43iBh0AFkqAXnNwuNwuL
        l/Z45NDrZ9Jbn4Bqosf5MTdMWwjjMEY7Pp8aHnk=
X-Google-Smtp-Source: ABdhPJzK6cSMn+HDFhuBPyz0xbsXJXCQ7kZL8KTzlfKBDhHdacY3bQgOuecjIM+xrmFVCFk7Ozss13UuugxdEB6hZ8w=
X-Received: by 2002:a25:a268:: with SMTP id b95mr36582994ybi.35.1635839719820;
 Tue, 02 Nov 2021 00:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-4-lukas.bulwahn@gmail.com> <CAK8P3a3+-J6XbUmzWs7ATN7z53GomZSj6vq3n5R709=iL45RrA@mail.gmail.com>
In-Reply-To: <CAK8P3a3+-J6XbUmzWs7ATN7z53GomZSj6vq3n5R709=iL45RrA@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 2 Nov 2021 08:55:09 +0100
Message-ID: <CAKXUXMwBsDY_onmEztvrfS6Q3k_0YH8gQGLm9zcM2Ge--kcG6A@mail.gmail.com>
Subject: Re: [PATCH 03/13] arm: Kconfig.debug: drop reference to removed ARCH_MSM
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:42 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit c0c89fafa289 ("ARM: Remove mach-msm and associated ARM architecture
> > code") removes the definition of the config ARCH_MSM. Since then, the
> > reference to ARCH_MSM in the dependencies of UNCOMPRESS_INCLUDE in
> > Kconfig.debug is dead.
> >
> > Fortunately, ./scripts/checkkconfigsymbols.py warns:
> >
> > ARCH_MSM
> > Referencing files: arch/arm/Kconfig.debug
> >
> > Drop the dependency on this removed config.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  arch/arm/Kconfig.debug | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 83484564b1d9..87aa6e92ee6e 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -1886,7 +1886,7 @@ config DEBUG_UNCOMPRESS
> >
> >  config UNCOMPRESS_INCLUDE
> >         string
> > -       default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
> > +       default "debug/uncompress.h" if ARCH_MULTIPLATFORM || \
> >                                         PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
>
> The PLAT_SAMSUNG reference is also misplaced here, I think you just want
> ARCH_S3C24XX instead, since the other samsung ones already require
> ARCH_MULTIPLATFORM.
>

Agree. I can clean up (or better stated: optimize) the dependencies
further in such a way. But that config dependency optimization goes
beyond just removing dead symbols and deserves to be its own patch.
Patch will follow later this week.

Lukas
