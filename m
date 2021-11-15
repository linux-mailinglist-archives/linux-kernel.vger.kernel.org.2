Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1C4511A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 20:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbhKOTMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 14:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhKORo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:44:29 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD20C061229;
        Mon, 15 Nov 2021 09:23:31 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 132so17601247qkj.11;
        Mon, 15 Nov 2021 09:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NfC2dqLr39jbggixF1Npmm68NwaIpp57HvOc/oAv+Jk=;
        b=WCDsqRwfSuTTIbQZh5LViioXgVo+RxQ53LwjmkLS+u+KQL0y9YLub/ypvF5ER2NZ0g
         +fGBHz2JA2qfoBh5Keuaxqe72aUH+vard09IvBvcxZNM5iMflhUkKJN0I9xHceKBPdCV
         3zo4/ZgAhcoVZrGw6Uugpu9sDQghZjqwUCDG513p9Ed0m8KwTiI8OTFVqStT1TeouaRL
         yqT0r6O9OJ28XI672XeWJrUls2CzMSVQkX+ShLkwFqggRZAsyUaGv3E776F+QVFuSXOd
         bMBZlrbEPhIsh4pfVagPoeZG4hq1Dmj6mXq8BdBOfJQa80hsY5yd9/st+JY3uY5tMBZu
         yLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NfC2dqLr39jbggixF1Npmm68NwaIpp57HvOc/oAv+Jk=;
        b=AX1wJIKKR3DOhkUsviuAmGZO82h8J+ugBfBqBFEw7Q5xwGVvLE0hWIfx2Wc0DnBsIl
         40zV9YyZ9jtI/IyhLPKHjpZXtq4n/W2ktZrPtevQ4fnoiwj38m8aXUcDUnmBjDOOukSb
         FVlslmn9bLhBMBxjouOF9qnGF0U29MStY+aQXnW0j2QydBeJUhuRe/yCIax+4mGCHiS/
         9WVKK52IH3p13KXTPyf6zDTIUmVQ3aFdr1vxQKI5pKx/hGYiHTT+AarOsNtDuUt3iIYf
         Y1dArPLZ+qDDpw2VCteqWL2M7iqRbuSiLH6GPOXVLEUB2yzLm3AR+MvyQuVqbzPfNsCg
         dL5g==
X-Gm-Message-State: AOAM5304m9tETYpwffUNnW/aLYqkl5cw8QitRCpduuHSsq64Mo/jJBRa
        oNYyQp+FueLgS4mVqfMiYWk=
X-Google-Smtp-Source: ABdhPJxAYa6nz/V7SeELy67MUzSqABnb5Q3mQ/4PtR6hABStUejqpfuOTZRiO99q8KXSxZP7HzCU/g==
X-Received: by 2002:a05:620a:2093:: with SMTP id e19mr523259qka.516.1636997011074;
        Mon, 15 Nov 2021 09:23:31 -0800 (PST)
Received: from [192.168.43.249] (mobile-166-172-185-244.mycingular.net. [166.172.185.244])
        by smtp.gmail.com with ESMTPSA id y8sm7408296qko.36.2021.11.15.09.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 09:23:30 -0800 (PST)
Subject: Re: [PATCH] of: base: Skip CPU nodes with non-"okay"/"disabled"
 status
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20211108084804.13474-1-matthias.schiffer@ew.tq-group.com>
 <7b4afaa7-13df-513a-5986-e1a9f5f5d7ed@gmail.com>
 <19130461cbdd39e92b06ec425db5db2984b41a41.camel@ew.tq-group.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0b4b4c4c-7b8d-7139-54b1-29c79f7ec081@gmail.com>
