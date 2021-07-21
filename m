Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA23D0E90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbhGULYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238672AbhGULWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626869010;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIoWBvZyQ1nQ5eQbYUUlt0BMPpJi6szuMaY9eqlGLvI=;
        b=KPAd5gKUOSj5/qqCLVI8byUYEbsrI50VKu9QRHtZmxHdCv/2BevVYD2hxNZ3OLQn0lRFjo
        mKfVW7BeaNCSMCPNDWeCuNyRQDpl0YAJKE7V5wiok6lOQjaf5jDxY3QQgUlsYx+Wbx2XRu
        pGaFHVfrQrQGTEIDRB+2HF2u9qpp9Ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-vSzVV2NFMBureCNAwWT2rg-1; Wed, 21 Jul 2021 08:03:27 -0400
X-MC-Unique: vSzVV2NFMBureCNAwWT2rg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B465E1084F55;
        Wed, 21 Jul 2021 12:03:25 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33E235C1BB;
        Wed, 21 Jul 2021 12:03:21 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 12/12] mm/debug_vm_pgtable: Fix corrupted page flag
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-13-gshan@redhat.com>
 <57cb2f04-b3f2-2df4-3d9b-0b430b9c9f3e@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <8157142c-58e0-44c4-5cdb-76fff4a07210@redhat.com>
Date:   Wed, 21 Jul 2021 22:03:39 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <57cb2f04-b3f2-2df4-3d9b-0b430b9c9f3e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/21/21 8:18 PM, Anshuman Khandual wrote:
> On 7/19/21 6:36 PM, Gavin Shan wrote:
>> In page table entry modifying tests, set_xxx_at() are used to populate
>> the page table entries. On ARM64, PG_arch_1 is set to the target page
>> flag if execution permission is given. The page flag is kept when the
>> page is free'd to buddy's free area list. However, it will trigger page
>> checking failure when it's pulled from the buddy's free area list, as
>> the following warning messages indicate.
>>
>>     BUG: Bad page state in process memhog  pfn:08000
>>     page:0000000015c0a628 refcount:0 mapcount:0 \
>>          mapping:0000000000000000 index:0x1 pfn:0x8000
>>     flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
>>     raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
>>     raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>>     page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
>>
>> This fixes the issue by clearing PG_arch_1 through flush_dcache_page()
>> after set_xxx_at() is called.
> 
> Could you please add comments before each flush_dcache_page() instance
> explaining why this is needed for arm64 platforms with relevant PG_arch_1
> context and how this does not have any adverse effect on other platforms ?
> It should be easy for some one looking at this code after a while to figure
> out from where flush_dcache_page() came from.
> 

Good point. I will improve chage log to include the commit ID in v4 where the
page flag (PG_arch_1) is used and explain how. In that case, it's much clearer
to understand the reason why we need flush_dcache_page() after set_xxx_at() on
ARM64.

Thanks,
Gavin

