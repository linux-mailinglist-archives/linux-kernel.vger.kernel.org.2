Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410E8441FB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhKAR7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhKAR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:58:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210FC061767;
        Mon,  1 Nov 2021 10:56:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso4356wmd.3;
        Mon, 01 Nov 2021 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZ2A2AWagNpv2J8C8P3tLCVgYhd2un+CUt39jsHUZpc=;
        b=JsBw+/WDf2+nx6I0RUT1eXgDPCkJk4ykkvyEZ238RYwKJ3qDaKRsJODzA9eJ1SrR6M
         KR5MYPjaYeQUnH52j2eXrj8I/uz8phJ2Z7uZ+JjusWHJFxfRDYpZ9+sZbyqLjnDzf2P7
         /Z8TjVHHXrDSqPhsxCSjk/6CL8CJsOc5ZJE78ur0eMGBNcJBrd51DCpeRCyzH7ovKCoh
         kgE2c64VAfVU0nY6ajuPze5o6VeNElMlXUmUiJ6wKhmfn6Lvdnc1qGAJouGUubToQr1R
         aIoxZ+m+5GfutNpg8WEN8FS2IfUjXSci/JYQ5IPSRX97WHpmhFJfi//GDhu6nPIvtG9j
         FK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZ2A2AWagNpv2J8C8P3tLCVgYhd2un+CUt39jsHUZpc=;
        b=Qa/NhH+ykSoewyngHb5tEwflEq3kMGHBuq/qhUMF9rUtSV48h1R4ZIt9moz2aMzV1w
         iBGQfNm/fGtcLqA5+l9Fss/SW4ehADC1yj9jPA5g3BhPWzYkfQIs6jZu3zzzQjsN3Pqu
         Ll3XzBZWX3KtpP/DWpvRL6LC1Ug89GMaEUM/MVoT7ZU6VNX64u2WU45GRHrPNZUyHF5e
         BEXilvRfV3O962M7BPYdiMY/7ltkPZ7LjcVhyQiHr3P4/qblmEPwe9tNMYAibbbrcXgW
         7frpFSuMk0VKuk3lXKk1GhWqFY8cc1tR1PzkwUMxJy1+6KLyQeVGqCoT1+g5pRjhi/Do
         kicw==
X-Gm-Message-State: AOAM531Ap8kyj8FE5wsdMkvOxD7Tp0M8GRn7V8jlb6tJrqXvFZ66vkqy
        BWuHbO+GSkYFAnw/48Hc+8V/nFnQqmDBKNS+uBQ=
X-Google-Smtp-Source: ABdhPJw8wKcfyMP3WnvzELw4fAFEeF9Qqe/NMhnO6k7F1oamAM9YgTt8bPddiGlxtH3a7+NJoBGGnIWyIHXYGeKvo1o=
X-Received: by 2002:a7b:c1d5:: with SMTP id a21mr502663wmj.14.1635789376712;
 Mon, 01 Nov 2021 10:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211028135737.8625-1-yc.hung@mediatek.com> <20211028135737.8625-2-yc.hung@mediatek.com>
 <YXwoB7FtRw0AzgcD@sirena.org.uk>
In-Reply-To: <YXwoB7FtRw0AzgcD@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 1 Nov 2021 19:56:04 +0200
Message-ID: <CAEnQRZCQHxctG+3L72Xx3083shytF478ONGGpZf0A-6-+nFE=w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ASoC: SOF: mediatek: Add mt8195 dsp clock support
To:     Mark Brown <broonie@kernel.org>
Cc:     YC Hung <yc.hung@mediatek.com>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, matthias.bgg@gmail.com,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>, trevor.wu@mediatek.com,
        allen-kh.cheng@mediatek.com,
        angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 8:00 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Oct 28, 2021 at 09:57:36PM +0800, YC Hung wrote:
> > Add adsp clock on/off support on mt8195 platform.
> >
> > Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: YC Hung <yc.hung@mediatek.com>
> > ---
> >  sound/soc/sof/mediatek/adsp_helper.h       |   2 +-
>
> This doesn't apply against current code, there's no such file upstream.
> Please check and resend.

This patch was sent only to get an Ack-by for 2/2 from Rob Herring.
The patch will go first to SOF tree and then I will
send you a patch based on your for-next branch.

YC sorry for not being more explicit. I think the right way was to
mark this patch series as [RFC PATCH].
