Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F3422FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhJESI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhJESI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:08:26 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48073C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 11:06:35 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x124so373303oix.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ZhJmS/oaFcG0CCC1jcKsenxPXA1oO8fnKa8QfXuwC6Y=;
        b=P7Ks9E3jRuLaebd0/Wgoc5DyaqIFcAoRmR/amJcDKI4CaK0QQU9tSBKiH9TeEonza9
         dPqOzNonsSRhVVPt1vmxKtKvXmkLnWG1nFcbJlQeV85bHrVIQHqSC79AN1TE9cchxjUC
         xQdRIiwPCeK3dAGVmMlBOIcoSJpYJ7prn2A34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ZhJmS/oaFcG0CCC1jcKsenxPXA1oO8fnKa8QfXuwC6Y=;
        b=F7nn0iJH+M6tnHlXnJo4yXV/UkOzuVWmLOyZhKN/495ka3Td1jI92fSxUdS4IsMLVw
         R48HzI+5aCRKtRrrrdJ7h2Z3i3MMiwziNwY2kV2fXL0WBtJICc3MRHk1kruiR48sW3RV
         8FkhuQvIs6CQno92ixEtXsYhqomHsG8L1Z3a+6LSbAYNA45+SXqu8GHNplNfGWVYxBuM
         rBgQJSLMNsAqzE6E2+QyTwnSz4eoCevoO70Eo6aMVraFwfdYPlQDTDuhdIEa9bIsBlrt
         sXh0nPusa+/iy9Yrcxdw5r7YTWPsaiRkzDkdAElKwdxW1UqGGGvvKWihIS0WJlxWyPE1
         CDtQ==
X-Gm-Message-State: AOAM533RcmAXiugNsPXV5vbffgEbYemjv9CCNBf/D2+WmtrkIfL3CGp7
        5Q6vl/+luOi9EHz/ww5iHKzdDTC+KLKZAcnGuUhWKQ==
X-Google-Smtp-Source: ABdhPJwy7XEXx1crzpVbI98jIWwyHysBUIuro9gRyQtRlRRB27rta23ocJ1zayjMe/m6FjoIgKNVHGMbx873MznmCeE=
X-Received: by 2002:aca:42d7:: with SMTP id p206mr3684143oia.32.1633457194655;
 Tue, 05 Oct 2021 11:06:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Oct 2021 11:06:33 -0700
MIME-Version: 1.0
In-Reply-To: <1633427071-19523-1-git-send-email-mkrishn@codeaurora.org>
References: <1633427071-19523-1-git-send-email-mkrishn@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 5 Oct 2021 11:06:33 -0700
Message-ID: <CAE-0n535JFD9QDeeDk5Tik4DKqt68pQRsHTbW9sxvHijXhOE3g@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msm: use compatible string to find mdp node
To:     Krishna Manikandan <mkrishn@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kalyan_t@codeaurora.org, robdclark@gmail.com,
        bjorn.andersson@linaro.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krishna Manikandan (2021-10-05 02:44:31)
> In the current implementation, substring comparison
> using device node name is used to find mdp node
> during driver probe. Use compatible string instead
> of node name to get mdp node from the parent mdss node.
>
> Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 2e6fc18..50a23cf 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1241,9 +1241,16 @@ static int add_components_mdp(struct device *mdp_dev,
>         return 0;
>  }
>
> -static int compare_name_mdp(struct device *dev, void *data)
> +static int find_mdp_node(struct device *dev, void *data)
>  {
> -       return (strstr(dev_name(dev), "mdp") != NULL);
> +       return of_device_is_compatible(dev->of_node, "qcom,mdp4") ||

Why do we care about mdp4? It looks like this function is only called if
get_mdp_ver() returns 5 or DPU, in which case 4 isn't relevant?

> +               of_device_is_compatible(dev->of_node, "qcom,mdp5") ||
> +               of_device_is_compatible(dev->of_node, "qcom,mdss_mdp") ||
> +               of_device_is_compatible(dev->of_node, "qcom,sdm845-dpu") ||
> +               of_device_is_compatible(dev->of_node, "qcom,sm8150-dpu") ||
> +               of_device_is_compatible(dev->of_node, "qcom,sm8250-dpu") ||
> +               of_device_is_compatible(dev->of_node, "qcom,sc7180-dpu") ||
> +               of_device_is_compatible(dev->of_node, "qcom,sc7280-dpu");

Instead of this duplicate string check why not use canonical compatible
lists?

	return of_match_node(dpu_dt_match, dev->of_node) ||
	       of_match_node(mdp5_dt_match, dev->of_node);


This way we're not constantly updating this list of compatibles in two
places.

>  }
>
>  static int add_display_components(struct platform_device *pdev,
> @@ -1268,7 +1275,7 @@ static int add_display_components(struct platform_device *pdev,
>                         return ret;
>                 }
>
> -               mdp_dev = device_find_child(dev, NULL, compare_name_mdp);
> +               mdp_dev = device_find_child(dev, NULL, find_mdp_node);
>                 if (!mdp_dev) {
>                         DRM_DEV_ERROR(dev, "failed to find MDSS MDP node\n");
>                         of_platform_depopulate(dev);
