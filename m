Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E00E37AC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhEKQmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:42:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57793 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhEKQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:42:49 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgVS2-0004uh-6x
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 16:41:42 +0000
Received: by mail-vs1-f71.google.com with SMTP id n10-20020a67ac4a0000b0290227113abed7so9864906vsh.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=alnNJ8eTIAKjnyjv7sFy0NrcXIfxDIzBImh7xvBaNx4=;
        b=Zd3hcRk6iFDRX1o/9VXfQhvfWTDHOx+2kctkHjM+zRFuWbfip53LwgP1U5FpWimXGa
         TPT0l3Qmj1VdxIsq1vfoEy+w9dwKV2+XFQ3Fjrkip3mJe3Sot44IdsZFs9zmy4pSEhCp
         +hKDWUd3WvVkPTcIM6qs18emYBEq9Z+NS7JUOw+/Vju4cggtLVjhRVhp16yjujc9Z7az
         iTXRdxeMA5w1vi7uM76VcQRtA2yIjw+qkOm3NujOQpryi37QstgmKnFzgtSodVGZ5Dte
         bgKpbJpG2ZLCfJytNceL3n8RAZQejUKH/N/doqG9dgq9D6f62nVXVFqLPOfS+YLR86p2
         aBOg==
X-Gm-Message-State: AOAM53184FsxbR2gRTvAXsJKLdk1w/HCoJ/q37v05FRp7MEXlZbuB2s0
        cqD4FIh2Jf6QermVf3SV/g4NmAiXuwjPsgx33Ygdko93haQB+mAvjLUH+6wSXSJhczUI3GlzaZm
        kbnGiTUre9zQmZiPpMSBhjGTLkeRiiVnogWs2Ety/Cg==
X-Received: by 2002:a67:cc2:: with SMTP id 185mr26956870vsm.0.1620751301355;
        Tue, 11 May 2021 09:41:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyomdb1bhDBL2AaXVV3yxPtwgBghGFRDYkkSZwWfK0Zfh4v60wP0v79x/KYYwcRaDElKcuP4A==
X-Received: by 2002:a67:cc2:: with SMTP id 185mr26956838vsm.0.1620751301136;
        Tue, 11 May 2021 09:41:41 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id 61sm2296538uaa.17.2021.05.11.09.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 09:41:40 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] memory: tegra: Enable compile testing for all
 drivers
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210510213729.7095-1-digetx@gmail.com>
 <20210510213729.7095-3-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <54acffad-97c0-56cd-46ba-5ceba454ec09@canonical.com>
Date:   Tue, 11 May 2021 12:41:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210510213729.7095-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 17:37, Dmitry Osipenko wrote:
> Enable compile testing for all Tegra memory drivers.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
> index a70967a56e52..a910f661105f 100644
> --- a/drivers/memory/tegra/Kconfig
> +++ b/drivers/memory/tegra/Kconfig
> @@ -2,7 +2,7 @@
>  config TEGRA_MC
>  	bool "NVIDIA Tegra Memory Controller support"
>  	default y
> -	depends on ARCH_TEGRA
> +	depends on (ARCH_TEGRA || COMPILE_TEST)

No need for ().

>  	select INTERCONNECT
>  	help
>  	  This driver supports the Memory Controller (MC) hardware found on
> @@ -11,7 +11,7 @@ config TEGRA_MC
>  config TEGRA20_EMC
>  	tristate "NVIDIA Tegra20 External Memory Controller driver"
>  	default y
> -	depends on TEGRA_MC && ARCH_TEGRA_2x_SOC
> +	depends on TEGRA_MC && (ARCH_TEGRA_2x_SOC || COMPILE_TEST)

There is a lot of "depends on TEGRA_MC". How about making it a "if
TEGRA_MC" block?

Best regards,
Krzysztof
