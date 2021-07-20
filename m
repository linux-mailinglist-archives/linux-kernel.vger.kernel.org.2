Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3913B3CF4AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbhGTGBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:01:45 -0400
Received: from foss.arm.com ([217.140.110.172]:51492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236403AbhGTGBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:01:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75DD1FB;
        Mon, 19 Jul 2021 23:41:48 -0700 (PDT)
Received: from [10.163.66.175] (unknown [10.163.66.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F1CA3F73D;
        Mon, 19 Jul 2021 23:41:46 -0700 (PDT)
Subject: Re: [PATCH v2 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719054138.198373-1-gshan@redhat.com>
 <20210719054138.198373-2-gshan@redhat.com>
 <8d754894-5c21-1287-82b6-7ac3b064af3d@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ff9766a5-3f4e-f821-daf1-b2779a8c81fc@arm.com>
Date:   Tue, 20 Jul 2021 12:12:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8d754894-5c21-1287-82b6-7ac3b064af3d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 6:31 PM, Gavin Shan wrote:
>> +    if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +        has_transparent_hugepage()) {
>> +        page = alloc_pages(GFP_KERNEL, HPAGE_PMD_ORDER);
>> +        if (page) {
>> +            args->pmd_pfn = page_to_pfn(page);
>> +            args->pte_pfn = args->pmd_pfn;
>> +            return 0;
>> +        }
>> +    }
>> +
> 
> As syzbot reported against v1 series, we could allocate pages larger than (1 << (MAX_ORDER - 1)) here.
> So __GFP_NOWARN is needed here. I will fix it in v3 series.

I could find the following build error reported from lkp on V2.

mm/debug_vm_pgtable.c:445:8: warning: variable 'pud' set but not used [-Wunused-but-set-variable]

Could you please point to the syzbot reported problem on V1 as you
have mentioned above. Are there configs where HPAGE_[PMD|PUD]_ORDER
is greater than (MAX_ORDER - 1) ? If yes, how adding __GFP_NOWARN
solves the problem ?
