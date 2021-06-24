Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8183B26F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhFXFpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230093AbhFXFpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624513405;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yeRuwo7aYMlJt0vQUT3Uo5t/TQHLlH47dQnt+AgEW0=;
        b=J1gGSPReLEhYHxHiuCaBRFY4oFWhUVCkjqgDy7/clotZY8sdI5yl6b3/lVPNfgmi7S8bhx
        6xVbt53Z/QmPbncDffmakfKIgPgoNsZ+SLVL920t/2UJeguo/UEyjFbruGBpTJgCkxXBB1
        239iTlNscXWSui+PBUXP6tgBza+nCpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-VHDDG51kOJqYe9PVlY3PeA-1; Thu, 24 Jun 2021 01:43:23 -0400
X-MC-Unique: VHDDG51kOJqYe9PVlY3PeA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B472100C610;
        Thu, 24 Jun 2021 05:43:22 +0000 (UTC)
Received: from [10.64.54.70] (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B19CD608BA;
        Thu, 24 Jun 2021 05:43:20 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
To:     Randy Dunlap <rdunlap@infradead.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210624033740.20862-1-gshan@redhat.com>
 <a6cdc518-3bd7-2b66-acd0-c4d53d360eae@infradead.org>
 <435d4707-3871-26fe-e0e4-df93931ba49d@redhat.com>
 <cfba8d64-810d-675b-8727-66c84106883c@infradead.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <0e6e80a8-23f9-d0e7-a486-3b9affc02555@redhat.com>
Date:   Thu, 24 Jun 2021 17:44:50 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <cfba8d64-810d-675b-8727-66c84106883c@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 3:37 PM, Randy Dunlap wrote:
> On 6/23/21 9:58 PM, Gavin Shan wrote:
>> On 6/24/21 12:14 PM, Randy Dunlap wrote:
>>> On 6/23/21 8:37 PM, Gavin Shan wrote:
>>>> The empty NUMA nodes, where no memory resides in, are allowed. For
>>>> these empty NUMA nodes, the 'len' of 'reg' property is zero. These
>>>> empty NUMA node IDs are still valid and parsed. I finds difficulty
>>>> to get where it's properly documented.
>>>>
>>>> So lets add note to empty NUMA nodes in the NUMA binding doc.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/numa.txt | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>>> index 21b35053ca5a..c564705c0eac 100644
>>>> --- a/Documentation/devicetree/bindings/numa.txt
>>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>>> @@ -109,6 +109,10 @@ Example:
>>>>    Dual socket system consists of 2 boards connected through ccn bus and
>>>>    each board having one socket/soc of 8 cpus, memory and pci bus.
>>>>    +Note that the empty NUMA nodes, which no memory resides in, are allowed
>>>
>>> Missing period at end of the sentence above.
>>>
>>
>> Oh, Yes. Thanks, Randy. I will replace "resides in" with "resides in period"
>> in v2.
> 
> Cute. Would it help if I replaced "period" with Missing "full stop" or '.' at the end
> of the sentence?
> 

Ah, yes, '.' is needed either. Do you want me to post a new revision or you
modify it right away? I don't know how device-tree patches get merged :)

>>>> +Their NUMA node IDs are still valid so that memory can be added into these
>>>> +NUMA nodes through hotplug afterwards.
>>>> +
>>>>        memory@c00000 {
>>>>            device_type = "memory";
>>>>            reg = <0x0 0xc00000 0x0 0x80000000>;
>>
>> By the way, I have one more question to check with you if I can. I'm not sure
>> if dummy and invalid 'unit-address' is allowed in the empty memory node name,
>> which follows the format "memory@unit-address'.
>>
>> (1) The 'unit-address' is same thing as to 'base address' for memory node,
>>      as specified in device-tree specification. I'm not sure if 'base address'
>>      can be dummy and invalid one since empty memory node doesn't have memory
>>      at all.
>>
>>      https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#node-names
>>
>> (2) I don't find the 'unit-address' is used in linux, but I'm not sure other
>>      software component like firmware uses it or not.
> 
> I have no idea about that.
> 
Okey.

Thanks,
Gavin

