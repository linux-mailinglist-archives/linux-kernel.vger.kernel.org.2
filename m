Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0338C261
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhEUI7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:59:03 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:40866 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbhEUI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:59:00 -0400
Received: by mail-vs1-f52.google.com with SMTP id o192so9969084vsd.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2kr3t6v6evb9JMX3TsVNw2P+BRoGWCMgAwqQMlTxdU=;
        b=NI2WvZcDxTaC5gfOeBI8JiFHSzOO03edw1ZTdxXG3EyreobRitnC5ZVLjOPtW904+W
         yWDIOfSn6QGV5dy3f65e7nPoBLK2849vAStMvlSCjFpW4i0MkI6KhhmwOvftfxjnVRwd
         wdcyqehiJ0yIUGewA9dKi8j8Y+F4LQn2v7+OCggLYzeRqpR+Bm+abwQwmkCxrTx7r8Zb
         l7E2hXD3H98zESKmQkzNHjBsGec9k9UKQYVJ3wIeaL0uU6tTVIUqrhRzttxI3ij/qxwj
         6yiqghSTf4s4sF4ekbKfO7TOB5V03An/s1z7h1owXFozSinEcZZWk0akF0zHMnxQr6FW
         vRaA==
X-Gm-Message-State: AOAM530Je6zB8ycbs0GZsXfzv05MB/Mu7RMmmuadOqrYb7SM4AB1f+Fz
        VJDX2j89jaTU8yvXDTV1XZ/LlktJ16/17AIJiCM=
X-Google-Smtp-Source: ABdhPJyN39qgUdgGScGVhqxyha/ipuTqH1sY1//tvr6jZ11ExUjNgscIuePElMY3FpLhsnrF5Mqh7S97TNiSS6I6lwA=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr8932547vsd.42.1621587456585;
 Fri, 21 May 2021 01:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210520163751.27325-1-maz@kernel.org> <20210520163751.27325-31-maz@kernel.org>
In-Reply-To: <20210520163751.27325-31-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 May 2021 10:57:24 +0200
Message-ID: <CAMuHMdXvupO2i+A7EaONXGashKPF3TuikH4Kkn3Xw1NJWLG4tw@mail.gmail.com>
Subject: Re: [PATCH 30/39] PCI: Bulk conversion to generic_handle_domain_irq()
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

>  drivers/pci/controller/pcie-rcar-host.c        |  8 +++-----

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
