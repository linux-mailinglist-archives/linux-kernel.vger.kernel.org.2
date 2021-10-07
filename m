Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7370E425A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbhJGSIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhJGSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:08:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F55C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:06:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o204so1964070oih.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SF++BOLAlw+gmm2whEMt+9+RSjiVl4Y2q05QuVk4Bi8=;
        b=JZUaORpsBwKxCbhGCZt/3OvFehX/ZlMOjau9tKi7+z6xpNwYIt1zuCmCkfwEglbruc
         J8OZV8RKA3NXLumvqbyNfDifsmDTF2igARFQvGcaHdtQvHP+VNSTxt9Tcya6GuhKPOTB
         KOVQOInU7Vu3fm+/FryIhsq3PpPd9yW6ghyD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SF++BOLAlw+gmm2whEMt+9+RSjiVl4Y2q05QuVk4Bi8=;
        b=tCqG+A61Z//TW67AYhsA7R/X0E6NaG31cYV3WDCctBKg0CnLOEFPzs9RrF8u72h6ih
         mcivG0D+mSM6yoSUFE757sqIcTDvjk6Wh3j7HyFuPpYqvVv9Al/9ngRXqOHhGa8BwX84
         PPhcqC5Pt8gHRWwilr6zQWk92kgoVxEyCzAtg0ctLZYTJkJ2uz82Mvxo221i7QWR7FoV
         XHMpG1w5yerc9zmS13+8Mnmmx2ynzKk+7OZLtM4iZkW6w3vkhz1K3UN8lDfQ3m5htNFO
         PkrsovarVIQpl0RmYQtf8DfeGCqrivPVSyjWla9hjPZEhgpgUyx2oP3t3zJDwpLTc+X7
         Ktsg==
X-Gm-Message-State: AOAM530mWu1fn39P7D6zw/mj5uLIlfABOniCw1Wo71+uYHO+0jxOmjdM
        tQqMusqrdEUG+ExQVLsCQBcY/GhNRrRDpq6ksNRoFA==
X-Google-Smtp-Source: ABdhPJxT78LC/jFpZgqZ7+FEhoNmAoI/1qtnz4jLeheFfZGuTZ4oIZcVBly+qSTc29jruR3Jqoqm6fohXJ6TdNNiEO0=
X-Received: by 2002:a05:6808:f8f:: with SMTP id o15mr12828011oiw.164.1633630009087;
 Thu, 07 Oct 2021 11:06:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Oct 2021 14:06:48 -0400
MIME-Version: 1.0
In-Reply-To: <20211007052812.3717-1-quic_saipraka@quicinc.com>
References: <20211007052812.3717-1-quic_saipraka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 7 Oct 2021 14:06:48 -0400
Message-ID: <CAE-0n51EBGqOZ7D+sn5=M-ig=6p_NUb+8veaaXXQJo+UrLoQfA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable QTI SC7280 pinctrl, gcc and interconnect
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2021-10-06 22:28:12)
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 156d96afbbfc..87584769cf71 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -984,6 +985,7 @@ CONFIG_MSM_MMCC_8996=y
>  CONFIG_MSM_GCC_8998=y
>  CONFIG_QCS_GCC_404=y
>  CONFIG_SC_GCC_7180=y
> +CONFIG_SC_GCC_7280=y

Any reason to not enable DISPCC or GPUCC which selects the GCC config?
Same goes for sc7180.

>  CONFIG_SDM_CAMCC_845=m
>  CONFIG_SDM_GCC_845=y
>  CONFIG_SDM_GPUCC_845=y
