Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D000140035F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349995AbhICQe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhICQeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:34:25 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC1EC061760
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 09:33:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e7so6055900pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tqMg1ZebpCNplH/x6OLfzFPMVt1JW72f2Hu9Wiq2UWc=;
        b=HnWKqjrTmBKv1PyyWr+sEF0WLQvRSvWmijEvLEPO6ZGJYkB96BbKxmDzXO5bEVkNX0
         Gye0CJ1csIVvZi8XD+4ae++jUySAp5kkfTghNWYupSN2tSAMPs8/Wpag2Eh23zVGKRlf
         jc/vYfuXkkusmhG79jqu0+r4s4r/XQpAOsdfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqMg1ZebpCNplH/x6OLfzFPMVt1JW72f2Hu9Wiq2UWc=;
        b=RGKzmh6i0vMtXl9vMD0E3q7yT0AFnR1m1q+p5PucFL2yI9xiuQaWaFTkTN6r5e/Z92
         pOKLcZLP/Cl0VMDXhFKFx7Wp/N6wBEbDWUrZOAvdO5yQPGNJK2BACLkPD9v+g6fQfIpd
         L6aFIVGtENvWkvH2NcvGzVQnuR7yCd+qP8Fxp1HfunY/Iwvw1k0hYaTGeS9CPNqh31/K
         PCNcjALwyaHHwBeDGmFthz3044HlqR7A4mhogKSqKUEKRrmaYl3HremHaXAI3PR7ATtQ
         9hX+FB9sHdoPwBl5x4MPJWWHc+FC2T+JhXF2Ve21mXPYIS3Gu+SW4Mhydp8Ew74WbyFT
         ho8w==
X-Gm-Message-State: AOAM530ZAcXPF3w1IBLhZpHh7cFHCIOBJjLHW7jnPe+u515VwPGHkvqt
        FDLaf4rcIIn3QmI6MCdTylFSZg==
X-Google-Smtp-Source: ABdhPJw1enRwqkfNnYs1tJ1J4jtIZtEfyJa5iYoj/xe7pu98hWndi/JcWDD+rKPRbERxiEHXvx2Xqg==
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr4372914pge.5.1630686805312;
        Fri, 03 Sep 2021 09:33:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:80b3:9f00:3170:fd8b])
        by smtp.gmail.com with UTF8SMTPSA id q126sm5940224pfc.156.2021.09.03.09.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 09:33:24 -0700 (PDT)
Date:   Fri, 3 Sep 2021 09:33:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajesh Patil <rajpat@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, sboyd@kernel.org, dianders@chromium.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: Re: [PATCH V7 3/7] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
Message-ID: <YTJOU/oVWSdxD1uz@google.com>
References: <1630643340-10373-1-git-send-email-rajpat@codeaurora.org>
 <1630643340-10373-4-git-send-email-rajpat@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1630643340-10373-4-git-send-email-rajpat@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 09:58:56AM +0530, Rajesh Patil wrote:
> From: Roja Rani Yarubandi <rojay@codeaurora.org>
> 
> Add QUPv3 wrapper_0 DT nodes for SC7280 SoC.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 684 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 682 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 7ec9871..5c6a1d7 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>
> ...
>
> +			qup_spi0_data_clk: qup-spi0-data-clk {
> +				pins = "gpio0", "gpio1", "gpio2";
> +				function = "qup00";
> +			};
> +
> +			qup_spi0_cs: qup-spi0-cs {
> +				pins = "gpio3";
> +				function = "qup00";
> +			};


I think we still want this for all SPI ports, which existed in previous
versions:

			qup_spi0_cs_gpio: qup-spi0-cs-gpio {
				pins = "gpio3";
				function = "gpio";
			};

It just shouldn't be selected together with 'qup_spiN_cs'.

Maybe a follow up patch would be good enough, so:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
