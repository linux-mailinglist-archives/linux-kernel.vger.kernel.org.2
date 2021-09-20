Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924784114FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbhITMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhITMz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:55:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF238610CE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632142439;
        bh=W1eYMmg9H2jFhknPdndD+apjfXD08+jcBBvof7g6zWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S7MJFsqD329nVxBkT3qwZRjVziZdooDG/bJRPvx0Q9Iq3SPPXzDGYDb+9aSViTfS7
         7SXCE6oiiFvWGI+1XYBiwps+OZoeEXZIVulXjF6zI1a3BuzLgVGtJLEgGRRFi4k5H2
         wvf4P7hbXWrcNIXiU0FL940HN90ryprb+4Qv/w6MUY8kItqxzd0k2iinbx7TW6g/pb
         4vYAIGMdwbagWgjGpjWTACn0kkA7eDZvVyg1RshPDqgPee6wuvkwNPJw6jSywFuxJr
         LymfjSSgslnzgDwl8eoxu99g5NOfpmNw3DU+7VJczwV4sQRaLkvE+6qxI3gHS76Fv2
         q2S9mgfzC/0vQ==
Received: by mail-wr1-f42.google.com with SMTP id d6so29282907wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:53:59 -0700 (PDT)
X-Gm-Message-State: AOAM533cOn2EuEpnkH7L5PyveKfnO9oBE6dc8SoEsr7uV1swDd3IgPGH
        8LqY3tdI/h6140FpnekzVuxayXkNv2OfqbB3anQ=
X-Google-Smtp-Source: ABdhPJwgSLeOA+5EYUZWyMXPW6vc2urD0vjnW6PXs7wvXSXhdxd/LtmNdjYm/cajU/C5Q3kNTl/tQUp6tjS8FOlAVrE=
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr29348860wmf.82.1632142438279;
 Mon, 20 Sep 2021 05:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210920100206.1418649-1-arnd@kernel.org> <20210920123542.GA14852@sirena.org.uk>
In-Reply-To: <20210920123542.GA14852@sirena.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 20 Sep 2021 14:53:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0uz0Uy1p1Ku9_rqwgh0hnEhWrDqxzgd9cU4Dcd++TMMQ@mail.gmail.com>
Message-ID: <CAK8P3a0uz0Uy1p1Ku9_rqwgh0hnEhWrDqxzgd9cU4Dcd++TMMQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: force COMMON_CLK dependency
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
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
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 2:35 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Sep 20, 2021 at 12:01:58PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Without CONFIG_COMMON_CLK, this driver fails to link:
> >
> > ERROR: modpost: "clk_unregister_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
> > ERROR: modpost: "clk_register_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
>
> This doesn't apply against current code, please check and resend.

It's already fixed the way that Geert suggested in your asoc/for-5.15,
sorry for the dup.

        Arnd
