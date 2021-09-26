Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30234186A6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 08:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhIZGJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 02:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhIZGJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 02:09:32 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C42AC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 23:07:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id x191so7529263pgd.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IrGPEPvgg2pFaS7mVTGLV712LfHqQe0Dx83upuAH6t0=;
        b=FPjeG/D8k9+REWHk/Zwo9XGB2U/jge6yQmGbhrQAS0/nVvGBLNqKxuHb5Sumzg30i2
         adqep7nejSNhKo+ojcAi5YyEClU1Yd3S1JLImeIhSHVfMPOwzm9PEc1Kx2i1QK5U3Wix
         gciCB0xTNmyvV7Avb6XNQQDOAmV7nvHkjN6vEVW0qKdOki//gvLcqkY2yAt2TRpbcFXl
         JOilGfXHvjq1pvtWMDV2DAR6mEApkprXafgpNImE9FJwzdEvE3+Lro5arBYaAo9tHGDM
         qHKoVFwoMz88x7hMxZTreEoAJZB6PaNEXoub0RCSQ55qWsTt4kBjc+fJqYdsKTas7J/0
         cVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IrGPEPvgg2pFaS7mVTGLV712LfHqQe0Dx83upuAH6t0=;
        b=pegKwP5PXCCtd3u7VetkhOR8P/V5DqgJMtboogRZ2dZpd0blw3Sn4tqeCFPIQfxVNS
         FBfHKq2cXVIpGvWJ5zhB4oP4SkHk9e8Ak5I9Sou/Sn6Ao/kxiyaOmZ0LcTq0QQdjuYe/
         8vLllUsL+LxmfEZhHtOwB6pzkMsVsM1gSju3vOsLjSIeCpt+3NqNfP6frP7trZCk03Md
         PJAdpeLFA2LTTDuxy7RZxlXy0LhVLb95PZ7OcXksKlQN/H7aUPq8/6Glp9K19lZigvN9
         GSbm1CV1jG4DUQo7aSZ2B4b/DJlsnVd6ZZRsCMrhosADdWBQF1cUreYtV/kUaq737uTH
         jnzA==
X-Gm-Message-State: AOAM533eDSrddIKofmTnoCwKuEgMs1Y9T0+n0FEVy/p+OVOpxv5HigdQ
        Z6AMxqiaqECzE6LEUjZYZ4WdsQ==
X-Google-Smtp-Source: ABdhPJxh/GCvWcE/Jii9pN0giTvX0nn9T38e9MKiHbsDD1dw7VkLMUEwyPO/vIAlhy0vFZggBdP+Gw==
X-Received: by 2002:a65:4007:: with SMTP id f7mr10960730pgp.251.1632636476816;
        Sat, 25 Sep 2021 23:07:56 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id d19sm13263947pfn.102.2021.09.25.23.07.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Sep 2021 23:07:56 -0700 (PDT)
Date:   Sun, 26 Sep 2021 14:07:50 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: c630: Move panel to aux-bus
Message-ID: <20210926060749.GB9901@dragon>
References: <20210924025255.853906-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924025255.853906-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 09:52:55PM -0500, Bjorn Andersson wrote:
> With the newly introduced aux-bus under the TI SN65DSI86 the panel
> node should be described as a child instead of a standalone node, move
> it there.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 27 +++++++++----------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index bd22352b6c7a..4818ca6d820d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -56,20 +56,6 @@ mode {
>  		};
>  	};
>  
> -	panel {
> -		compatible = "boe,nv133fhm-n61";
> -		no-hpd;
> -		backlight = <&backlight>;

There is some prerequisite change for this patch?  I do not find this
backlight node on v5.15-rc, neither linux-next.

Shawn

> -
> -		ports {
> -			port {
> -				panel_in_edp: endpoint {
> -					remote-endpoint = <&sn65dsi86_out>;
> -				};
> -			};
> -		};
> -	};
> -
>  	/* Reserved memory changes for IPA */
>  	reserved-memory {
>  		wlan_msa_mem: memory@8c400000 {
> @@ -441,6 +427,19 @@ sn65dsi86_out: endpoint {
>  				};
>  			};
>  		};
> +
> +		aux-bus {
> +			panel: panel {
> +				compatible = "boe,nv133fhm-n61";
> +				backlight = <&backlight>;
> +
> +				port {
> +					panel_in_edp: endpoint {
> +						remote-endpoint = <&sn65dsi86_out>;
> +					};
> +				};
> +			};
> +		};
>  	};
>  };
>  
> -- 
> 2.32.0
> 
