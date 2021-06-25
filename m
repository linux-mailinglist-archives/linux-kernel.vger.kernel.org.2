Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755733B3A08
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhFYAMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233006AbhFYAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624579748;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4knyT9IBjuCK4Ns9ef27jgboQNJ/fxEGqbQX/vpuCbo=;
        b=hnRCEkvWMu2AFIU2L/PUZ0IwoyeV+p1YkcRwXJIMRfNGUYzfwUw+rkYV/9YBjmjwF3HtSa
        VvIn7rW02EnkvEGbvifbf8UXLHVkj3X9XbPuRCA4kDDYAJdpLwRWUpn759ITSa8X3IT+Ow
        X9bjFCsOBewvYfjjTe0rrvKQeHFa+BA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-H3pyIl-1Oxm8F1_kpSxkFw-1; Thu, 24 Jun 2021 20:09:06 -0400
X-MC-Unique: H3pyIl-1Oxm8F1_kpSxkFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C142E8042A8;
        Fri, 25 Jun 2021 00:09:05 +0000 (UTC)
Received: from [10.64.54.70] (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F94810023B5;
        Fri, 25 Jun 2021 00:09:03 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
From:   Gavin Shan <gshan@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210624033740.20862-1-gshan@redhat.com>
 <a6cdc518-3bd7-2b66-acd0-c4d53d360eae@infradead.org>
 <435d4707-3871-26fe-e0e4-df93931ba49d@redhat.com>
 <cfba8d64-810d-675b-8727-66c84106883c@infradead.org>
 <0e6e80a8-23f9-d0e7-a486-3b9affc02555@redhat.com>
Message-ID: <0592a04c-c526-101b-2ca2-caf4fc9e7587@redhat.com>
Date:   Fri, 25 Jun 2021 12:10:33 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <0e6e80a8-23f9-d0e7-a486-3b9affc02555@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 5:44 PM, Gavin Shan wrote:
> On 6/24/21 3:37 PM, Randy Dunlap wrote:
>> On 6/23/21 9:58 PM, Gavin Shan wrote:
>>> On 6/24/21 12:14 PM, Randy Dunlap wrote:
>>>> On 6/23/21 8:37 PM, Gavin Shan wrote:
>>>>> The empty NUMA nodes, where no memory resides in, are allowed. For
>>>>> these empty NUMA nodes, the 'len' of 'reg' property is zero. These
>>>>> empty NUMA node IDs are still valid and parsed. I finds difficulty
>>>>> to get where it's properly documented.
>>>>>
>>>>> So lets add note to empty NUMA nodes in the NUMA binding doc.
>>>>>
>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/numa.txt | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>>>> index 21b35053ca5a..c564705c0eac 100644
>>>>> --- a/Documentation/devicetree/bindings/numa.txt
>>>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>>>> @@ -109,6 +109,10 @@ Example:
>>>>>    Dual socket system consists of 2 boards connected through ccn bus and
>>>>>    each board having one socket/soc of 8 cpus, memory and pci bus.
>>>>>    +Note that the empty NUMA nodes, which no memory resides in, are allowed
>>>>
>>>> Missing period at end of the sentence above.
>>>>
>>>
>>> Oh, Yes. Thanks, Randy. I will replace "resides in" with "resides in period"
>>> in v2.
>>
>> Cute. Would it help if I replaced "period" with Missing "full stop" or '.' at the end
>> of the sentence?
>>
> 
> Ah, yes, '.' is needed either. Do you want me to post a new revision or you
> modify it right away? I don't know how device-tree patches get merged :)
> 

Randy, I just posted v2 to include changes suggested by you. Could
you help to have a quick check when getting a chance?

>>>>> +Their NUMA node IDs are still valid so that memory can be added into these
>>>>> +NUMA nodes through hotplug afterwards.
>>>>> +
>>>>>        memory@c00000 {
>>>>>            device_type = "memory";
>>>>>            reg = <0x0 0xc00000 0x0 0x80000000>;
>>>

[...]

Thanks,
Gavin

