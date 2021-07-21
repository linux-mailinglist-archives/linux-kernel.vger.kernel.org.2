Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA13D0CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbhGUJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:46:46 -0400
Received: from foss.arm.com ([217.140.110.172]:50854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238684AbhGUJhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:37:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2444731B;
        Wed, 21 Jul 2021 03:17:47 -0700 (PDT)
Received: from [10.163.64.235] (unknown [10.163.64.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB6EA3F694;
        Wed, 21 Jul 2021 03:17:44 -0700 (PDT)
Subject: Re: [PATCH v3 12/12] mm/debug_vm_pgtable: Fix corrupted page flag
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-13-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <57cb2f04-b3f2-2df4-3d9b-0b430b9c9f3e@arm.com>
Date:   Wed, 21 Jul 2021 15:48:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210719130613.334901-13-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 6:36 PM, Gavin Shan wrote:
> In page table entry modifying tests, set_xxx_at() are used to populate
> the page table entries. On ARM64, PG_arch_1 is set to the target page
> flag if execution permission is given. The page flag is kept when the
> page is free'd to buddy's free area list. However, it will trigger page
> checking failure when it's pulled from the buddy's free area list, as
> the following warning messages indicate.
> 
>    BUG: Bad page state in process memhog  pfn:08000
>    page:0000000015c0a628 refcount:0 mapcount:0 \
>         mapping:0000000000000000 index:0x1 pfn:0x8000
>    flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
>    raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
>    raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>    page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
> 
> This fixes the issue by clearing PG_arch_1 through flush_dcache_page()
> after set_xxx_at() is called.

Could you please add comments before each flush_dcache_page() instance
explaining why this is needed for arm64 platforms with relevant PG_arch_1
context and how this does not have any adverse effect on other platforms ?
It should be easy for some one looking at this code after a while to figure
out from where flush_dcache_page() came from.
