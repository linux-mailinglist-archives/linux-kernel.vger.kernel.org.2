Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284C040D8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhIPLjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:39:14 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42758
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238088AbhIPLjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:39:13 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 17C2240262
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631792271;
        bh=908BDomxjWW13dJ+h5+IM/p6bjjEbnfsipmAx3G+qQk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=mBtaNSilOEf22C0wURChaHF5QhPdYld4ejvTMRBKeQhk9OuZVH9Z4u1Fgk/lHPekP
         B225albEp9tWH3PM+b3krkGXFNPZBmgzGD7wHxrqYok2+RLw0BZWknjPiPmncHyoi6
         b1e+8ci92P5T4DwAh0BBLH8d2PCfnmYnrBv3O6kyiNx1a7Z/xNs3fZGQzGesUeqfPR
         EEorOXQE9hWyVQ0Z/5k02R7B1wiVqYH6g7N/sv/CO9KlJWZhskirOS4bJjSlhtOH7H
         GE6CSAu53bagwJ87nZlUKyXB7NAkm0fjGdesNgHgMHCK6AbYRvdwlgHazVXaZYVk8/
         fKVVPo7e8Hi2g==
Received: by mail-pg1-f200.google.com with SMTP id t28-20020a63461c000000b00252078b83e4so4843388pga.15
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 04:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=908BDomxjWW13dJ+h5+IM/p6bjjEbnfsipmAx3G+qQk=;
        b=Vkvfrb7bsRuERpFcrbQcc2KhSY0hjKljp1Y3GbPzJ5iC55L0oZcuh+1cFdgf4vcBOJ
         FyZi4oPrWmXig6akqgVUOAIkZ9BLgy8C0mgvmrAa/fb1aDnj4yZ+z32AsctXj+M6x4mH
         T5s9eO577wL9zZ0dTVE79pDjEKgMFcge15Uxlx9QrtJ1CJjGE5dys9XjYMHjmiUcXjRT
         /re0vsvUqQHw/cDvsNvBisqzH5PG3Iiallto1pjfVM24yZU6Wx4K8ArA3mvUO9YsGryQ
         RlNx/YQjD56xSk6PHjCk1J8mEOHBRZZLE7tHX2CZSuoCiXSMQT+D8eAMZ/YEHuoTX1qL
         5h+g==
X-Gm-Message-State: AOAM530aWXpCP9VxrbSWOXm726lukm5xZE028UgqGaoqDk91VkBn0w82
        b3mmgyIwrA95X1LbL01Zo1OeZCW+Eq1FuzQnZzCfeFHoX5EbIqLo50x1K33F08k8X/EfAptc1Sp
        AA7tD1CklwC7Jjw7lJnebItvs7Aun/aDuxR6GGSq5TQ==
X-Received: by 2002:a17:90b:1642:: with SMTP id il2mr14228765pjb.133.1631792269402;
        Thu, 16 Sep 2021 04:37:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLagWl0Y6m5fry/PR5aoSchKNH70gRTQIBS9Soy65wMzgO8Re9fUCU8+kZz5YLK+ougSaEog==
X-Received: by 2002:a17:90b:1642:: with SMTP id il2mr14228747pjb.133.1631792269161;
        Thu, 16 Sep 2021 04:37:49 -0700 (PDT)
Received: from [192.168.1.124] ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id j25sm2783466pff.34.2021.09.16.04.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 04:37:48 -0700 (PDT)
Subject: Re: [Intel-gfx] [PATCH] drm/i915: zero fill vma name buffer
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20210915192318.2061-1-tim.gardner@canonical.com>
 <7a653532-046d-c68a-3dc9-ef2deaf455f9@linux.intel.com>
 <87ee9ox0kv.fsf@intel.com>
From:   Tim Gardner <tim.gardner@canonical.com>
Message-ID: <dc88e195-949c-bb46-b7d3-18e90df9b064@canonical.com>
Date:   Thu, 16 Sep 2021 05:37:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87ee9ox0kv.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/21 4:43 AM, Jani Nikula wrote:
> On Thu, 16 Sep 2021, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
>> On 15/09/2021 20:23, Tim Gardner wrote:
>>> In capture_vma() Coverity complains of a possible buffer overrun. Even
>>> though this is a static function where all call sites can be checked,
>>> limiting the copy length could save some future grief.
>>>
>>> CID 93300 (#1 of 1): Copy into fixed size buffer (STRING_OVERFLOW)
>>> 4. fixed_size_dest: You might overrun the 16-character fixed-size string c->name
>>>      by copying name without checking the length.
>>> 5. parameter_as_source: Note: This defect has an elevated risk because the
>>>      source argument is a parameter of the current function.
>>> 1326        strcpy(c->name, name);
>>>
>>> Fix any possible overflows by using strncpy(). Zero fill the name buffer to
>>> guarantee ASCII string NULL termination.
>>>
>>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>>> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Cc: David Airlie <airlied@linux.ie>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: intel-gfx@lists.freedesktop.org
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
>>> ---
>>>    drivers/gpu/drm/i915/i915_gpu_error.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
>>> index 9cf6ac575de1..154df174e2d7 100644
>>> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
>>> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
>>> @@ -1297,10 +1297,11 @@ static bool record_context(struct i915_gem_context_coredump *e,
>>>    	return simulated;
>>>    }
>>>    
>>> +#define VMA_NAME_LEN 16
>>>    struct intel_engine_capture_vma {
>>>    	struct intel_engine_capture_vma *next;
>>>    	struct i915_vma *vma;
>>> -	char name[16];
>>> +	char name[VMA_NAME_LEN];
>>>    };
>>>    
>>>    static struct intel_engine_capture_vma *
>>> @@ -1314,7 +1315,7 @@ capture_vma(struct intel_engine_capture_vma *next,
>>>    	if (!vma)
>>>    		return next;
>>>    
>>> -	c = kmalloc(sizeof(*c), gfp);
>>> +	c = kzalloc(sizeof(*c), gfp);
>>>    	if (!c)
>>>    		return next;
>>>    
>>> @@ -1323,7 +1324,7 @@ capture_vma(struct intel_engine_capture_vma *next,
>>>    		return next;
>>>    	}
>>>    
>>> -	strcpy(c->name, name);
>>> +	strncpy(c->name, name, VMA_NAME_LEN-1);
>>
>> GCC is supposed to catch any problems here as you say in the commit message.
>>
>> But to fix I suggest a single line change to strlcpy(c->name, name,
>> sizeof(c->name)) which always null terminates as bonus.
> 
> strscpy() is preferred over both strncpy() and strlcpy(). :)
> 
> BR,
> Jani.
> 

Good call. v2 on the way.

rtg

>>
>> Probably same in i915_vma_coredump_create() which with strncpy would
>> have a theoretical chance of attempting to copy over a
>> non-null-terminated string.
>>
>> Regards,
>>
>> Tvrtko
>>
>>>    	c->vma = vma; /* reference held while active */
>>>    
>>>    	c->next = next;
>>>
> 

-- 
-----------
Tim Gardner
Canonical, Inc
