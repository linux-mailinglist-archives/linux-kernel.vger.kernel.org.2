Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E6F42169D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhJDShr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbhJDShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:37:46 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD79C061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:35:57 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x124so22811870oix.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=hXHHXCyhxvnGT3QgfcApqG6moWz0bf7iL02kdOIh9PQ=;
        b=HRBTgWhCYpNHFgX6gVtv0Fhea1PCx8OnfEDJAoF0JSHT4GU6PZiyevQlrJo8r1xGFd
         hoL0zYqtr7NMbNr+wgjuJYA8sZJts5glM7htXHl07e8YUYWCf09mCXa+sH7n0GuV9TVz
         aznweM1wvnoBQ3lS9t+S4gp7pHQ7lY/Czua8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=hXHHXCyhxvnGT3QgfcApqG6moWz0bf7iL02kdOIh9PQ=;
        b=GMjWnfaQzy5HC2LXkahSDKBOetVeLsZ2Wveynz86yQ/eqNdrzJ+1TCP/R6LFpil14p
         kL+5SUT1/Oxil7eZreI+/PPGyCJQcatVejKM3GzcUDR06rBNmh+Irs6Z2b3JH/DKNXNF
         n9lfbV4lRaHOUOCqqxu4IWJUHW5dsH2YPfIVkb4Xt7dkQVYC8X1b/dyFGtbQe+JGRHY6
         1kD+nNAJdTHzmUCtLBgT0s5uIf5Nf7lAIKRbYI4NV3bslUFrnauMSHWZu3LzWTMmPrvJ
         f30sSPbl7TL3e9VcniiTN5yo1zo8787Pp0zN+PMUQEvIdferRnMb6hQ080l8Gu9oxYml
         LKjw==
X-Gm-Message-State: AOAM533D7VWIFlP2yU+U+Y5vs6RgHdwIMYB7RqRIwGuZOwufLoJgYVM+
        Qaww4oV3dVcjDq8Zx3EHfd5SipQM+AZW1/4vThSoyQ==
X-Google-Smtp-Source: ABdhPJyEaUIn4jKNa/faVuYQtFHfhH/wNnzeZuhXD9ZXzTI2+gVLl7lVZFKDzAY6df30uzyTknavPIhXv7wOs9lXFB4=
X-Received: by 2002:a05:6808:f8f:: with SMTP id o15mr14513558oiw.164.1633372556918;
 Mon, 04 Oct 2021 11:35:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Oct 2021 14:35:56 -0400
MIME-Version: 1.0
In-Reply-To: <1633330133-29617-4-git-send-email-pillair@codeaurora.org>
References: <1633330133-29617-1-git-send-email-pillair@codeaurora.org> <1633330133-29617-4-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 4 Oct 2021 14:35:56 -0400
Message-ID: <CAE-0n51cMX95kuuFUAusqhFOUUZeGsGfA_=5u+5O8w1C=toLzA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] remoteproc: qcom: q6v5_wpss: Add support for
 sc7280 WPSS
To:     Rakesh Pillai <pillair@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sibis@codeaurora.org,
        mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rakesh Pillai (2021-10-03 23:48:53)
> Add support for PIL loading of WPSS processor for SC7280
> - WPSS boot will be requested by the wifi driver and hence
>   disable auto-boot for WPSS.
> - Add a separate shutdown sequence handler for WPSS.
> - Add multiple power-domain voting support
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

This changed? Please don't keep reviewed-by if things changed
significantly.

> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 098362e6..b6d3c3d 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -531,15 +685,40 @@ static const struct adsp_pil_data cdsp_resource_init = {
>         .ssr_name = "cdsp",
>         .sysmon_name = "cdsp",
>         .ssctl_id = 0x17,
> +       .is_wpss = false,
> +       .auto_boot = true,
>         .clk_ids = (const char*[]) {
>                 "sway", "tbu", "bimc", "ahb_aon", "q6ss_slave", "q6ss_master",
>                 "q6_axim", NULL
>         },
>         .num_clks = 7,
> +       .proxy_pd_names = (const char*[]) {
> +               "cx", NULL
> +       },
> +};
> +
> +static const struct adsp_pil_data wpss_resource_init = {
> +       .crash_reason_smem = 626,
> +       .firmware_name = "wpss.mdt",
> +       .ssr_name = "wpss",
> +       .sysmon_name = "wpss",
> +       .ssctl_id = 0x19,
> +       .is_wpss = true,
> +       .auto_boot = false,
> +       .load_state = "wpss",
> +       .clk_ids = (const char*[]) {
> +               "gcc_wpss_ahb_bdg_mst_clk", "gcc_wpss_ahb_clk",
> +               "gcc_wpss_rscp_clk", NULL

Please remove "gcc_wpss_" prefix and "_clk" postfix. Does that make this
match the binding?

> +       },
> +       .num_clks = 3,
> +       .proxy_pd_names = (const char*[]) {
> +               "cx", "mx", NULL
> +       },
>  };
>
