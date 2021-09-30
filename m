Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88AE41D8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350472AbhI3L1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350444AbhI3L1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:27:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DC4C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:25:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u18so23835109lfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuWajK2Vii41SiDlh9TTWWF0mw4w25Q0O4RAtrkwQRE=;
        b=tFDH3e22bxO1f/FW2NFzaUcXTUhaogzBYzqVOQueZE9qXFWpZLs6dUg5VihT5BeeIC
         X/8HCmmgjGub64eLEQ5+ZARJyMSbSZC2Xnm4Mq458PK7jNkIdqOiNao9PY7x7dSFte1a
         8VcZ/33yci0z0aBUq5zryWBCGaUmefCgCBB/JLNGdvtR/7hlFIhcMSoUm8vQyT2gkVjZ
         /OInZhBmO2vZhOiHnVzSh76Y3898705zSEQe5wS/q1s12bFjVqS8UoWblw/RvKKfPe2d
         Bd/NTjGbEB4SzyWZoRmC4vEm3C5ELdEozRiSO2naa/iC2J3XylmE2xtPSR7btOwwqpw3
         IPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuWajK2Vii41SiDlh9TTWWF0mw4w25Q0O4RAtrkwQRE=;
        b=KeZjeQi5YUegmAxhZT3v6pz27D9Zb5Cbcir8tvH6QmYzkLTaAahxe0XYnXf8FMFEkV
         Y675rTlytZWDmkLd023rTUt55N+1xV4cGA3pt+sHXmHESUVwoTg1pEHKT7kIdk7KKU9/
         dSgTl6J3qOLgEnCyteUlJV+fse1wLjLE6/gfX28jAazcn9s8av78tLGLHsJColWszWHq
         Zxo1jZReUSn2AlXR/vCtpAX0lvhzjI9HJxgmhpsXs/Dg42LMK2FTtMH2wQ0d3lArbdIY
         QqeWslBOV0BKsfZdvc0RmhjR24bd0aG1QpnQKzBpEsKtn8U+kU5Ge92mn7WK1pVr9Bqh
         o6QA==
X-Gm-Message-State: AOAM533nx9IKoSO0dqWL3/U6e0dbB5OArJrx+xzEMQjvoD5i7bwbSMPA
        /KHq6DeJGbo2N9WAz38g7Nkdq4KoMcNqKmsW+F64emLLx3w=
X-Google-Smtp-Source: ABdhPJyPFP3Fvxf55MEWXbcgZbyXPCmbmefXEfcokkOYmtHBZ6fdxo0S9lTY6Wvb5Xoeb3x/hORezmvGdDeSzBYzXfQ=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr5594997ljn.463.1633001131038;
 Thu, 30 Sep 2021 04:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210929111757.52625-1-andriy.shevchenko@linux.intel.com> <20210929111757.52625-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210929111757.52625-2-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 13:24:54 +0200
Message-ID: <CAPDyKFr+Y-fjKvjOg_W=+hHPABTHdApZ8=WWwXn6gQy0tn6+bQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: slot-gpio: Update default label when no
 con_id provided
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sept 2021 at 13:17, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Currently default label of GPIO is assigned to the device name,
> when no con_id provided. Instead, let's update it to reflect
> what it's about (use already prepared template).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/slot-gpio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index e365d328f43c..dd2a4b6ab6ad 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -178,6 +178,10 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>         if (IS_ERR(desc))
>                 return PTR_ERR(desc);
>
> +       /* Update default label if no con_id provided */
> +       if (!con_id)
> +               gpiod_set_consumer_name(desc, ctx->cd_label);
> +
>         if (debounce) {
>                 ret = gpiod_set_debounce(desc, debounce);
>                 if (ret < 0)
> @@ -226,6 +230,10 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>         if (IS_ERR(desc))
>                 return PTR_ERR(desc);
>
> +       /* Update default label if no con_id provided */
> +       if (!con_id)
> +               gpiod_set_consumer_name(desc, ctx->ro_label);
> +
>         if (debounce) {
>                 ret = gpiod_set_debounce(desc, debounce);
>                 if (ret < 0)
> --
> 2.33.0
>
