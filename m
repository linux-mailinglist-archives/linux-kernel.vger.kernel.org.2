Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E033D7470
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhG0Lj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:39:58 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:45902 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbhG0Lj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:39:56 -0400
Received: by mail-vs1-f51.google.com with SMTP id f28so6913129vsh.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMORGYq9zYL0BbSC5siHJfgjQsNzYI00xMgJvguvEqQ=;
        b=fpu34FrDjD/NCNn3kjYsLcdxhgeAl9P5Knhp7qBPPe33cUJsiRPPj5RUJgRG19NHy7
         qg53Pt41MO/KoUJG5MylHd/6et4EI0dK9Z6Hg08DbJl+NOMYOB668IXI+0paUCaHu1ll
         YKiW3yBJgUr95S4ad2WFwiZTIxhcc5ziwIMMFl6zDguSAZbDnfSgeEkaeYSBxp0/cTBY
         181hliPlClEcW3i9eG1RtDi8bOgxCk/wrj3CZ+JwL5+AfRsVjNnKchGJUDHmqBsZuY5g
         La2s+7LVHvBTmXpcCTbbDOHeir30pjctgCNcn3PJ+ktJiSsw6TGTMr+SCjOc6+jLPzKM
         7kgg==
X-Gm-Message-State: AOAM533EzMRQ9mBoSgMJ5pub6ScDMPH9El/0WmSUN7/YDDyBe9hiv3yI
        /uYCRgFxhSTUd+vja0Vzdi0/BQrtFSSVHWAN6SY=
X-Google-Smtp-Source: ABdhPJz8EAHSpA5ssumFMd2SO7/p1K8PP/rO1gNlbgefMt9MamIF0aFU6Rje/V/LzHfe6Y7dv4vFKrYpt9b1YlS0RHg=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr15890283vsb.18.1627385996758;
 Tue, 27 Jul 2021 04:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210727093015.1225107-1-javierm@redhat.com> <CAMuHMdXXoHLO=jsjb+xtW7GDQsvu8Zuz=JmbaEXT49w5o4SJ9A@mail.gmail.com>
 <f9df82c9-1e1a-d657-d712-312f5f17cab0@redhat.com> <CAMuHMdVh4XgXeaLXXTmPxMuWM4C1mTDnhSmDmff6T37PwNxupg@mail.gmail.com>
 <e3f0f7a0-2130-18be-48a4-af1918017eca@redhat.com>
In-Reply-To: <e3f0f7a0-2130-18be-48a4-af1918017eca@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Jul 2021 13:39:45 +0200
Message-ID: <CAMuHMdX+hsXeoY8jNdDvyiw2HxhwcQw60LJddsaOGZBcHT=a=A@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/firmware: fix SYSFB depends to prevent build failures
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Jul 27, 2021 at 1:32 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 7/27/21 1:17 PM, Geert Uytterhoeven wrote:
> >> Not enabling this, would mean that a platform device to match a driver
> >> supporting the EFI GOP framebuffer (e.g: simple{drm,fb} or efifb) will
> >> not be registered. Which will lead to not having an early framebuffer.
> >
> > Do all (embedded) EFI systems have a frame buffer?
>
> That's a good question. I don't know if all EFI firmwares are expected
> to provide a GOP or not. But even the u-boot EFI stub provides one, if
> video output is supported by u-boot on that system.
>
> > Perhaps SYSFB should be selected by SYSFB_SIMPLEFB, FB_VESA,
> > and FB_EFI?
>
> It's another option, yes. I just thought that the use of select was not
> encouraged and using depends was less fragile / error prone.

Select is very useful for config symbols that are invisible to the user (i.e.
cannot be enabled/disabled manually).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
