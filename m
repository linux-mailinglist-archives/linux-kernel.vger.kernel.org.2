Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54F93E46A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhHINbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHINbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:31:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 104326103B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628515855;
        bh=3Q+Y76mabCBAkeS1OkTLTBG6PO19Eb+uHYKiEoMf0rc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aykCzZcVQyfJZbqutziyiWp5pX2Phw84+xn9RYd5qb9P5wBQcbZFW6eAm/pPM9Ew6
         tpUrj0CpsCmYmTT5jVWMx4ZYKtT39aJVyQH1ketghOvZhQwLPEGcVaGhqfHY3yXdV+
         OKPx1TGNOYLN5eyA1IAwewopTb3BISluGMoVYDf2hnBjb7ONWpHZuArr3pyJS63TKN
         Wvf760llZoqNTOYU3L5ub9DIEPWH2AKKOYLSC0Sn4aOceZ0XBNo+PNTR5EyKUuePiM
         fZXSZe7eatqySpm5foEFGe304cGSs404nlJejOEO9uT5TgGDn4YqAosEf66DsL9kLZ
         SBH96J32zDT/A==
Received: by mail-wm1-f42.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so370842wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 06:30:54 -0700 (PDT)
X-Gm-Message-State: AOAM531Mq/YrAGRQ8DmvRt8deKcpqoALLCs1+IYFtEKCOyc+Tg0RjsqA
        8AAdyA8pJzAdZL6zZ1wEpwBkNzySe8JQSpNRg3Q=
X-Google-Smtp-Source: ABdhPJxl4QPAglGMMc6y1IGMVOChD84KKdMB8PjGKNXhkhWJ/ORYqy5JYUFXKgx8V4dc9Ov25B5IISYTC15U0yrTqRs=
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr16521594wmq.43.1628515853670;
 Mon, 09 Aug 2021 06:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210723224617.3088886-1-kherbst@redhat.com> <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
 <CACO55tuNWk6emjnnukgv9h-9jbpVP564Ogmi7TGbybc9n5v+ZQ@mail.gmail.com>
 <CAK8P3a1BceSaiqkTf+9Pr4Br-G3kgqD4ztwiaS7fxNiUg9t7Dg@mail.gmail.com>
 <CACO55tsoi2akTKvFdz3p48UHRjFXDW7dUnOM8qVePBFWet-3UQ@mail.gmail.com>
 <CACO55tuceMUz2pgOM23wvcmtaTqbo6S6rCB+mfLptqJRt=fMWA@mail.gmail.com>
 <CAK8P3a3+AD02-8nbULMdae2Hc=hJ+-Zb_CL+bHF-9oGieYiZWQ@mail.gmail.com>
 <CACO55tswMuDE9u3asU2Ls7BhA0uKGGarLk+E-WTD6MVnLwc3tw@mail.gmail.com>
 <CAK8P3a0i0WP24Z0TScmPqKxmM2ovtKnmm+qZq6+Tc1ju+hma0w@mail.gmail.com> <87tujyoitk.fsf@intel.com>
In-Reply-To: <87tujyoitk.fsf@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 9 Aug 2021 15:30:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a30acg_FX9iHqftKeVmS=L81bqYw3XMQJ8=1fP5aU7jMQ@mail.gmail.com>
Message-ID: <CAK8P3a30acg_FX9iHqftKeVmS=L81bqYw3XMQJ8=1fP5aU7jMQ@mail.gmail.com>
Subject: Re: [PATCH] nouveau: make backlight support non optional
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 3:20 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Sat, 24 Jul 2021, Arnd Bergmann <arnd@kernel.org> wrote:
> > On Sat, Jul 24, 2021 at 4:14 PM Karol Herbst <kherbst@redhat.com> wrote:
> >>
> >> we use the MXM_WMI in code. We also have to keep arm in mind and not
> >> break stuff there. So I will try to play around with your changes and
> >> see how that goes.
> >
> > Ok, should find any randconfig build failures for arm, arm64 or x86 over the
> > weekend. I also this on linux-next today
> >
> > ld: drivers/gpu/drm/i915/display/intel_panel.o: in function
> > `intel_backlight_device_register':
> > intel_panel.c:(.text+0x2804): undefined reference to `backlight_device_register'
> > ld: intel_panel.c:(.text+0x284e): undefined reference to
> > `backlight_device_register'
> > ld: drivers/gpu/drm/i915/display/intel_panel.o: in function
> > `intel_backlight_device_unregister':
> > intel_panel.c:(.text+0x28b1): undefined reference to
> > `backlight_device_unregister'
> >
> > and I added this same thing there to see how it goes:
>
> Last I checked (and it was a while a go) you really had to make all
> users of BACKLIGHT_CLASS_DEVICE depend not select it, otherwise you end
> up with recursive dependencies.

Yes, that is correct. It turns out that my randconfig tree already had a local
patch to change most of the other users (everything outside of drivers/gpu)
to 'depends on'.

      Arnd
