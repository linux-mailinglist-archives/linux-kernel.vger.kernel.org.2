Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAC33DE41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhCPTxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhCPTwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:52:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588ABC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:52:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso44038pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=faqEscETZSrulFIYYb0jYXjyqjYLAtUQhOAj+Eq6L58=;
        b=QROtZwY30S3rnLQyjWUfx7axM5L4YmKHg48BV9XAqfriiSXwNfo8MBUdwI4rc93tls
         J9uTptxJH41Xo8BWbEa8PBBTibvHLTwCOCG2GR7K6eDIKOx9NAr275DDYVkjLa6epeOQ
         fcf6aOsuwSky2knXWvm4Dz/1LRFe6QEw2HfGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=faqEscETZSrulFIYYb0jYXjyqjYLAtUQhOAj+Eq6L58=;
        b=KN6izZ6y0VgH37zAkb8rH8KYSM+Xwe9dlhDA6UUbZNEZnPiFRTPFQxLVXINdiWmhIm
         v4ndHCU72t9o7IoX3mxfLD14OROkNCIuBefNxvMvu0syRJe2/oHZnQNGZZRsD/6vWs0o
         xCfRWsFt+8iOAH0q6G0Mz6vPI6QgEpHeD7Wf+LKTgv4sun0wVrAlR0WRUo8MLdIxCHiJ
         Lazj25/h3TxOmL+mZ0VDAhfUbXClQ2ajyx25w1D6qLDR69yl91M6UoHjmW1Bfh0aPUNJ
         U3L6AqPZBWilMWHMLg8Ob8DihYAgMbpAEEk+hrEqeisM6nDaXQijkWwD05EskdHCI3Xb
         TeLg==
X-Gm-Message-State: AOAM533/iuBsvDYpzBROxmJ0chbHvA5GqSTJM70JRGLOfyN9Qw0Ch11B
        mFCjalz/Jh9z57Tzq9I45BM/ow==
X-Google-Smtp-Source: ABdhPJxAnOk6JambfDEnqQzor6Xe+Gu7aky1OLCVD+xQPfi53DULiWa/GGdpDVhUE7i9hd0Hnue97A==
X-Received: by 2002:a17:903:22d0:b029:e6:887d:b702 with SMTP id y16-20020a17090322d0b02900e6887db702mr1120399plg.32.1615924349763;
        Tue, 16 Mar 2021 12:52:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b471:7d:bf21:d7dd])
        by smtp.gmail.com with UTF8SMTPSA id p25sm17698016pfe.100.2021.03.16.12.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:52:29 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:52:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        David Collins <collinsd@codeaurora.org>
Subject: Re: [PATCH V2 2/5] regulator: qcom-rpmh: Add PM7325/PMR735A
 regulator support
Message-ID: <YFEMezCRjK2W6THZ@google.com>
References: <1615816454-1733-1-git-send-email-skakit@codeaurora.org>
 <1615816454-1733-3-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615816454-1733-3-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:24:11PM +0530, satya priya wrote:
> Add support for PM7325/PMR735A regulators. This ensures
> that consumers are able to modify the physical state of PMIC
> regulators.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V2:
>  - No change.
> 
>  drivers/regulator/qcom-rpmh-regulator.c | 53 ++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 9471890..3509523 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
>  
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>  
> @@ -1042,6 +1042,49 @@ static const struct rpmh_vreg_init_data pmx55_vreg_data[] = {
>  	{},
>  };
>  
> +static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps520, "vdd-s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps520, "vdd-s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps520, "vdd-s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps520, "vdd-s6"),
> +	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps520, "vdd-s7"),
> +	RPMH_VREG("smps8",  "smp%s8",  &pmic5_hfsmps510, "vdd-s8"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l7"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l5"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9-l10"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l2-l7"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l8"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9-l10"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l6-l9-l10"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
> +	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
> +	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_nldo,      "vdd-l13"),
> +	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_nldo,      "vdd-l14-l16"),
> +	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
> +	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_nldo,      "vdd-l14-l16"),
> +	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
> +	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
> +	RPMH_VREG("ldo19",  "ldo%s19", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
> +};

Could you help me understand these funky supply names? I see other RPMh
regulators also have them, so they are probably totally fine, but it
isn't clear to me what exactly the names represent. Apparently the LDO
itself is in the supply name, but many LDOs also list others.
