Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25BC3E41F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhHIJBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234061AbhHIJBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628499661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoO0nUKoGU4+yW1m7cbdBKZwkrdjkhDY5qQ8aeTmSZA=;
        b=I60bjBeTNWvzFpR5meDG9pLosEixjlpA20TNZkSpeeD1y2QaBYFBQlPTHOSjv5vO32jfZW
        lH1md2ggHOV6MKf+W3zYU+SV81Z4Z9WkuQAK8INznrgPyYoKf0A8xtgsJ3HL2iymJNq0qU
        YfBxEzJkmdLi4G8bMj16vFiS8WU8Q5w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-FWJvWbbNMEmBK2A1dMxAvw-1; Mon, 09 Aug 2021 05:01:00 -0400
X-MC-Unique: FWJvWbbNMEmBK2A1dMxAvw-1
Received: by mail-ej1-f70.google.com with SMTP id kf21-20020a17090776d5b02905af6ad96f02so573173ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 02:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FoO0nUKoGU4+yW1m7cbdBKZwkrdjkhDY5qQ8aeTmSZA=;
        b=WZovf9+zQKFrD5pmRoKuZ+A5fuGRObaq4Y7tYBKLWIwJ9DI4iTg1brD4ydQTUTfDaq
         G6q22j56LTagCWXCQZbvyRm/Rs3HgDB5oGQuYg5lQqemV4/kGCL/PavEk0EghgdW2HAO
         Yl4oh7aalk5mzY7IGuHSL1P59wzp5nwYKbzzHYdng+9cfHYJs5+SQAtR3zaUMtMN+5B/
         Bmxu9T/OFbAqxm62j7I/S4+2i9KhMrpk6vl2hCrf5b/bEN6I5gSAlRKrpLjHws1946nl
         HVN79UV+P8cMZtgKdUNXT2qB0kjoBb5XOiRTCgpaoTwHUwqquGweTzfM8kqCZPPNfAPB
         /SmA==
X-Gm-Message-State: AOAM532xAK+ihrk4oA7UMBnpKHKFb7jw7BEIbiH/N1CR6A0Ufnu9Vp8Z
        sc/gjEwjmnwrPtE7A67NCQqVU9OlceVGAQWVhTcCFipg7+izT0ULdEdDgsr4fqpJFiBrGN4FPrE
        DDa/nPZY5aisJADHQQpr9Mfh8
X-Received: by 2002:aa7:d499:: with SMTP id b25mr264726edr.360.1628499659237;
        Mon, 09 Aug 2021 02:00:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzciqT2dLJpKtZTsjmfVHRPiQE1ErZUf+FdcUCtHWDBh7wF3C/mmtt1TDR33+wvBc5LmB/EFQ==
X-Received: by 2002:aa7:d499:: with SMTP id b25mr264710edr.360.1628499659137;
        Mon, 09 Aug 2021 02:00:59 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id o17sm5666699ejb.84.2021.08.09.02.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 02:00:58 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] platform/x86/intel: int3472: Use y instead of objs
 in Makefile
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Mark Gross <mgross@linux.intel.com>
References: <20210806154951.4564-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5ac33176-3c70-681c-578b-639af929c0f4@redhat.com>
Date:   Mon, 9 Aug 2021 11:00:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806154951.4564-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/6/21 5:49 PM, Andy Shevchenko wrote:
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
>  drivers/platform/x86/intel/int3472/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/Makefile b/drivers/platform/x86/intel/int3472/Makefile
> index 48bd97f0a04e..2362e04db18d 100644
> --- a/drivers/platform/x86/intel/int3472/Makefile
> +++ b/drivers/platform/x86/intel/int3472/Makefile
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_INTEL_SKL_INT3472)		+= intel_skl_int3472.o
> -intel_skl_int3472-objs			:= intel_skl_int3472_common.o \
> +intel_skl_int3472-y			:= intel_skl_int3472_common.o \
>  					   intel_skl_int3472_discrete.o \
>  					   intel_skl_int3472_tps68470.o \
>  					   intel_skl_int3472_clk_and_regulator.o
> 

