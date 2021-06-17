Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18D83ABF19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhFQWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhFQWws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:52:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA6BC061574;
        Thu, 17 Jun 2021 15:50:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c5so8475282wrq.9;
        Thu, 17 Jun 2021 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KcA7PNNr/ye+bW5nAILlDnKfv5EVgNn+yBa/eTdKm3U=;
        b=g8IJ8qA/0Jx32P3r0ImGZcGfWvJGwGrbym5CV9abUwcYEIp7GUnk+/N4mcTO5HrB41
         9oQAF/bPwlEMnmF8DxnLxtxxnIaHaaqtkCp+gAaqa4/7JIg8jz9FBZpM9xfzALBlFEen
         iDEGmcd3tiTsIvWNkyisLZrZ1hj5ShIlRZGyj4tZtAkLZsbMXy2uiKkS6WyrCz5V3kXu
         wmgYjnM/XEKOu/es9m5e1asE5ptoTgJJKDSmNPteSWk2KUuL+NKtZVDLmaUdxCSq+syz
         yvrQnkgaclfh+x+sFxpdQNc/9kju5A+WfMc5eZK5LkkEA0HYBPqKepUmtjliSseUr8C2
         jSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KcA7PNNr/ye+bW5nAILlDnKfv5EVgNn+yBa/eTdKm3U=;
        b=a/U3Rx9jY4VEuuXLxDYcG7amfAgSJdEGo0am2IC7NeEGA66X1XPNq40ou6Lc7yThic
         KNR/liF6Si4NBH7FK1OsaMXLX7wRNEXlpYAdQo4i0MGtkt8BJaSofc7p9/0JjBbG6guf
         /NbDfp99586R5hx6ruC0fUnIUzerx+v20pLDPJrjqCd4n96+63gWMZ4vulqXdSa+1eXR
         fzc/476IA3e00hP+Vf6XyAKZHYio06nlhSACg5sLlqLADWZ/gmse8AwCl0OMag7n+QcE
         Mj9SUbh2aXiIE1Ad+igH4kb8w6KqMBE7rsfhrP4zNVflPmhSwJFnYPlOiTHZrnAUCQoW
         qw/A==
X-Gm-Message-State: AOAM531NpZjeY+PVRc6gJ7ODE97QCPu9Y1CPW9pdYP9D6Pa696NYLnzW
        qZG7DxGUHurewuIdHLpMjjn90e7ftGc=
X-Google-Smtp-Source: ABdhPJywKcntEOFhYoq2xobjgyu5YSXIQ8oGDBHrzDjeyydwX9l9gFBOuUM6igWWUWIhQRsAC8Ij1A==
X-Received: by 2002:adf:b19a:: with SMTP id q26mr8608897wra.401.1623970237833;
        Thu, 17 Jun 2021 15:50:37 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.84])
        by smtp.gmail.com with ESMTPSA id r1sm6231533wmh.32.2021.06.17.15.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 15:50:37 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] platform/x86: intel_skl_int3472: Fix dependencies
 (drop CLKDEV_LOOKUP)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
References: <20210617183031.70685-1-andriy.shevchenko@linux.intel.com>
 <20210617183031.70685-2-andriy.shevchenko@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <c3aec3b4-1ba1-6442-fbed-57a16febde68@gmail.com>
Date:   Thu, 17 Jun 2021 23:50:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617183031.70685-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 17/06/2021 19:30, Andy Shevchenko wrote:
> Besides the fact that COMMON_CLK selects CLKDEV_LOOKUP


So it does - thanks

> , the latter
> is going to be removed from clock framework.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Reviewed-by: Daniel Scally <djrscally@gmail.com>

> ---
>  drivers/platform/x86/intel-int3472/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel-int3472/Kconfig b/drivers/platform/x86/intel-int3472/Kconfig
> index c112878e833b..62e5d4cf9ee5 100644
> --- a/drivers/platform/x86/intel-int3472/Kconfig
> +++ b/drivers/platform/x86/intel-int3472/Kconfig
> @@ -1,7 +1,7 @@
>  config INTEL_SKL_INT3472
>  	tristate "Intel SkyLake ACPI INT3472 Driver"
>  	depends on ACPI
> -	depends on COMMON_CLK && CLKDEV_LOOKUP
> +	depends on COMMON_CLK
>  	depends on I2C
>  	depends on GPIOLIB
>  	depends on REGULATOR
