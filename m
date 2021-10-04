Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC3642067C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhJDHQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:16:47 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:33282 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhJDHQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:16:32 -0400
Received: by mail-vs1-f46.google.com with SMTP id 188so18463195vsv.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 00:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9EwFX43l/2r99tmwRun5vT5zyRd1lmM0divCgfmoFw=;
        b=XA70uUpa1RA+I7WOefely6oJZ0PYzOlPu4z++xifMASsi86clRBmgdfA4qLBLPJ3ao
         Gh81Q1o0xYqqZFNxiFbWgq5IP/hv8/p8ZcDb5I4/f/2YdJTh+g5dQjd6pBmoRS7IgMxY
         hztyxnpbA7341Ewj1te4MDUHkaT6S3e24TKj5jtkOjm+heIL3B+Ge/+hlTPM9YzYv/dA
         zhS7JVA3UnNfXIl4aJc8R9vpRVhq33KnNIhuCtyvFW7I5qHkx/woMsFOSW4uQWQ7a8/i
         xoqzgnbnFY0MKQEhLNbwf7w3/WZ81srVEu0cr6tanFjPQU8dOS3Yk52X9M2927oMfpds
         7VNg==
X-Gm-Message-State: AOAM532uSwYIzDHULPmTJ8gAfabPHcwErZf2CO1Y4hCPwYSwSSnbvFKA
        TDTKnpQ2x8fg4wjrROWY/ckJFZTD4Gln6ZfVCeQJnJ5w
X-Google-Smtp-Source: ABdhPJwPUrVlAy5tkRXrLHhIaBrswRZA2a5X0zmaS24RWUwiCQqZa669QAw1LVnhiyUQwtk7S3TTLkOlHsvMsWcFEsQ=
X-Received: by 2002:a67:f147:: with SMTP id t7mr11286284vsm.41.1633331683781;
 Mon, 04 Oct 2021 00:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211003030357.32456-1-rdunlap@infradead.org>
In-Reply-To: <20211003030357.32456-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Oct 2021 09:14:32 +0200
Message-ID: <CAMuHMdVuObZvVCkQbXfmruB_RnprkghAv6b14Pz5nC+7M4YtzQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: atmel: add COMPILE_TEST for SND_ATMEL_SOC_PDC
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
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

> This means that SND_ATMEL_SOC_PDC can depend on HAS_DMA || COMPIE_TEST.

COMPILE_TEST

> Fixes: 6c5c659dfe3f ("ASoC: atmel: ATMEL drivers don't need HAS_DMA")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  sound/soc/atmel/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20211001.orig/sound/soc/atmel/Kconfig
> +++ linux-next-20211001/sound/soc/atmel/Kconfig
> @@ -11,6 +11,7 @@ if SND_ATMEL_SOC
>
>  config SND_ATMEL_SOC_PDC
>         bool
> +       depends on HAS_DMA || COMPILE_TEST
>
>  config SND_ATMEL_SOC_DMA
>         bool

The actual change LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
