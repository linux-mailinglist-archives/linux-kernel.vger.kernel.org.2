Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1F45C957
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbhKXQBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:01:53 -0500
Received: from mail-vk1-f182.google.com ([209.85.221.182]:42691 "EHLO
        mail-vk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhKXQBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:01:52 -0500
Received: by mail-vk1-f182.google.com with SMTP id b125so1830428vkb.9;
        Wed, 24 Nov 2021 07:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ptv6aIhfTWN4MeV+ze8LFVjMsNdx8UNG/X8//1/4PrE=;
        b=26vOzjTuZC+LLu20QguiW35MAcj1WJdg9IjxrlL/CqIaexGQVRiHN4HR59YypVZq5l
         SlAPkyn3aZ1D8I3VdakCdOf/JASKER/P9ttIsIpxCImYPLAxoMNc0unM/E7rpg4+dxoB
         iQ9caG0ww8Gt77gfXUll99dRdSpO5hhADBcD+u/b5Rq3eTxC+JaM34zvLoMSF3XZbLA0
         WX0cL6J369mBtA9Sb/8zM2cD+M0KmoujHRcmtR1u3GyMxUrC9Az6MlB5eoydmlxl9cmw
         GWzC1MS3SoZVaj8F2oJms95CZL/nsgyFCSkFn6r5dqlFkHqZ2sP6tDgmthQtow1an/je
         gjHw==
X-Gm-Message-State: AOAM531bRd8INWW2YvrFa34oQlo8gDaayie6GywuK8RTSjlFSxSZNyd0
        sqO7P7UDYEBbUD/++uSUriN7pkBvpyJ/hw==
X-Google-Smtp-Source: ABdhPJyR0XhmK1/Z4aINbM4rTJFV/XVP9HimDAYcrcwUICC3JyR1I9kHn61VTLPWjKuZXOFe+WFQmA==
X-Received: by 2002:a1f:ff08:: with SMTP id p8mr1463197vki.33.1637769522023;
        Wed, 24 Nov 2021 07:58:42 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id f11sm45786vkk.50.2021.11.24.07.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 07:58:41 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id o1so6098861uap.4;
        Wed, 24 Nov 2021 07:58:41 -0800 (PST)
X-Received: by 2002:a9f:3e01:: with SMTP id o1mr12046695uai.89.1637769521047;
 Wed, 24 Nov 2021 07:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20211124155101.59694-1-david@ixit.cz>
In-Reply-To: <20211124155101.59694-1-david@ixit.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Nov 2021 16:58:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4c1CMc_GzORTN-j1j3LZ0jui=h2RDVoVVMQmXfOuAmQ@mail.gmail.com>
Message-ID: <CAMuHMdU4c1CMc_GzORTN-j1j3LZ0jui=h2RDVoVVMQmXfOuAmQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8962: add missing interrupt property
To:     David Heidelberg <david@ixit.cz>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        - <patches@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ~okias/devicetree@lists.sr.ht, Rob Herring <robh@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 4:51 PM David Heidelberg <david@ixit.cz> wrote:
> Both, hardware and drivers does support interrupts.
>
> Fix warnings as:
> arch/arm/boot/dts/tegra30-microsoft-surface-rt-efi.dt.yaml: audio-codec@1a: 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: /home/runner/work/linux/linux/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml
>
> Fixes: cd51b942f344 ("ASoC: dt-bindings: wlf,wm8962: Convert to json-schema")
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
