Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD653E0875
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhHDTCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhHDTCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:02:06 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C711C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 12:01:52 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g5-20020a9d6b050000b02904f21e977c3eso2593114otp.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4641MPkioKublOkHL4evZ5kS7fvIPpw+L1PqXgIieP8=;
        b=GqkjpQMjn9YW6aAFi+Vp0+YrxgzlIVN3vDD/r/lSR6Zpe18H+WzZIXfnbSguXd5sKL
         2Z3CdFOVNtk56T2xekum7tqzdP5f/8GxuJAZHNTWC73fSAMKNAcZghWnJzpMH6DFT6ND
         23T185qFL3X/2ZYsssPjeD2+y7M6mHHG5mtOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4641MPkioKublOkHL4evZ5kS7fvIPpw+L1PqXgIieP8=;
        b=jshlBfM1cYBvYsp1KZBHcu4ksSo7m1V+0GXHviW0/7MeteCZxrdK3wouYGRVa1GKXW
         bhLL2KTpM2QLy5leLFgTA/Bt0no5sdItw5Mh+MFFh3ypoWLa+twlhwcmcVj/C+jZ90su
         jkDKx0AnAyjJQrzyusMl7ftbojXwxI0vmSMaeghvL2R8xuWPNsjGxF2qXUiQ/7EwZLri
         ujjvfrCcu+MKFgFMWAf5MH3f3ckcJOG39TNbkR5Ddo5WE/b7H120KYmfqj/8o1+abiPQ
         R7yIpqtD1xND0SSzgAJTbcZy3q2V+69Si1kwRnPl/FBWoT3BSYGEa1GpPURU+l+tuNTX
         2t7w==
X-Gm-Message-State: AOAM532P4VerMmQBR3BBAvg9Br609QjtjJy81j5zU11Zp4592eXGXj8s
        UTZFefjj1xKpjxzs6cLCUB5/HZLi537vQcImBCx4VA==
X-Google-Smtp-Source: ABdhPJx2OkzKOmmq/s4XSPcU7nqbnZJdKgsYBlKrpDnpvRgoLEowSTouTJP69cnCrn0RYHIxfZzw76HULG++n4OxZlM=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr864327otq.233.1628103711737;
 Wed, 04 Aug 2021 12:01:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Aug 2021 12:01:51 -0700
MIME-Version: 1.0
In-Reply-To: <1627581885-32165-3-git-send-email-sibis@codeaurora.org>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org> <1627581885-32165-3-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 4 Aug 2021 12:01:51 -0700
Message-ID: <CAE-0n53cH749NC9JPqJvMZGBQf47AZ3qY66eoqk2CiQHvuumkg@mail.gmail.com>
Subject: Re: [PATCH 2/4] cpufreq: qcom: Re-arrange register offsets to support
 per core L3 DCVS
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-07-29 11:04:43)
> Qualcomm SoCs (starting with SM8350) support per core voting for L3 cache
> frequency.

And the L3 cache frequency voting code can't be put into this cpufreq
driver?

> So, re-arrange the cpufreq register offsets to allow access for
> the L3 interconnect to implement per core control. Also prevent binding
> breakage caused by register offset shuffling by using the SM8250/SM8350
> EPSS compatible.
>
> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index f86859bf76f1..74ef3b38343b 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -28,6 +28,7 @@ struct qcom_cpufreq_soc_data {
>         u32 reg_volt_lut;
>         u32 reg_perf_state;
>         u8 lut_row_size;
> +       bool skip_enable;
>  };
>
>  struct qcom_cpufreq_data {
> @@ -257,19 +258,31 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>         .reg_volt_lut = 0x114,
>         .reg_perf_state = 0x920,
>         .lut_row_size = 32,
> +       .skip_enable = false,
>  };
>
>  static const struct qcom_cpufreq_soc_data epss_soc_data = {
> +       .reg_freq_lut = 0x0,
> +       .reg_volt_lut = 0x100,
> +       .reg_perf_state = 0x220,
> +       .lut_row_size = 4,
> +       .skip_enable = true,
> +};
> +
> +static const struct qcom_cpufreq_soc_data epss_sm8250_soc_data = {
>         .reg_enable = 0x0,
>         .reg_freq_lut = 0x100,
>         .reg_volt_lut = 0x200,
>         .reg_perf_state = 0x320,
>         .lut_row_size = 4,
> +       .skip_enable = false,
>  };
>
>  static const struct of_device_id qcom_cpufreq_hw_match[] = {
>         { .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
>         { .compatible = "qcom,cpufreq-epss", .data = &epss_soc_data },
> +       { .compatible = "qcom,sm8250-cpufreq-epss", .data = &epss_sm8250_soc_data },
> +       { .compatible = "qcom,sm8350-cpufreq-epss", .data = &epss_sm8250_soc_data },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> @@ -334,10 +347,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>         data->res = res;
>
>         /* HW should be in enabled state to proceed */

It looks odd that we're no longer making sure that the clk domain is
enabled when we probe the driver. Why is that OK?

> -       if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
> -               dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> -               ret = -ENODEV;
> -               goto error;
> +       if (!data->soc_data->skip_enable) {
> +               if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
> +                       dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> +                       ret = -ENODEV;
> +                       goto error;
> +               }
>         }
>
