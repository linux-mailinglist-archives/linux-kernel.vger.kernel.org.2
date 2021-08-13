Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911FF3EB34E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbhHMJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239544AbhHMJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628846731;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/u8LYZUFfXpTFUk/tewCuf2wr2VOqPNaLEeEv38oPr4=;
        b=Ro0E+HFqhPI2r0QKTUgAinSKQdGzVquHZVxx3eJon6t7wln1ZkUUOe/ZZOI2WeH45iCuIs
        bsjk2Rk6CHe2f6tyAHzDCwOCycWMU462ax+k7t1etZJmj+cmiEeQGjP0O4jGRlIdkoFQCp
        0BNJJsHqI1dM+XAy+12tpdVPvDR1NNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-54wTLrrfP-yUVfPFUBdowA-1; Fri, 13 Aug 2021 05:25:29 -0400
X-MC-Unique: 54wTLrrfP-yUVfPFUBdowA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FF95801AEB;
        Fri, 13 Aug 2021 09:25:12 +0000 (UTC)
Received: from [10.64.54.103] (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00EA7687D5;
        Fri, 13 Aug 2021 09:25:06 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 00/12] mm/debug_vm_pgtable: Enhancements
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Vineet Gupta <vgupta@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        vgupta@synopsys.com, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210809092631.1888748-1-gshan@redhat.com>
 <b066aea5-6b3e-193a-01d0-32b52d5ac513@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <d96fa0d8-98d8-c924-99f7-bb9673fc2a13@redhat.com>
Date:   Fri, 13 Aug 2021 19:25:01 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <b066aea5-6b3e-193a-01d0-32b52d5ac513@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman and Vineet,

On 8/12/21 9:11 PM, Anshuman Khandual wrote:
> On 8/9/21 2:56 PM, Gavin Shan wrote:
>> There are couple of issues with current implementations and this series
>> tries to resolve the issues:
>>
>>    (a) All needed information are scattered in variables, passed to various
>>        test functions. The code is organized in pretty much relaxed fashion.
>>
>>    (b) The page isn't allocated from buddy during page table entry modifying
>>        tests. The page can be invalid, conflicting to the implementations
>>        of set_xxx_at() on ARM64. The target page is accessed so that the
>>        iCache can be flushed when execution permission is given on ARM64.
>>        Besides, the target page can be unmapped and accessing to it causes
>>        kernel crash.
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
>> v6:
>>     * Populate saved page table entry pointers after
>>       they're allocated in init_args()                        (Anshuman)
>>     * Fix imbalanced preemption count issue by replacing
>>       pte_alloc_mmap() with pte_alloc() in init_args()        (syzbot)
> 
> + vgupta@kernel.org
> 
> Hello Gavin/Vineet,
> 
> This series still need to be tested on ARC ?
> 

Yes, I'm unable to test ARC as it's not supported by QEMU yet.
It would great if Vineet can give it a try on ARC :)

Thanks,
Gavin

