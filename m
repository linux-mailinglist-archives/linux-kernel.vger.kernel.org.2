Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD70D3B3BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFYEfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 00:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhFYEfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624595575;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gca2iBYAHt0jcFm1i9vXcVWslf2z4fsvsR8AkljVE2M=;
        b=No4ZpKSdymzV50DfB0EIuSb7u0Y38g31WRQZkNJsex7v072frRyzEQIVvXh7QT/rAETRm4
        xqkfdD8Hr1WTK5phRj8jzgb6JjpT4yv9u53pcxG1hdbWHt/G/hjbCMlvRuzbj840a1P0Aq
        0Qbg2QeOF0TdOdo7UWWzDfjJFGCDoYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-fXs5K0QMNy2I_3El9oywcw-1; Fri, 25 Jun 2021 00:32:53 -0400
X-MC-Unique: fXs5K0QMNy2I_3El9oywcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69E2D100C609;
        Fri, 25 Jun 2021 04:32:52 +0000 (UTC)
Received: from [10.64.54.70] (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A76E60C05;
        Fri, 25 Jun 2021 04:32:49 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3] Documentation, dt, numa: Add note to empty NUMA node
To:     Randy Dunlap <rdunlap@infradead.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210625043025.47469-1-gshan@redhat.com>
 <874bcd17-29b6-658b-fa11-7854b1300d30@infradead.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <2973ca46-c092-3ffe-b14a-7481e479012e@redhat.com>
Date:   Fri, 25 Jun 2021 14:32:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <874bcd17-29b6-658b-fa11-7854b1300d30@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 1:47 PM, Randy Dunlap wrote:
> On 6/24/21 9:30 PM, Gavin Shan wrote:
>> The empty NUMA nodes, where no memory resides in, are allowed. For
>> these empty NUMA nodes, the 'len' of 'reg' property is zero. These
>> empty NUMA node IDs are still valid and parsed. I finds difficulty
>> to get where it's properly documented.
>>
>> So lets add note to empty NUMA nodes in the NUMA binding doc.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   Documentation/devicetree/bindings/numa.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>> index 21b35053ca5a..edf728cff155 100644
>> --- a/Documentation/devicetree/bindings/numa.txt
>> +++ b/Documentation/devicetree/bindings/numa.txt
>> @@ -109,6 +109,10 @@ Example:
>>   Dual socket system consists of 2 boards connected through ccn bus and
>>   each board having one socket/soc of 8 cpus, memory and pci bus.
>>   
>> +Note that the empty NUMA nodes, which no memory resides in, are allowed.
> 
> I would write that without "the":
> 
> +Note that empty NUMA nodes, which no memory resides in, are allowed.
> 
> BTW, AFAIK, NUMA nodes may contain memory, CPU(s), or I/O -- any one, two, or
> three, without the other types of resources being present.
> 

Sure, I will drop "the" in v4.

The NUMA nodes here are memory nodes here. Since the NUMA node usually means
memory node. I'm not sure if I change the term "NUMA node" to "NUMA memory
node" in v4. If you agree, I would have something like this:

Note that empty memory nodes, which no memory resides in, are allowed.
The NUMA node IDs in these empty memory nodes are still valid, but memory
can be added into them through hotplug afterwards.

> 
>> +Their NUMA node IDs are still valid so that memory can be added into these
>> +NUMA nodes through hotplug afterwards.
>> +
>>   	memory@c00000 {
>>   		device_type = "memory";
>>   		reg = <0x0 0xc00000 0x0 0x80000000>;
> 
> 
> OT: is your system clock off by a couple of hours?
> Your emails seem to be from in the future.
> 

Yeah, The local clock becomes messy after my laptop reboots. I enabled
NTP and kept it running. Hopefully, the clock is precise this time.
Thanks for the reminder, Randy :)

Thanks,
Gavin

