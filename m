Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35E453564
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhKPPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbhKPPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:13:33 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51FC0432CE;
        Tue, 16 Nov 2021 07:07:18 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a2so19153612qtx.11;
        Tue, 16 Nov 2021 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FhGahbj8gjGRzN6ME6kPexbCpOoO7zBFoOACpso/eDE=;
        b=NSlqTEt50/q25vW9T3DaBTlQoewWCyKxylpBCh9HJXyRjkRzagGi8ESIUa1mtY7PeR
         lejxgrtrmKULQrITJolI6BshZgS9ZTH21PFMAi1o5nkBexK4V0ngKl6V9/hHsG/84/no
         MtOvnilKQi83McQLseFtFIsKuc+usm5kRyAmW2KyBnoQZVEYU+ZtCbexWIA2cP+mHVjQ
         uwBHxIaGRP41uhHlA6vKKiYpIHmg5Wv0TWwnhkXvkqULP4pSxlY2nB4RqW2s2F06CQ7A
         p/PKeMtMaZapzRZs8li9Xkke1EeiSXP7OF/KO/ODEZl3YnOBkpGk3tvBad+2K6Q9rw+5
         cohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FhGahbj8gjGRzN6ME6kPexbCpOoO7zBFoOACpso/eDE=;
        b=pJ1+4mSteGUDvl1TxeFPGKROK/gmwSln8iYFfE9pLsKAPvonngh5QK5ceQzxm5cr1P
         Xi/V4NGX6Ot4m/5pRLl8vXzKE0m3wZybvPVf5XM52IWYoLBwfnA19py9WPeC513+LAes
         cbhqdnIN4IX/fGeYxchYqIvTVIhTc13YIR5ALGMzW8Z5SK2QTv+Qa2jxegbjjFTOQNRb
         +qDXu0N9sN50Ru9T/3EGAvticDMugZlpSOrLOmCgZgdaf0RLNEn7l32Eo++Kf8LUaVC+
         QVOnCi/6IV++l2FK95YoOzv/V1yW2sb92dBcwkRj7j0KnO3fGoY8v+c6RV0EM8TsoLwx
         VBnQ==
X-Gm-Message-State: AOAM533XT/13UfVjsNWTmo4aa1gwG7kB/8Md7Yv8Wy/pqzwGhV7UBV0X
        YQe14mFea1X5kd/b3WRRqUY=
X-Google-Smtp-Source: ABdhPJyU6mbevvP6ucg6dQ5GHxW6bUzjqVIAO3exH2zn05JgXo4/MqDBkHfz+YzXeCatnkiany40uw==
X-Received: by 2002:ac8:5f07:: with SMTP id x7mr8490283qta.244.1637075236408;
        Tue, 16 Nov 2021 07:07:16 -0800 (PST)
Received: from [192.168.43.249] (mobile-166-172-185-244.mycingular.net. [166.172.185.244])
        by smtp.gmail.com with ESMTPSA id j13sm8831036qkp.111.2021.11.16.07.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 07:07:15 -0800 (PST)
Subject: Re: [PATCH] of: base: Skip CPU nodes with non-"okay"/"disabled"
 status
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20211108084804.13474-1-matthias.schiffer@ew.tq-group.com>
 <7b4afaa7-13df-513a-5986-e1a9f5f5d7ed@gmail.com>
 <19130461cbdd39e92b06ec425db5db2984b41a41.camel@ew.tq-group.com>
 <0b4b4c4c-7b8d-7139-54b1-29c79f7ec081@gmail.com>
 <e1a8d864a87553fb99bae8ac0c437dad8c37cd79.camel@ew.tq-group.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <18dbe345-e268-b640-3ab6-d7381b236edf@gmail.com>
Date:   Tue, 16 Nov 2021 10:07:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e1a8d864a87553fb99bae8ac0c437dad8c37cd79.camel@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 11/16/21 3:32 AM, Matthias Schiffer wrote:
> On Mon, 2021-11-15 at 12:23 -0500, Frank Rowand wrote:
>> Hi Matthias,
>>
>> On 11/15/21 3:13 AM, Matthias Schiffer wrote:
>>> On Sun, 2021-11-14 at 14:41 -0500, Frank Rowand wrote:
>>>> On 11/8/21 3:48 AM, Matthias Schiffer wrote:

It turns out I confused myself a bit...

The first email provided the clue that I needed:

>>>>> Allow fully disabling CPU nodes using status = "fail". Having no status
>>>>> property at all is still interpreted as "okay" as usual.

I managed to forget that sentence before I looked at the code in the patch.

