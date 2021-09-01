Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063253FD44D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbhIAHP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:15:59 -0400
Received: from mail-vk1-f178.google.com ([209.85.221.178]:45980 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbhIAHP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:15:58 -0400
Received: by mail-vk1-f178.google.com with SMTP id h13so632486vkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 00:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QadCFZQ2SQPPYc3LZSgseGA9mPxC2ggiigDkQzPcZ7E=;
        b=tWwuLhIqdXJAL+Vy1w5kKq6yGCZT4mSIORSxp/7YOJklBAvhq30cHShFL0o1W7jHPr
         Nlh8i81uHBwC/rzRWWVw2Oux+k2mLmc2ZfBGT1+CEOrgdxHuro49zjw7lS/KhMpFT/GA
         3JzferU/wgaVRKMgDHA4ndZQ8iM+lB/2WxnDYQo/46Y3tkgIUERxjAx8Xr2JXlmBJ+Sb
         KVR7vUJB1+fsPVp5iOx6/CyX8KPTBirErKEzoph3ORdI0N+mbozqAhOqd9klCB2YdnZE
         JyhuYu0peXh/fjB3rYiFW5DJ01Y9jzQX8+UhQkIaynnoZjS8balQrQH66Ws249FnlxRB
         Za5g==
X-Gm-Message-State: AOAM532VJ5NRFaI43nPuOpNOAJ0DHEgjvPFA1fmMco79WjBNcSZKdJrA
        /1ezVQLt1RVaWBHSf/InlycQT2EAEAKal3yNaXA=
X-Google-Smtp-Source: ABdhPJwsjmzlnZudgyUqICpu9dUfkd2zTmDDo4gWcc2mlI2J0tB7JsSrjrkZZ5a9NdFjWFziJSe1eOA2qgj7wUlPqbA=
X-Received: by 2002:a1f:738f:: with SMTP id o137mr20861558vkc.2.1630480501855;
 Wed, 01 Sep 2021 00:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <7e628e359bde04ceb9ddd74a45931059b4a4623c.1630415860.git.geert+renesas@glider.be>
 <535478691c3a9ed31b508f59dc897be57c4213c0.camel@mediatek.com>
In-Reply-To: <535478691c3a9ed31b508f59dc897be57c4213c0.camel@mediatek.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Sep 2021 09:14:50 +0200
Message-ID: <CAMuHMdUd+j7MYv3LXOH1C45UjEqVVjwm1mmyzpZyv+cuR3cDaw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: SND_SOC_MT8195 should depend on ARCH_MEDIATEK
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trevor,

On Wed, Sep 1, 2021 at 5:48 AM Trevor Wu <trevor.wu@mediatek.com> wrote:
> On Tue, 2021-08-31 at 15:18 +0200, Geert Uytterhoeven wrote:
> > The Mediatek MT8195 sound hardware is only present on Mediatek MT8195
> > SoCs.  Hence add a dependency on ARCH_MEDIATEK, to prevent asking the
> > user about this driver when configuring a kernel without Mediatek SoC
> > support.
> >
> > Fixes: 6746cc858259985a ("ASoC: mediatek: mt8195: add platform
> > driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  sound/soc/mediatek/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> > index cf567a89f421b4c0..c8c815f599da90bf 100644
> > --- a/sound/soc/mediatek/Kconfig
> > +++ b/sound/soc/mediatek/Kconfig
> > @@ -187,6 +187,7 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
> >
> >  config SND_SOC_MT8195
> >       tristate "ASoC support for Mediatek MT8195 chip"
> > +     depends on ARCH_MEDIATEK || COMPILE_TEST
> >       select SND_SOC_MEDIATEK
> >       help
> >         This adds ASoC platform driver support for Mediatek MT8195
> > chip
>
> Hi Geert,
>
> Thanks for your patch first.
> I really missed the dependency declaration.
> But we only test "depends on ARCH_MEDIATEK" internally, maybe removing
> "COMPILE_TEST" like other MTK series is better for the maintenance in
> the future.

If the driver compiles with CONFIG_ARCH_MEDIATEK=n, it is better
to enable compile-testing, as that may catch issues.\
I didn't change the existing MTK symbols, only new symbols.
(adding missing dependencies to existing symbols is in my (huge) backlog ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
