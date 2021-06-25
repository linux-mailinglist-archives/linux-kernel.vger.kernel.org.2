Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6DA3B3ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 04:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhFYC2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 22:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232983AbhFYC2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624587940;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5/SuZmFUGG4xnHkucjjPJL7xkaO4zx3n4uChnfC3ME=;
        b=Wk4fdRb+0FteTNRdw5iyNGU4wMtzQ2lSJ2rh+CqeYpZSnJchyuGBeaQjqmEBM0CS2UnDBQ
        DmC2OJwHI0dnbp7CHZrAjfQWSiexlMSE2Vgck7B6I3V0yUFhaJsP61GOxtIESybI5vljXP
        ezj+THJ/cwqcz3kVhPq3Q5pXXMYySk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-t_83xIGUP9ydGR_reZH_Gw-1; Thu, 24 Jun 2021 22:25:36 -0400
X-MC-Unique: t_83xIGUP9ydGR_reZH_Gw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5195D804142;
        Fri, 25 Jun 2021 02:25:35 +0000 (UTC)
Received: from [10.64.54.70] (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87A9A10023B5;
        Fri, 25 Jun 2021 02:25:33 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] Documentation, dt, numa: Add note to empty NUMA node
To:     Randy Dunlap <rdunlap@infradead.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210625020322.43825-1-gshan@redhat.com>
 <834b6b3a-c56b-b8e3-f401-30fdc689d6a2@infradead.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <7b49ad10-10a8-a20a-fce3-9fb113bcac54@redhat.com>
Date:   Fri, 25 Jun 2021 14:27:02 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <834b6b3a-c56b-b8e3-f401-30fdc689d6a2@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 11:49 AM, Randy Dunlap wrote:
> On 6/24/21 7:03 PM, Gavin Shan wrote:
>> The empty NUMA nodes, where no memory resides in, are allowed. For
>> these empty NUMA nodes, the 'len' of 'reg' property is zero. These
>> empty NUMA node IDs are still valid and parsed. I finds difficulty
>> to get where it's properly documented.
>>
>> So lets add note to empty NUMA nodes in the NUMA binding doc.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v2: Update to address Randy's comments
> 
> Hi Gavin,
> 
> Sorry, there has been some misunderstanding. Please see below.
> 
> 
>> ---
>>   Documentation/devicetree/bindings/numa.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>> index 21b35053ca5a..08e361f9954c 100644
>> --- a/Documentation/devicetree/bindings/numa.txt
>> +++ b/Documentation/devicetree/bindings/numa.txt
>> @@ -109,6 +109,10 @@ Example:
>>   Dual socket system consists of 2 boards connected through ccn bus and
>>   each board having one socket/soc of 8 cpus, memory and pci bus.
>>   
>> +Note that the empty NUMA nodes, which no memory resides in period, are
> 
> In patch v1, this was:
> 
>    +Note that the empty NUMA nodes, which no memory resides in, are allowed
> 
> and I said:
> 
>    Missing period at end of the sentence above.
> 
> What I meant by that was "Missing 'period' ('.') punctuation at the end
> of the sentence above. So it should simply be changed to:
> 
> 
>    +Note that the empty NUMA nodes, which no memory resides in, are allowed.
> 

Thanks, Randy. v3 will be posted shortly to have everything corrected.
Sorry about the misunderstanding.

I thought "in period" means "temporarily" and it makes sense to me :)

> 
>> +allowed. Their NUMA node IDs are still valid so that memory can be added
>> +into these NUMA nodes through hotplug afterwards.
>> +
>>   	memory@c00000 {
>>   		device_type = "memory";
>>   		reg = <0x0 0xc00000 0x0 0x80000000>;
> 
> Sorry about the confusion.
> 

Sorry to take more of your time to review :)

Thanks,
Gavin

