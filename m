Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224503C97D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 06:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbhGOE51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 00:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234980AbhGOE51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626324874;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rso+wZGJ9EdbcL4pqe63HOb/592Ln3IxXiUcSTBK6oE=;
        b=QP+gP8Hl56DyHHW5Kve1PR+icVhTBa6WGRXPvI5pipN61Ib1dmG7N4eUG4dmWYSWUHbipj
        3LF0hvvgqwdThlpS1z5+FQBFx8HHTqJR3SgemHrTwiA9arRtqIc9y/7n0WOa1eMCKyOAJV
        gVODBZBuIi1aR1rzEnVvLEequ5CwmlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-pK_eNy_rNz2TiQbxauz-7Q-1; Thu, 15 Jul 2021 00:54:32 -0400
X-MC-Unique: pK_eNy_rNz2TiQbxauz-7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C33B100B3AC;
        Thu, 15 Jul 2021 04:54:31 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92B265D9C6;
        Thu, 15 Jul 2021 04:54:28 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5] Documentation, dt, numa: Add note to empty NUMA node
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, drjones@redhat.com,
        shan.gavin@gmail.com
References: <20210628093411.88805-1-gshan@redhat.com>
 <20210701172527.GA2567910@robh.at.kernel.org>
 <1c43cd39-7bf6-b99c-36ec-798b81b1aba1@redhat.com>
 <CAL_JsqLF1pW-43BoH7bPkT+a3dk716LwCV6WO1Ygag_BZ-QO2Q@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <1b675d9d-9e76-ed69-9f32-4418d7dad5fd@redhat.com>
Date:   Thu, 15 Jul 2021 14:54:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLF1pW-43BoH7bPkT+a3dk716LwCV6WO1Ygag_BZ-QO2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 7/13/21 5:44 AM, Rob Herring wrote:
> On Thu, Jul 1, 2021 at 6:02 PM Gavin Shan <gshan@redhat.com> wrote:
>> On 7/2/21 3:25 AM, Rob Herring wrote:
>>> On Mon, Jun 28, 2021 at 05:34:11PM +0800, Gavin Shan wrote:
>>>> The empty memory nodes, where no memory resides in, are allowed.
>>>> For these empty memory nodes, the 'len' of 'reg' property is zero.
>>>> The NUMA node IDs are still valid and parsed, but memory may be
>>>> added to them through hotplug afterwards. I finds difficulty to
>>>> get where it's properly documented.
>>>
>>> This is already in use? If so, what platform(s)?
>>>
>>
>> It's not used yet, but will be used by QEMU once this patch is merged.
>> In QEMU, ARM64 could have multiple empty memory nodes. The corresponding
>> NUMA ID and distance map are still valid because memory may be added into
>> these empty memory nodes in future.
>>
>> For the QEMU case, the names of empty memory nodes are the biggest concern.
>> According to device-tree specification, the name follows the format of
>> 'memory@unit-address' and the 'unit-address' is equivalent to 'base-address'.
>> However, the 'base-address' should be invalid one. In current QEMU implementation,
>> the valid 'base-address' and 'unit-address' are provided to these empty
>> memory nodes. Another issue in QEMU is trying to populate two empty memory
>> nodes, which have same names. This leads to failure of device-tree population
>> because of the duplicated memory node names, blocking VM from booting.
> 
> We accept patches to the DT spec, so why are you working around it?
> However, a fake base doesn't seem like a good solution to me, so
> premature for any DT spec change.
> 
> In any case, I think this needs a lot more context in terms of what
> you are trying to accomplish and a wider audience. Some more Arm
> folks, UEFI folks, etc. Maybe the boot-architecture list. Maybe that
> all happened already, but I doubt it.
> 

Thanks for your comments again. How about to have something like below.
I need your help to review it first before I'm going to send the formal
patch to more maillists for further reviews. The commit log will be improved
that time either, to includes more details.


==============================================================================
4 - Empty memory nodes
==============================================================================

Empty memory nodes, which no memory resides in, are allowed on some systems
like virtual machine (VM). The 'length' field of the 'reg' property is zero,
but the 'base-address' is an invalid address, which is the summation of highest
memory address plus the NUMA node ID. However, the NUMA node IDs and distance
maps are still valid and memory may be added into them by hotplug afterwards.

[examples will be included when patch is posted]

Changes since v5:

    * The virtual machine (VM) is mentioned.
    * The 'base-address' is fixed to be the summation of highest memory
      address plus the NUMA node ID.

>>>> So lets add a section for empty memory nodes in NUMA binding
>>>> document. Also, the 'unit-address', equivalent to 'base-address'
>>>> in the 'reg' property of these empty memory nodes is suggested to
>>>> be the summation of highest memory address plus the NUMA node ID.
>>>
>>> What purpose does this serve? The kernel won't do anything with it other
>>> than validate the numa-node-id range.
>>>
>>
>> As mentioned above, the point is to have dummy, invalid and non-overlapped
>> 'base-address' and 'unit-address' for these empty memory nodes, to avoid
>> duplicated memory node names in devcie-tree.
>>
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>> v5: Separate section for empty memory node
>>>> ---
>>>>    Documentation/devicetree/bindings/numa.txt | 61 +++++++++++++++++++++-
>>>>    1 file changed, 60 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>>> index 21b35053ca5a..230c734af948 100644
>>>> --- a/Documentation/devicetree/bindings/numa.txt
>>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>>> @@ -103,7 +103,66 @@ Example:
>>>>               };
>>>>
>>>>    ==============================================================================
>>>> -4 - Example dts
>>>> +4 - Empty memory nodes
>>>> +==============================================================================
>>>> +
>>>> +Empty memory nodes, which no memory resides in, are allowed. The 'length'
>>>> +field of the 'reg' property is zero, but the 'base-address' is a dummy
>>>> +address and invalid. The 'base-address' could be the summation of highest
>>>> +memory address plus the NUMA node ID. However, the NUMA node IDs and
>>>> +distance maps are still valid and memory may be added into them through
>>>> +hotplug afterwards.
>>>> +
>>>> +Example:
>>>> +
>>>> +    memory@0 {
>>>> +            device_type = "memory";
>>>> +            reg = <0x0 0x0 0x0 0x80000000>;
>>>> +            numa-node-id = <0>;
>>>> +    };
>>>> +
>>>> +    memory@0x80000000 {
>>>
>>> unit-address should not have '0x'.
>>>
>>
>> Ok. Lets fix it in v6 after it's agreed to add the section into the
>> NUMA binding document. Actually, the '0x' is copied from the existing
>> example in same document. After this patch is finalized, I will post
>> separate patch to fix all wrong formats in same document as well.
> 
> Fixes first, features second.
> 
> Or just don't copy bad examples.
> 

Please ignore this part because we don't have the issue in existing
examples. Sorry about the confusion. We just need to remove '0x' prefix
in the examples introduced by this patch itself.

Thanks,
Gavin

