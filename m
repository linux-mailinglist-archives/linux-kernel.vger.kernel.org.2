Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD5E31171A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhBEX1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhBEOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:24:12 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F403C0611BE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:49:56 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t17so5273640qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeuHLQ7JECkgdoRKO/4LxCyiZkjLTmsvyU3Pu79LXkI=;
        b=I9UpfpO5HdcWAccTUrGlLX5qDWG3gjoHXGhAAIBeWPfTAANsrkbXZALJ85OryQXAyS
         fNcjtbwQmYSL52UoY6vhHkjjlccBfDahNxMXl++WG6N09lFczbh7zDIR83X4D03y4kK8
         o72O0PaZAZNiF9cHenj+WaQxug7rrH73pyGFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeuHLQ7JECkgdoRKO/4LxCyiZkjLTmsvyU3Pu79LXkI=;
        b=jZmwZ9fYCxvIiKE2ClM11r7S9W21iDNNpmJj2pLHEQ6a1c79AFTuOwrOdA/Kyxzek9
         D3oXPDgTOTI2miUj6QwupMHGmcFcIvUiU9wPv4SAtJV4ZLb80Q3eDdjNPbJlOlhQBy9h
         uvmWcM6/5LltogzysiyPL1/LwyPGNjZXe1Hu4DuDpnbAo01x4vMhI63NXDbt9zfLA1yM
         KVMZ2lnjSf1lMvFosWqmmleP9Z6Aeg48JYAj8iT9YebMia39IdSO2yQH/XWGWYttc8NG
         e9qhQOvM/4OGoRW6xiY4pORzb58sVnPvimOdJXIt5SrK0LvHc2GNN3ropyACei/Et3yk
         gMXw==
X-Gm-Message-State: AOAM5336bQlPqZ8syKxsyXAqjptSBhEB0j5Y+73qzWE0PcMXFTQ9SRaV
        3IAt9YlMcokQLTF3JBmYjO6PFJsIO7GSYA==
X-Google-Smtp-Source: ABdhPJwjUmu7QOfN4QPPnaul7xAZwPe82TwlYNtCAwW+Xybye2tVF8kct+RSzMdjRM16UpLwWUMZlA==
X-Received: by 2002:a05:620a:1485:: with SMTP id w5mr3165285qkj.201.1612536958662;
        Fri, 05 Feb 2021 06:55:58 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g19sm8679419qtc.33.2021.02.05.06.55.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 06:55:58 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id e132so6968448ybh.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 06:55:57 -0800 (PST)
X-Received: by 2002:a25:60d6:: with SMTP id u205mr6993695ybb.276.1612536957207;
 Fri, 05 Feb 2021 06:55:57 -0800 (PST)
MIME-Version: 1.0
References: <1612524533-3970-1-git-send-email-rbokka@codeaurora.org>
In-Reply-To: <1612524533-3970-1-git-send-email-rbokka@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Feb 2021 06:55:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W9YWxVY6cEEXBr1wMcMzEPak3PeyROSvmnOWewL9BiUQ@mail.gmail.com>
Message-ID: <CAD=FV=W9YWxVY6cEEXBr1wMcMzEPak3PeyROSvmnOWewL9BiUQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: nvmem: Fix voltage settings for QTI qfprom-efuse
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 5, 2021 at 3:29 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
>
> QFPROM controller hardware requires 1.8V min for fuse blowing.
> So, this change sets the voltage to 1.8V, required to blow the fuse
> for qfprom-efuse controller.
>
> To disable fuse blowing, we set the voltage to 0V since this may
> be a shared rail and may be able to run at a lower rate when we're
> not blowing fuses.
>
> Fixes: 93b4e49f8c86 ("nvmem: qfprom: Add fuse blowing support")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> ---
>  drivers/nvmem/qfprom.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index 6cace24..100d69d 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -127,6 +127,16 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
>  {
>         int ret;
>
> +       /*
> +        * This may be a shared rail and may be able to run at a lower rate
> +        * when we're not blowing fuses.  At the moment, the regulator framework
> +        * applies voltage constraints even on disabled rails, so remove our
> +        * constraints and allow the rail to be adjusted by other users.

Some year maybe I'll try to fix the regulator framework to not count
voltage constraints for disbled rails, or perhaps have it be optional.
;-)  In theory it should be much easier after the patches we already
landed not to count current requests for disabled rails...


> +        */
> +       ret = regulator_set_voltage(priv->vcc, 0, INT_MAX);
> +       if (ret)
> +               dev_warn(priv->dev, "Failed to set 0 voltage (ignoring)\n");
> +
>         ret = regulator_disable(priv->vcc);
>         if (ret)
>                 dev_warn(priv->dev, "Failed to disable regulator (ignoring)\n");
> @@ -172,6 +182,17 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
>                 goto err_clk_prepared;
>         }
>
> +       /*
> +        * Hardware requires 1.8V min for fuse blowing; this may be
> +        * a rail shared do don't specify a max--regulator constraints
> +        * will handle.
> +        */
> +       ret = regulator_set_voltage(priv->vcc, 1800000, INT_MAX);
> +       if (ret) {
> +               dev_err(priv->dev, "Failed to set 1.8 voltage\n");
> +               goto err_clk_rate_set;
> +       }
> +

Looks right to me.  Assuming that this works.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
