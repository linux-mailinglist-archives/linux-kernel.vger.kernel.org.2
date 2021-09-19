Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C2410B43
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhISLWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 07:22:50 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:43704 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhISLWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 07:22:49 -0400
Received: by mail-vs1-f53.google.com with SMTP id n17so13159577vsr.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 04:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/ORHhnIy4nRW8aqt0HSfTMaa02QlmIV//+XG+bOnCU=;
        b=ulnEM9GRyJb5o8fmp/47GTftxBNGKLrkah+dYvkkEgRUxZgXrGEJPduSS83szqbcRj
         aTXCn+DPmj+WOArBmviYoHrTNPMvlODv52g/lOaiIL1rRIA9yqZHk/DG87w+jD6zXjhs
         e/+a6XTTs6UNV1lVdsYAJLfH9bFX+4JYUu2V5JtsYOzyHKoVWWTKrra7nyTGQgzZGawB
         8o/4ZY+o+D6m82dtJ9Z24+GFQhFXFHZAYpKEDxEvK8+Z1Tu4A5mAnajmIheFiVoO7IDy
         9rDYrftNFlsFBUWUI2XijAiPpSfgcDz3Rh+skp6GXYlk6v3rRvOT1LVV2aXen4bQEVKY
         L76Q==
X-Gm-Message-State: AOAM531hmMHBB9aqFKb31+Uw2xhdRpoDvaxEXfGzJG1Qz2ahIqNgVSkD
        n9fhM0tXu+P/drSvH7ZytuymzRqeEf35rf7gDNlCvtLqxXg=
X-Google-Smtp-Source: ABdhPJwsB+qX90+yBYMN6r5ozVeZNqsRYThb/1LSzyrHRlpuxm7MGRTllo/zneEm4++pxAdqeW8raOaQ69xnLE9sMcM=
X-Received: by 2002:a67:cc1c:: with SMTP id q28mr12982410vsl.37.1632050484249;
 Sun, 19 Sep 2021 04:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210918051632.1297025-1-liu.yun@linux.dev>
In-Reply-To: <20210918051632.1297025-1-liu.yun@linux.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 19 Sep 2021 13:21:13 +0200
Message-ID: <CAMuHMdX2Wk6T9JAZT4Nqoiay5H+00xaUsn_pAGgspodpQuJcJQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: SND_SOC_MT8195 remove depends on COMPILE_TEST
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jackie,

On Sat, Sep 18, 2021 at 7:17 AM Jackie Liu <liu.yun@linux.dev> wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
>
> After compiling with COMPILE_TEST, we are most likely to compile on a
> different architecture, such as x86. At this time, it is possible that
> the HAVE_CLK macro is not selected, resulting in compilation failure.
>
> Avoid fail like:
>
>   Kernel: arch/x86/boot/bzImage is ready  (#17)
>   ERROR: modpost: "clkdev_add" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
>   ERROR: modpost: "clkdev_drop" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
>   ERROR: modpost: "clk_unregister_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
>   ERROR: modpost: "clk_register_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
>   make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
>   make[1]: *** Deleting file 'modules-only.symvers'
>   make: *** [Makefile:1783: modules] Error 2
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: 940ffa194547 ("ASoC: mediatek: SND_SOC_MT8195 should depend on ARCH_MEDIATEK")
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Thanks for your patch!

> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -187,7 +187,7 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
>
>  config SND_SOC_MT8195
>         tristate "ASoC support for Mediatek MT8195 chip"
> -       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       depends on ARCH_MEDIATEK

Instead of dropping support for compile-testing, wouldn't it be better
to add the missing real dependencies?

    HAVE_CLK (clkdev_add, clkdev_drop)
    COMMON_CLK (clk_unregister_gate, clk_register_gate)

As the latter selects the former, adding the line

    depends on COMMON_CLK

Also, the Fixes line is wrong as the link failure happened before.
Fixes: 6746cc858259985a ("ASoC: mediatek: mt8195: add platform driver")

>         select SND_SOC_MEDIATEK
>         help
>           This adds ASoC platform driver support for Mediatek MT8195 chip

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
