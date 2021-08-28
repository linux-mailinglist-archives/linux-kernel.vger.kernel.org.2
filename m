Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556B53FA71D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhH1SIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhH1SIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 14:08:34 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF96C0613D9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 11:07:43 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id z3-20020a4a98430000b029025f4693434bso3115644ooi.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ves4rEFbuIlPzY9KtlYpO56vkgctRzHEkajdiDzSNZI=;
        b=hdp6No9GL73pD05e+eYeNTDWcPTx1YCFqtVOhyTeTf2uROufLpRpcCpAd9UylKgj3d
         WGuVdr2F0ccCoHWGW8rbmtLuLtjEv6iOTSIBj+JCzJqaEqE1SZBnBYrVLsl4mrcefQbu
         WcoLTHbDrz8voCrX+Jlwp2OWKlZiOZJUp76HdBNHcDvaOv8h7IfUF0DRObXZBoP2WGu/
         UDCmBNOEFIqax2CcxGecDYALKC9+wvygXJZ0eLoGp2b5vsM4G3ytxergTgB+rqxrLwtL
         7vh33G+GrpgxO4RolCgDxopyVI98QLBjqFwqHaPKevU0tVXQOiPGwfz+d18B0FFN7fmR
         IR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ves4rEFbuIlPzY9KtlYpO56vkgctRzHEkajdiDzSNZI=;
        b=kd4LGfedvQnETFkl43tnbN/f+Fwp3Z4ZPIVDzGaB0k1YeMq1ohGW/u80rFAdCk5DMm
         nYXb5mWvIGlNFO++4SO/tzo/SRtEVmZ5vZursiOvK/FiZ4l/mFzyQzZNuAL72TKRdos2
         m3I/I9/3QEo2RoenHf9eIM+3Me1vk25xWVdU7H21jTs8V8gxThke9LqTPBkaW5UDUZEe
         G2F76glqszVdhl/gsWf//wMJvD6nVejuTrk8ArexLs1RRF2ol2zwh+L0ofoNMVOMDMA/
         sI/WuBKA8toLbK2+9ANlU49NwObSXUMQlAZ4m7i93YgskvyCpaidFzD8rhIk8PpwhyS7
         VUZQ==
X-Gm-Message-State: AOAM533vnNVyjaigb7wABgcrpR9RBOtAIDY71cgcSOGEHnVU1a1/yfgd
        TiF/wr3I/7wphUuE1we+gCiJpQ==
X-Google-Smtp-Source: ABdhPJzGm7aYpkcvBh52pNx0ZDFrrdjtJC2mAVrJctkZ0jCtShiTb6GbKe3ylOcs27/Yo065nyQ4zg==
X-Received: by 2002:a4a:c541:: with SMTP id j1mr4162359ooq.15.1630174062688;
        Sat, 28 Aug 2021 11:07:42 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 186sm1942151ood.39.2021.08.28.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 11:07:42 -0700 (PDT)
Date:   Sat, 28 Aug 2021 13:07:39 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add SM6350 pinctrl
 bindings
Message-ID: <YSp7az2iBlPnGgxQ@yoga>
References: <20210828172315.55742-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828172315.55742-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 28 Aug 12:23 CDT 2021, Konrad Dybcio wrote:

