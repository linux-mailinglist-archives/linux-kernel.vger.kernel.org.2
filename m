Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA33937C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhE0VLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233387AbhE0VLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622149788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYCU0AwNZCgbe0HM2uiCGrbOSvKYgrER6VSFwgOWNSg=;
        b=VbmWc7tB1hoQQmz3pYC6PfIeNcJpmi0SQumpwHCsbRgEjyv4K5xjVJN2H0Raoiybj4QIrC
        9hnZkB9oewfCd1ph4fCmZfo1v1jv6iXDk/P0aK9UnufDNbmtUPr/dQZBrMRJgj1WEckxXE
        5kCYxDUQDSSk/KlJ0a90PEiDC7Hi2O8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-J_blHBxWMdKzgXjgF3sO3w-1; Thu, 27 May 2021 17:09:47 -0400
X-MC-Unique: J_blHBxWMdKzgXjgF3sO3w-1
Received: by mail-oo1-f71.google.com with SMTP id j19-20020a4adf530000b029023ce471f589so984536oou.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yYCU0AwNZCgbe0HM2uiCGrbOSvKYgrER6VSFwgOWNSg=;
        b=p+CVgKfNkjGO7HpVd9jnAbXfKhYPpUW3DHIQg4G9ptGOw8sTHFIpLNUG6kTmCV2Cdv
         wR890Mg8L1dnSU1hAEBHfqkIJ+H6Q8s4vtU526VshR4tsuNPZwWr8EZfV9EPpo4iQl7v
         OXCg58j6oFjOXw1vAdLaTZ6d2N5VZq95WknMFgFAkMg1FSU8V0aJ6YHnak6yOIE4nZ3O
         EsHwzrtR61KQ2sgy19RfbkjH6r2oU9HaKQIlW6aKH+rG4WSnFarnGL88i6ByJZpj5Nv4
         VJhWgchQAGwk+MF1qt+UXW1t/1FHTwFhbXfT7bRHvaQtN6GQYH3z6umqKySxCi9z4pMn
         a4eA==
X-Gm-Message-State: AOAM5320MT3PHJ8pPXj/zMPDneo4pJKG/z2IeRNTQfevalQVY7TdVAym
        i5AluhF2REE8crm/QaWwkkP+um5eKFIaudRMtNJNGbVK33n5MelqF3qGaEraQ7PATwjtsstLYyz
        M+LyHOzKoeHE4E//bkCH/0KIXyjC/xZGBCubN8YGj94SUtWRaEagaF4DEqG043lt5rPZft/Q=
X-Received: by 2002:a9d:6444:: with SMTP id m4mr4440108otl.124.1622149786114;
        Thu, 27 May 2021 14:09:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeLoT6fSUCKNnag5ungWi0Ue0kKJfTQKBZusMiWBPiOTPaWlnxkjPVrF+veyO7F9+IgRIaTA==
X-Received: by 2002:a9d:6444:: with SMTP id m4mr4440087otl.124.1622149785842;
        Thu, 27 May 2021 14:09:45 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r83sm686643oih.48.2021.05.27.14.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 14:09:45 -0700 (PDT)
Subject: Re: [PATCH] percpu: initialize best_upa variable
To:     Dennis Zhou <dennis@kernel.org>
Cc:     tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210515180817.1751084-1-trix@redhat.com>
 <YKHPV4QAXmaWb6jJ@google.com>
 <dd1dabe0-73a5-8a39-ba58-bb58a1453d90@redhat.com>
 <YKKAGbOyRSX5jmxY@google.com> <YLAAGCeCyVKGxO+V@google.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f5b2cbfb-d540-ca93-6f37-7d4bddec9ab8@redhat.com>
Date:   Thu, 27 May 2021 14:09:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLAAGCeCyVKGxO+V@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/27/21 1:24 PM, Dennis Zhou wrote:
> Hello,
>
> On Mon, May 17, 2021 at 02:39:21PM +0000, Dennis Zhou wrote:
>> On Mon, May 17, 2021 at 06:17:47AM -0700, Tom Rix wrote:
>>> On 5/16/21 7:05 PM, Dennis Zhou wrote:
>>>> Hello,
>>>>
>>>> On Sat, May 15, 2021 at 11:08:17AM -0700, trix@redhat.com wrote:
>>>>> From: Tom Rix <trix@redhat.com>
>>>>>
>>>>> Static analysis reports this problem
>>>>> percpu.c:2945:6: warning: Assigned value is garbage or undefined
>>>>>           upa = best_upa;
>>>>>               ^ ~~~~~~~~
>>>>> best_upa may not be set, so initialize it.
>>>>>
>>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>>> ---
>>>>>    mm/percpu.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/mm/percpu.c b/mm/percpu.c
>>>>> index a257c3efdf18b..6578b706fae81 100644
>>>>> --- a/mm/percpu.c
>>>>> +++ b/mm/percpu.c
>>>>> @@ -2916,6 +2916,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
>>>>>    	 * Related to atom_size, which could be much larger than the unit_size.
>>>>>    	 */
>>>>>    	last_allocs = INT_MAX;
>>>>> +	best_upa = max_upa;
>>>>>    	for (upa = max_upa; upa; upa--) {
>>>>>    		int allocs = 0, wasted = 0;
>>>>> -- 
>>>>> 2.26.3
>>>>>
>>>> I think the proper fix would be:
>>>>
>>>> best_upa = 0;
>>> I was looking for initializing with something that would work.
>>>
>> I think I prefer setting it to 0 because it forces the loop to have
>> succeeded vs being able to bypass it if the for loop logic was changed.
>>
>>>> for (...) { }
>>>> BUG_ON(!best_upa);
>>> WARN_ON instead?
>> This is initialization code. So if upa == 0, it really is a problem.
>> Having 0 units per allocation is bogus.
>>
>>>> upa = best_upa;
>>>>
>>>> If you're fine with this I'll make the changes and apply it to
>>>> for-5.13-fixes.
>>>>
>>>> Can you also tell me what static analysis tool produced this? I'm just a
>>>> little curious because this code hasn't changed in several years so I'd
>>>> have expected some static analyzer to have caught this by now.
>>> Clang 10
>>>
>>> Tom
>>>
>> Thanks,
>> Dennis
> Following up here. Are you find with me making the changes and
> attributing it to you? Otherwise I can just spin another patch real
> quick.

I am fine with you respinning, no need to attribute the change to me.

If you would like a review, include me on the cc.

Thanks!

Tom

> At this point I've already sent my PR for-5.13-fixes. So I'll queue some
> fix for-5.14.
>   
> Thanks,
> Dennis
>

