Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB93A5635
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 06:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFMEXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 00:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhFMEXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 00:23:36 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBBC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 21:21:23 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s23so10582461oiw.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 21:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8YqT4iQ5ARuAsr6gtIHiKsiWycjnAEstDWdPEQ2s7Oo=;
        b=SzK65P0jNbO87tAuQU+tnH5HoSu25WKpV5S4ECBy4n4OUq7OkU4RUkEn2S9I8tpLe0
         UWUHYqjE1iPLFwpK6asKcuVwZcudPJj8tYRYtZbvQrDSGgxc6RGKH8fQq0g9NhIu23S8
         McOnAJ5fK4be9oGgD1gbPnDMP9nVxMbxDlULrHNEJPoDZ68LjjdNx2rsEoWgfVfYP9xk
         3bNDzl4Qqw6M0tRhB9xSflSQ8UUVXWIGsU1bfP1yyDr3U+vQrZ0xhQ86orbkid2nIL/j
         2KfA+jnMvihI34zfIcZsc9mJ0+BPfuGF+0yNupOR9DWyFlWnXtxHSaU1J7oahd9rOcM9
         UAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YqT4iQ5ARuAsr6gtIHiKsiWycjnAEstDWdPEQ2s7Oo=;
        b=c3TfPzgJQD9cD3xcdmJevO7YoiQBdH4O3/MnXqN+AXDVw0Ij4JYBbcgdxiJuwF1cHS
         a1uvYzJq8zcqUxJBU03T43otZC0kJQrPlUsVzssEL3d1WHXES+UMa4D6mxbPSTubvZvE
         sx0yw3h6AjRA6TtOcLpWvf4RhtNYI4YlyGeabWNwE9qKUdnxh6P/7psMA/Pnr3tZLabU
         r4J32TchTcznMTrw6sFUQ/w4zAc+3quU7whANbazOl3anHoocfaxoerSGNAkFmrKh9Am
         KxbbOgEiV4HoZaynpAlxv3/IeNqQg+nmoRNA7BJh8Vhp0gEgo5Y7LHUNfaPFfkMoHdaT
         GTLA==
X-Gm-Message-State: AOAM532bfXdXVCCpNTwpvCXYbogNXCIGMAy3RTxuUyJVmiuoG7Gu9lK5
        LdYeteSAAXefp61LxP3x1QSG9A==
X-Google-Smtp-Source: ABdhPJx39pPSqUGZ+2JLZGZIoy2K54tmZqpddydIlq0r84X5ZZ7EvZbLXRRnITnI5LKzKYzAIeqymg==
X-Received: by 2002:aca:a9c3:: with SMTP id s186mr6856373oie.103.1623558082760;
        Sat, 12 Jun 2021 21:21:22 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n186sm2110995oia.1.2021.06.12.21.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 21:21:22 -0700 (PDT)
Date:   Sat, 12 Jun 2021 23:21:20 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: pmi8998: introduce qpnp haptics
Message-ID: <YMWHwHXRZ69vivC7@yoga>
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

No qcom, in node name, please.

> +			compatible = "qcom,qpnp-haptics";
> +			reg = <0xc000 0x100>;

#size-cells is <0>, so this means 2 addresses. Please drop the "length".

Regards,
Bjorn

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
