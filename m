Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8813DCE42
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 02:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhHBAJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 20:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230368AbhHBAJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 20:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627862941;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zCcZUC7jKcLM4i9cUzwtGUYcu7sQ5TzmnJ5PKQDk7Q=;
        b=dmQT4elql0ZmR4SjDOWsZNxQQB7QTYAYp6ZN1ebqlGzqqxysz8BnQaazjvK0fDER7UvJRw
        KsxCsPQayegya6cUoUdoFYW/1Djenu1Q6j+KLldk9yp47VuLsul+56zgnU9nkJMKrowlqD
        UyO3C6vubmiCQ02lQlrUuVfkWlM/mcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-3JfPNNsDMj6u2KhsKB_0Bg-1; Sun, 01 Aug 2021 20:08:58 -0400
X-MC-Unique: 3JfPNNsDMj6u2KhsKB_0Bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0FD387D542;
        Mon,  2 Aug 2021 00:08:55 +0000 (UTC)
Received: from [10.64.54.184] (vpn2-54-184.bne.redhat.com [10.64.54.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DDA85F707;
        Mon,  2 Aug 2021 00:08:50 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 00/12] mm/debug_vm_pgtable: Enhancements
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <8b969a2a-a883-3ce2-fac4-70ac2e3fd157@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <05736d94-3bd1-3193-69b1-3c71aa22d0a7@redhat.com>
Date:   Mon, 2 Aug 2021 10:09:03 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <8b969a2a-a883-3ce2-fac4-70ac2e3fd157@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/29/21 5:14 PM, Anshuman Khandual wrote:
> On 7/27/21 11:43 AM, Gavin Shan wrote:
>> There are couple of issues with current implementations and this series
>> tries to resolve the issues:
>>
>>    (a) All needed information are scattered in variables, passed to various
>>        test functions. The code is organized in pretty much relaxed fashion.
>>
>>    (b) The page isn't allocated from buddy during page table entry modifying
>>        tests. The page can be invalid, conflicting to the implementations
>>        of set_xxx_at() on ARM64. The target page is accessed so that the iCache
>>        can be flushed when execution permission is given on ARM64. Besides,
>>        the target page can be unmapped and access to it causes kernel crash.
>>
>> "struct pgtable_debug_args" is introduced to address issue (a). For issue
>> (b), the used page is allocated from buddy in page table entry modifying
>> tests. The corresponding tets will be skipped if we fail to allocate the
>> (huge) page. For other test cases, the original page around to kernel
>> symbol (@start_kernel) is still used.
>>
>> The patches are organized as below. PATCH[2-10] could be combined to one
>> patch, but it will make the review harder:
>>
>>    PATCH[1] introduces "struct pgtable_debug_args" as place holder of all
>>             needed information. With it, the old and new implementation
>>             can coexist.
>>    PATCH[2-10] uses "struct pgtable_debug_args" in various test functions.
>>    PATCH[11] removes the unused code for old implementation.
>>    PATCH[12] fixes the issue of corrupted page flag for ARM64
>>
>> Changelog
>> =========
>> v4:
>>     * Determine the page allocation method according to
>>       MAX_ORDER                                                   (Anshuman)
>>     * Move existing comments to init_args()                       (Anshuman)
>>     * Code refactoring as suggested by Anshuman                   (Anshuman)
>>     * Improved commit log and add comments for flush_dcache_page()
>>       in PATCH[v4 12/12]                                          (Anshuman)
>>     * Address misc comments                                       (Anshuman
> 
> This series builds ok on all supported platforms but should also be tested
> on them as well i.e s390, ppc, arc and riscv. I was able to do some tests
> on arm64 and x86 platforms.
> 

I had tests on the platforms except arc as it's not supported by QEMU yet.
The test is pretty simple to boot the kernel and see if there is any warning
raised from mm/debug_vm_pgtable. Everything looks good.

The test was done on v5, which will be posted pretty soon. Thanks again for
your continuous review.

Thanks,
Gavin