>>>>>
>>>>> This allows a bootloader to change the number of available CPUs (for
>>>>> example when a common DTS is used for SoC variants with different numbers
>>>>> of cores) without deleting the nodes altogether, which could require
>>>>> additional fixups to avoid dangling phandle references.
>>>>>
>>>>> References:
>>>>> - https://www.lkml.org/lkml/2020/8/26/1237
>>>>> - https://www.spinics.net/lists/devicetree-spec/msg01007.html
>>>>> - https://github.com/devicetree-org/dt-schema/pull/61
>>>>>
>>>>> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>>>>> ---
>>>>>  drivers/of/base.c | 29 +++++++++++++++++++++++++++++
>>>>>  1 file changed, 29 insertions(+)
>>>>>
>>>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>>>> index 61de453b885c..4e9973627c8d 100644
>>>>> --- a/drivers/of/base.c
>>>>> +++ b/drivers/of/base.c
>>>>> @@ -650,6 +650,32 @@ bool of_device_is_available(const struct device_node *device)
>>>>>  }
>>>>>  EXPORT_SYMBOL(of_device_is_available);
>>>>>  
>>>>> +/**
>>>>> + *  __of_device_is_disabled - check if a device has status "disabled"
>>>>> + *
>>>>> + *  @device: Node to check status for, with locks already held
>>>>> + *
>>>>> + *  Return: True if the status property is set to "disabled",
>>>>> + *  false otherwise
>>>>> + *
>>>>> + *  Most callers should use __of_device_is_available() instead, this function
>>>>> + *  only exists due to the special interpretation of the "disabled" status for
>>>>> + *  CPU nodes.
>>>>> + */
>>>>> +static bool __of_device_is_disabled(const struct device_node *device)
>>>>> +{
>>>>> +	const char *status;
>>>>> +
>>>>> +	if (!device)
>>>>> +		return false;
>>>>> +
>>>>> +	status = __of_get_property(device, "status", NULL);
>>>>> +	if (status == NULL)
>>>>> +		return false;
>>>>> +
>>>>> +	return !strcmp(status, "disabled");
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   *  of_device_is_big_endian - check if a device has BE registers
>>>>>   *
>>>>> @@ -817,6 +843,9 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
>>>>>  		of_node_put(node);
>>>>>  	}

So in the following test:

>>>>>  	for (; next; next = next->sibling) {
>>>>> +		if (!__of_device_is_available(next) &&
>>>>> +		    !__of_device_is_disabled(next))

   (!__of_device_is_available(next) &&
    !__of_device_is_disabled(next))

is meant to detect a status of "fail" or "fail-sss".  Since I forget the sentence
about "fail" from early in the email, I had difficulty in interpreting the intent
of the (!ok && !disabled) form of the test.  The intent of the test would be more
clear if it was checking _for_ "fail" instead of checking for _not_ the other
possible status values.

So you _are_ checking for the status of "fail" check (Rob's choice #1 below)
and I just did not understand that was the intent of the patch.

So I am fine with the patch if you change the above logic to check for
"fail" or "fail-sss".

It would also be good to add a comment to the of_get_next_cpu_node() header
comment that "fail" nodes are excluded.

Sorry for the confusion.

-Frank

>>>>
>>>> Shouldn't that just be a check to continue if the device is disabled?
>>>>
>>>> If adding a check for available, then all of the callers of for_each_of_cpu_node()
>>>> need to be checked.  There is at least one that is suspicious - arch/arm/mach-imx/platsmp.c
>>>> has a comment:
>>>>
>>>>  * Initialise the CPU possible map early - this describes the CPUs
>>>>  * which may be present or become present in the system.
>>
>> Thanks for the links to previous discussion you provided below.  I had
>> forgotten the previous discussion.
>>
>> In [2] Rob ended up saying that there were two options he was fine with.
>> Either (or both), in of_get_next_cpu_node(),
>>
>>   (1) use status of "fail" as the check or
>>
>>   (2) use status of "disabled" as the check, conditional on !IS_ENABLED(CONFIG_PPC)
>>       "this would need some spec update"
>>       "Need to double check MIPS and Sparc though."
>>
>> Neither of these two options are what this patch does.  It seems to me that
>> option 1 is probably the easiest and least intrusive method.
> 
> My intuition is that a device with an unknown status value should not
> be used. For most devices this is already handled by treating any value
> that is not unset, "okay" or "ok" the same. For CPU nodes, this would
> be the case by treating such values like "fail".
> 
> I did a quick grep through the in-tree Device Trees, and I did find a
> few unusual status properties (none of them in CPU nodes though):
> 
> - Typo "failed" (4 cases)
> - Typo "disable" (17 cases)
> - "reserved" (19 cases)
> 
> "fail" appears 2 times, the rest is "okay", "ok" or "disabled".
> 
> I do not have a strong opinion on this though - for our concrete
> usecase, checking for "fail" is fine, and we can treat unknown values
> like "disabled" if you prefer that solution. Should "fail-*" status
> values also be treated like "fail" then?
> 
> 
> 
> 
>>
>> -Frank
>>
>>> Previously, there were two option for the (effective) value of the
>>> status of a device_node:
>>>
>>> - "okay", "ok" or unset
>>> - anything else (which includes "disabled" and "fail")
>>>
>>> __of_device_is_available() checks which of these two is the case.
>>>
>>> With the new code, we have 3 cases for the status of CPU nodes:
>>>
>>> - "okay", "ok" or unset
>>> - "disabled"
>>> - anything else ("fail", ...)
>>>
>>> My patch will only change the behaviour in one case: When a CPU node
>>> has a status that is not "okay", "ok", "disabled" or unset - which is
>>> exactly the point of my patch.
>>>
>>> See also the change [1], which removed the !available check a while
>>> ago, and the discussion in [2], which led us to the conclusion that 
>>> of_get_next_cpu_node() must not distinguish "okay" and "disabled" CPU
>>> nodes and we instead need a third status to disable a CPU for real.
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/of/base.c?id=c961cb3be9064d1097ccc019390f8b5739daafc6
>>> [2] https://www.lkml.org/lkml/2020/8/26/1237
>>>
>>>
>>>>
>>>> -Frank
>>>>
>>>>> +			continue;
>>>>>  		if (!(of_node_name_eq(next, "cpu") ||
>>>>>  		      __of_node_is_type(next, "cpu")))
>>>>>  			continue;
>>>>>
>>>>
>>>>
>>
>>
> 

