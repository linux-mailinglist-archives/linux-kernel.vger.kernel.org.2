Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE232CFCE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhCDJhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:37:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237673AbhCDJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614850556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P1qJfzyEGRuuV0eDxn3pbmVD8vuajk2myHnjwQFS5/s=;
        b=E+xwZUUSx2KwIqA1crISHXF6y/2MNTqXMvXjgXw0ePI+T51xMt888Yv4ZOOElC1grD4+mJ
        1XSWTm0Gj6yFh7oxUfD8jIT9nhx1UpSHHEeGVM7U196oB5zbRM8UXjQkMuYp5UEwyFJQji
        dVeuYDYhsAkJUpEJV1jEsuBSk9N02Oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-q6eMNokkMuyGV7rcPv2jCQ-1; Thu, 04 Mar 2021 04:35:52 -0500
X-MC-Unique: q6eMNokkMuyGV7rcPv2jCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22852108BD0E;
        Thu,  4 Mar 2021 09:35:51 +0000 (UTC)
Received: from [10.36.113.171] (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B27470911;
        Thu,  4 Mar 2021 09:35:49 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: suppress wrong warning info when alloc
 gigantic page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Chen Wandun <chenwandun@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210219123909.13130-1-chenwandun@huawei.com>
 <46e76ac3-def1-80d4-14f1-61f7cd00d033@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <cf79e9a4-72ba-8fa0-0710-5e82a5b5e4d5@redhat.com>
Date:   Thu, 4 Mar 2021 10:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <46e76ac3-def1-80d4-14f1-61f7cd00d033@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.21 20:14, Mike Kravetz wrote:
> On 2/19/21 4:39 AM, Chen Wandun wrote:
>> If hugetlb_cma is enabled, it will skip boot time allocation
>> when allocating gigantic page, that doesn't means allocation
>> failure, so suppress this warning info.
>>
> 
> Normally the addition of warning messages is discouraged.  However, in
> this case the additional message provides value.  Why?
> 
> Prior to the commit cf11e85fc08c, one could have a kernel command line
> that contains:
> 
> hugepagesz=1G hugepages=16
> 
> This would allocate 16 1G pages at boot time.
> 
> After the commit, someone could specify a command line containing:
> 
> hugepagesz=1G hugepages=16 hugetlb_cma=16G
> 
> In this case, 16G of CMA will be reserved for 1G huge page allocations
> after boot time.  The parameter 'hugepages=16' is ignored, and the warning
> message is logged.  The warning message should only be logged when the
> kernel parameter 'hugepages=' is ignored.
> 
> IMO, it make sense to log a warning if ignoring a user specified parameter.
> The user should not be attempting boot time allocation and CMA reservation
> for 1G pages.
> 
> I do not think we should drop the warning as the it tells the user thay
> have specified two incompatible allocation options.
> 

I agree. It has value.

-- 
Thanks,

David / dhildenb

