Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF145AAA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhKWSBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbhKWSBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:01:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279DC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:58:28 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y8so17758126plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bbmQ71C4USib8g5VHZ5eqkApHXrc8RLia8DHNhFTyQU=;
        b=Cov85HUUN0KM4BeG3WFGXEAchQ2VXlVaepCqxKV045fK75ed/5eUpFh1nAvm2cQ7D0
         KG+EDVGTIf6D0J+XG+Zj0bjRFDH313TxWVKq+nJoxrj1+wJz6rV92MBdKucxrMrPHGnu
         OV+x6rRmbsKjpNMeu18VxpnipBclEjIA9jOp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bbmQ71C4USib8g5VHZ5eqkApHXrc8RLia8DHNhFTyQU=;
        b=pwZfWno1BcMg3Ud1Cy4+oabQ7G9ygeHYIbbzP1Zj/tuViC0OB4qmyTOJqqCKyYSy2/
         JRGD6AQLB2i/JuKg1i40H7vuzkfXzYWefQdKyhcEWR2wpMAX8mWjk7LzC2ABRE9S48Pm
         QMIiSMmb6L8aUP+7mFYVnJ2/cNO5C9vTO3ggaEKUve9aJWIF2vF9qGKl6yWcAfhAAGi1
         VY7GkirzD3zN31yoJG/V/2wnob0D1EphZK4JE1dtrNynCh68KhrdNcef1r+t5UgDcOuh
         dGLRKLYKSkDeYuhKVOiv/Eu/ud+iL6v29hd/swzXBGHpwjlVuOlqyS/IyszZYoa1fIqX
         WRNw==
X-Gm-Message-State: AOAM533giF7H7pp+KcTh0NW3ekQFx8XcM0NJKx7mtoqquvXCD+bhV2FX
        btjgDEW2ShVKEQloB8yOAqluKg==
X-Google-Smtp-Source: ABdhPJw7fi+m3nrYztNvGziyYc7XGj+5DLWEPXnojuB8/xBvoE/zTBv3+WkUhVF9pVLzwAPbYfAvoQ==
X-Received: by 2002:a17:90b:180d:: with SMTP id lw13mr5176744pjb.225.1637690308371;
        Tue, 23 Nov 2021 09:58:28 -0800 (PST)
Received: from localhost ([2620:15c:202:201:5fa5:d920:9d68:9c16])
        by smtp.gmail.com with UTF8SMTPSA id mu4sm2251712pjb.8.2021.11.23.09.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 09:58:28 -0800 (PST)
Date:   Tue, 23 Nov 2021 09:58:26 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@codeaurora.org,
        dianders@chromium.org, kgodara@codeaurora.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc7280-crd: Add Touchscreen and
 touchpad support
Message-ID: <YZ0rwiHuh0OeP0VD@google.com>
References: <1637650813-16654-1-git-send-email-rnayak@codeaurora.org>
 <1637650813-16654-5-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1637650813-16654-5-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:30:13PM +0530, Rajendra Nayak wrote:
> From: Kshitiz Godara <kgodara@codeaurora.org>
> 
> Add Touchscreen and touchpad hid-over-i2c node

to which board(s)?

> Signed-off-by: Kshitiz Godara <kgodara@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 63 +++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index 8c2aee6..bef3037 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -23,6 +23,47 @@
>  	};
>  };
>  
> +ap_tp_i2c: &i2c0 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	trackpad: trackpad@15 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x15>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tp_int_odl>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +
> +		post-power-on-delay-ms = <20>;
> +		hid-descr-addr = <0x0001>;
> +		vdd-supply = <&vreg_l18b_1p8>;
> +
> +		wakeup-source;
> +	};
> +};
> +
> +ap_ts_pen_1v8: &i2c13 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	ap_ts: touchscreen@5c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x5C>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
> +
> +		post-power-on-delay-ms = <500>;
> +		hid-descr-addr = <0x0000>;
> +
> +		vdd-supply = <&vreg_l19b_1p8>;
> +	};
> +};
> +
>  &nvme_pwren {
>  	pins = "gpio51";
>  };
> @@ -30,3 +71,25 @@
>  &nvme_3v3_regulator {
>  	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
>  };
> +
> +&tlmm {
> +	tp_int_odl: tp-int-odl {
> +		pins = "gpio7";
> +		function = "gpio";
> +		input-enable;

Not sure about this one, is the explicit 'input-enable' actually needed here?

> +		bias-disable;
> +	};
> +
> +	ts_int_l: ts-int-l {
> +		pins = "gpio55";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	ts_reset_l: ts-reset-l {
> +		pins = "gpio54";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <2>;

As per my comment on "[3/4] arm64: dts: qcom: sc7280: Define EC and H1 nodes" it
seems setting the drive strength to 2 isn't necessary, since that's the default.
