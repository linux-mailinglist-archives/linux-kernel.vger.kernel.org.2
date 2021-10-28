Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D14843F29B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhJ1WW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJ1WW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:22:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D535C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:20:00 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x8so6151209oix.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XlHbKWd6pbbGkZIStSTxFaG7vAcQNI1eMo098oPb11U=;
        b=RhaDuJkxg7XSpHf1uMr3Oikq4bAIm4AIWrTxFhp8J7btCs5Nftz/ce0uJkrqfybZrc
         bNQo6d4RbqLbn4oijl8a1LKrezIg6TCLyulzp5pwHGocfyCOsHOuL2cH3DLL4oQzk6+x
         KMcxqk/gkb95/yfIhVcLt7ii70Z/DCTgQVYUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XlHbKWd6pbbGkZIStSTxFaG7vAcQNI1eMo098oPb11U=;
        b=E5KzOHecSsJNivNPomwKmT/DFQlLp3ILbmxesyGAZBeG8f/lAV5Xr6rMovC+eGs82S
         r0JG3bHQYU10pwLwFvZsRtQxKeAZ1KN/6PTU9lC6xYq0vfCZraQOahdBTmYNh0AtGoyQ
         mpKwuylOV75HLoyf13tyRq/SnMOlYlcnjGbFe6MxS4c3mb8SSiPUwSPzjOfxUndGibMr
         Cc4doJkOCTz3yrbrGxp1Zh9sQJTO+Pr/NNEAhZLDv9ZS0B/X55XwJs+ZvliHVoP9qvqB
         XWFxIFcljtTI7jfEUiuGYRA4FrfzS8zUZobUTqP57taQ9kkaaKUPNjBy90UTUSlWo+l2
         QYfg==
X-Gm-Message-State: AOAM530EMkiiU3LsXLmhIpN/CHWlLhc9KBGBWO8sO+6hFe0KcstexWiR
        00tQvOh96qzJ/k1c8MaF5YgJT5xrpytYFQ8aHS2hmQ==
X-Google-Smtp-Source: ABdhPJwfvxRCDnP08dCwT4fknbFntzz7glH0jJBWYvi4icewMHAZCYjPyRlLWbnJ8EuU6GfjGvnkRIw06lYY/iyvDZU=
X-Received: by 2002:a05:6808:23c2:: with SMTP id bq2mr11059063oib.32.1635459599626;
 Thu, 28 Oct 2021 15:19:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Oct 2021 15:19:59 -0700
MIME-Version: 1.0
In-Reply-To: <1635429901-5734-1-git-send-email-quic_kalyant@quicinc.com>
References: <y> <1635429901-5734-1-git-send-email-quic_kalyant@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 28 Oct 2021 15:19:59 -0700
Message-ID: <CAE-0n51QgYprv+BPKWHSVgUFDhHzb0t=DRBG_g9yvXeMWyaVqg@mail.gmail.com>
Subject: Re: [v1] drm/msm/disp/dpu1: set default group ID for CTL.
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        y@qualcomm.com
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, mkrishn@codeaurora.org,
        abhinavk@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kalyan Thota (2021-10-28 07:05:01)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 4ade44b..57b9be1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -179,13 +179,16 @@ enum {
>
>  /**
>   * CTL sub-blocks
> - * @DPU_CTL_SPLIT_DISPLAY       CTL supports video mode split display
> + * @DPU_CTL_SPLIT_DISPLAY,     CTL supports video mode split display
> + * @DPU_CTL_FETCH_ACTIVE,      Active CTL for fetch HW (SSPPs).
> + * @DPU_CTL_VM_CFG,            CTL supports multiple VMs.

Are those commas supposed to be colons? Also the application of the
period/full-stop is not consistent. Please pick one. I see the double
star so it looks like kernel-doc, but probably doesn't parse properly.

>   * @DPU_CTL_MAX
>   */
>  enum {
>         DPU_CTL_SPLIT_DISPLAY = 0x1,
>         DPU_CTL_ACTIVE_CFG,
>         DPU_CTL_FETCH_ACTIVE,
> +       DPU_CTL_VM_CFG,
>         DPU_CTL_MAX
>  };
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index 64740ddb..455b06a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -498,6 +498,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
>         u32 intf_active = 0;
>         u32 mode_sel = 0;
>

Can we get a comment here about what's happening?

> +       if ((test_bit(DPU_CTL_VM_CFG, &ctx->caps->features)))

Does it need to be atomic? Sort of doubt it, so probably __test_bit()
would work just as well.

> +               mode_sel = 0xf0000000;

How about a define for 0xf0000000? Preferably a name that matches the
register description for this bit pattern.

> +
>         if (cfg->intf_mode_sel == DPU_CTL_MODE_SEL_CMD)
>                 mode_sel |= BIT(17);
>
