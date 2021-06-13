Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376743A5638
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 06:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhFMEYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 00:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhFMEYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 00:24:38 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF14C061767
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 21:22:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so1974425oti.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 21:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FIZzF+vNdvW8c/xyt8LCztOh3ZfjKKS6HpmIg9OM5VY=;
        b=rvY1xartR0XzuC5JdSjapKuTtUvr/7VGuU161r7PTcuvr+HypOPsCoYN09MrI6csfx
         k4j/ApxxkJFRgOgkD7JFv70jie+0DVwUD0UyppFZrJaGFJsi8LbCF5OuFvJ+yp9//VNC
         Rg5wDKLA4qR1I4dFQdyGiitmAaIvN76W79EYpcXDQtwAGcC199yHcXdmlCA+iNQViC6B
         n2ZDwYsH+0hWd/xAEPx+uoAZsOZ0KMI8PXfh3+x+C5SyOnxJg3gUYEgVCywQ9hPG/2by
         bqB1uBi6Y7AyqMJjB8Yx1zFr81PaiaqD5Kpf+oGHmqYQoGOS0lSIGFRVWLwnhseauKtu
         f3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FIZzF+vNdvW8c/xyt8LCztOh3ZfjKKS6HpmIg9OM5VY=;
        b=s/DQSbnso1b6Lh8hoMidLgfoyOMyiflpd1tcpuLTibZuF1p/C+OXv1sMbGwYpIH59f
         RsI2nDmZKRCE5RSpglxburBqVN//eB1qqJCp8ckc1i32u4O5e/a9Mco0Kpeb3+x48wAu
         NBSYQnBi7w8e7tzCJ5wloUBqNFR7gZBxPfXDO4p+JCRk/xhIui3hrTyaJow6JvZC7t7W
         BKE+WfTxFDNFwtyPz6IhKlnfF/FNvRwjhpYwVUe4U2NCAp0lLj1I0tudSp5BJpnpFK09
         O/tTymvMoGD6G3m1xIxM2edk8AQUEg/TjF84/xIz6w0rgWsZwF9xB8fl4+fTNYDjqzYw
         vNjQ==
X-Gm-Message-State: AOAM531Mz4e76TXSgNWYeE7oCHIPScTntzu/ul/Ybvrwk/Pv+4c/1Zx4
        EhyHQQWIstIv2dg+oV7xiC30cw==
X-Google-Smtp-Source: ABdhPJx0kCEOPhXvpn2xjNNrCqf5m6I1JDLPJKDrXVNK4ZZt0cNU+x3XzQgoqDWgMEA3tv+XeknKwA==
X-Received: by 2002:a05:6830:1da4:: with SMTP id z4mr6169678oti.83.1623558146857;
        Sat, 12 Jun 2021 21:22:26 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r2sm1423281otd.54.2021.06.12.21.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 21:22:26 -0700 (PDT)
Date:   Sat, 12 Jun 2021 23:22:24 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: pmi8998: introduce qpnp haptics
Message-ID: <YMWIABGYJlDEd+c9@yoga>
References: <20210612205405.1233588-4-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612205405.1233588-4-caleb@connolly.tech>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12 Jun 15:54 CDT 2021, Caleb Connolly wrote:

> Add bindings for Qualcomm QPNP haptics, setting default values used on
> most devices.
> 
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> index d230c510d4b7..ccf64c1898d4 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/input/qcom,qpnp-haptics.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> 
> @@ -41,5 +42,20 @@ lab: lab {
>  				interrupt-names = "sc-err", "ocp";
>  			};
>  		};
> +
> +		qpnp_haptics: qcom,haptics@c000 {

Also, please label this pmi8998_haptics, to make it easier to find where
it's defined when looking at the .dts.

Thanks,
Bjorn

> +			compatible = "qcom,qpnp-haptics";
> +			reg = <0xc000 0x100>;
> +
> +			interrupts = <0x3 0xc0 0x0 IRQ_TYPE_EDGE_BOTH>,
> +				     <0x3 0xc0 0x1 IRQ_TYPE_EDGE_BOTH>;
> +			interrupt-names = "short", "play";
> +
> +			qcom,wave-shape = <HAP_WAVE_SINE>;
> +			qcom,play-mode = <HAP_PLAY_BUFFER>;
> +			qcom,brake-pattern = <0x3 0x3 0x2 0x1>;
> +
> +			status = "disabled";
> +		};
>  	};
>  };
> --
> 2.31.1
> 
> 
