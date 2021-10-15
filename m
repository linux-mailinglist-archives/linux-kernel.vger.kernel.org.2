Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477C442E580
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhJOA4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhJOA4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:56:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2DAC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:54:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so34134000lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EzSOlg8FhBLL7uosP6twAnna/CbUWSXhwXOgPejU6Eg=;
        b=iOff/qLNaQaDTpK3SPHPKs03aW8yJPxrKCsraiu1ky0jgf80c06HghJc9MdmIc6ENi
         9kab7G0dIJlDCqT42N0AWfh93mdc0HFWeiRL/TQW/n6CLYve6/b7abRy7uDvnq1JqVOX
         0I5b4XiQOj6uGo2goLRp3e/MknUfxel157f/0poNxb/JMVA6kZrO9RXZF6EuM1z7XKTz
         7ThIgZ1ZJaW/zyXlYocwDamntUtgQs1qV4wFUUXNDh7Mo6teLw0UC5PMBHh4MckvmP+u
         S/VrCURIMEUuRH23Pp0mNFRVUg2QCf4C5CuP28whyVaHFi1PhI64T3QXGY3cLtRMsAvE
         732w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EzSOlg8FhBLL7uosP6twAnna/CbUWSXhwXOgPejU6Eg=;
        b=oqGyu9xTw++LYgDbPV/SvFRRD9RRtmUqsfyoJkvxveAWCnglnwa5Run3vr8p9vl9Rb
         PALR6A1VfEIFVQKSIGD0jRs56l0erpUm5EjAiujXLu9WaQmUFl+BRobBdkW8P69oocDh
         lsJ4Qpc/Gzxl6tY0Wkw37DtFGvQENsSvwcudchjMTLCN7GNUSKEPe4tfv6D+A2nIDHna
         RSZKkpmoLN27fLEVh4ucyKZcJThsSHXDcemIcz5wNrJk/eWL8RHVvYTD7AqCOKGIfBh6
         PHv6xX+Hc7lNV1xk/rDH773dEbfrjCP9OUoy1AeU/dXoA/iouz9ls+uZxCYrP/U6YRSe
         IbZQ==
X-Gm-Message-State: AOAM53193/2EDL3t00bxIs9hfjLSoq59T2VkOL8nUElQK75B8sIXwxoe
        8YsnHEGYwPYCL87/6jTib5YVOw==
X-Google-Smtp-Source: ABdhPJz9Q3V063lFfUwUVefDHnSyQ4R/kEJ1zqwcEvYH+kpBozpZYS8IYWmFYKIm/lov9wG72nHIgA==
X-Received: by 2002:a2e:b17c:: with SMTP id a28mr9361641ljm.398.1634259246036;
        Thu, 14 Oct 2021 17:54:06 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d14sm387721lfb.210.2021.10.14.17.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 17:54:05 -0700 (PDT)
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm prima/pronto drivers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20211008192840.3593362-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <69309ba8-56f5-e62b-a370-cac8605d0220@linaro.org>
Date:   Fri, 15 Oct 2021 03:54:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211008192840.3593362-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2021 22:28, Bjorn Andersson wrote:
> The Qualcomm prima/pronto drivers consists of a remoteproc driver boot
> the combined WiFi and Bluetooth firmware on the related co-processor, a
> control driver to load calibration and settings firmware, the wcn36xx
> WiFi driver and the SMD based Bluetooth driver.
> 
> Enable these in the defconfig to provide Bluetooth and WiFi on devices
> such as the Qualcomm Dragonboard 410c.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   arch/arm64/configs/defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 39a448e9edd3..c39c96f14208 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -201,6 +201,7 @@ CONFIG_BT_HCIUART=m
>   CONFIG_BT_HCIUART_LL=y
>   CONFIG_BT_HCIUART_BCM=y
>   CONFIG_BT_HCIUART_QCA=y
> +CONFIG_BT_QCOMSMD=m
>   CONFIG_CFG80211=m
>   CONFIG_MAC80211=m
>   CONFIG_MAC80211_LEDS=y
> @@ -380,6 +381,7 @@ CONFIG_USB_NET_MCS7830=m
>   CONFIG_ATH10K=m
>   CONFIG_ATH10K_PCI=m
>   CONFIG_ATH10K_SNOC=m
> +CONFIG_WCN36XX=m
>   CONFIG_BRCMFMAC=m
>   CONFIG_MWIFIEX=m
>   CONFIG_MWIFIEX_PCIE=m
> @@ -1020,6 +1022,8 @@ CONFIG_REMOTEPROC=y
>   CONFIG_QCOM_Q6V5_MSS=m
>   CONFIG_QCOM_Q6V5_PAS=m
>   CONFIG_QCOM_SYSMON=m
> +CONFIG_QCOM_WCNSS_PIL=m
> +CONFIG_RPMSG_CHAR=m
>   CONFIG_RPMSG_QCOM_GLINK_RPM=y
>   CONFIG_RPMSG_QCOM_GLINK_SMEM=m
>   CONFIG_RPMSG_QCOM_SMD=y
> @@ -1043,6 +1047,7 @@ CONFIG_QCOM_SMD_RPM=y
>   CONFIG_QCOM_SMP2P=y
>   CONFIG_QCOM_SMSM=y
>   CONFIG_QCOM_SOCINFO=m
> +CONFIG_QCOM_WCNSS_CTRL=m
>   CONFIG_QCOM_APR=m
>   CONFIG_ARCH_R8A774A1=y
>   CONFIG_ARCH_R8A774B1=y
> 


-- 
With best wishes
Dmitry
