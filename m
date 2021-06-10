Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348843A24AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFJGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:45:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39863 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJGpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:45:46 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrEPu-0005GA-70
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 06:43:50 +0000
Received: by mail-wm1-f69.google.com with SMTP id z25-20020a1c4c190000b029019f15b0657dso2662949wmf.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Cnxc9a5Hbs5GVecJ6riph8QcEVy6pKQKSj3ZxVzabg=;
        b=qCt8gzEPMPThIb6bS/1exoYMgyAmc1mJpR6H6sh32mXvQFGpG0ZanABUbw2MK2bN97
         hFBB8LEAlkJhziWHenmD20wGhll767JXwehXESqKSwtEqoVYzOKynwPM47xNpMqKTOWl
         kGF2BJQ8garpkbUb+ELKV0uqBEeySpuqVOOKRw+iTOx7bJOiYnBWBjGh6n6SYajh7Hge
         E4jqn73jgMRxIH/6lcht8qK1uMp0Pg79ccGZSKgt+/f4ufm7a6b33xcIU3LCTCI0tXma
         Micj0YPnkuIdkZjeP7Yg0O2ifiVXqJJTnLn4/X6j9ly15/XeHm2f3PBM5GE4I22hi0RP
         OTWg==
X-Gm-Message-State: AOAM533OpTM+JGkkx7MuHNDENu4jHV83gYFjCzmmUlF/8+tWmrwqCjOI
        m/9ioyzJNok1WreYZlqDHPcvDa0HmOHgsNfjddcENLeVoNuejdNMhrx9IT9HAPPJVx8Gya7soaO
        M2zb/6MP4UPP0r21cLGE6dVm2sC6bzudD9ijzgvmnQw==
X-Received: by 2002:a5d:648a:: with SMTP id o10mr3513548wri.274.1623307429731;
        Wed, 09 Jun 2021 23:43:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOOjeybgNtep8FfbNLzY/mE05daXRXnIof6P9YIUDD5UQ85p+2PLukrf344jAtP/7qei+svw==
X-Received: by 2002:a5d:648a:: with SMTP id o10mr3513535wri.274.1623307429594;
        Wed, 09 Jun 2021 23:43:49 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id c7sm2555372wrc.42.2021.06.09.23.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 23:43:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] memory: tegra: Add missing dependencies
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210609112806.3565057-1-thierry.reding@gmail.com>
 <20210609112806.3565057-2-thierry.reding@gmail.com>
 <0c762772-929e-2eb8-6568-4aa82ea2f9ad@gmail.com>
 <ee2846c0-9274-0888-90ac-dac72d2ab5fd@canonical.com>
 <a3110fbd-c4af-0317-5a6d-1f780f1dac91@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1400979c-c7a7-9618-1168-70185ed10546@canonical.com>
Date:   Thu, 10 Jun 2021 08:43:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a3110fbd-c4af-0317-5a6d-1f780f1dac91@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 18:57, Dmitry Osipenko wrote:
> 09.06.2021 16:19, Krzysztof Kozlowski пишет:
>> On 09/06/2021 13:58, Dmitry Osipenko wrote:
>>> 09.06.2021 14:28, Thierry Reding пишет:
>>>> From: Thierry Reding <treding@nvidia.com>
>>>>
>>>> When enabling the COMPILE_TEST Kconfig option, the Tegra memory
>>>> controller can be built without ARCH_TEGRA being selected. However, the
>>>> driver implicitly depends on some symbols pulled in via ARCH_TEGRA,
>>>> which causes the build to break.
>>>>
>>>> Add explicit dependencies for OF_EARLY_FLATTREE and OF_RESERVED_MEM to
>>>> the Tegra MC Kconfig option to make sure they are selected even if
>>>> ARCH_TEGRA is not.
>>>>
>>>> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>>> ---
>>>>  drivers/memory/tegra/Kconfig | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
>>>> index f9bae36c03a3..ecfb071fc4f4 100644
>>>> --- a/drivers/memory/tegra/Kconfig
>>>> +++ b/drivers/memory/tegra/Kconfig
>>>> @@ -48,6 +48,8 @@ config TEGRA124_EMC
>>>>  config TEGRA210_EMC_TABLE
>>>>  	bool
>>>>  	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
>>>> +	select OF_EARLY_FLATTREE
>>>> +	select OF_RESERVED_MEM
>>>>  
>>>>  config TEGRA210_EMC
>>>>  	tristate "NVIDIA Tegra210 External Memory Controller driver"
>>>>
>>>
>>> Will this work if CONFIG_OF is disabled?
>>
>> Yeah, good question. That's why I propose "depends on". No issues with
>> unmet or circular dependencies.
> 
> What about to add stub for RESERVEDMEM_OF_DECLARE() + CONFIG_OF_RESERVED_MEM=n?
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index d8db8d3592fd..9c2e71e202d1 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1329,6 +1329,12 @@ static inline int of_get_available_child_count(const struct device_node *np)
>  	return num;
>  }
>  
> +#define _OF_DECLARE_STUB(table, name, compat, fn, fn_type)		\
> +	static const struct of_device_id __of_table_##name		\
> +		__attribute__((unused))					\
> +		 = { .compatible = compat,				\
> +		     .data = (fn == (fn_type)NULL) ? fn : fn }
> +
>  #if defined(CONFIG_OF) && !defined(MODULE)
>  #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
>  	static const struct of_device_id __of_table_##name		\
> @@ -1338,10 +1344,7 @@ static inline int of_get_available_child_count(const struct device_node *np)
>  		     .data = (fn == (fn_type)NULL) ? fn : fn  }
>  #else
>  #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
> -	static const struct of_device_id __of_table_##name		\
> -		__attribute__((unused))					\
> -		 = { .compatible = compat,				\
> -		     .data = (fn == (fn_type)NULL) ? fn : fn }
> +	_OF_DECLARE_STUB(table, name, compat, fn, fn_type)
>  #endif
>  
>  typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> index 76e4a0fffba4..4de2a24cadc9 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -27,11 +27,11 @@ struct reserved_mem_ops {
>  
>  typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
>  
> +#ifdef CONFIG_OF_RESERVED_MEM
> +
>  #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
>  	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
>  
> -#ifdef CONFIG_OF_RESERVED_MEM
> -
>  int of_reserved_mem_device_init_by_idx(struct device *dev,
>  				       struct device_node *np, int idx);
>  int of_reserved_mem_device_init_by_name(struct device *dev,
> @@ -41,6 +41,10 @@ void of_reserved_mem_device_release(struct device *dev);
>  
>  struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
>  #else
> +
> +#define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
> +	_OF_DECLARE_STUB(reservedmem, name, compat, init, reservedmem_of_init_fn)
> +
>  static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
>  					struct device_node *np, int idx)
>  {

The stubs might be good idea anyway, but the driver explicitly needs for
runtime working reservedmem, so it should select it.

Best regards,
Krzysztof
