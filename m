Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F4C3E0902
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbhHDTwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:52:01 -0400
Received: from relay06.th.seeweb.it ([5.144.164.167]:57619 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhHDTwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:52:00 -0400
Received: from [192.168.1.101] (83.6.167.155.neoplus.adsl.tpnet.pl [83.6.167.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 46CE33F36E;
        Wed,  4 Aug 2021 21:51:45 +0200 (CEST)
Subject: Re: [PATCH] arm64: dts: qcom: sm8150-mtp: Add 8150 compatible string
To:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210804133223.2503517-1-thara.gopinath@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <e43fff78-652c-5401-af4b-f3615df0edcb@somainline.org>
Date:   Wed, 4 Aug 2021 21:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804133223.2503517-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.08.2021 15:32, Thara Gopinath wrote:
> Add "qcom,sm8150" as one of the platform compatible strings.
> This will be later used by cpufreq-dt-platdev to exclude using
> cpufreq-dt cpufreq driver.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


> ---
>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> index 53edf7541169..b484371a6044 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> @@ -15,7 +15,7 @@
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. SM8150 MTP";
> -	compatible = "qcom,sm8150-mtp";
> +	compatible = "qcom,sm8150-mtp", "qcom,sm8150";
>  
>  	aliases {
>  		serial0 = &uart2;
>
