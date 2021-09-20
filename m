Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0119D41128B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhITKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:06:53 -0400
Received: from mail-vk1-f179.google.com ([209.85.221.179]:42536 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbhITKGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:06:51 -0400
Received: by mail-vk1-f179.google.com with SMTP id o204so1601526vko.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 03:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJlXbAv3u12lESrV/6ZqM6UNLLxRX/MyMpJQH7eW+7g=;
        b=QJW8NWZ6s+9sRrkLMZJ1hRS4ERcN83nBXhosSdCm8nGG6qo5Z4m2XvFVZqKzFQuu3T
         cP2lpPNRcReq/IJFZkkzqfw+dipu9em4hYzXVe3MROHoApvws0rqwZc5LdVktw/O85Di
         e8nXPDa4wRL4W93ek+x8d3EFM/LvRdWw3ces6SdXD785bRD0bbqAvwLSxUBxkMZmUe+D
         xGC7TRgLqAR94UVMW/O/F0eFpeKKWf03QucvZIIIxs7bt29R+7SyLvq39XRt+cFHT0Cn
         E4E8xz1Bkrj+zI37RHvg6vTBT2ZU5GT3mvd0iADVrQ1Ju9uaga66TGO9/4da7qu4i37p
         Is5g==
X-Gm-Message-State: AOAM533xFpOebhVTEPs4srz9kTf85bU/BPP+y9Z0MEQDBQ3cDKGQbNwi
        fg3pqlyCikrwvvqnbbOO/Qq23+AWNmtm0MaGVJc=
X-Google-Smtp-Source: ABdhPJw21KYJ6+E01J7XKEBzRND+bYGJxtvpgL/KCdlzvGuzKjTv1Xd3XS/lrKcKi3oLR3yuOCRgqcDqibrEOieac7U=
X-Received: by 2002:a1f:230c:: with SMTP id j12mr13427328vkj.11.1632132324735;
 Mon, 20 Sep 2021 03:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210920100206.1418649-1-arnd@kernel.org>
In-Reply-To: <20210920100206.1418649-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Sep 2021 12:05:13 +0200
Message-ID: <CAMuHMdUvb=nCZ=qfeUyUHQJ7TRjMjs4OVtd2q3yQT5SPk6Dx_g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: force COMMON_CLK dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your patch!

On Mon, Sep 20, 2021 at 12:02 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without CONFIG_COMMON_CLK, this driver fails to link:
>
> ERROR: modpost: "clk_unregister_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
> ERROR: modpost: "clk_register_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
>
> Add the proper Kconfig dependency for compile testing.
>
> Fixes: 6746cc858259 ("ASoC: mediatek: mt8195: add platform driver")
> Fixes: 940ffa194547 ("ASoC: mediatek: SND_SOC_MT8195 should depend on ARCH_MEDIATEK")

I don't think the second Fixes tag is appropriate, as that commit did not
relax the dependencies.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 5a2f4667d50b..268c1f74aa3e 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -187,7 +187,7 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
>
>  config SND_SOC_MT8195
>         tristate "ASoC support for Mediatek MT8195 chip"
> -       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       depends on ARCH_MEDIATEK || (COMPILE_TEST && COMMON_CLK)

Why not add a second line

    depends on COMMON_CLK

to make a clear distinction between hard and soft dependencies?

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
