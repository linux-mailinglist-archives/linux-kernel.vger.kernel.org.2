Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7733B3BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhFYEv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 00:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFYEv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:51:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97A8C061574;
        Thu, 24 Jun 2021 21:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=T6yWviVRgbLrzRABmzLM9v7RQmJuSHF1UP5Tn0iggiY=; b=Rdz2Cm0eDhd9u0ZTVUn5gmw1gA
        HmV9ERIqSmm2pbs0Lfbu8wWuFQ5eqiPFGQYaliFRbh6hHlY3CpINFNg3xrOYUbN9ksy6eforGD1eP
        yL+95B55st3SiMpWK4bkieKjm1X+Ae0EqJRtnIxYlm7n/9P06JtGy0YTPjq9JIDekYock4sE2UMF7
        aaOmOilK0IoY7uR4ELxhJY38VJKaUEdKIxAlZEbqFbgURXqzr0bYkdEnSbEvZVqOeNWUAnnH3wZtk
        nNyOKeNH5cNWHm+p/KYbB5FE27qUH9IdJABMoYFXEQYfEuGRhl1GYXfpfnq1bIr9rKRy5W3AzEzjF
        Pu+lFEQA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwdm4-00HGp7-7h; Fri, 25 Jun 2021 04:49:04 +0000
Subject: Re: [PATCH v3] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210625043025.47469-1-gshan@redhat.com>
 <874bcd17-29b6-658b-fa11-7854b1300d30@infradead.org>
 <2973ca46-c092-3ffe-b14a-7481e479012e@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3e7eb6ca-6f4c-2a85-8ff2-f7daf186d7a1@infradead.org>
Date:   Thu, 24 Jun 2021 21:49:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2973ca46-c092-3ffe-b14a-7481e479012e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 9:32 PM, Gavin Shan wrote:
> On 6/25/21 1:47 PM, Randy Dunlap wrote:
>> On 6/24/21 9:30 PM, Gavin Shan wrote:
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
>>> index 21b35053ca5a..edf728cff155 100644
>>> --- a/Documentation/devicetree/bindings/numa.txt
>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>> @@ -109,6 +109,10 @@ Example:
>>>   Dual socket system consists of 2 boards connected through ccn bus and
>>>   each board having one socket/soc of 8 cpus, memory and pci bus.
>>>   +Note that the empty NUMA nodes, which no memory resides in, are allowed.
>>
>> I would write that without "the":
>>
>> +Note that empty NUMA nodes, which no memory resides in, are allowed.
>>
>> BTW, AFAIK, NUMA nodes may contain memory, CPU(s), or I/O -- any one, two, or
>> three, without the other types of resources being present.
>>
> 
> Sure, I will drop "the" in v4.
> 
> The NUMA nodes here are memory nodes here. Since the NUMA node usually means
> memory node. I'm not sure if I change the term "NUMA node" to "NUMA memory
> node" in v4. If you agree, I would have something like this:
> 
> Note that empty memory nodes, which no memory resides in, are allowed.
> The NUMA node IDs in these empty memory nodes are still valid, but memory
> can be added into them through hotplug afterwards.

OK, that sounds fine to me.

thanks.
-- 
~Randy

