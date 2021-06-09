Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E343A108B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhFIJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbhFIJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:50:55 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA4C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 02:49:00 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z1so24748079ils.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCj9GCI+5QISlmGJjehDkaz0A2PdjbYMmQM8TFM7cPQ=;
        b=eJFtZM3I6Dm/cIcSWJdNjF3jep+VNcHdOjE4Inxmm7DNf5csnGMG1e+98OSj/SImd/
         wBzkqd/JQyXoIo2or+T2MIs3EKFuHAazJoCZ0i4DHsmOvL3sec1wOKWsfgZn9pF7AYUK
         i76J3nSz/DDNHF/bzdTKFIitmBwzGlnpHAmXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCj9GCI+5QISlmGJjehDkaz0A2PdjbYMmQM8TFM7cPQ=;
        b=ghu+Gyd14ISKTyS0A+Nwf33zkdahxVfIIKOsbDpI+/SeJom/Lu/GEb4RKJLDNHWWdU
         5taCVl8URtDfsWwHiW4BOXU+up1c9xfY9eiZqg8pF7GSsvzra0vvq8z0orGQv499AF07
         2YKkAGgdBNqD8LN2xt4Y6pG8/jM243KbgCHc3OoX5xinohMurx+ZqsMmZz1S8l1hRRm/
         BepcyP/H5OGI5hSp0N5ESAiEXJUK0igqgXYu04CMB8UEYLxGVI2iYIvONJfLEt38A1vT
         meIF7awyQc6JKjrrgqHBZcHMv+2G2UUyhBQoX+N/ViiZsZ8Funb3+mLPFh5bMenKVXtO
         MIWQ==
X-Gm-Message-State: AOAM533Yy+WHR/suFEb0jCxhITqmKKUKLyBn20wMTVRdHmJCLYTfvawx
        8SKYQPJomo/n1992VAxF8pgLH4a49sX7Iw==
X-Google-Smtp-Source: ABdhPJz2g3YXjXusWf49O2tC8dqOL+DhOKbZtoiNPtiE1pir7bjRAGEOUrfkDay7z3cpxN3KJi5ATA==
X-Received: by 2002:a05:6638:1029:: with SMTP id n9mr24641041jan.48.1623232138915;
        Wed, 09 Jun 2021 02:48:58 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id b23sm1241123ior.4.2021.06.09.02.48.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 02:48:58 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id v13so24608955ilh.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:48:58 -0700 (PDT)
X-Received: by 2002:a92:d589:: with SMTP id a9mr22625576iln.175.1623232137595;
 Wed, 09 Jun 2021 02:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com> <20210517173314.140912-5-gene.chen.richtek@gmail.com>
In-Reply-To: <20210517173314.140912-5-gene.chen.richtek@gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 9 Jun 2021 17:48:21 +0800
X-Gmail-Original-Message-ID: <CAC=S1njg1PUAkz+TvbtPPxm4uDb3xDSA5HmOOgjwrLz01vFzHw@mail.gmail.com>
Message-ID: <CAC=S1njg1PUAkz+TvbtPPxm4uDb3xDSA5HmOOgjwrLz01vFzHw@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] mfd: mt6360: Combine mt6360 pmic/ldo resources
 into mt6360 regulator resources
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     lee.jones@linaro.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:34 AM Gene Chen <gene.chen.richtek@gmail.com> wrote:
>
> From: Gene Chen <gene_chen@richtek.com>
>
> Combine mt6360 pmic/ldo resources into mt6360 regulator resources
> to simplify the similar resources object.
>
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/mt6360-core.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 512480f7bd40..3553c7045829 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -266,7 +266,7 @@ static const struct resource mt6360_led_resources[] = {
>         DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
>  };
>
> -static const struct resource mt6360_pmic_resources[] = {
> +static const struct resource mt6360_regulator_resources[] = {
>         DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> @@ -279,9 +279,6 @@ static const struct resource mt6360_pmic_resources[] = {
>         DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),

Nit: sort MT6360_LDO*_OC_EVT and MT6360_LDO*_PGB_EVT after combining
the resources.

>
> -};
> -
> -static const struct resource mt6360_ldo_resources[] = {
>         DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> @@ -299,10 +296,7 @@ static const struct mfd_cell mt6360_devs[] = {
>                     NULL, 0, 0, "mediatek,mt6360-chg"),
>         MFD_CELL_OF("mt6360-led", mt6360_led_resources,
>                     NULL, 0, 0, "mediatek,mt6360-led"),
> -       MFD_CELL_OF("mt6360-pmic", mt6360_pmic_resources,
> -                   NULL, 0, 0, "mediatek,mt6360-pmic"),
> -       MFD_CELL_OF("mt6360-ldo", mt6360_ldo_resources,
> -                   NULL, 0, 0, "mediatek,mt6360-ldo"),
> +       MFD_CELL_RES("mt6360-regulator", mt6360_regulator_resources),
>         MFD_CELL_OF("mt6360-tcpc", NULL,
>                     NULL, 0, 0, "mediatek,mt6360-tcpc"),
>  };
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
