Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE4366DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbhDUOPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243331AbhDUOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619014477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AX/V6t89v5q0pnrudK+WSOQOtbBvPI5Z4KBsqWMHXTQ=;
        b=ZnHFuuLajO9ie34b1khpJJP8hVTM5vKq2Q1eOqDbT/j6XMvdJR4mW8PLqO1R/0QkWtcnnz
        sdF3psc77jJQrQMH/kdERs6btyziWPVBYOR7knzAi+wlnzVCi40Hff/Bi4c/pNTzA46Fo9
        SFrciFa7J0Rwhh9Wqx7bPHEun5UW27Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-DWAJ2gD9OvOxcptArvBhaQ-1; Wed, 21 Apr 2021 10:14:34 -0400
X-MC-Unique: DWAJ2gD9OvOxcptArvBhaQ-1
Received: by mail-ed1-f71.google.com with SMTP id l7-20020aa7c3070000b029038502ffe9f2so9338447edq.16
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AX/V6t89v5q0pnrudK+WSOQOtbBvPI5Z4KBsqWMHXTQ=;
        b=FjXNjXOnycL2ZuIjtv+7gqUFdi2EE+JBxharESvoLsD3aWgC/9X6UB9PYxu/lzuxDc
         ugNx+aG2yQGlLG7K1ucux9ajz9gQSp8MHJbmuze/AohEs8Gfe1mIhnLcv86pLGu45HDF
         xaj1aaOvbUD8Rk6ZCd++v23mp2FcC0DbCtFf8upYFegKoRnuv/9gdJHv9dzkVchj0bJY
         SmkzlG1jDPVZGHYNQJCGhsCbEOarMd04qnXBGKXup9wUplWUlYI4Znj+9oVuTmD5w+qW
         XJE0VbrKJoqMEmD0ZNKx9QGBbFTJ7P6aR4LVk3BWugivuqLGsq7WYZhs5FA6uRpZQ2LK
         SPog==
X-Gm-Message-State: AOAM530NU+yV9TrpqsV7QTQ6JcidLpdYXESXcLZRwalXij1nsywARx5n
        Zoyrh5vdO/81MZACNOFbKk9NbbwA1HbAgQgYlnJ7PdZqRYf+TKPYUzyIrTuN+m/qqSAFvt+gAF7
        W0YYZq7rnTjM+unzNnBBvLeEA9wQ/x5ygGHr6dq+VviIIWwXFdCvFHNhY98Xyg/g0/2FH1RIZ0k
        rj
X-Received: by 2002:a17:906:1d0e:: with SMTP id n14mr33336779ejh.97.1619014473376;
        Wed, 21 Apr 2021 07:14:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBoGShIK2hD58OGZUceTgJ7hT1ipFzIy7ZJ6TiKDOehe3hIZ7bPjraE2Cc0iFqhwquFTDvEw==
X-Received: by 2002:a17:906:1d0e:: with SMTP id n14mr33336750ejh.97.1619014473195;
        Wed, 21 Apr 2021 07:14:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d15sm2509354ejj.42.2021.04.21.07.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 07:14:32 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: intel_pmc_core: add ACPI dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210421134957.3329062-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8f57e976-70e5-29d3-51d7-071fafb24caf@redhat.com>
Date:   Wed, 21 Apr 2021 16:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421134957.3329062-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/21/21 3:49 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver now fails to build without ACPI:
> 
> drivers/platform/x86/intel_pmc_core.c: In function 'pmc_core_get_tgl_lpm_reqs':
> drivers/platform/x86/intel_pmc_core.c:617:41: error: invalid use of undefined type 'struct acpi_device'
>   617 |         out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
> 
> This could probably be made optional, but it won't be used without
> ACPI in practice, so just add a Kconfig dependency.
> 
> Fixes: 428131364f00 ("platform/x86: intel_pmc_core: Get LPM requirements for Tiger Lake")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 697fc446ac41..2714f7c3843e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1194,6 +1194,7 @@ config INTEL_MRFLD_PWRBTN
>  config INTEL_PMC_CORE
>  	tristate "Intel PMC Core driver"
>  	depends on PCI
> +	depends on ACPI
>  	help
>  	  The Intel Platform Controller Hub for Intel Core SoCs provides access
>  	  to Power Management Controller registers via various interfaces. This
> 

