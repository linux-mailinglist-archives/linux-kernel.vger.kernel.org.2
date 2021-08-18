Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5E3EFE41
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbhHRHwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238841AbhHRHwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629273129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOMN6Z2zh1UW6EVvLFcoYXZV9eRu7KQDPh2XJGIt4dg=;
        b=S672gC09KNru327l2R5MmSYoXROUu2zVuatZBp32PBQ/elfJRQqRwRzQj+5fRDjXuktaIz
        vfQeF6f6Zr07DZW6dqgW/RKSw/927oL3TqkDeak1Kmyr42KOmynCE/weKLspTJmliUTDgi
        Xz67vtJUP9N8vfQ2Qi+b/RJDQwWvHVk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-DrFVVNBBOvezaSJ-v7MK0A-1; Wed, 18 Aug 2021 03:52:08 -0400
X-MC-Unique: DrFVVNBBOvezaSJ-v7MK0A-1
Received: by mail-ej1-f72.google.com with SMTP id kf21-20020a17090776d5b02905af6ad96f02so560015ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOMN6Z2zh1UW6EVvLFcoYXZV9eRu7KQDPh2XJGIt4dg=;
        b=O9H02ia0ZCOieROWVgt3rqHqTvlxcVj8qTinsGmIDmOYTPowjPFKBHufuZPxFoA7qd
         +LVYiVfYwJJcAh8TAf0Oah9iFpJufNprtP9oC1M1u00l8BdyZO46A6q4xIAAewYUP0bd
         6ErFOtdgV1k1mzG2YFpDDZs1Xei40iu7s+9gfu1DrJZgkQ2etXC51kea60m/qSmVS5Cc
         MyYinIKxJG3VOflL5eScvHbSFaeJVWSQoYudtZqAGJ1sqfI5kQ9ujkh5tJZScHXjJYB2
         a7pDSP6W+c2MIym1nbP8wTv1LT6JfC8tj/EkBVOerI+bb8e31w9uO5goBf2Vj03KpepH
         TQBg==
X-Gm-Message-State: AOAM533TeaSvt6vS8KKEu5ql0YkjThegISMZg1ewXuwD0Q+OaRxv5qaV
        OOKKxc7RWr0QytWT1O7IxXKZ8FoBp5AjOhhEMBqIkemTxHKTcqtrpS/SqLUnPAwLE2rl9CQLcUh
        eqha7VX5KxdR1CUz3yzJibN6j
X-Received: by 2002:a17:906:c4c:: with SMTP id t12mr8490877ejf.217.1629273126666;
        Wed, 18 Aug 2021 00:52:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKuoN0LMbLlnRfvMbXfG+NS0pWGRAO2j3+oB/zXa5n9J84AZ01fPrOVlJL4FGyr+YINw9iTQ==
X-Received: by 2002:a17:906:c4c:: with SMTP id t12mr8490869ejf.217.1629273126477;
        Wed, 18 Aug 2021 00:52:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id a25sm1642557ejv.91.2021.08.18.00.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 00:52:06 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] platform/x86: intel_pmt_telemetry: Ignore zero
 sized entries
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        mgross@linux.intel.com, bhelgaas@google.com,
        srinivas.pandruvada@intel.com, andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20210817224018.1013192-1-david.e.box@linux.intel.com>
 <20210817224018.1013192-5-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c1a8e066-ef99-911c-1b82-6e8da62e935a@redhat.com>
Date:   Wed, 18 Aug 2021 09:52:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817224018.1013192-5-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/21 12:40 AM, David E. Box wrote:
> Some devices may expose non-functioning entries that are reserved for
> future use. These entries have zero size. Ignore them during probe.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

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
> V2:	New patch
> 
>  drivers/platform/x86/intel/pmt/telemetry.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
> index 3559f6e7b388..d93d02672679 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.c
> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> @@ -61,6 +61,14 @@ static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
>  	/* Size is measured in DWORDS, but accessor returns bytes */
>  	header->size = TELEM_SIZE(readl(disc_table));
>  
> +	/*
> +	 * Some devices may expose non-functioning entries that are
> +	 * reserved for future use. They have zero size. Do not fail
> +	 * probe for these. Just ignore them.
> +	 */
> +	if (header->size == 0)
> +		return 1;
> +
>  	return 0;
>  }
>  
> 

