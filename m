Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C961D32D887
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbhCDRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:23:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234267AbhCDRX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614878521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQatpNWGE4o3s3KgiODLTmG3DHd1ZX49JLUXKjotVm8=;
        b=ZOswHyuHCU5lPaTzMSZuXGiUbueFuhjWecwqQ6jzOqycr9Xt+k1GA+dXEP+Ed5kWVRfxgL
        e6o2CZEo66UAmLcxeIvHtXlP9+aDfGDD9t4NMVX1YC5IveWzlU4IteIgp7uRJ4tXfa+PZh
        MFvXj+llBUtio3udy6ME6fmE69OuNMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-wh0zyP4bOgaH95Tsff0Ryw-1; Thu, 04 Mar 2021 12:21:58 -0500
X-MC-Unique: wh0zyP4bOgaH95Tsff0Ryw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBC8E19057A1;
        Thu,  4 Mar 2021 17:21:56 +0000 (UTC)
Received: from [10.36.113.171] (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5D51002393;
        Thu,  4 Mar 2021 17:21:55 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: suppress wrong warning info when alloc
 gigantic page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Chen Wandun <chenwandun@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210219123909.13130-1-chenwandun@huawei.com>
 <46e76ac3-def1-80d4-14f1-61f7cd00d033@oracle.com>
 <cf79e9a4-72ba-8fa0-0710-5e82a5b5e4d5@redhat.com>
 <2cb384b9-1301-59a8-f678-c67ee26053b3@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <17c958bc-d421-f48b-a07a-bf22afc32d33@redhat.com>
Date:   Thu, 4 Mar 2021 18:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <2cb384b9-1301-59a8-f678-c67ee26053b3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.21 18:20, Mike Kravetz wrote:
> On 3/4/21 1:35 AM, David Hildenbrand wrote:
>> On 19.02.21 20:14, Mike Kravetz wrote:
>>> On 2/19/21 4:39 AM, Chen Wandun wrote:
>>>> If hugetlb_cma is enabled, it will skip boot time allocation
>>>> when allocating gigantic page, that doesn't means allocation
>>>> failure, so suppress this warning info.
>>>>
>>>
>>> Normally the addition of warning messages is discouraged.  However, in
>>> this case the additional message provides value.  Why?
>>>
>>> Prior to the commit cf11e85fc08c, one could have a kernel command line
>>> that contains:
>>>
>>> hugepagesz=1G hugepages=16
>>>
>>> This would allocate 16 1G pages at boot time.
>>>
>>> After the commit, someone could specify a command line containing:
>>>
>>> hugepagesz=1G hugepages=16 hugetlb_cma=16G
>>>
>>> In this case, 16G of CMA will be reserved for 1G huge page allocations
>>> after boot time.  The parameter 'hugepages=16' is ignored, and the warning
>>> message is logged.  The warning message should only be logged when the
>>> kernel parameter 'hugepages=' is ignored.
>>>
>>> IMO, it make sense to log a warning if ignoring a user specified parameter.
>>> The user should not be attempting boot time allocation and CMA reservation
>>> for 1G pages.
>>>
>>> I do not think we should drop the warning as the it tells the user thay
>>> have specified two incompatible allocation options.
>>>
>>
>> I agree. It has value.
>>
> 
> Hi David,
> 
> Sorry my above reply was too quick as I did not take a close look at
> the code/patch.  See,
> 
> https://lore.kernel.org/mm-commits/YDAbeDsG7GhV6s6B@carbon.dhcp.thefacebook.com/
> 
> This patch is actually in Andrew's tree.
> 

Oh, I missed that discussion - thanks for the pointer!

-- 
Thanks,

David / dhildenb

