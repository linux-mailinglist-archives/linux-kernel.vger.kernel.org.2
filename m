Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE344CFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 03:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhKKCTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 21:19:39 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:36435 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhKKCTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 21:19:38 -0500
Received: from [192.168.1.101] (83.6.165.118.neoplus.adsl.tpnet.pl [83.6.165.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5AE0A3F6B4;
        Thu, 11 Nov 2021 03:16:47 +0100 (CET)
Message-ID: <fe19d7e6-8d31-a157-65d0-da53095485ea@somainline.org>
Date:   Thu, 11 Nov 2021 03:16:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] arm64: dts: qcom: Add support for SONY Xperia XZ2 / XZ2C
 / XZ3 (Tama platform)
Content-Language: en-US
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211106191437.84943-1-konrad.dybcio@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211106191437.84943-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> new file mode 100644
> index 000000000000..6b088675f4b9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> @@ -0,0 +1,442 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sdm845.dtsi"
> +#include "pm8005.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
> +
> +/ {
> +	qcom,msm-id = <321 0x20001>; /* SDM845 v2.1 */
> +	qcom,board-id = <8 0>;
> +
> +	gpio-keys {

Whooops! It seems that I totally forgot to add a compatible to gpio-keys.. Could that be fixed when applying if the patch is otherwise good? Should it not be the case, I'll surely fix that in the next revision..


> +		cam-focus {
> +			label = "cam_focus";
> +			gpios = <&pm8998_gpio 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_CAMERA_FOCUS>;
> +			debounce-interval = <15>;
> +			gpio-key,wakeup;
> +		};
> +


Konrad

