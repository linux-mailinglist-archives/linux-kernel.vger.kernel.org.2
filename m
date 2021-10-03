Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA942015C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 13:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhJCLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhJCLgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 07:36:51 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D59C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 04:35:03 -0700 (PDT)
Received: from [192.168.1.101] (83.6.167.124.neoplus.adsl.tpnet.pl [83.6.167.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 7BD371F67A;
        Sun,  3 Oct 2021 13:35:01 +0200 (CEST)
Message-ID: <25a61a6c-a339-27c3-4bf0-35aad014c954@somainline.org>
Date:   Sun, 3 Oct 2021 13:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 11/11] arm64: dts: qcom: sm7225: Add device tree for
 Fairphone 4
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211003083141.613509-1-luca@z3ntu.xyz>
 <20211003083141.613509-12-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211003083141.613509-12-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.10.2021 10:31, Luca Weiss wrote:
> Add device tree for the Fairphone 4 smartphone which is based on
> Snapdragon 750G (sm7225) which is basically sm6350.
>
> Currently supported are UART, physical buttons (power & volume), screen
> (based on simple-framebuffer set up by the bootloader), regulators and
> USB.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> [...]

> +
> +&pm6350_gpios {
> +	gpio_keys_pins: gpio-keys-pins {

'pin' singular, I guess


> +		pinconf {
> +			pins = "gpio2";
> +			function = PMIC_GPIO_FUNC_NORMAL;
> +			bias-pull-up;
> +			input-enable;
> +			power-source = <0>;
> +		};

pinconf {} is not necessary


[...]


Other than that:


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad


