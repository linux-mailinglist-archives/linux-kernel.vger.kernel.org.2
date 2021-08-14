Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4823EC211
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbhHNKkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbhHNKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:40:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7C2C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 03:39:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so8492087wmi.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AjtBntReMJGpNPGRQcNNDdIRXr/5WmXLSjQN1TRNwcM=;
        b=Bn/vziQkg530r29jS6+PdUl1chWice+vbrCzGWDBk4mqC8l0HKPNmPLOdHdaX2LtyG
         Ai1V4yiLeqMqZE/i1XI26p7qyjU3MBfpVH7XfA92ps7/q6ZISVhiiqJZKV4DFEqdU8JW
         kguIHhjPFpbWsF8mrZIieiDlU+2O+MMwiQd6t9HDoTn+pLuH049bssii9+hPHJLvnYb9
         x1oMsaNYr4HLsNpRE0SD3bGRGv32CayiyOub3ItHmeWdyUbPdGK5FQEyKH11ddOlUrnM
         aKe2RsX9+Qqf+nNEm/5k8PCQEobzQIbY3hdnfIcN3iuJw6U7lpOI4rfFcobgGx3lJPTf
         V96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AjtBntReMJGpNPGRQcNNDdIRXr/5WmXLSjQN1TRNwcM=;
        b=R/0WPSAUFC966yhOTit4tK5TQEOxbPnLd3w1bpKS3P5Yw6Sz9hBnShkWS9+SFNnzvO
         vB6I9BqE2G8VCTG4BX7jRX0Jm1N+RPJpbkxjutfkpnis4I9c78umlBdJaWOHrBcQ1nEf
         vLNpd4v50MJOKKaOyi5RzO94S6MGd3IP05mOrrpyowLq7354NTtZ2C5twV0XDPOsf2kL
         cXP52c337VqR9h+TmjJ4J+XUUQ74wJ6J5bq2C52x2if/aIq2bP3yT9y/XOSRbDnb5Nji
         nQxpHJnMWiZN3JPWE3Bi3oybkRPg5QsimzEDnksiLob6qM1F5IEMzEmKLs3NGnbL5wFv
         Qmng==
X-Gm-Message-State: AOAM5328gunhDTqUvvjfRNPHm2u0KMCulAbn7NZ8rhYekviMHQPRVYX2
        cR2AeRTiHiWxWoykJw+9u9OwbQ==
X-Google-Smtp-Source: ABdhPJzBALGrCf8MxWf9h62cOgtFY5oMK4xDQgub5sOUQBmLCT2fQvu9N1PDpNMhJ56z3BplMyOPFw==
X-Received: by 2002:a7b:c354:: with SMTP id l20mr6781859wmj.159.1628937594242;
        Sat, 14 Aug 2021 03:39:54 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id z137sm4359508wmc.14.2021.08.14.03.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 03:39:51 -0700 (PDT)
Subject: Re: [PATCH 18/20] Move Intel thermal driver for menlow platform
 driver to intel/ directory to improve readability.
To:     Kate Hsuan <hpa@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org
References: <20210810095832.4234-1-hpa@redhat.com>
 <20210810095832.4234-19-hpa@redhat.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <95801e67-f09e-64f3-abd6-f38a8f1f1d51@linaro.org>
Date:   Sat, 14 Aug 2021 12:39:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810095832.4234-19-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2021 11:58, Kate Hsuan wrote:


Why not move it into drivers/thermal/intel ?


> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/platform/x86/Kconfig                       |  8 --------
>  drivers/platform/x86/Makefile                      |  2 +-
>  drivers/platform/x86/intel/Kconfig                 |  1 +
>  drivers/platform/x86/intel/Makefile                |  2 ++
>  drivers/platform/x86/intel/menlow/Kconfig          | 14 ++++++++++++++
>  drivers/platform/x86/intel/menlow/Makefile         |  6 ++++++
>  .../platform/x86/{ => intel/menlow}/intel_menlow.c |  0
>  7 files changed, 24 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/menlow/Kconfig
>  create mode 100644 drivers/platform/x86/intel/menlow/Makefile
>  rename drivers/platform/x86/{ => intel/menlow}/intel_menlow.c (100%)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index b9c0d2d97793..50ded236a841 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -632,15 +632,7 @@ config THINKPAD_LMI
>  
>  source "drivers/platform/x86/intel/Kconfig"
>  
> -config INTEL_MENLOW
> -	tristate "Thermal Management driver for Intel menlow platform"
> -	depends on ACPI_THERMAL
> -	select THERMAL
> -	help
> -	  ACPI thermal management enhancement driver on
> -	  Intel Menlow platform.
>  
> -	  If unsure, say N.
>  
>  config INTEL_OAKTRAIL
>  	tristate "Intel Oaktrail Platform Extras"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index f4c6ced59da1..ea5f5dd3f78a 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -67,7 +67,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>  obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
>  
>  
> -obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
> +
>  obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
>  obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
>  
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index 4efb5ad3e3e1..59c9b602c784 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -36,6 +36,7 @@ source "drivers/platform/x86/intel/intel_speed_select_if/Kconfig"
>  source "drivers/platform/x86/intel/turbo_max_3/Kconfig"
>  source "drivers/platform/x86/intel/uncore_freq/Kconfig"
>  source "drivers/platform/x86/intel/int0002/Kconfig"
> +source "drivers/platform/x86/intel/menlow/Kconfig"
>  
>  
>  endif # X86_PLATFORM_DRIVERS_INTEL
> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
> index fe5058c3af18..b2326554bd84 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_INTEL_HID_EVENT)		+= hid/
>  obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= wmi/
>  obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
>  obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= int0002/
> +obj-$(CONFIG_INTEL_MENLOW)		+= menlow/
>  
>  
>  # Intel PMIC / PMC / P-Unit devices
> @@ -38,3 +39,4 @@ obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
>  obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= turbo_max_3/
>  obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= uncore_freq/
>  
> +
> diff --git a/drivers/platform/x86/intel/menlow/Kconfig b/drivers/platform/x86/intel/menlow/Kconfig
> new file mode 100644
> index 000000000000..b2920d259ff7
> --- /dev/null
> +++ b/drivers/platform/x86/intel/menlow/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Intel x86 Platform Specific Drivers
> +#
> +
> +config INTEL_MENLOW
> +	tristate "Thermal Management driver for Intel menlow platform"
> +	depends on ACPI_THERMAL
> +	select THERMAL
> +	help
> +	  ACPI thermal management enhancement driver on
> +	  Intel Menlow platform.
> +
> +	  If unsure, say N.
> diff --git a/drivers/platform/x86/intel/menlow/Makefile b/drivers/platform/x86/intel/menlow/Makefile
> new file mode 100644
> index 000000000000..0e9fda9bff98
> --- /dev/null
> +++ b/drivers/platform/x86/intel/menlow/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Intel x86 Platform Specific Drivers
> +#
> +
> +obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
> diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel/menlow/intel_menlow.c
> similarity index 100%
> rename from drivers/platform/x86/intel_menlow.c
> rename to drivers/platform/x86/intel/menlow/intel_menlow.c
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
