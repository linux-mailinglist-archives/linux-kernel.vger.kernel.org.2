Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29DE4029F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 15:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbhIGNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344760AbhIGNm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 09:42:26 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C202BC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 06:41:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id n27so12863996oij.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jchNFw2Yo6yuHBkCcN+NUbTUJfaJKlkFnbZpG0pAu7A=;
        b=gFG6W/BIZhouj41N1VFuNOuM/IKg9E0XlOYTxj5EFDgxlPyJOkuYlhOTWhBaASrfsB
         Cu3ELwhUYioXB643bpMKZlyGLiyvUozDsZMPV0ffUX9Je1EITSbnOfs0TOvhEzYac3tN
         K4Hbzk3Tgmv8a//NDAwpR62OrgB9IEW+x54IVUJas9paeHQs5YNNUVjOwAyjSfT8TJ1o
         DCx7OicZa7l/OlmA/CgVA1W2MoBKpc+F9czC1KLZp+CCVbLkT/mYYFMjfGI9vIswlXZk
         qHs0Rwhy9/cjUH4JGn5ZWKE2lDsaGnax43+uovwy6IOZzTU4jacayIW5G/spMlZTBnrB
         hT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jchNFw2Yo6yuHBkCcN+NUbTUJfaJKlkFnbZpG0pAu7A=;
        b=IhZVqAMvLT/U1/1Tb5hPKObu5BCz8OCrHg7C3u6SfVmw9p/atUd5ntQOoFXU3OSUi/
         CQef/nGmT4nomk71WMtx+L+TttLW8PVE+7NOSv4lKTbPHwFaCdZf4VfxEhswaDbc5Fhc
         cRFjWbxl6QavSAx1JTr/1hBEcx21652UJJN61BE7dMnuj1AQ15XMjOUcdIqUjgtqissG
         fooweSeZoCk1nh+SvxDlnPowpvhhsPZfmsKp8t28g7q8+WHs1NjLHreIPQpnsbbnDm6y
         kKEu7i2Whbb0ynLaWrR7+arv6KDC0GIa5z2rTOD4RazKTfiZGy3b+KtsJQtm1gt7XrUi
         Nvug==
X-Gm-Message-State: AOAM532BkXQNJKYf5S254dlKpjH6MBrMJin7LSYpaEYGgb39K7roJ32D
        ZRPkvcv6q52CjfXJyJVEpQxOQQ==
X-Google-Smtp-Source: ABdhPJzAP3CxEwNPcfyk8aYdZT0lTDiRDckG1yFSnnOIAwMEtDMdx2M3cqLlGWfCIBTPrFfoHJrK5A==
X-Received: by 2002:a05:6808:3a8:: with SMTP id n8mr3064825oie.10.1631022079161;
        Tue, 07 Sep 2021 06:41:19 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u19sm2186193oof.30.2021.09.07.06.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:41:18 -0700 (PDT)
Date:   Tue, 7 Sep 2021 06:42:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
Subject: Re: [PATCH 3/7] arm64: dts: qcom: msm8998-xperia: Add support for
 wcn3990 Bluetooth
Message-ID: <YTdsOhAtDGqM+e9q@ripper>
References: <20210903180924.1006044-1-angelogioacchino.delregno@somainline.org>
 <20210903180924.1006044-3-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903180924.1006044-3-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03 Sep 11:09 PDT 2021, AngeloGioacchino Del Regno wrote:

> This platform uses the WCN3990 Bluetooth chip, reachable on UART-3.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> index 2fe53e4675d5..66b009ba72fe 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> @@ -179,6 +179,23 @@ &blsp1_i2c5_sleep {
>  	bias-disable;
>  };
>  
> +&blsp1_uart3 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +
> +		clocks = <&rpmcc RPM_SMD_RF_CLK2_PIN>;
> +	};
> +};
> +
> +

Please drop the extra newline when you respin the series.

Regards,
Bjorn

>  &blsp2_uart1 {
>  	status = "okay";
>  };
> -- 
> 2.32.0
> 
