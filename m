Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6334F2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhC3VTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhC3VTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:19:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A7FC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:19:30 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l13so13005240qtu.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6rFezdA5OJ9mTG164jTh973n/T9ArBSRkBvKYL1hbU=;
        b=F7orwkVqtDNCgPCQA7+jYbbqDLvKxYNea+LjGvci1d+v8BM3zK4cp7X7GMk1sm+Sp0
         zHMF4kvJWCe/Px6LUkBaeWTFEZD5PT5V94tmq58Kdm/Ypqt27jAWFNktBNRGoJlWpdS7
         /nQlLxzxXtPiz0sAL6LPHeCXWK1eU/D30Sens=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6rFezdA5OJ9mTG164jTh973n/T9ArBSRkBvKYL1hbU=;
        b=WZ4MuP/hfWXGURpLYPYmw/kv4at4LDcu340AIykZ+GoTql/E4rIJaKSzeWZ8yS9QbQ
         stote2SbL8+4uT1f684LLgsoJkBUGKaqIQVctm94DA+r8ofZqurzwYFdzMcE9ZMj/Ijr
         uO/VpUI6L7eH2Jgb4IAExy/nvolWaL6KU0Yh+fyuyrBb292rUvtGFDxaadXInO/UWIXc
         XmAU5DeUxwetMMdDJcLzL9hRf3gE79L5tUPgzM0qy0FrquR5Jkg2h9OAvGrwHSa82awZ
         WkJPdZZ7OZcNYiSLOi1ghXONph9AreYwimspHfWEE0ySX8FUOOpokwp1TCsVxldV4Cnq
         E82A==
X-Gm-Message-State: AOAM533uJTtpwYS44WPgS5TTEovLuaDu804mBAl/WFkWBze5ARIwsF5k
        tCFY5X+VhbLwuVgrzd/mLUi7Ksy+0jSgbw==
X-Google-Smtp-Source: ABdhPJzAKQi3eeHJ0aTfVao1QLjr+u0DXMY/tifC3vJ843/Iy/cHmY+Bw8pdOdWxuNAJgJpDPIZ+Hg==
X-Received: by 2002:ac8:71d2:: with SMTP id i18mr29362517qtp.371.1617139169199;
        Tue, 30 Mar 2021 14:19:29 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g6sm16884055qkd.62.2021.03.30.14.19.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 14:19:27 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id j198so18828333ybj.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:19:27 -0700 (PDT)
X-Received: by 2002:a25:2f4b:: with SMTP id v72mr238021ybv.79.1617139166929;
 Tue, 30 Mar 2021 14:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <1616651056-11844-1-git-send-email-rnayak@codeaurora.org> <1616651056-11844-2-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1616651056-11844-2-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Mar 2021 14:19:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VT6xUmUK7Kss8cpF1wjw9tLx67wJMtiV6yTDaVYXXrqA@mail.gmail.com>
Message-ID: <CAD=FV=VT6xUmUK7Kss8cpF1wjw9tLx67wJMtiV6yTDaVYXXrqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvmem: qfprom: Add support for fuse blowing on sc7280
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 24, 2021 at 10:45 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> @@ -111,6 +113,15 @@ static const struct qfprom_soc_compatible_data sc7180_qfprom = {
>         .nkeepout = ARRAY_SIZE(sc7180_qfprom_keepout)
>  };
>
> +static const struct nvmem_keepout sc7280_qfprom_keepout[] = {
> +       {.start = 0x128, .end = 0x148},
> +       {.start = 0x238, .end = 0x248}
> +};
> +
> +static const struct qfprom_soc_compatible_data sc7280_qfprom = {
> +       .keepout = sc7280_qfprom_keepout,
> +       .nkeepout = ARRAY_SIZE(sc7280_qfprom_keepout)
> +};
>  /**

nit: blank line between structure and comment?


> @@ -187,9 +199,9 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
>          * a rail shared do don't specify a max--regulator constraints
>          * will handle.
>          */
> -       ret = regulator_set_voltage(priv->vcc, 1800000, INT_MAX);
> +       ret = regulator_set_voltage(priv->vcc, qfprom_blow_uV, INT_MAX);
>         if (ret) {
> -               dev_err(priv->dev, "Failed to set 1.8 voltage\n");
> +               dev_err(priv->dev, "Failed to set %duV\n", qfprom_blow_uV);

nit: the comment above this block (not in the unified diff)
specifically calls out 1.8V. It'd be nice if you updated the comment
since it's no longer fixed at 1.8V.


> @@ -379,6 +399,8 @@ static int qfprom_probe(struct platform_device *pdev)
>
>                 if (major_version == 7 && minor_version == 8)
>                         priv->soc_data = &qfprom_7_8_data;
> +               if (major_version == 7 && minor_version == 15)
> +                       priv->soc_data = &qfprom_7_15_data;

nit: "else if" instead of "if"?


I guess I'm a little late since I think this already got applied, but
all the above are nits. Maybe you could send a follow-up patch to
address them?

-Doug