Date:   Mon, 15 Nov 2021 12:23:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <19130461cbdd39e92b06ec425db5db2984b41a41.camel@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 11/15/21 3:13 AM, Matthias Schiffer wrote:
> On Sun, 2021-11-14 at 14:41 -0500, Frank Rowand wrote:
>> On 11/8/21 3:48 AM, Matthias Schiffer wrote:
>>> Allow fully disabling CPU nodes using status = "fail". Having no status
>>> property at all is still interpreted as "okay" as usual.
>>>
>>> This allows a bootloader to change the number of available CPUs (for
>>> example when a common DTS is used for SoC variants with different numbers
>>> of cores) without deleting the nodes altogether, which could require
>>> additional fixups to avoid dangling phandle references.
>>>
>>> References:
>>> - https://www.lkml.org/lkml/2020/8/26/1237
>>> - https://www.spinics.net/lists/devicetree-spec/msg01007.html
>>> - https://github.com/devicetree-org/dt-schema/pull/61
>>>
>>> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>>> ---
>>>  drivers/of/base.c | 29 +++++++++++++++++++++++++++++
>>>  1 file changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index 61de453b885c..4e9973627c8d 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -650,6 +650,32 @@ bool of_device_is_available(const struct device_node *device)
>>>  }
>>>  EXPORT_SYMBOL(of_device_is_available);
>>>  
>>> +/**
>>> + *  __of_device_is_disabled - check if a device has status "disabled"
>>> + *
>>> + *  @device: Node to check status for, with locks already held
>>> + *
>>> + *  Return: True if the status property is set to "disabled",
>>> + *  false otherwise
>>> + *
>>> + *  Most callers should use __of_device_is_available() instead, this function
>>> + *  only exists due to the special interpretation of the "disabled" status for
>>> + *  CPU nodes.
>>> + */
>>> +static bool __of_device_is_disabled(const struct device_node *device)
>>> +{
>>> +	const char *status;
>>> +
>>> +	if (!device)
>>> +		return false;
>>> +
>>> +	status = __of_get_property(device, "status", NULL);
>>> +	if (status == NULL)
>>> +		return false;
>>> +
>>> +	return !strcmp(status, "disabled");
>>> +}
>>> +
>>>  /**
>>>   *  of_device_is_big_endian - check if a device has BE registers
>>>   *
>>> @@ -817,6 +843,9 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
>>>  		of_node_put(node);
>>>  	}
>>>  	for (; next; next = next->sibling) {
>>> +		if (!__of_device_is_available(next) &&
>>> +		    !__of_device_is_disabled(next))
>>
>> Shouldn't that just be a check to continue if the device is disabled?
>>
>> If adding a check for available, then all of the callers of for_each_of_cpu_node()
>> need to be checked.  There is at least one that is suspicious - arch/arm/mach-imx/platsmp.c
>> has a comment:
>>
>>  * Initialise the CPU possible map early - this describes the CPUs
>>  * which may be present or become present in the system.
> 

Thanks for the links to previous discussion you provided below.  I had
forgotten the previous discussion.

In [2] Rob ended up saying that there were two options he was fine with.
Either (or both), in of_get_next_cpu_node(),

  (1) use status of "fail" as the check or

  (2) use status of "disabled" as the check, conditional on !IS_ENABLED(CONFIG_PPC)
      "this would need some spec update"
      "Need to double check MIPS and Sparc though."

Neither of these two options are what this patch does.  It seems to me that
option 1 is probably the easiest and least intrusive method.

-Frank

> Previously, there were two option for the (effective) value of the
> status of a device_node:
> 
> - "okay", "ok" or unset
> - anything else (which includes "disabled" and "fail")
> 
> __of_device_is_available() checks which of these two is the case.
> 
> With the new code, we have 3 cases for the status of CPU nodes:
> 
> - "okay", "ok" or unset
> - "disabled"
> - anything else ("fail", ...)
> 
> My patch will only change the behaviour in one case: When a CPU node
> has a status that is not "okay", "ok", "disabled" or unset - which is
> exactly the point of my patch.
> 
> See also the change [1], which removed the !available check a while
> ago, and the discussion in [2], which led us to the conclusion that 
> of_get_next_cpu_node() must not distinguish "okay" and "disabled" CPU
> nodes and we instead need a third status to disable a CPU for real.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/of/base.c?id=c961cb3be9064d1097ccc019390f8b5739daafc6
> [2] https://www.lkml.org/lkml/2020/8/26/1237
> 
> 
>>
>> -Frank
>>
>>> +			continue;
>>>  		if (!(of_node_name_eq(next, "cpu") ||
>>>  		      __of_node_is_type(next, "cpu")))
>>>  			continue;
>>>
>>
>>
> 

