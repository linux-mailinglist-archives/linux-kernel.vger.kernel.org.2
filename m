Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202BB38C251
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhEUI4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:56:16 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:44934 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhEUI4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:56:15 -0400
Received: by mail-vs1-f51.google.com with SMTP id i29so4262400vsr.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lI66EapJINQfVaC+bNRebZquzzxGjECYNjYDaBWb8as=;
        b=VS30WhuNeQXuS8fnmZPdiJXbizgtmkvwXkIl3rvUliIooPO1aWJjUcAdsNz4zAZkCD
         cWbNDhGnTcqc/eQWnNAk3OWwG6LmBnty3ZWBYad9K/IrUbvu/DCLfXUkvOKC6Qu0y74Y
         qL+U9K4ngVcbcr6YpJ08au1IYYb4nde4XkUsDVCBWIiY3RGSoldZ6dreDtbcMOxNCSMg
         qZpT4Rpr+oVUDcCpEtAmOp//IrqJYLCJf3KouUCGWCSvr7f2wMsOo3zJFYy85cn8CezS
         +yRQ2V/cbh2kcRhZZZK6rEzGxT1GY4AtvUm7CEAmp9hN5WyW0O+BhpPsdyLevZit8mTh
         ktwQ==
X-Gm-Message-State: AOAM533+BQjtJXLMs2xMaKGPZ5gxdj1or9rF/XP5lopOINvUHbGUN/VC
        qOByjCMo3OVsjifrEgshMEYzwfcnvLat2qsCDRk=
X-Google-Smtp-Source: ABdhPJw4LyIepBROa4U+wefLkmkjzEuEKcZWmdgGY7RdxHNl5OwMOZpSP9YANdFrf8DxyCijj8ititq1NriKJlLNdQQ=
X-Received: by 2002:a05:6102:392:: with SMTP id m18mr9313311vsq.40.1621587291613;
 Fri, 21 May 2021 01:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210520163751.27325-1-maz@kernel.org> <20210520163751.27325-28-maz@kernel.org>
In-Reply-To: <20210520163751.27325-28-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 May 2021 10:54:39 +0200
Message-ID: <CAMuHMdVWunk7dUixTigJCkXAKcq6oTOUZoNFaR2_pz7iXw+OHQ@mail.gmail.com>
Subject: Re: [PATCH 27/39] irqchip: Bulk conversion to generic_handle_domain_irq()
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

>  drivers/irqchip/irq-renesas-irqc.c     |  2 +-

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
