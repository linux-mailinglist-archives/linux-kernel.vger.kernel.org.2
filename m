Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3751E3DB99B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbhG3Ntc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhG3Nta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:49:30 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C7C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:49:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a12so6419502qtb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKFVB3IPR9lkSCEivG2PKNtFQz06R+D8dqrPSZQVhIs=;
        b=MEbABptqXJglM26bxbD6CXo+dI7tsy8Ef6mKgr0+/TMZtm6CaLpLI83wRe6CtDssMY
         cGrKlT8wH4v18FxmQJ5UKSyQwjt7aPP5UxUNzNEQLXCLZk8BsgyYxmJcfjJSSJcjTnhh
         +qe1EKdSoyzxiUawP0TyNaR3uCQQRcxX+DYLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKFVB3IPR9lkSCEivG2PKNtFQz06R+D8dqrPSZQVhIs=;
        b=St3iuIFwI3wVwfy9aB8X5yXWWS/3nVAJznvJx/4WK9ihhudbvJtfnDu0NRUsB4CDBc
         eAbX59hBF94eC1rvIJXwh7ilI6a59RF/b/WS6tDQ8PGq2cUkq5T6AXoDh6jkGwrnfztx
         qjmtR4Aqycteesu+VSpDnLEqeYdutm3DrL50sWABKYgEoT+r7rOcAxxG42PALdHagrwC
         oGwlANwGVZr35/lqlxpoKYTwPhG8yU8qcXjc+AT6++mhjAJ1ORgGe1NYxH6zB+nJsJ78
         O9DuDNVmCRMpXmXXCB8pUcBfEL2/t2Dp1uFhzQn5eBccblrDQ9HBsflEgMf4EEEUTMCF
         coHA==
X-Gm-Message-State: AOAM531GScjiM5NXbva2QbPjWJM4HGfYyPnyR+BRTlsO7czZOLGoDGSr
        8ltAt4O6oQvJmNUyl2s+REI7TpeEkGB9Wg==
X-Google-Smtp-Source: ABdhPJx1nBfQaSlEn2iFzGQ0+JVZ7vIuFaSO6Y4gRrEjgqUcHkUy4b2lE0d7zwE27I6UBYxZ5zwBFg==
X-Received: by 2002:ac8:47d9:: with SMTP id d25mr2314124qtr.277.1627652963215;
        Fri, 30 Jul 2021 06:49:23 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id y2sm923218qkd.38.2021.07.30.06.49.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 06:49:22 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id w17so16048781ybl.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:49:22 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr3375680ybb.257.1627652961581;
 Fri, 30 Jul 2021 06:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <1627627573-32454-1-git-send-email-rnayak@codeaurora.org> <1627627573-32454-3-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1627627573-32454-3-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jul 2021 06:49:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9wzRu20xydjt3c6682rWocd6dik6qRc9N1t_Dq97ODw@mail.gmail.com>
Message-ID: <CAD=FV=X9wzRu20xydjt3c6682rWocd6dik6qRc9N1t_Dq97ODw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] nvmem: qfprom: Fix up qfprom_disable_fuse_blowing()
 ordering
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 29, 2021 at 11:46 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> qfprom_disable_fuse_blowing() disables a bunch of resources,
> and then does a few register writes in the 'conf' address
> space.
> It works perhaps because the resources are needed only for the
> 'raw' register space writes, and that the 'conf' space allows
> read/writes regardless.
> However that makes the code look confusing, so just move the
> register writes before turning off the resources in the
> function.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/nvmem/qfprom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index 81fbad5..b0ca4c6 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -139,6 +139,9 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
>  {
>         int ret;
>
> +       writel(old->timer_val, priv->qfpconf + QFPROM_BLOW_TIMER_OFFSET);
> +       writel(old->accel_val, priv->qfpconf + QFPROM_ACCEL_OFFSET);
> +
>         /*
>          * This may be a shared rail and may be able to run at a lower rate
>          * when we're not blowing fuses.  At the moment, the regulator framework
> @@ -159,9 +162,6 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
>                          "Failed to set clock rate for disable (ignoring)\n");
>
>         clk_disable_unprepare(priv->secclk);
> -
> -       writel(old->timer_val, priv->qfpconf + QFPROM_BLOW_TIMER_OFFSET);
> -       writel(old->accel_val, priv->qfpconf + QFPROM_ACCEL_OFFSET);
>  }

I think it doesn't matter since all of these resources are just needed
for burning fuses, but I agree that what you have here makes more
logical sense and makes the function less confusing.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
