Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD1420685
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhJDHTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:19:22 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:35443 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJDHTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:19:21 -0400
Received: by mail-vs1-f49.google.com with SMTP id w13so361731vsa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 00:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tq3r3SqIuxf7MSAP423+T3z19O8+N54Ab2Em8HAL104=;
        b=FEyM0BK041NdfnvzM6zBBOh6YL9XrB/GLR7eQ+1007+cxkl2vNuQz0aaS+oVCrFLVo
         n2vy7VifM0VNYoUXiG4iVvD5d78muV6ghOo/7z2nqFb3hEt4Q7IvMPHSEXvHAA+9iWDE
         JIZXpH15vbUEJ3IdPzXURcMtFpXADsugixQIRVTtyqq+Fa8oSQpWI9uFKXLSu227YTty
         GvUV+v1LbfBUix7JXum4/1k9IWPbqtYBMTsZQQkMYqPM4mh4qIn8Ll7Ml5t1fL1nwMt9
         XTPHFgTEbSlBZ/gzD8sKGvBgQtZ66beclItw/lAjJbzP+mHL6UiO17BA17SOBbB28SfG
         O6ag==
X-Gm-Message-State: AOAM530kkgSPiorABGIcuv7IyWn9liuNIm4mQNRY0FbtFvFO+jucOgQ2
        s25tWiuNMx6Vwqn6awtgZjRqXcJAXczrBxrXl7o=
X-Google-Smtp-Source: ABdhPJxlU5DOPg9j9M8lzJDp/gf8nfLm5tU4dSRqNvnBVD3Ar4MoASkpYleFMBnm+HvISxcTtu38S+NO9ww7xL7VdnI=
X-Received: by 2002:a67:2c58:: with SMTP id s85mr11305419vss.35.1633331852971;
 Mon, 04 Oct 2021 00:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211003030404.32707-1-rdunlap@infradead.org>
In-Reply-To: <20211003030404.32707-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Oct 2021 09:17:22 +0200
Message-ID: <CAMuHMdVRJ4kY1vncgm3jn=p1gYzYQC7C9E3dv+KoYauJgjL=fw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: add COMPILE_TEST for SND_SOC_FSL_ASRC
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sun, Oct 3, 2021 at 5:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Geert pointed out that since sound/soc has the soc_dummy_driver for
> NO_DMA platforms, it is possible (desirable) to have drivers that
> depend on HAS_DMA to alternately depend on COMPILE_TEST.

Actually I had never heard about the soc_dummy_driver before ;-)
I did know about the dummies in include/linux/dma-mapping.h.

> This means that SND_ATMEL_FSL_ASRC can depend on HAS_DMA || COMPIE_TEST.

COMPILE_TEST

> Fixes: 121a01521b1e ("ASoC: fsl: fix build failure")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- linux-next-20211001.orig/sound/soc/fsl/Kconfig
> +++ linux-next-20211001/sound/soc/fsl/Kconfig
> @@ -5,7 +5,7 @@ comment "Common SoC Audio options for Fr
>
>  config SND_SOC_FSL_ASRC
>         tristate "Asynchronous Sample Rate Converter (ASRC) module support"
> -       depends on HAS_DMA
> +       depends on HAS_DMA || COMPILE_TEST
>         select REGMAP_MMIO
>         select SND_SOC_GENERIC_DMAENGINE_PCM
>         help

The actual change LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
