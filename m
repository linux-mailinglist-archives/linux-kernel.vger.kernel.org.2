Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32F8383B50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbhEQRcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:32:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236191AbhEQRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:32:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HH4KnP012861;
        Mon, 17 May 2021 13:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gG7poeajwHzo+ksfNup3ImS74+kfbrcfZHeo+UFoZ5E=;
 b=OvENhqYULWV7sHVO7zVPPD8NMCfiyVOUeI4FU03Yfgv/UedyCJvezlwxR4UH5oJZt2bF
 vGHvZfccOEm3tdh91cG9kzzhWjtUFF+tycxi7DCmYwpc0ZfrMhAhYZYCvtyTNVt1QDOx
 Tg8XqjF41iFbaSkQovoZfDLBp/d5YcdQIU+F0IaH7fUL10A5NrDVdtc8c+Bc2HukAjnk
 jj1Ee2hYZJKV80yewqLkDKljkOB6jegKCnYRly1SekOIjdbLQDsrXWg0a6fmq60nBUZf
 +4y/H1vmalJo+hACrmIuPS6JsucAk86oejPMKTQ2crsuNuxi19Tm+22G3r0q1ckM6Her jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38kux11r79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 13:28:44 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14HHAY6p040100;
        Mon, 17 May 2021 13:28:44 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38kux11r6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 13:28:43 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14HHSJc9006489;
        Mon, 17 May 2021 17:28:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 38j5x88j9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 17:28:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14HHSBWl26411268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 17:28:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7A74AE04D;
        Mon, 17 May 2021 17:28:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4514AAE045;
        Mon, 17 May 2021 17:28:38 +0000 (GMT)
Received: from pomme.local (unknown [9.145.23.115])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 May 2021 17:28:38 +0000 (GMT)
Subject: Re: [PATCH 00/21] mm: Add vma_lookup()
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <1edcdd6f-af3b-560f-d10f-cbae5e911ea1@linux.ibm.com>
Date:   Mon, 17 May 2021 19:28:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MlzrHFys5fWFRUVkyzsZUTB7RcWxBbxb
X-Proofpoint-ORIG-GUID: CautskajhkVrfu9qOgO9i4j0PLTrA43u
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_06:2021-05-17,2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/05/2021 à 18:58, Liam Howlett a écrit :
> Many places in the kernel use find_vma() to get a vma and then check the
> start address of the vma to ensure the next vma was not returned.
> 
> Other places use the find_vma_intersection() call with add, addr + 1 as
> the range; looking for just the vma at a specific address.
> 
> The third use of find_vma() is by developers who do not know that the
> function starts searching at the provided address upwards for the next
> vma.  This results in a bug that is often overlooked for a long time.
> 
> Adding the new vma_lookup() function will allow for cleaner code by
> removing the find_vma() calls which check limits, making
> find_vma_intersection() calls of a single address to be shorter, and
> potentially reduce the incorrect uses of find_vma().
> 
> This patch set was originally part of the maple tree patch set.

FWIW, for the whole series:

Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>


> Changes since being broken out on its own:
> - Changed initial implementation of vma_lookup() to use find_vma() as requested
>    by Michel Lespinasse.
> - Updated commit comments to be more descriptive
> 
> These patches are based on next-20210506
> 
> Liam R. Howlett (22):
>    mm: Add vma_lookup()
>    drm/i915/selftests: Use vma_lookup() in __igt_mmap()
>    arch/arc/kernel/troubleshoot: use vma_lookup() instead of find_vma()
>    arch/arm64/kvm: Use vma_lookup() instead of find_vma_intersection()
>    arch/powerpc/kvm/book3s_hv_uvmem: Use vma_lookup() instead of
>      find_vma_intersection()
>    arch/powerpc/kvm/book3s: Use vma_lookup() in
>      kvmppc_hv_setup_htab_rma()
>    arch/mips/kernel/traps: Use vma_lookup() instead of find_vma()
>    arch/m68k/kernel/sys_m68k: Use vma_lookup() in sys_cacheflush()
>    x86/sgx: Use vma_lookup() in sgx_encl_find()
>    virt/kvm: Use vma_lookup() instead of find_vma_intersection()
>    vfio: Use vma_lookup() instead of find_vma_intersection()
>    net/ipv5/tcp: Use vma_lookup() in tcp_zerocopy_receive()
>    drm/amdgpu: Use vma_lookup() in amdgpu_ttm_tt_get_user_pages()
>    media: videobuf2: Use vma_lookup() in get_vaddr_frames()
>    misc/sgi-gru/grufault: Use vma_lookup() in gru_find_vma()
>    kernel/events/uprobes: Use vma_lookup() in find_active_uprobe()
>    lib/test_hmm: Use vma_lookup() in dmirror_migrate()
>    mm/ksm: Use vma_lookup() in find_mergeable_vma()
>    mm/migrate: Use vma_lookup() in do_pages_stat_array()
>    mm/mremap: Use vma_lookup() in vma_to_resize()
>    mm/memory.c: Use vma_lookup() in __access_remote_vm()
>    mm/mempolicy: Use vma_lookup() in __access_remote_vm()
> 
>   arch/arc/kernel/troubleshoot.c                 |  8 ++++----
>   arch/arm64/kvm/mmu.c                           |  2 +-
>   arch/m68k/kernel/sys_m68k.c                    |  4 ++--
>   arch/mips/kernel/traps.c                       |  4 +---
>   arch/powerpc/kvm/book3s_hv.c                   |  4 ++--
>   arch/powerpc/kvm/book3s_hv_uvmem.c             |  2 +-
>   arch/x86/kernel/cpu/sgx/encl.h                 |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        |  4 ++--
>   .../gpu/drm/i915/gem/selftests/i915_gem_mman.c |  2 +-
>   drivers/media/common/videobuf2/frame_vector.c  |  2 +-
>   drivers/misc/sgi-gru/grufault.c                |  4 ++--
>   drivers/vfio/vfio_iommu_type1.c                |  2 +-
>   include/linux/mm.h                             | 18 ++++++++++++++++++
>   kernel/events/uprobes.c                        |  4 ++--
>   lib/test_hmm.c                                 |  5 ++---
>   mm/ksm.c                                       |  6 ++----
>   mm/memory.c                                    |  4 ++--
>   mm/mempolicy.c                                 |  2 +-
>   mm/migrate.c                                   |  4 ++--
>   mm/mremap.c                                    |  4 ++--
>   net/ipv4/tcp.c                                 |  4 ++--
>   virt/kvm/kvm_main.c                            |  2 +-
>   22 files changed, 54 insertions(+), 41 deletions(-)
> 

