Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F89413654
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhIUPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:40:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234078AbhIUPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632238723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEHJIaeIrxQ7EDkWo18sxWISgbaZ5rdeC8twtOOBkO8=;
        b=BF9PjOFwsAQgdRKDqMfPcNcrESKFYf41X4z45CzaiT++IO7oAGQxIdGjSSokoMHyJbQ2bg
        yNrAQ26brVsGqzAAjZmaR8MTwJwsn9eFWJ9cy2nBHoOY1XoBpDyIICjHxorDd9spBa9lTB
        3QYe7SDjjVmMAYLZBTWeG9Vfmavt4AU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-uKy3e4w6Nz-RQqGt1hlC3w-1; Tue, 21 Sep 2021 11:38:42 -0400
X-MC-Unique: uKy3e4w6Nz-RQqGt1hlC3w-1
Received: by mail-ed1-f71.google.com with SMTP id 2-20020a508e02000000b003d871759f5dso5567112edw.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JEHJIaeIrxQ7EDkWo18sxWISgbaZ5rdeC8twtOOBkO8=;
        b=h6FbIzkXw0z4P8ojeciT913ymkMG5GbOsXZRBpRk0hSkzor63F6e9ct2eAOaaoOp3T
         UVzF5t7C8PAVCOPSzGDRwYWwAs+/+AbJSCkniNLF2orZfDYnHYkZKouWJ/ulKIC9xvlb
         vASN30kdashF0nLUsww9ugltiVIjxD6BL7gxunEPMYCfjmq8h3yWArairQgjAIY+RYGc
         GH6R1tyyiOox76VNOK/0F0dHEpyVqq32h6PKZyBM/SCfT3/xGp2xmN1hVWJPd9XaJlI4
         xofoC7fc1CzyrMH5iDX4D46yyHvRgqhYT0dIZcsWNT9om1rmqLo6ks6eZT1vfyBT6JQw
         u4LA==
X-Gm-Message-State: AOAM533Y0vEH2/dbXbvRxmYdU+c9l8MBpWAPjxHKe+ImtuhgxRSfzyvd
        CZ8w+tphYt5eARznltCGiLS4KuEVq1qd3BGl3y0MrVDNqKC7AeMOYh/pKOkOXhnOxVj3YHmOXRt
        FQ6Dma5uhFyow+iMabH35SbAM4L2rZMR2qPrwYCUJopsaPPhY/xwaxkaQDNw/5SZ3PcoXN9TGnt
        LB
X-Received: by 2002:a17:906:c25a:: with SMTP id bl26mr35721369ejb.345.1632238721130;
        Tue, 21 Sep 2021 08:38:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr7TElEIy2EEm4/rx64vptbKgUH9jeDU8LRqXITNmphVxELjt4tx7Ldiqec0QA4sPUdepPOA==
X-Received: by 2002:a17:906:c25a:: with SMTP id bl26mr35721329ejb.345.1632238720807;
        Tue, 21 Sep 2021 08:38:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b14sm8632615edy.56.2021.09.21.08.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 08:38:40 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Prefer struct_size over open
 coded arithmetic
To:     Greg KH <greg@kroah.com>
Cc:     Kees Cook <keescook@chromium.org>, Len Baker <len.baker@gmx.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210918150500.21530-1-len.baker@gmx.com>
 <202109192246.B438B42EF@keescook>
 <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
 <YUn3F9HtgrpN9sSM@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <725ac392-642b-f57d-a286-d662eaa7d2a2@redhat.com>
