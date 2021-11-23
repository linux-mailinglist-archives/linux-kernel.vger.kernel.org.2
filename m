Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2345AC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhKWTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhKWTiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:38:07 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30D4C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:34:58 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id k23so393494lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAMWwENTmC7DzHcgX7E/tW+4+EEPwisOX8kGjUdddTY=;
        b=YF6gOICxsFKSGsCKGEnlRdknU4T7rQ2D+vR7fhPq+flRWwgs8jYEWXZ3RrOY0m23cP
         jyRrELQ4i1OwvAxclElGmeuj8dmIaPKHwE5LtTdTiwyc9qMwCn20KvjSMqG80b71Y/SO
         hYUJ/gQaLNHZprcrlKRehj9zm5fE9Bye4W2yEKpuBQfRw2cMCMLYgjHE416JiwCWHr68
         NJsIaObwr6s61lfkEnSurC9kEcuvAaOvgY2g7YE2CFk9SXI3zEi8ZdSWV3e4CNxIwz+c
         +CVOrkFegJlJBfGlQq+4yScr0gMVdlTps0usPOWCov/Tnm7Ys0im+RYvR0mIGD3M35rM
         6Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAMWwENTmC7DzHcgX7E/tW+4+EEPwisOX8kGjUdddTY=;
        b=vdcXrQ9P7h6RpvWR8fxtOVfb3u4i3qyRjAsRleB2qLjZmsaEcLnkyIDUIQW/Y5kalG
         MUdECS0hEHw/8sYINVNXrLD8uzDHj839Ehw5GB9QDsrQERZGgzftxAOQ3gCpUx5kqgS8
         KPKKPX9g4257Onmbvh5quR/9/D7CST1JMrZI5T5EmQcxA7s3t7kQJtVniwlEtYAjEX1K
         gNgSapudNzFzhp+sGdyAbkoIHgNJBWXWc3JmsB/Scaj3MvyzDEKxf9vDBhpZGqJZVQfy
         6K/MC3SK7m/Pc+/RP3dRIY61wB+6yzgc90aA279emBinuybi74xX5OLlIQFAFySNgY5e
         8IeQ==
X-Gm-Message-State: AOAM533fGiUfRnPcffQmq1f+1TI8vRr+uPp00/kB7VM5Im+tkzUKWVMN
        LrEaUy29fXj+len3FBKvtAlgoWe+2kuUichy9M+fFQ==
X-Google-Smtp-Source: ABdhPJwrjHz86W+VahcN/ogSmg3g2k2OHcHKcRD40FmzVFDWnMKV0fz6haEETY3J8bDF4QtQN9WFXdVoWSBwT7iGa6k=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr8391990ljp.367.1637696097076;
 Tue, 23 Nov 2021 11:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20211116190244.1417591-1-john@metanate.com> <20211116190244.1417591-3-john@metanate.com>
In-Reply-To: <20211116190244.1417591-3-john@metanate.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 20:34:20 +0100
Message-ID: <CAPDyKFp1zMBUfK7LteW0yEfTpqtU+P+EybLsJBFx_r54HwFdMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: use standard "mmc" alias stem
To:     John Keeping <john@metanate.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 at 20:02, John Keeping <john@metanate.com> wrote:
>
> The standard stem for MMC aliases is "mmc" and this is used by the MMC
> core to set the slot index.

This isn't the correct description of the mmc aliases. The below text
is copied from the DT doc:

"It is possible to assign a fixed index mmcN to an MMC host controller
(and the corresponding mmcblkN devices) by defining an alias in the
/aliases device tree node."

>
> Use this in preference to the non-standard "mshc" stem when setting the
> controller ID to avoid needing two aliases for each MMC device in order
> to cover both the core and dw_mmc-specific functionality.
>
> The old "mshc" lookup is kept for backwards compatibility.

The mshc alias is really weird!

It looks like some leftover from when the dw_mmc controller supported
multiple slots. This support was dropped a long time ago, simply
because it never really worked - and it was not worth trying to. Only
one slot per controller is supported.

Rather than re-using the mmc alias in the same weird way as the mshc
alias, I suggest we try to remove parsing of the mshc aliases
completely. By looking at the corresponding code and in combination
with the DTS files, it certainly looks doable to me. Do you want to
have a look at it?

Additionally, there is no need to deprecate the mshc alias binding, as
it seems like it has never been documented. :-)

Kind regards
Uffe

>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 37af1245304b..6ffaa354410a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -112,7 +112,11 @@ int dw_mci_of_alias_get_id(struct dw_mci *host)
>         if (WARN_ON(!host->dev->of_node))
>                 return 0;
>
> -       ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
> +       ctrl_id = of_alias_get_id(host->dev->of_node, "mmc");
> +
> +       /* Compatibility fallback for old device trees. */
> +       if (ctrl_id < 0)
> +               ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
>
>         if (ctrl_id < 0)
>                 ctrl_id = 0;
> --
> 2.34.0
>
