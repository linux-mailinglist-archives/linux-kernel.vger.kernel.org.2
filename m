Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5521C44761C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 22:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhKGV5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 16:57:55 -0500
Received: from m-r2.th.seeweb.it ([5.144.164.171]:58549 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhKGV5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 16:57:52 -0500
Received: from [192.168.1.222] (adsl-d210.84-47-0.t-com.sk [84.47.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4AD293E8B0;
        Sun,  7 Nov 2021 22:55:05 +0100 (CET)
Date:   Sun, 07 Nov 2021 22:54:59 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sdm630: Assign numbers to eMMC and
 SD
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        paul.bouchara@somainline.org,
        angelogioacchino.delregno@somainline.org
Message-Id: <N7282R.N797L5JNOD37@somainline.org>
In-Reply-To: <20211107195511.3346734-2-danct12@riseup.net>
References: <20211107195511.3346734-1-danct12@riseup.net>
        <20211107195511.3346734-2-danct12@riseup.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Martin Botka <martin.botka@somainline.org>

On Mon, Nov 8 2021 at 02:55:05 AM +0700, Dang Huynh 
<danct12@riseup.net> wrote:
> This makes eMMC/SD device number consistent.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi 
> b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 3e0165bb61c5..b75bb87ed290 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -19,6 +19,11 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
> 
> +	aliases {
> +		mmc1 = &sdhc_1;
> +		mmc2 = &sdhc_2;
> +	};
> +
>  	chosen { };
> 
>  	clocks {
> --
> 2.33.1
> 


