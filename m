Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4A23E41F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhHIJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234151AbhHIJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628499650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8HttrntNZPFs0juELsB3vTreBKXm0ssKSUN1T2UgVs=;
        b=M3Dibxjd0J6Y6jcbcdndZhgBDBmnK6AvaMyxaT9mW+2XNxZbUe8UEkS/VwzuZZRE8nA8Zl
        1sIRJsgVbB+LThiqnpztcA8mm3ayAMFRv1hENnq/GheAuNNhk7xTdFQkLzFxsBd5GI/tT5
        VC8Re40rt/qJPQi7rWmDNscWK/L1ck8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-luxxXI36MsipE0-e8bZQVQ-1; Mon, 09 Aug 2021 05:00:41 -0400
X-MC-Unique: luxxXI36MsipE0-e8bZQVQ-1
Received: by mail-ej1-f69.google.com with SMTP id k22-20020a1709061596b02905a370b2f477so4309802ejd.17
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 02:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L8HttrntNZPFs0juELsB3vTreBKXm0ssKSUN1T2UgVs=;
        b=sNLl652wIeqpljHF+HVF+oUEVnjYozDpTCLMktnxw4vcZyP1qXEjxl1ugmRfjs7woj
         Sc9V7jIQEKwOkSGrDQHgXloxjUqe/wRnl2omJc8+BlqDlXBMV1f8emgHCFQfflaTeCAG
         yd5oyijMNCaRFJEHn2EqaHIS0/uC2V2BroI0stacKuZd9SUjrbd0PqoYyMJI6AqJJVdN
         NkHtVwTrk0LgKfvewL8zsjOh9cQ54LVSD9/FA5ZBA2JGY5ox9bqkSrjMLYA37BU1R89U
         P6cua9HQ9y4v1a1UidezsG6O86GlVfIjs3ZwGLKAuXRXfbbMNTJS/694lpRxZtGI2vqI
         BhbA==
X-Gm-Message-State: AOAM531tZWXKcBpmZOjUug834/n4JkVYyCymLfKQsf7HZe5Y6J2mbQvd
        Mc/IRMMY2UE0oUcKyar4MxQuwJIS5lB89rCm6YZXwRVHcCC09QDtmaFzVU6VstvewaxltxQHd1e
        LowIRJzg9coPEEmZWauPS1Fef
X-Received: by 2002:a17:906:5e45:: with SMTP id b5mr21620411eju.301.1628499640036;
        Mon, 09 Aug 2021 02:00:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw09sn2gDpVU46Yw+tmDb/2htDgapIE6hFOQ5zm1XmYLbdAv6Pp+VPMXn88sB/Yp0DTV5l6UA==
X-Received: by 2002:a17:906:5e45:: with SMTP id b5mr21620400eju.301.1628499639906;
        Mon, 09 Aug 2021 02:00:39 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id v13sm5669377ejh.62.2021.08.09.02.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 02:00:39 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] platform/x86/intel: pmt: Use y instead of objs in
 Makefile
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
References: <20210806155017.4633-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a6b48303-1a43-5cc2-ec4a-41fed5ae02cb@redhat.com>
Date:   Mon, 9 Aug 2021 11:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806155017.4633-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/6/21 5:50 PM, Andy Shevchenko wrote:
> The 'objs' is for user space tools, for the kernel modules
> we should use 'y'.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
> 
> Hans, feel free to fold in the original commit
> 
>  drivers/platform/x86/intel/pmt/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/Makefile b/drivers/platform/x86/intel/pmt/Makefile
> index 019103ee6522..279e158c7c23 100644
> --- a/drivers/platform/x86/intel/pmt/Makefile
> +++ b/drivers/platform/x86/intel/pmt/Makefile
> @@ -4,9 +4,9 @@
>  # Intel Platform Monitoring Technology Drivers
>  #
>  
> -pmt_class-objs				+= class.o
>  obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt_class.o
> -pmt_telemetry-objs			+= telemetry.o
> +pmt_class-y				:= class.o
>  obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= pmt_telemetry.o
> -pmt_crashlog-objs			+= crashlog.o
> +pmt_telemetry-y				:= telemetry.o
>  obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= pmt_crashlog.o
> +pmt_crashlog-y				:= crashlog.o
> 

