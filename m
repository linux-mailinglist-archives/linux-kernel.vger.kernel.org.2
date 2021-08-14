Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33C3EBFFB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 04:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhHNC6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 22:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236466AbhHNC6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 22:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628909875;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZ/gidsl6OmROeOx/n9lMGdC7WafEvzvYpOK4Q3l9nc=;
        b=VBiPc7zSU7tXoe0FT9rAT6xHCdjFzLQR5Ndy467kf/gSChMp4szkY1oKgZB3kBHA79jsZq
        KqRqoHr1gf8287+LbcsR9rGmf2mmp0/Va/TMZeW6cVb+56fpSq6p1i7BTZNoLBVgxpjNRq
        RDIAr1Xu0iyZ1Gb1JupsOsmJXVIovZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-L-p7VCTxOcq4NrRI9XGaug-1; Fri, 13 Aug 2021 22:57:51 -0400
X-MC-Unique: L-p7VCTxOcq4NrRI9XGaug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB61F8030B7;
        Sat, 14 Aug 2021 02:57:49 +0000 (UTC)
Received: from [10.64.54.103] (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2097F5C1A1;
        Sat, 14 Aug 2021 02:57:41 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 00/12] mm/debug_vm_pgtable: Enhancements
To:     Vineet Gupta <vgupta@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com,
        arcml <linux-snps-arc@lists.infradead.org>
References: <20210809092631.1888748-1-gshan@redhat.com>
 <b066aea5-6b3e-193a-01d0-32b52d5ac513@arm.com>
 <d96fa0d8-98d8-c924-99f7-bb9673fc2a13@redhat.com>
 <25018384-acc5-dcf7-5125-378499ab4555@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <828d44a7-525f-c507-00d1-8e323c8956bc@redhat.com>
Date:   Sat, 14 Aug 2021 12:57:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <25018384-acc5-dcf7-5125-378499ab4555@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

On 8/14/21 5:43 AM, Vineet Gupta wrote:
> On 8/13/21 2:25 AM, Gavin Shan wrote:
>> On 8/12/21 9:11 PM, Anshuman Khandual wrote:
>>> On 8/9/21 2:56 PM, Gavin Shan wrote:
>>>> There are couple of issues with current implementations and this series
>>>> tries to resolve the issues:
>>>>
>>>>    (a) All needed information are scattered in variables, passed to various
>>>>        test functions. The code is organized in pretty much relaxed fashion.
>>>>
>>>>    (b) The page isn't allocated from buddy during page table entry modifying
>>>>        tests. The page can be invalid, conflicting to the implementations
>>>>        of set_xxx_at() on ARM64. The target page is accessed so that the
>>>>        iCache can be flushed when execution permission is given on ARM64.
>>>>        Besides, the target page can be unmapped and accessing to it causes
>>>>        kernel crash.
>>>>
>>>> "struct pgtable_debug_args" is introduced to address issue (a). For issue
>>>> (b), the used page is allocated from buddy in page table entry modifying
>>>> tests. The corresponding tets will be skipped if we fail to allocate the
>>>> (huge) page. For other test cases, the original page around to kernel
>>>> symbol (@start_kernel) is still used.
>>>>
>>>> The patches are organized as below. PATCH[2-10] could be combined to one
>>>> patch, but it will make the review harder:
>>>>
>>>>    PATCH[1] introduces "struct pgtable_debug_args" as place holder of all
>>>>             needed information. With it, the old and new implementation
>>>>             can coexist.
>>>>    PATCH[2-10] uses "struct pgtable_debug_args" in various test functions.
>>>>    PATCH[11] removes the unused code for old implementation.
>>>>    PATCH[12] fixes the issue of corrupted page flag for ARM64
>>>>
>>>> Changelog
>>>> =========
>>>> v6:
>>>>     * Populate saved page table entry pointers after
>>>>       they're allocated in init_args() (Anshuman)
>>>>     * Fix imbalanced preemption count issue by replacing
>>>>       pte_alloc_mmap() with pte_alloc() in init_args() (syzbot)
>>>
>>> + vgupta@kernel.org
> 
> Please also keep linux-snps-arc CC'ed for ARC changes.
> 

Sure.

>>>
>>> Hello Gavin/Vineet,
>>>
>>> This series still need to be tested on ARC ?
>>>
>>
>> Yes, I'm unable to test ARC as it's not supported by QEMU yet.
>> It would great if Vineet can give it a try on ARC :)
> 
> We do have a working QEMU (in the process of being upstreamed) you could try
> https://github.com/foss-for-synopsys-dwc-arc-processors/qemu #master
> 
> Is this code in some shared git repo we can pull - instead of apply 8 files.
> 

Here is repo with v6 series included. Please help to have
a try.

    https://github.com/gwshan/linux  # kvm/arm64_debug

I tried to build the cross-compiler with buildroot with following
2 repos. Unfortunately, none of them worked for me. The QEMU
binary can be built successfully with the provided repo though.


[1] git://github.com/foss-for-synopsys-dwc-arc-processors/buildroot.git
     (branch: master)

     There are build errors after choosing little-endian ARM from
     "make menuconfig"

[2] https://github.com/buildroot/buildroot
     (branch: master)

     The build is successful, but the kernel can't be built because
     of the following errors:
    
     # make ARCH=arc CROSS_COMPILE=arc-linux- axs103_smp_defconfig
     # make -j 40
        :
     LD      vmlinux.o
     arc-linux-ld: error: attempting to link /home/gavin/sandbox/buildroot/buildroot.arc/output/host/lib
     /gcc/arc-buildroot-linux-uclibc/10.2.0/libgcc.a(_muldi3.o) with a binary vmlinux.o of different
     architecture

Thanks,
Gavin

