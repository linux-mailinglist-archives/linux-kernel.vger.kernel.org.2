Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D803D1E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhGVGOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 02:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229547AbhGVGOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626936905;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQVCng+li2VqCvgwwVsr3N15LvPWZJi5vTPPAqH9HhU=;
        b=dPSXu9bcIvhLHQhvhhPn8Y+PJowxe5qF+b7YADdEcp6V9ntlFHe9145SlEfsIxJ3nmXok3
        dbm3nsi00cN4Ms5P4IoZv9gl52IUfph5z6WBVFkTIkj4bn3kVaGOs4eHY1HmUvJYCISwmV
        PK4N7cs1aJxXwu/tLOtOpnxY8QagTzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-rthJiOKuO3OmSpSyAJQ-6A-1; Thu, 22 Jul 2021 02:55:01 -0400
X-MC-Unique: rthJiOKuO3OmSpSyAJQ-6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2765100D3A9;
        Thu, 22 Jul 2021 06:54:14 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E92A19D7C;
        Thu, 22 Jul 2021 06:54:11 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 12/12] mm/debug_vm_pgtable: Fix corrupted page flag
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-13-gshan@redhat.com>
 <57cb2f04-b3f2-2df4-3d9b-0b430b9c9f3e@arm.com>
 <8157142c-58e0-44c4-5cdb-76fff4a07210@redhat.com>
 <5db75fd6-aeb9-c06f-30ab-839c09a0bc68@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <5d9f2080-7020-d3f0-73cc-ae2af0943303@redhat.com>
Date:   Thu, 22 Jul 2021 16:54:29 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <5db75fd6-aeb9-c06f-30ab-839c09a0bc68@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/22/21 1:51 PM, Anshuman Khandual wrote:
> Small nit:
> 
> s/Fix corrupted page flag/Fix page flag corruption on arm64/
> 

Sure, The replacement will be applied in v4, thanks!

> On 7/21/21 5:33 PM, Gavin Shan wrote:
>> Hi Anshuman,
>>
>> On 7/21/21 8:18 PM, Anshuman Khandual wrote:
>>> On 7/19/21 6:36 PM, Gavin Shan wrote:
>>>> In page table entry modifying tests, set_xxx_at() are used to populate
>>>> the page table entries. On ARM64, PG_arch_1 is set to the target page
>>>> flag if execution permission is given. The page flag is kept when the
>>>> page is free'd to buddy's free area list. However, it will trigger page
>>>> checking failure when it's pulled from the buddy's free area list, as
>>>> the following warning messages indicate.
>>>>
>>>>      BUG: Bad page state in process memhog  pfn:08000
>>>>      page:0000000015c0a628 refcount:0 mapcount:0 \
>>>>           mapping:0000000000000000 index:0x1 pfn:0x8000
>>>>      flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
>>>>      raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
>>>>      raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>>>>      page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
>>>>
>>>> This fixes the issue by clearing PG_arch_1 through flush_dcache_page()
>>>> after set_xxx_at() is called.
>>>
>>> Could you please add comments before each flush_dcache_page() instance
>>> explaining why this is needed for arm64 platforms with relevant PG_arch_1
>>> context and how this does not have any adverse effect on other platforms ?
>>> It should be easy for some one looking at this code after a while to figure
>>> out from where flush_dcache_page() came from.
>>>
>>
>> Good point. I will improve chage log to include the commit ID in v4 where the
>> page flag (PG_arch_1) is used and explain how. In that case, it's much clearer
>> to understand the reason why we need flush_dcache_page() after set_xxx_at() on
>> ARM64.
> 
> But also some in code comments where flush_dcache_page() is being called.
> 

Yes, I will add some comments where flush_dcache_page() is called in v4.

Thanks,
Gavin