Date:   Tue, 21 Sep 2021 17:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUn3F9HtgrpN9sSM@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/21 5:15 PM, Greg KH wrote:
> On Tue, Sep 21, 2021 at 03:46:23PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 9/20/21 7:58 AM, Kees Cook wrote:
>>> On Sat, Sep 18, 2021 at 05:05:00PM +0200, Len Baker wrote:
>>>> As noted in the "Deprecated Interfaces, Language Features, Attributes,
>>>> and Conventions" documentation [1], size calculations (especially
>>>> multiplication) should not be performed in memory allocator (or similar)
>>>> function arguments due to the risk of them overflowing. This could lead
>>>> to values wrapping around and a smaller allocation being made than the
>>>> caller was expecting. Using those allocations could lead to linear
>>>> overflows of heap memory and other misbehaviors.
>>>>
>>>> So, switch to flexible array member in the struct attribute_set_obj and
>>>> refactor the code accordingly to use the struct_size() helper instead of
>>>> the argument "size + count * size" in the kzalloc() function.
>>>>
>>>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>>>>
>>>> Signed-off-by: Len Baker <len.baker@gmx.com>
>>>> ---
>>>>  drivers/platform/x86/thinkpad_acpi.c | 8 +++-----
>>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>>>> index 50ff04c84650..ed0b01ead796 100644
>>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>>> @@ -1008,7 +1008,7 @@ struct attribute_set {
>>>>
>>>>  struct attribute_set_obj {
>>>>  	struct attribute_set s;
>>>> -	struct attribute *a;
>>>> +	struct attribute *a[];
>>>>  } __attribute__((packed));
>>>
>>> Whoa. I have so many questions... :)
>>>
>>>>
>>>>  static struct attribute_set *create_attr_set(unsigned int max_members,
>>>> @@ -1020,13 +1020,11 @@ static struct attribute_set *create_attr_set(unsigned int max_members,
>>>>  		return NULL;
>>>>
>>>>  	/* Allocates space for implicit NULL at the end too */
>>>> -	sobj = kzalloc(sizeof(struct attribute_set_obj) +
>>>> -		    max_members * sizeof(struct attribute *),
>>>> -		    GFP_KERNEL);
>>>> +	sobj = kzalloc(struct_size(sobj, a, max_members + 1), GFP_KERNEL);
>>>
>>> Whoa, this needs a lot more detail in the changelog if this is actually
>>> correct. The original code doesn't seem to match the comment? (Where is
>>> the +1?) So is this also a bug-fix?
>>
>> Kees, at first I thought you were spot-on with this comment, but the
>> truth is more subtle. struct attribute_set_obj was:
>>
>> struct attribute_set_obj {
>>         struct attribute_set s;
>>         struct attribute *a;
>> } __attribute__((packed));
>>
>> Another way of looking at this, which makes things more clear is as:
>>
>> struct attribute_set_obj {
>>         struct attribute_set s;
>>         struct attribute *a[1];
>> } __attribute__((packed));
>>
>> So the sizeof(struct attribute_set_obj) in the original kzalloc call
>> included room for 1 "extra" pointer which is reserved for the terminating
>> NULL pointer.
>>
>> Changing the struct to:
>>
>> struct attribute_set_obj {
>>         struct attribute_set s;
>>         struct attribute *a[];
>> } __attribute__((packed));
>>
>> Is equivalent to changing it to:
>>
>> struct attribute_set_obj {
>>         struct attribute_set s;
>>         struct attribute *a[0];
>> } __attribute__((packed));
>>
>> So the change in the struct declaration reduces the sizeof(struct attribute_set_obj)
>> by the size of 1 pointer, making the +1 necessary.
>>
>> So AFAICT there is actually no functional change here.
>>
>> Still I will hold off merging this until we agree on this :)
> 
> First off, why is a single driver doing so many odd things with
> attribute groups?  Why not just use them the way that the rest of the
> kernel does?  Why does this driver need this special handling and no one
> else does?

The thinkpad_acpi driver carries a lot of legacy with it.
So in general we are careful with making changes because some people
still use quite old ThinkPad-s and it is tricky to make sure we
don't break stuff on older models. So yeah there is some cruft in
a bunch of places in this driver.

In this case it seems that cleaning things up is a straight forward fix
though, so we really should do so.

> 
> I think the default way of handling if an attribute is enabled or not,
> should suffice here, and make things much simpler overall as all of this
> crazy attribute handling can just be removed.
> 
> Bonus would also be that I think it would fix the race conditions that
> happen when trying to create attributes after the device is bound to the
> driver that I think the existing driver has today.
> 
>>> (I see the caller uses +2? Why? It seems to be using each of hotkey_attributes,
>>> plus 1 more attr, plus a final NULL?)
>>
>> The +2 is actually for 2 extra attributes (making the total number
>> of extra attributes +3 because the sizeof(struct attribute_set_obj)
>> already includes 1 extra). 
>>
>> FWIW these 2 extra attributes are for devices with a
>> a physical rfkill on/off switch and for the device being
>> a convertible capable of reporting laptop- vs tablet-mode.
> 
> Again, using the default way to show (or not show) attributes should
> solve this issue.  Why not just use that instead?

I agree, moving to a "fixed" attribute_group, with an is_visible
check for the optional attributes would be a much better fix and
allow removal of a whole bunch of custom code.

If anyone following this thread could submit a patch doing that,
then that would be great.

>>>>  	if (!sobj)
>>>>  		return NULL;
>>>>  	sobj->s.max_members = max_members;
>>>> -	sobj->s.group.attrs = &sobj->a;
>>>> +	sobj->s.group.attrs = sobj->a;
>>>>  	sobj->s.group.name = name;
>>>
>>> The caller also never sets a name?
>>
>> attribute_group.name may be NULL, I don't know
>> of (m)any drivers which actual set this to non NULL.
> 
> It is used by some, that is how you can put all of the attributes in a
> subdirectory automatically.  No idea if that's needed here...
> 
> All attributes for this driver are documented in Documentation/ABI/,
> right? :)

I'm not sure if all attributes are documented, but a lot of them
(including all recently added ones) are documented in:
Documentation/admin-guide/laptops/thinkpad-acpi.rst

Regards,

Hans

