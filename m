Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0E2408729
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhIMIjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238823AbhIMIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631522292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qh6P33VcH3uz2AI1w5Pma4JSyKdtq+QIbmAMwM1Yrh0=;
        b=frUkG0cBfc2nnOVvivqWyo1ldUGFw+RxkucTUomf4+VyvPvoSW6A/WwzxPeniSPtTlHOf5
        PhoCda0B0krFW1YCnRieZXxueBNZbFEz4L6AKz/V9TO3dQGICqmc3etfMZ45evH/fsbKHQ
        9WEShr60NsyapfM5xzdVouPkXZ45u+M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-Uq6gkxnwPKq5XeO_rIfUVw-1; Mon, 13 Sep 2021 04:38:08 -0400
X-MC-Unique: Uq6gkxnwPKq5XeO_rIfUVw-1
Received: by mail-ed1-f70.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so4528640edd.22
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qh6P33VcH3uz2AI1w5Pma4JSyKdtq+QIbmAMwM1Yrh0=;
        b=5FsncBhC0l3k9J5d0o0DMb5kdP/L4cc8F0VWEv5JdQ7ambU30nW4W2sgOBgHk/3dZi
         nqbZyzfC/ZE4NwzbpL5EoDcAkrbygo49NF8mIFzVIcN4eYre2ZYZrlo3j3rdhFkz+MDm
         yZBkavovlS6krgqv8KvwQX57Cu1liyQLIfkWsFFYghhuQYIQ9p+RQ0AFaBlUKeS0q6QG
         v/T06IjsFZyYQ0yF2cFK6jbKx/Xl6fK2KLRYp9kpaKcBCtP4B+OOevh8DVXXMYDHpWrl
         HMTzd4/H9iCs+rTBMm+BJe+/FPgpp/eGoG7+FI67lRXtticBNiHtL7hahaGR6MbyNMzi
         Q8Iw==
X-Gm-Message-State: AOAM530T6Oi4DQdvRjCPo07yBpj4fb0xYcybblBxZTPE5i1J44CA530y
        G8lVS+E6NqPsarSoCJ18Y4e0scs5yj02vv2xhMWYvuOIz1CvgfK9XQKzIMTIBdrIyc/Az4zYOBM
        iMRQpocX2vB+GMjbET+nrsTqO
X-Received: by 2002:a17:906:a24d:: with SMTP id bi13mr11485263ejb.481.1631522287620;
        Mon, 13 Sep 2021 01:38:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqFgVyTdiuwa+TbhSuN62Ka8m3x9OzJ7llnV4DCsSH4Tdr20imAxFAMYAlZSlxYh2RnwSBDg==
X-Received: by 2002:a17:906:a24d:: with SMTP id bi13mr11485249ejb.481.1631522287465;
        Mon, 13 Sep 2021 01:38:07 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id d10sm3553926edx.57.2021.09.13.01.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 01:38:07 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] platform/x86/intel: punit_ipc: Drop wrong use of
 ACPI_PTR()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        kernel test robot <lkp@intel.com>
References: <20210827145310.76239-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <80f5cda9-2855-501a-5472-7d5ab6290835@redhat.com>
Date:   Mon, 13 Sep 2021 10:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827145310.76239-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/27/21 4:53 PM, Andy Shevchenko wrote:
> ACPI_PTR() is more harmful than helpful. For example, in this case
> if CONFIG_ACPI=n, the ID table left unused which is not what we want.
> 
> Instead of adding ifdeffery here and there, drop ACPI_PTR()
> and unused acpi.h.
> 
> Fixes: fdca4f16f57d ("platform:x86: add Intel P-Unit mailbox IPC driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will also add this to the fixes branch, so that it gets send out
to Linus in my next pull-request with fixes for 5.15.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/intel/punit_ipc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/punit_ipc.c b/drivers/platform/x86/intel/punit_ipc.c
> index f58b8543f6ac..66bb39fd0ef9 100644
> --- a/drivers/platform/x86/intel/punit_ipc.c
> +++ b/drivers/platform/x86/intel/punit_ipc.c
> @@ -8,7 +8,6 @@
>   * which provide mailbox interface for power management usage.
>   */
>  
> -#include <linux/acpi.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -319,7 +318,7 @@ static struct platform_driver intel_punit_ipc_driver = {
>  	.remove = intel_punit_ipc_remove,
>  	.driver = {
>  		.name = "intel_punit_ipc",
> -		.acpi_match_table = ACPI_PTR(punit_ipc_acpi_ids),
> +		.acpi_match_table = punit_ipc_acpi_ids,
>  	},
>  };
>  
> 

