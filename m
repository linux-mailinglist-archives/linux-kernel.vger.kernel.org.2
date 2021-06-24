Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088B73B26E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFXFkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXFkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:40:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F3C061574;
        Wed, 23 Jun 2021 22:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=LzKmFEvfSqHE5WGD0woHAtqwFUsZUDbQDhrUeoqAXLU=; b=Qq5pr0qZePwVNkKzuKAolBa4m4
        YNvbKkbB2jhWRkblkrfE8gWHJ9dj3iXfI7ghr5HOS3JBHwKZKZNmUx8g+MMe8po4+RuTAguV0kZ9u
        RybllMI6D5qJN7Jg2w6dNXTw97aaFYM2GyU8hcwVmzLexfBZm83w1GNtyzxzYGjeiciHLkvn+IHjp
        YC6+frbSy85QLu/PtnPFbe72+YxpaQqlQJC6tDdQeidFS8XCJ5PIrK4F6sfAV9AgO/uVvuTNRbApe
        EIgzUwjIwcPfqlLm0uB5g/AZw0/fKUOZx01kJHMYM2JNTQ+6k/XFmdypReBWthUXOodf5miEMYr+m
        FheM2fdQ==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwI3a-00Cr18-0A; Thu, 24 Jun 2021 05:37:42 +0000
Subject: Re: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210624033740.20862-1-gshan@redhat.com>
 <a6cdc518-3bd7-2b66-acd0-c4d53d360eae@infradead.org>
 <435d4707-3871-26fe-e0e4-df93931ba49d@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cfba8d64-810d-675b-8727-66c84106883c@infradead.org>
Date:   Wed, 23 Jun 2021 22:37:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <435d4707-3871-26fe-e0e4-df93931ba49d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 9:58 PM, Gavin Shan wrote:
> On 6/24/21 12:14 PM, Randy Dunlap wrote:
>> On 6/23/21 8:37 PM, Gavin Shan wrote:
>>> The empty NUMA nodes, where no memory resides in, are allowed. For
>>> these empty NUMA nodes, the 'len' of 'reg' property is zero. These
>>> empty NUMA node IDs are still valid and parsed. I finds difficulty
>>> to get where it's properly documented.
>>>
>>> So lets add note to empty NUMA nodes in the NUMA binding doc.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   Documentation/devicetree/bindings/numa.txt | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>> index 21b35053ca5a..c564705c0eac 100644
>>> --- a/Documentation/devicetree/bindings/numa.txt
>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>> @@ -109,6 +109,10 @@ Example:
>>>   Dual socket system consists of 2 boards connected through ccn bus and
>>>   each board having one socket/soc of 8 cpus, memory and pci bus.
>>>   +Note that the empty NUMA nodes, which no memory resides in, are allowed
>>
>> Missing period at end of the sentence above.
>>
> 
> Oh, Yes. Thanks, Randy. I will replace "resides in" with "resides in period"
> in v2.

Cute. Would it help if I replaced "period" with Missing "full stop" or '.' at the end
of the sentence?

>>> +Their NUMA node IDs are still valid so that memory can be added into these
>>> +NUMA nodes through hotplug afterwards.
>>> +
>>>       memory@c00000 {
>>>           device_type = "memory";
>>>           reg = <0x0 0xc00000 0x0 0x80000000>;
> 
> By the way, I have one more question to check with you if I can. I'm not sure
> if dummy and invalid 'unit-address' is allowed in the empty memory node name,
> which follows the format "memory@unit-address'.
> 
> (1) The 'unit-address' is same thing as to 'base address' for memory node,
>     as specified in device-tree specification. I'm not sure if 'base address'
>     can be dummy and invalid one since empty memory node doesn't have memory
>     at all.
> 
>     https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#node-names
> 
> (2) I don't find the 'unit-address' is used in linux, but I'm not sure other
>     software component like firmware uses it or not.

I have no idea about that.
