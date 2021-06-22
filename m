Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1E13B007A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFVJog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhFVJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624354939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jShsVGW+iZ832g9v6h9ET2H9fUfcv30IVBX0gdnYAH8=;
        b=XGad2DcRe/+UQmnsPDfBS3DowFvDG7skLzN8tGfNve00RiFc+Q/K2w9h4r/RzYXNH4v7Yh
        LLT2Vfz14Siz4HTtrmnaDU1oa7Da0l2fuxXqnauApwcEfILrOIPTrw9OlXXC/gDM3afj6u
        GYW4LkH5a5tJ+WR3TLhCZBkUtJ0fGOM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-ZZnKgqVdP_KfqpVHYwtiFw-1; Tue, 22 Jun 2021 05:42:17 -0400
X-MC-Unique: ZZnKgqVdP_KfqpVHYwtiFw-1
Received: by mail-ej1-f71.google.com with SMTP id ho42-20020a1709070eaab02904a77ea3380eso222131ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jShsVGW+iZ832g9v6h9ET2H9fUfcv30IVBX0gdnYAH8=;
        b=T9cE684A3trilG/OW21WEtbt8txje+FC5ayYbznqnFRYihaCny/2phwBpHzLm9MNHB
         ThzN1M+YxrH8l3/73NB7KY7tLrwN1EtoFLwIEhJzPmX1jCX70Cs6XSvDTmqM1P6a+T7l
         H1KFN7Wdhpydd+Ups1v2pVsn96lyRh/xOqqHB5y3wi9wsIFmi/GFkjPkuNB5Vg5ocCpJ
         fKMdvHS/zTwp428MUXzsU19rNv+dxZV9p5bv0Dt8fn4tF6f5iQ7u6cjAv+DtaCpup9BS
         VWPTnabQu0gaWxXZxlxZjJOUF/M2E/Y2H3xdpKRjROejR2MJ6b5LcbJnuo22QqtyDuVg
         gx7g==
X-Gm-Message-State: AOAM530mJBohSNSOoyfY6Qkg42fHH78+Sb1SawRBk1ZlbjLjhfKHwlxs
        nKA+tvnWEq9/AaIvVYoaLu2TYMxB4nDI5vPtlBJcc2o49GJw7LYmjmWfBvuMswjVIdvQMKcPL3l
        24EVY7dG5h5nRZ5yUFRAoVvTO
X-Received: by 2002:a17:906:94d1:: with SMTP id d17mr3064899ejy.460.1624354936722;
        Tue, 22 Jun 2021 02:42:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjlKwhJZ7loCtKYfNxt2d5FUj/1gLyLtgpp2KN/Bimw7rLhTeI2ycJXD5QyJspS6ZzLNStYQ==
X-Received: by 2002:a17:906:94d1:: with SMTP id d17mr3064881ejy.460.1624354936589;
        Tue, 22 Jun 2021 02:42:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u22sm11882365edr.11.2021.06.22.02.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 02:42:16 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] platform/x86: Remove "default n" entries
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9f5fc6f7-0979-5767-9929-550be74e608e@redhat.com>
Date:   Tue, 22 Jun 2021 11:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/18/21 2:55 PM, Andy Shevchenko wrote:
> Linus already once did that for PDx86, don't repeat our mistakes.
> TL;DR: 'n' *is* the default 'default'.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note I've squashed in the following fixup to patch 7/8:

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9388,7 +9388,7 @@ F:        drivers/platform/x86/intel_scu_*
 INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
 M:     Daniel Scally <djrscally@gmail.com>
 S:     Maintained
-F:     drivers/platform/x86/intel-int3472/
+F:     drivers/platform/x86/intel/int3472/
 
 INTEL SPEED SELECT TECHNOLOGY
 M:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

(checkpatch complained about MAINTAINERS not being updated)

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> v2: no changes
>  drivers/platform/x86/Kconfig      | 1 -
>  drivers/platform/x86/dell/Kconfig | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 4fd792f2a10a..ccb827b57f1f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1092,7 +1092,6 @@ config TOUCHSCREEN_DMI
>  
>  config FW_ATTR_CLASS
>  	tristate
> -	default n
>  
>  config INTEL_IMR
>  	bool "Intel Isolated Memory Region support"
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index 9b0a4d080f43..9e7314d90bea 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -5,7 +5,6 @@
>  
>  menuconfig X86_PLATFORM_DRIVERS_DELL
>  	bool "Dell X86 Platform Specific Device Drivers"
> -	default n
>  	depends on X86_PLATFORM_DEVICES
>  	help
>  	  Say Y here to get to see options for device drivers for various
> 