> Add device tree binding Documentation details for Qualcomm SM6350
> pinctrl driver.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> Changes since v2:
> - Tweak the regex to match gpio0-gpio157
> 
>  .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
> new file mode 100644
> index 000000000000..554992a681f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sm6350-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SM6350 TLMM block
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@somainline.org>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer (TLMM) block found
> +  in the SM6350 platform.
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,sm6350-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  '#interrupt-cells': true
> +  gpio-controller: true
> +  gpio-reserved-ranges: true
> +  '#gpio-cells': true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  '-state$':
> +    oneOf:
> +      - $ref: "#/$defs/qcom-sm6350-tlmm-state"
> +      - patternProperties:
> +          ".*":
> +            $ref: "#/$defs/qcom-sm6350-tlmm-state"
> +
> +$defs:
> +  qcom-sm6350-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-7])$"
> +            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data ]
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +        enum: [ adsp_ext, agera_pll, atest_char, atest_char0, atest_char1, atest_char2,
> +                atest_char3, atest_tsens, atest_tsens2, atest_usb1, atest_usb10, atest_usb11,
> +                atest_usb12, atest_usb13, atest_usb2, atest_usb20, atest_usb21, atest_usb22,
> +                atest_usb23, audio_ref, btfm_slimbus, cam_mclk0, cam_mclk1, cam_mclk2, cam_mclk3,
> +                cam_mclk4, cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3,
> +                cci_timer4, cri_trng, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3,
> +                dp_hot, edp_lcd, gcc_gp1, gcc_gp2, gcc_gp3, gp_pdm0, gp_pdm1, gp_pdm2, gpio,
> +                gps_tx, ibi_i3c, jitter_bist, ldo_en, ldo_update, lpass_ext, m_voc, mclk,
> +                mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2, mdp_vsync3, mi2s_0, mi2s_1, mi2s_2,
> +                mss_lte, nav_gpio, nav_pps, pa_indicator, pcie0_clk, phase_flag0, phase_flag1,
> +                phase_flag10, phase_flag11, phase_flag12, phase_flag13, phase_flag14, phase_flag15,
> +                phase_flag16, phase_flag17, phase_flag18, phase_flag19, phase_flag2, phase_flag20,
> +                phase_flag21, phase_flag22, phase_flag23, phase_flag24, phase_flag25, phase_flag26,
> +                phase_flag27, phase_flag28, phase_flag29, phase_flag3, phase_flag30, phase_flag31,
> +                phase_flag4, phase_flag5, phase_flag6, phase_flag7, phase_flag8, phase_flag9,
> +                pll_bist, pll_bypassnl, pll_reset, prng_rosc, qdss_cti, qdss_gpio, qdss_gpio0,
> +                qdss_gpio1, qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
> +                qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6,
> +                qdss_gpio7, qdss_gpio8, qdss_gpio9, qlink0_enable, qlink0_request, qlink0_wmss,
> +                qlink1_enable, qlink1_request, qlink1_wmss, qup00, qup01, qup02, qup10, qup11,
> +                qup12, qup13_f1, qup13_f2, qup14, rffe0_clk, rffe0_data, rffe1_clk, rffe1_data,
> +                rffe2_clk, rffe2_data, rffe3_clk, rffe3_data, rffe4_clk, rffe4_data, sd_write,
> +                sdc1_tb, sdc2_tb, sp_cmu, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tsense_pwm1,
> +                tsense_pwm2, uim1_clk, uim1_data, uim1_present, uim1_reset, uim2_clk, uim2_data,
> +                uim2_present, uim2_reset, usb_phy, vfr_1, vsense_trigger, wlan1_adc0, wlan1_adc1,
> +                wlan2_adc0, wlan2_adc1, ]
> +
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      drive-strength: true
> +      input-enable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +      - function
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        pinctrl@f100000 {
> +                compatible = "qcom,sm6350-tlmm";
> +                reg = <0x0f100000 0x300000>;
> +                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +                gpio-ranges = <&tlmm 0 0 157>;
> +
> +                gpio-wo-subnode-state {
> +                        pins = "gpio1";
> +                        function = "gpio";
> +                };
> +
> +                uart-w-subnodes-state {
> +                        rx {
> +                                pins = "gpio25";
> +                                function = "qup13_f2";
> +                                bias-disable;
> +                        };
> +
> +                        tx {
> +                                pins = "gpio26";
> +                                function = "qup13_f2";
> +                                bias-disable;
> +                        };
> +                };
> +        };
> +...
> -- 
> 2.33.0
> 
