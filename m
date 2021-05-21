Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC538C274
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhEUJA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:00:56 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:39441 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbhEUJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:00:45 -0400
Received: by mail-vs1-f47.google.com with SMTP id f9so3510771vsp.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMgtIV76+cKtNNMrJAj6JQqbd2T9T+KKYZslTWOigC4=;
        b=rGloMInk/s/Ypgx2dCh2T9le6mQgnT19xMNVd6OfUtpCVbYJxU/Paj5CUwD+sasw/I
         sitFZbrAesjA/wWetn42q61MONHKnfNG16KFAZl1NUA9eNLDI8HRvEVBykO978hCe2hz
         lQT/9Ass39B89SXethMYsFX5hR1HbkaY96MQB01OjQxYzaK9cPGpOaxAnwL1edApeCJR
         7U2k0mct/484MjdFWULUVmWp7sg1y6JW7X0oLEW7yffwW1UpqnKneW4v/XT9F8ZnmP3g
         0C6yiG+Uerm9IkiQOMQJZ9yN7zXYJPWgMYrj6PwOpAfQT14dPVeoQ433dlj46G4acFGl
         ri8g==
X-Gm-Message-State: AOAM530qzdE0rOpSb8zox9trTTWg13eG9vhIJodoVW8ypmLizm0o1IRz
        HcoZ2cUx22WeWBT+ssh1EV4aarbsDtOXGjhBFto=
X-Google-Smtp-Source: ABdhPJzO3IDLG36kh2cMOsw/Oc5lyaD2pH5MdVBtVabd7SDz677hXZXrsGvs8XWHIJEEnIImZzD8WwWzYupOC3K00/Q=
X-Received: by 2002:a67:8713:: with SMTP id j19mr8969169vsd.3.1621587562709;
 Fri, 21 May 2021 01:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210520163751.27325-1-maz@kernel.org> <20210520163751.27325-29-maz@kernel.org>
In-Reply-To: <20210520163751.27325-29-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 May 2021 10:59:10 +0200
Message-ID: <CAMuHMdW8v6G1jfDR3=NeG3-zW0_jpNXTAM6B9MCYGDFqxqdG7w@mail.gmail.com>
Subject: Re: [PATCH 28/39] gpio: Bulk conversion to generic_handle_domain_irq()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 6:57 PM Marc Zyngier <maz@kernel.org> wrote:
> Wherever possible, replace constructs that match either
> generic_handle_irq(irq_find_mapping()) or
> generic_handle_irq(irq_linear_revmap()) to a single call to
> generic_handle_domain_irq().
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

>  drivers/gpio/gpio-em.c           |  2 +-
>  drivers/gpio/gpio-rcar.c         |  4 ++--

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
