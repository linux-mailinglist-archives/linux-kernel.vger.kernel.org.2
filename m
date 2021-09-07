Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61F402F4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346244AbhIGT73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346379AbhIGT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:59:18 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA979C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:58:11 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n27so17569oij.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=cpuPNID504m7krAb/gnZk/TMIGInSz6Tx5yLWjazrsg=;
        b=E3fIS0Qjf1RWD0+HmTt7aH/vOzhv+9aYVBplyK4lppbLc/cgG9GpeWN+xHa0GwTdeW
         ZrsHcigd7JHlpqyoC/U9gMa8NHq1LETG4KDFNeQnKORZdIcpozavIHLG4C5QDPUGk+lj
         oUoqFF2hsGO3INM+rygUirSqR43YhBIRBVi8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=cpuPNID504m7krAb/gnZk/TMIGInSz6Tx5yLWjazrsg=;
        b=sQQTpHIJ6CCxZAKwfXubdvxjqrMytvEQTE0ZbiejkjeGHpLe8dDPjIiYSRQJvid4EU
         FiJMRJryfKVcbxeB9m8cv4ZCTQTsZjARkSruG6Bts4/wVyRDhyn7NZ3wF6XnwdFDETsK
         n79k4UAehUskl6KwpTVdtYmTY6dk9L1IQ+hvZ+vONtHAnp6pQbolcIHTVT023CGJkLZw
         YbwnvkpwC0LcHq4/KAB4sSwghCc0z8cts+XNaQNFhERoczwJ0g42R4cwKm3QSwx+u1Eq
         3V6QejDwh9LTrF7gf0UVLEJn0NUm/ghkxA4lbtnk0r+CWB/M3TtmPfFVzFQY5Up+WwTH
         6kyQ==
X-Gm-Message-State: AOAM531Q+X52YZTPs74DNZusPN+1/dGcdRuBxoxAX/kXBjoQ1XKe3SLk
        b/t8tCB54fl2j1+sdT36CESkikF1A4wrruGeHUjlng==
X-Google-Smtp-Source: ABdhPJxJ3y8dRx8VJy9eL6kTfOJvnlG4ri+vzOT3EaB/ySeWkTsOJshIw66dlrmZ2Ye2utVyje6ymr02VG4RTaWH7Rg=
X-Received: by 2002:a54:4419:: with SMTP id k25mr4502942oiw.32.1631044691251;
 Tue, 07 Sep 2021 12:58:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Sep 2021 19:58:10 +0000
MIME-Version: 1.0
In-Reply-To: <1630906083-32194-2-git-send-email-mkshah@codeaurora.org>
References: <1630906083-32194-1-git-send-email-mkshah@codeaurora.org> <1630906083-32194-2-git-send-email-mkshah@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 7 Sep 2021 19:58:10 +0000
Message-ID: <CAE-0n50L-KgdbyQ-X0J6J8Za-j3P9o5iLyn4uNg8eKYBZG_16Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] dt-bindings: Introduce SoC sleep stats bindings
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, linux@roeck-us.net,
        rnayak@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2021-09-05 22:27:59)
> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> new file mode 100644
> index 0000000..4161156
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/soc-sleep-stats.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. (QTI) SoC sleep stats bindings
> +
> +maintainers:
> +  - Maulik Shah <mkshah@codeaurora.org>
> +  - Lina Iyer <ilina@codeaurora.org>
> +
> +description:
> +  Always On Processor/Resource Power Manager maintains statistics of the SoC
> +  sleep modes involving powering down of the rails and oscillator clock.
> +
> +  Statistics includes SoC sleep mode type, number of times low power mode were
> +  entered, time of last entry, time of last exit and accumulated sleep duration.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,rpmh-sleep-stats
> +      - qcom,rpm-sleep-stats
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  # Example of rpmh sleep stats
> +  - |
> +    aop_msgram@c3f0048 {

Node names should be generic and not have any underscores in them. I
still think 'memory' is more appropriate here. I doubt anyone will
confuse it for DDR.

> +      compatible = "qcom,rpmh-sleep-stats";
> +      reg = <0x0c3f0048 0x400>;
> +    };
