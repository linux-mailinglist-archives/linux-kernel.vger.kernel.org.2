Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA8B3B99DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 02:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhGBAEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 20:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234063AbhGBAEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 20:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625184141;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQa9AhG3ubmsrg3kaDvez+6g6tRTQsIoLD7B2XLxygc=;
        b=MQ2ubl3tHD7OLEmHesx76UveVhsvO3dUake7j8JPL5hh3RjgCwMMbfnr6hIMmQ8wzTbO81
        LSX8kRKTXz4hKrmzJ5IZuJ5JgEB+VgChhNdusfEnvec+9galfw1oCKyIEV41pwj4ObpLJ1
        mHogvx7uqr7uyU28DC3o3DmsmvGQjZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-PUb6VjVlMXGRqNQJ7kTgcg-1; Thu, 01 Jul 2021 20:02:20 -0400
X-MC-Unique: PUb6VjVlMXGRqNQJ7kTgcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74CA0A0CAB;
        Fri,  2 Jul 2021 00:02:19 +0000 (UTC)
Received: from [10.64.54.119] (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BD925D6AB;
        Fri,  2 Jul 2021 00:02:16 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5] Documentation, dt, numa: Add note to empty NUMA node
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, drjones@redhat.com, shan.gavin@gmail.com
References: <20210628093411.88805-1-gshan@redhat.com>
 <20210701172527.GA2567910@robh.at.kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <1c43cd39-7bf6-b99c-36ec-798b81b1aba1@redhat.com>
Date:   Fri, 2 Jul 2021 10:02:14 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210701172527.GA2567910@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 7/2/21 3:25 AM, Rob Herring wrote:
> On Mon, Jun 28, 2021 at 05:34:11PM +0800, Gavin Shan wrote:
>> The empty memory nodes, where no memory resides in, are allowed.
>> For these empty memory nodes, the 'len' of 'reg' property is zero.
>> The NUMA node IDs are still valid and parsed, but memory may be
>> added to them through hotplug afterwards. I finds difficulty to
>> get where it's properly documented.
> 
> This is already in use? If so, what platform(s)?
> 

It's not used yet, but will be used by QEMU once this patch is merged.
In QEMU, ARM64 could have multiple empty memory nodes. The corresponding
NUMA ID and distance map are still valid because memory may be added into
these empty memory nodes in future.

For the QEMU case, the names of empty memory nodes are the biggest concern.
According to device-tree specification, the name follows the format of
'memory@unit-address' and the 'unit-address' is equivalent to 'base-address'.
However, the 'base-address' should be invalid one. In current QEMU implementation,
the valid 'base-address' and 'unit-address' are provided to these empty
memory nodes. Another issue in QEMU is trying to populate two empty memory
nodes, which have same names. This leads to failure of device-tree population
because of the duplicated memory node names, blocking VM from booting.

>> So lets add a section for empty memory nodes in NUMA binding
>> document. Also, the 'unit-address', equivalent to 'base-address'
>> in the 'reg' property of these empty memory nodes is suggested to
>> be the summation of highest memory address plus the NUMA node ID.
> 
> What purpose does this serve? The kernel won't do anything with it other
> than validate the numa-node-id range.
> 

As mentioned above, the point is to have dummy, invalid and non-overlapped
'base-address' and 'unit-address' for these empty memory nodes, to avoid
duplicated memory node names in devcie-tree.

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v5: Separate section for empty memory node
>> ---
>>   Documentation/devicetree/bindings/numa.txt | 61 +++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>> index 21b35053ca5a..230c734af948 100644
>> --- a/Documentation/devicetree/bindings/numa.txt
>> +++ b/Documentation/devicetree/bindings/numa.txt
>> @@ -103,7 +103,66 @@ Example:
>>   		};
>>   
>>   ==============================================================================
>> -4 - Example dts
>> +4 - Empty memory nodes
>> +==============================================================================
>> +
>> +Empty memory nodes, which no memory resides in, are allowed. The 'length'
>> +field of the 'reg' property is zero, but the 'base-address' is a dummy
>> +address and invalid. The 'base-address' could be the summation of highest
>> +memory address plus the NUMA node ID. However, the NUMA node IDs and
>> +distance maps are still valid and memory may be added into them through
>> +hotplug afterwards.
>> +
>> +Example:
>> +
>> +	memory@0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x0 0x0 0x80000000>;
>> +		numa-node-id = <0>;
>> +	};
>> +
>> +	memory@0x80000000 {
> 
> unit-address should not have '0x'.
> 

Ok. Lets fix it in v6 after it's agreed to add the section into the
NUMA binding document. Actually, the '0x' is copied from the existing
example in same document. After this patch is finalized, I will post
separate patch to fix all wrong formats in same document as well.

>> +		device_type = "memory";
>> +		reg = <0x0 0x80000000 0x0 0x80000000>;
>> +		numa-node-id = <1>;
>> +	};
>> +
>> +	/* Empty memory node */
>> +	memory@0x100000002 {
>> +		device_type = "memory";
>> +		reg = <0x1 0x2 0x0 0x0>;
>> +		numa-node-id = <2>;
>> +	};
>> +
>> +	/* Empty memory node */
>> +	memory@0x100000003 {
>> +		device_type = "memory";
>> +		reg = <0x1 0x3 0x0 0x0>;
>> +		numa-node-id = <3>;
>> +	};
>> +
>> +	distance-map {
>> +		compatible = "numa-distance-map-v1";
>> +		distance-matrix = <0 0  10>,
>> +				  <0 1  20>,
>> +				  <0 2  40>,
>> +				  <0 3  20>,
>> +				  <1 0  20>,
>> +				  <1 1  10>,
>> +				  <1 2  20>,
>> +				  <1 3  40>,
>> +				  <2 0  40>,
>> +				  <2 1  20>,
>> +				  <2 2  10>,
>> +				  <2 3  20>,
>> +				  <3 0  20>,
>> +				  <3 1  40>,
>> +				  <3 2  20>,
>> +				  <3 3  10>;
>> +	};
>> +
>> +==============================================================================
>> +5 - Example dts
>>   ==============================================================================
>>   
>>   Dual socket system consists of 2 boards connected through ccn bus and
>> -- 
>> 2.23.0
>>

Thanks,
Gavin

