Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0893B5B77
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhF1Jku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232348AbhF1Jks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624873099;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KbstVO6yJsjAAz2Rw4pFG159iQgUyoPxnfRs5v5lilk=;
        b=ZqIAoS7zESNCpH8om+WBC9jRWVOJC4BKH0Q3u9CUp4c9m5LdVAr7vkMnBckFpX9nEAEaEN
        vN2fwKsgE1WmBuGzlS/j1ozxZ1ZC1nadxeT9vpz0iFl28hTKQUvc5WI7y4SlIWGITuu1lW
        YtF8kIJzkEn5WpuVphYH54pWodO+3B0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-XZYQWhsCMlauT0z5wfc2VA-1; Mon, 28 Jun 2021 05:38:17 -0400
X-MC-Unique: XZYQWhsCMlauT0z5wfc2VA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79ADE802E62;
        Mon, 28 Jun 2021 09:38:16 +0000 (UTC)
Received: from [10.64.54.204] (vpn2-54-204.bne.redhat.com [10.64.54.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CE705B826;
        Mon, 28 Jun 2021 09:38:13 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4] Documentation, dt, numa: Add note to empty NUMA node
To:     Andrew Jones <drjones@redhat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robh+dt@kernel.org, shan.gavin@gmail.com
References: <20210625052338.4875-1-gshan@redhat.com>
 <20210625070217.4ffmfe7nwlusbbjc@gator>
 <20210625070656.j373hveemf5cdch4@gator>
 <41643136-798b-a0f3-aee7-b6af94a2fc67@redhat.com>
 <20210625101821.3t3vgj2pnw3hqpzm@gator>
 <62d04903-e4f3-2302-d530-5942e33ae116@redhat.com>
 <20210628083420.v47xbbtcgjj2mu47@gator>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <60a2b930-40cc-ea32-878f-d063523b5fec@redhat.com>
Date:   Mon, 28 Jun 2021 19:38:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210628083420.v47xbbtcgjj2mu47@gator>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 6:34 PM, Andrew Jones wrote:
> On Fri, Jun 25, 2021 at 09:14:49PM +1000, Gavin Shan wrote:
>> On 6/25/21 8:18 PM, Andrew Jones wrote:
>>> On Fri, Jun 25, 2021 at 06:36:48PM +1000, Gavin Shan wrote:
>>>> On 6/25/21 5:06 PM, Andrew Jones wrote:
>>>>> On Fri, Jun 25, 2021 at 09:02:17AM +0200, Andrew Jones wrote:
>>>>>> On Fri, Jun 25, 2021 at 01:23:38PM +0800, Gavin Shan wrote:
>>>>>>> The empty memory nodes, where no memory resides in, are allowed.
>>>>>>> For these empty memory nodes, the 'len' of 'reg' property is zero.
>>>>>>> The NUMA node IDs are still valid and parsed, but memory can be
>>>>>>> added to them through hotplug afterwards. I finds difficulty to
>>>>>>> get where it's properly documented.
>>>>>>>
>>>>>>> So lets add note to empty memory nodes in the NUMA binding doc.
>>>>>>>
>>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>>>> ---
>>>>>>>     Documentation/devicetree/bindings/numa.txt | 4 ++++
>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>>>>>> index 21b35053ca5a..0fc882e44270 100644
>>>>>>> --- a/Documentation/devicetree/bindings/numa.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>>>>>> @@ -109,6 +109,10 @@ Example:
>>>>>>>     Dual socket system consists of 2 boards connected through ccn bus and
>>>>>>>     each board having one socket/soc of 8 cpus, memory and pci bus.
>>>>>>> +Note that empty memory nodes, which no memory resides in, are allowed.
>>>>>>> +The NUMA node IDs in these empty memory nodes are still valid, but
>>>>>>> +memory can be added into them through hotplug afterwards.
>>>>>>
>>>>>> Please change the second sentence to:
>>>>>>
>>>>>>      The NUMA node IDs in these empty memory nodes are still valid and
>>>>>>      memory may be added into them through hotplug afterwards.
>>>>>>
>>>>>> But, this doesn't look like the right place for this paragraph. You're
>>>>>> adding the paragraph to the example section, but the example doesn't have
>>>>>> any empty memory nodes.
>>>>>>
>>>>>> I think the paragraph should be added to section "2 - numa-node-id" and an
>>>>>
>>>>> Or maybe even create a new section for it.
>>>>>
>>>>>> example empty memory node should be provided. Also, the commit message
>>>>>> talks about the length of 'reg' being zero, which is an important
>>>>>> distinction which should also be documented.
>>>>>>
>>>>
>>>> Drew, thanks for your comments. Yeah, it sounds sensible to create
>>>> a new section for it and an example would be more helpful. Please
>>>> check if below changes are fine to you. I probably need Randy's review
>>>> again.
>>>>
>>>> I'm trying to avoid too many revisions for this sort of trivial patch,
>>>> even though I already had. However, it's time frame for v5.14 and I'm
>>>> pushing this to be merged during the cycle.
>>>
>>> We must revise until we're satisfied... Also, I wouldn't call writing
>>> specifications trivial.
>>>
>>
>> [...]
>>
>>> I'll just rewrite it:
>>>
>>>    Empty memory nodes, which no memory resides in, are allowed. The 'length'
>>>    field of the 'reg' property is zero, but the 'base-address' is a dummy
>>>    address and invalid. However, the NUMA node IDs and distance maps are
>>>    still valid and memory may be added into them through hotplug afterwards.
>>>
>>
>> [...]
>>
>>>
>>> You should write how you've selected the dummy addresses for the empty
>>> memory nodes, perhaps here in the /* Empty memory node */ comments or
>>> above in the paragraph or both.
>>>
>>>> +	memory@0x100000000 {
>>>> +		device_type = "memory";
>>>> +		reg = <0x1 0x0 0x0 0x0>;
>>>> +		numa-node-id = <2>;
>>>> +	};
>>>> +
>>>> +	/* Empty memory node */
>>>> +	memory@0x180000000 {
>>>> +		device_type = "memory";
>>>> +		reg = <0x1 0x80000000 0x0 0x0>;
>>>> +		numa-node-id = <3>;
>>>> +	};
>>>> +
>>
>> [...]
>>
>> Thanks, Drew. As 'base-address' is dummy address and invalid. So we
>> would note it as suggestion. With your suggestion integrated, how about
>> something like this?
>>
>> ==============================================================================
>> 4 - Empty memory nodes
>> ==============================================================================
>>
>> Empty memory nodes, which no memory resides in, are allowed. The 'length'
>> field of the 'reg' property is zero, but the 'base-address' is a dummy
>> address and invalid. The 'base-address' could be the summation of highest
>> memory address plus the NUMA node ID. However, the NUMA node IDs and
>> distance maps are still valid and memory may be added into them through
>> hotplug afterwards.
>>
>>         :
>>
>>         memory@0 {
>>                  device_type = "memory";
>>                  reg = <0x0 0x0 0x0 0x80000000>;
>>                  numa-node-id = <0>;
>>          };
>>
>>          memory@0x80000000 {
>>                  device_type = "memory";
>>                  reg = <0x0 0x80000000 0x0 0x80000000>;
>>                  numa-node-id = <1>;
>>          };
>>
>>          /* Empty memory node */
>>          memory@0x100000002 {
>>                  device_type = "memory";
>>                  reg = <0x1 0x2 0x0 0x0>;
>>                  numa-node-id = <2>;
>>          };
>>
>>          /* Empty memory node */
>>          memory@0x100000003 {
>>                  device_type = "memory";
>>                  reg = <0x1 0x3 0x0 0x0>;
>>                  numa-node-id = <3>;
>>          };
>>
>>          :
>>
>> Thanks,
>> Gavin
>>
>>
> 
> Looks good to me.
> 

Thanks, Drew. v5 was posted to reflect changes, but I don't
include Randy's r-b because too much changes introduced.
Hopefully, Randy can take a look on v5 when getting a chance.

Thanks,
Gavin

