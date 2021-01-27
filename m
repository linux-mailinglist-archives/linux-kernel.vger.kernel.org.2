Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6BA305E67
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhA0Oec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhA0OdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:33:11 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E921C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:32:31 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i20so1826676otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AkjKYkZu/O3ZhL9C1ly1S1R+Lu1EqcZrKzNmqSx7LJM=;
        b=ds5cTovti/PtWeJ9L9rKyAOoOCJlHao6cqyS9WX5rNXOcqjvrACFYWilYmHuy7YEyU
         Zr2gd5FdUeJLOW4mz/aprPbp4jYKkyWlUXgrn9h3WYr3u6hB8NAXTQzpnelYnHsugmKZ
         8PMgx78aR3uz8ZN6yPR1Fkrs+Kt5ya4IVDz5OvzISuhkLEicnFWhBEqdIXCZprV357r3
         980hdxNsheXU0huewLbFRO07m8egm/Zkuhqmd8q/0jApuDMAriwEoDScJaO8OaW6pD60
         J9WcOsudPLTYDO1sGadIy6cBl0PLr/9byY+lSqueuNJHlLE2zEF6GcacqQhYJS9jvbWy
         qo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AkjKYkZu/O3ZhL9C1ly1S1R+Lu1EqcZrKzNmqSx7LJM=;
        b=Yj3G6c1DZBbtv5NlOZenHd7MTDteJ7ArZmxRtmeY2y59jW5Uko6YiTYpZhWFHvi2zR
         AjLGPr9uhp+3XidnxoP7/4EYq8CR4XLFFAWO4KqMKpegBGPwApm6JVjMQzTKcDymVbit
         TEo+VocgRNzMVHAXxWSkm/+m3/WQsgXGdrrLkh62o67ySMTNB5OG4r6FRRjWfQe0Qlrr
         aICL+WaSF3+txSWlx3W0Vixt6x4OePSvl/Uz5yFfAHZI241ua+QySE9kMivzsnBFP0Cb
         RNI7dcFWP+XtWd7IYcBYk7rbftF/Gz6q2c8UPVIgAAmz9n/y11Fy6SIA/ugd14PDs0tM
         MZNQ==
X-Gm-Message-State: AOAM533uIOzBwprdRwF0N+DPrcm+x/9Y/QuKMA8MKVzLJ8wT2c271Bft
        Y6irBIJujjT8r+RD5BNBqbpMdQ==
X-Google-Smtp-Source: ABdhPJwmTqQPsWpvtbjcC2msBX3cGjNcoI9u2JDtZqhZPL4fnGyhqt4gHpM29qTSW+yW9tkibHcSxA==
X-Received: by 2002:a9d:5cc3:: with SMTP id r3mr8437957oti.286.1611757950813;
        Wed, 27 Jan 2021 06:32:30 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o98sm404617ota.0.2021.01.27.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:32:30 -0800 (PST)
Date:   Wed, 27 Jan 2021 08:32:28 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "N?colas F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Brian Masney <masneyb@onstation.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Russell King <linux@armlinux.org.uk>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH v2 4/4] ARM: dts: qcom: pm8941: Add nodes for QCOM SPMI
 Flash LEDs
Message-ID: <YBF5fPD8Mq0K8XDn@builder.lan>
References: <20210126140240.1517044-1-nfraprado@protonmail.com>
 <20210126140240.1517044-5-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126140240.1517044-5-nfraprado@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Jan 08:06 CST 2021, N?colas F. R. A. Prado wrote:

> Add the necessary devicetree nodes for the Qualcomm SPMI Flash LEDs
> present in PM8941.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@protonmail.com>
> ---
> Changes in v2:
> - Moved from hammerhead dts to pm8941 dtsi, as it was this way downstream
> - Now using values from leds-qcom-spmi-flash.h
> 
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 38 ++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index c1f2012d1c8b..89309d3c777c 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -2,6 +2,8 @@
>  #include <dt-bindings/iio/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/leds/leds-qcom-spmi-flash.h>
>  
>  &spmi_bus {
>  
> @@ -189,5 +191,41 @@ pm8941_5vs2: 5vs2 {
>  				regulator-initial-mode = <1>;
>  			};
>  		};
> +
> +		qcom,spmi-flash@d300 {

Please avoid "qcom," in the node names.

> +			status = "okay";

The "default" status is "okay", so no need to specify that if you're not
disabling it. That said, there are 8974 devices without flash LED...

> +
> +			compatible = "qcom,spmi-flash";
> +			reg = <0xd300 0x100>;
> +			flash-boost-supply = <&pm8941_5vs1>;
> +			torch-boost-supply = <&pm8941_5v>;
> +			pm8941_flash0: led0 {
> +				led-sources = <0>;
> +				function = LED_FUNCTION_FLASH;
> +				color = <LED_COLOR_ID_WHITE>;
> +				led-max-microamp = <200000>;
> +				flash-max-microamp = <1000000>;
> +				flash-max-timeout-us = <1280000>;
> +				default-state = "off";
> +				qcom,clamp-curr = <200000>;
> +				qcom,headroom = <QCOM_SPMI_FLASH_HEADROOM_500MV>;
> +				qcom,startup-dly = <QCOM_SPMI_FLASH_STARTUP_DLY_128US>;
> +				qcom,safety-timer;

...and I would expect that at least some of these properties should be
tweaked/tuned/reviewed for each device.

So it would probably be a good idea to make the spmi-flash status
"disabled" and move some of these properties to the product .dts.

Regards,
Bjorn

> +			};
> +
> +			pm8941_flash1: led1 {
> +				led-sources = <1>;
> +				function = LED_FUNCTION_FLASH;
> +				color = <LED_COLOR_ID_WHITE>;
> +				led-max-microamp = <200000>;
> +				flash-max-microamp = <1000000>;
> +				flash-max-timeout-us = <1280000>;
> +				default-state = "off";
> +				qcom,clamp-curr = <200000>;
> +				qcom,headroom = <QCOM_SPMI_FLASH_HEADROOM_500MV>;
> +				qcom,startup-dly = <QCOM_SPMI_FLASH_STARTUP_DLY_128US>;
> +				qcom,safety-timer;
> +			};
> +		};
>  	};
>  };
> -- 
> 2.30.0
> 
> 
