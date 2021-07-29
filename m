Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4379B3DABB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhG2TQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229713AbhG2TQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627586212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5A2N7dGYeQ+Xbk5UXj9qLfRubLSGQbg8nll0cwkgIt4=;
        b=Fqwu1t3H2zIdpj1eA25zWe+JZtJDVxWZY4z2z6vNH/wuev9YuC+TSWTiFsxVlHjQNhGdDq
        R5epwI+jciqxoThkY/Bd3VY3RHasbAbDf7ULua7o3gfOdVItowrOpjs7u5p9G+1Vyo4070
        RbM/zdi1mrd5NOPo7ssFUYB34+J8oSI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-GCO0TC1tMAWqjbcKnJUVZA-1; Thu, 29 Jul 2021 15:16:51 -0400
X-MC-Unique: GCO0TC1tMAWqjbcKnJUVZA-1
Received: by mail-qv1-f70.google.com with SMTP id hf7-20020a0562140e87b02902dc988b8675so4460439qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 12:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5A2N7dGYeQ+Xbk5UXj9qLfRubLSGQbg8nll0cwkgIt4=;
        b=WYe3uO9FDJ4TkEVGKBSJQ7BuxGbUD9AaFL2GsbefNLZbVJ38PamtEDVhsl1dAjU9mU
         cj91PNORwecIgynZhh2uVB3n9+3MTDpvQeRPOL/kHwNDLMkdTC+c+NWW/r9yA2CdrBzz
         rb6E8mMeCjDZVTGwTaQQPnfRlpnYnhzaSZZhJSvv788+wuR5uKWJUn6rVRS9r9hbUEbO
         G1PY1diuYkbgaBGUck8hGQLukruEwJaUYoOyLrYRSlLCtD/WVBmbv+fMTaXCqjuglEwl
         oAHkTOXDzTF60BF8Swi7mm1k5hwMj61Y9nA5SY3O8FWzeClEG9A3/W2N9lL1DZMvSv1r
         zNYw==
X-Gm-Message-State: AOAM530JzIz0Vl5/yyHj+BppZZpuWxpH5cfY4E+w5JBspGjol2fvdMGh
        8ASLxj03QgTJMqOCxaChJOJX0DIL2dHXlBSn2HnbK0a5Y/LcMEYG2Vhty7d4ftEWJi/ZEIXrmAY
        GJlNIhU/z6F4lHLZm3uUfBbgW
X-Received: by 2002:a37:668e:: with SMTP id a136mr6733810qkc.54.1627586210363;
        Thu, 29 Jul 2021 12:16:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXWZdunXtPWYgMO5r2/mrUnugJE+AZjsM1cvmYe3z4ID1Ag4YUCClpSiGUppBJ4TltSIlYHQ==
X-Received: by 2002:a37:668e:: with SMTP id a136mr6733790qkc.54.1627586210155;
        Thu, 29 Jul 2021 12:16:50 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t6sm2219044qkg.75.2021.07.29.12.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 12:16:49 -0700 (PDT)
Subject: Re: [PATCH] fpga: region: handle compat_id as an uuid
To:     Moritz Fischer <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>
Cc:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20210726202650.4074614-1-trix@redhat.com>
 <6f30a4c6-61a0-bb57-9f13-bcad3f3589b8@intel.com>
 <ba28bac6-9c6d-de73-523f-b8ba4bef84de@redhat.com>
 <DM6PR11MB38199F872DC94971D9C8A53885EA9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <YQL4qyAmqj322HTz@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a5b4b303-7d9b-27d7-4c1e-cd29fea8cdb9@redhat.com>
Date:   Thu, 29 Jul 2021 12:16:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YQL4qyAmqj322HTz@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/21 11:51 AM, Moritz Fischer wrote:
> On Wed, Jul 28, 2021 at 01:36:56AM +0000, Wu, Hao wrote:
>>> On 7/26/21 3:12 PM, Russ Weight wrote:
>>>> On 7/26/21 1:26 PM, trix@redhat.com wrote:
>>>>> From: Tom Rix <trix@redhat.com>
>>>>>
>>>>> An fpga region's compat_id is exported by the sysfs
>>>>> as a 128 bit hex string formed by concatenating two
>>>>> 64 bit values together.
>>>>>
>>>>> The only user of compat_id is dfl.  Its user library
>>>>> opae converts this value into a uuid.
>>>>>
>>>>> ex/
>>>>> $ cat /sys/class/fpga_region/region1/compat_id
>>>>> f3c9941350814aadbced07eb84a6d0bb
>>>>>
>>>>> Is reported as
>>>>> $ fpgainfo bmc
>>>>> ...
>>>>> Pr Interface Id                  : f3c99413-5081-4aad-bced-07eb84a6d0bb
>>>>>
>>>>> Storing a uuid as 2 64 bit values is vendor specific.
>>>>> And concatenating them together is vendor specific.
>>>>>
>>>>> It is better to store and print out as a vendor neutral uuid.
>>>>>
>>>>> Change fpga_compat_id from a struct to a union.
>>>>> Keep the old 64 bit values for dfl.
>>>>> Sysfs output is now
>>>>> f3c99413-5081-4aad-bced-07eb84a6d0bb
>>>> I'm fowarding feedback from Tim Whisonant, one of the OPAE userspace
>>>> developers:
>>>>
>>>> I think that this change to the sysfs for the compat_id node will
>>>> end up breaking the SDK, which does not expect the '-' characters to
>>>> be included when parsing the sysfs value. Currently, it is parsed as
>>>> a raw hex string without regard to any '-' characters. This goes for
>>>> any "guid" currently exported by sysfs and for what we read in the
>>>> device MMIO space.
>>> Yes, it will.
>>>
>>> And there are other places, like dfl-afu-main.c:afu_id_show()
>>>
>>> outputs raw hex that sdk turns into a uuid.
>>>
>>>
>>> Some options.
>>>
>>> If no one but dfl will ever use it, then v1 of patchset.
>>>
>>> If others can use it but don't want to change dfl, then v2 of patchset,
>>> my favorite.
>>>
>>> Or this one for uuid for everyone, what have been v3 but changed too much.
>>>
>>>
>>> could dfl change generally to output uuid's to the sysfs ?
>>>
>>> this would be generally helpful and a one time disruption to the sdk.
>> This change limited the output format to uuid_t, but if any hardware doesn't
>> use uuid_t on hardware may have to convert it back from the sysfs output in
>> userspace. Leave it to print hardware values (e.g. from register), and convert
>> it in userspace should be fine too I think.
> I'm not entirely sure. I seem to recall there being examples of sysfs
> files returning different things for different drivers.
>
> That being said it seems largely cosmetic to add the '-' in between.
>
> If it breaks userspace, I'm against it. If you *need* it make a
> compat_uuid entry or something in that case?

My gripe is

For a nominally common interface, compat_id has a vendor specific output.

If for example another vendor wanted to use this field but their natural 
format was an OF string.

16 bytes of raw hex would not work for them, so they would roll their own.

which defeats the purpose of a common interface.


The language in the docs as-is is vague on the output format.

DFL is the only user of the interface.

So ver 2

https://lore.kernel.org/linux-fpga/4ab7dd2d-c215-6333-6860-6f7d0ac64c3d@redhat.com/

Keeps the output as-is for dfl, so nothing breaks in userspace

And adds flexibility for vendors to output their appropriate natural form.

So compat_id becomes generally useful.


Tom


>
> - Moritz
>

