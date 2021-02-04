Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC130F784
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhBDQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbhBDQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:16:48 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651DC06178B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:16:02 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n2so3767123iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ShjPrOZFvuZnChZyDVoQ7xSgC+7vniucv2ofMDWRHQk=;
        b=EQT57eOUPYIRT1NrPO8pD8zpy/U+UCue8N9Oq5v10+xAVDdElx/xKbQyb1Kw4Cwx0E
         YW6eM9YeSporOIvf+pFgCoqz1SKANt8wXmv0B30+eGvD2KCdQ/5sdIoL4Pm1Y6xI29Ct
         zHgSaKMfI1X+K1VjW0DqjLvTCbHkrEDtgTcbUcIaIBohK+vDcpFpiebkZB3QGGushW9L
         dkaO2GUvxQdBEX1vQo/gVhaY8v6xF6YC87B66pKEaNPNBTwxSCpJE4y7RPjyz1sqypLt
         edkmxvEBM12Zx2DLEKpGk1iYM9Xv05w5aI5xNxlqJBGOJPGSJ5wxOt9LKnLOVCBFK88o
         kmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ShjPrOZFvuZnChZyDVoQ7xSgC+7vniucv2ofMDWRHQk=;
        b=EFOYsxxzmp0yDUt0L9tanIsaiBG//bp6evWHNK+5KnxvRHS8hcJ/YPrHIha3AFDvxX
         tpfYmn/SxpqVnM6g2pWMJg4ZyBPo2h+EeC4VICLCxic4FoyOfn+AvJJRXmahHazyf0B5
         cg0hIg9WBhyG0vF3J0whmKXNFcEyJ23iKgmQiVCNvMJPpxYktUMJxYLDDSF50vM2qXFB
         0LQ2oh58U70FhjJ+vhoclSTzO2nVST8XtP4zfjJM1PzeY6N2RbhF1nTywLLJOIZYsHYp
         NNJI3BPhBpBn2PKtnYw6GmRjtzm0RjNm3MF3CXWDXfMXbWq6PM4rBIR27aGLP5EgIWPG
         Vk9g==
X-Gm-Message-State: AOAM531K9xhlC9WnMvMpndv6tH+7Yn/J/0Ede2JCeOwk1uc+MaCcN7TM
        UY4fjDX39fM9Idg6Vb9TqrMcpWPCjZdY5g==
X-Google-Smtp-Source: ABdhPJyr2v/IFTnaKKEdZTWMU3m9sglGLyebnj4H2kEabPKC5oHO/coVZFkkpV0waP6jcBQZyqC3Kw==
X-Received: by 2002:a6b:5a0f:: with SMTP id o15mr41231iob.49.1612455361888;
        Thu, 04 Feb 2021 08:16:01 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id h12sm2796587ilq.16.2021.02.04.08.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 08:16:01 -0800 (PST)
Subject: Re: [PATCH] remoteproc: qcom: fix glink dependencies
To:     Arnd Bergmann <arnd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <clew@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Suman Anna <s-anna@ti.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Colin Ian King <colin.king@canonical.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210204154010.1585457-1-arnd@kernel.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <c326e5c8-e394-88bc-24f4-4dd8e246db3c@linaro.org>
Date:   Thu, 4 Feb 2021 10:16:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210204154010.1585457-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 9:40 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building the remoteproc drivers into the kernel while the qcom_glink
> code is in a loadable module results in a link error:
> 
> ld.lld: error: undefined symbol: qcom_glink_ssr_notify
>>>> referenced by vmlinux.o:(glink_subdev_unprepare)
> 
> Add a Kconfig dependency to avoid this.

So if they're incompatible in that way it's declared in the
header but not defined in the kernel so the link fails.

And at issue is anything that calls qcom_add_glink_subdev(),
which is qcom_q6v5_{adsp,mss,pas,wcss}.c, and those are
selected by CONFIG_QCOM_Q6V5_{ADSP,MSS,PAS,WCSS}.

But I don't see why QCOM_WCNSS_PIL needs the dependency.

Can you explain that?  Other that that this looks good
to me (and I'll offer reviewed-by with your response).

Thanks.

					-Alex

> Fixes: 8527efc59d45 ("rpmsg: glink: Guard qcom_glink_ssr_notify() with correct config")
> Fixes: 5d1f2e3c8090 ("soc: qcom: glink_ssr: Internalize ssr_notifiers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/remoteproc/Kconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 9e7efe542f69..88488af01fd9 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -155,6 +155,7 @@ config QCOM_Q6V5_ADSP
>   	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>   	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>   	depends on QCOM_SYSMON || QCOM_SYSMON=n
> +	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
>   	select MFD_SYSCON
>   	select QCOM_PIL_INFO
>   	select QCOM_MDT_LOADER
> @@ -171,6 +172,7 @@ config QCOM_Q6V5_MSS
>   	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>   	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>   	depends on QCOM_SYSMON || QCOM_SYSMON=n
> +	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
>   	select MFD_SYSCON
>   	select QCOM_MDT_LOADER
>   	select QCOM_PIL_INFO
> @@ -188,6 +190,7 @@ config QCOM_Q6V5_PAS
>   	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>   	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>   	depends on QCOM_SYSMON || QCOM_SYSMON=n
> +	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
>   	select MFD_SYSCON
>   	select QCOM_PIL_INFO
>   	select QCOM_MDT_LOADER
> @@ -206,6 +209,7 @@ config QCOM_Q6V5_WCSS
>   	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>   	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>   	depends on QCOM_SYSMON || QCOM_SYSMON=n
> +	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
>   	select MFD_SYSCON
>   	select QCOM_MDT_LOADER
>   	select QCOM_PIL_INFO
> @@ -238,6 +242,7 @@ config QCOM_WCNSS_PIL
>   	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>   	depends on QCOM_SMEM
>   	depends on QCOM_SYSMON || QCOM_SYSMON=n
> +	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
>   	select QCOM_MDT_LOADER
>   	select QCOM_PIL_INFO
>   	select QCOM_RPROC_COMMON
> 

