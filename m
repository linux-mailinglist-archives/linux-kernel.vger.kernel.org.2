Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0803482A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhCXUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:14:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:15382 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237898AbhCXUN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:13:57 -0400
IronPort-SDR: 9f6U0Bxs96s1dMqbpr/ej69cGrnhFRJw211cUCca5qHDd/m5f49Y+4TgP2XWEVruoOEkjdwUSW
 iHmI3NPwl1VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190806594"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190806594"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 13:13:56 -0700
IronPort-SDR: QuUqn96D0XsZj9XK7gbQ58m7XJS/x7VxHIG5SwLXN9XFsbU2ZRcHf87F/h1ZC3DkVP37k0Kvll
 vbyZjY2o/fpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="442396425"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2021 13:13:54 -0700
Subject: Re: [PATCH] firmware: stratix10-svc: build only on 64-bit ARM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
References: <20210321184650.10926-1-krzysztof.kozlowski@canonical.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <2d91b502-c3f2-fbe9-641f-ee2b07eb5668@linux.intel.com>
Date:   Wed, 24 Mar 2021 15:33:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210321184650.10926-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/21 1:46 PM, Krzysztof Kozlowski wrote:
> The Stratix10 service layer and RCU drivers are useful only on
> Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
> fails:
> 
>    drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
>    include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
>      declared with attribute error: FIELD_GET: type of reg too small for mask
>      _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>    ...
>    drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
>      priv->status.version = FIELD_GET(RSU_VERSION_MASK,
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reported-by: kernel test robot <lkp@intel.com>
> 
> ---
> 
> Fix for commit in:
> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
> ---
>   drivers/firmware/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 6a4e882e448d..08bd4d01fb04 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -206,7 +206,7 @@ config FW_CFG_SYSFS_CMDLINE
>   
>   config INTEL_STRATIX10_SERVICE
>   	tristate "Intel Stratix10 Service Layer"
> -	depends on ARCH_INTEL_SOCFPGA && HAVE_ARM_SMCCC
> +	depends on ARCH_INTEL_SOCFPGA && ARM64 && HAVE_ARM_SMCCC
>   	default n
>   	help
>   	  Intel Stratix10 service layer runs at privileged exception level,
> 
Acked-by: Richard Gong <richard.gong@linux.intel.com>

Regards,
Richard
