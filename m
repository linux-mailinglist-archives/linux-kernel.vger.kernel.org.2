Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D858365C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhDTPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232504AbhDTPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618932653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBBsrjmHRDP21lnXRazBH5eMtCC8CXeVM/g8RMCBPvM=;
        b=SQCWukSSFfevkr4c3gIgTUZzTC0WgUpdGirFsKz0TFYGdecF3jRJzINVOnDgEE+d+9c2U1
        KgvzXsQNMfDkJSKXR94hSV/2Z2xAPVm8K/LATmNgNhC1AKax24Tiy5a3cYVn+DvsFq9oqB
        LDZ7tQsIGqrX1BQYWnmnr3V+LrgEp2I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-CJC402btNvuPGwtWyHIVAQ-1; Tue, 20 Apr 2021 11:30:51 -0400
X-MC-Unique: CJC402btNvuPGwtWyHIVAQ-1
Received: by mail-ed1-f72.google.com with SMTP id z3-20020a05640240c3b029037fb0c2bd3bso13431960edb.23
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RBBsrjmHRDP21lnXRazBH5eMtCC8CXeVM/g8RMCBPvM=;
        b=fyUzrlwnGmcSQjg/1c9ZsR9H1F141XVws7kFZ8sQUSUaPDAq7owRRkYPozL/oF5Kx4
         bvxEM6VR1y3By99/bpVk5MCUemURdhhW7Y0rWn1rJdzCtvV74wOz7bV78FyG2EXMI+4b
         UlvdlEFijNZVRE3+QGytJCJF73KN1STqRKv7OTWLEeXbwMm6anIkvVu6vbI7zUQVQgKH
         FeQtX5iH71yfRVFma3vlls57JzUc7jHVztMLVTVGtQVQK87A47fpfJ53yPxF7Hj9onhn
         +o9VvIJhHNUamCb8sI5T2mdZj3sLSeYW7zVn6vyIYBFGSh6/HWqNBI0WJTxCdOZtAcq1
         EZiQ==
X-Gm-Message-State: AOAM532fK4v0+JlOLWR2b8FIIiQy2JrEKQwDNE7QDcRbVO1AATfVWJ/e
        6VZ87LCCOV+Kw6TmOxQAkgK7X8kdW5j273a5ZbUYBvwdaJ3gFhRgBhuEwR2nDeDlzjYFA4GJqWl
        jLTZdvHNSfIh0gKr7k5jb5Adb
X-Received: by 2002:a05:6402:134f:: with SMTP id y15mr15446457edw.259.1618932650227;
        Tue, 20 Apr 2021 08:30:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuVHu6/YIHf26jz/l5PBJO5dia9L05ZHer0be0n8fwzCxg/hUL9LLA7M5dpD9wD7isJaO0ng==
X-Received: by 2002:a05:6402:134f:: with SMTP id y15mr15446440edw.259.1618932650105;
        Tue, 20 Apr 2021 08:30:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h19sm12796131ejc.94.2021.04.20.08.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:30:49 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: fix a bit test
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YH6UUhJhGk3mk13b@mwanda>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <abec80a7-6fee-1105-e219-21fcd88f9949@redhat.com>
Date:   Tue, 20 Apr 2021 17:30:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH6UUhJhGk3mk13b@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/20/21 10:44 AM, Dan Carpenter wrote:
> The "funcs" variable is a u64.  If "func" is more than 31 then the
> BIT() shift will wrap instead of testing the high bits.
> 
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
>  drivers/platform/surface/aggregator/controller.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
> index 00e38284885a..69e86cd599d3 100644
> --- a/drivers/platform/surface/aggregator/controller.c
> +++ b/drivers/platform/surface/aggregator/controller.c
> @@ -1040,7 +1040,7 @@ static int ssam_dsm_load_u32(acpi_handle handle, u64 funcs, u64 func, u32 *ret)
>  	union acpi_object *obj;
>  	u64 val;
>  
> -	if (!(funcs & BIT(func)))
> +	if (!(funcs & BIT_ULL(func)))
>  		return 0; /* Not supported, leave *ret at its default value */
>  
>  	obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
> 

