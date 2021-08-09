Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE853E40EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhHIHmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233467AbhHIHmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628494900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKDuFOXcudRR7I95TUwGAE5VyDFCMtB+gvkbBiNEmAE=;
        b=WJhSspK6qpPJArjXVec1o/hiQhR6anLKI/6v966QT6vHvtj0mfKx+cxYBVyYaaS/edi+47
        6Yjh2MTdsaO0kj872q4KI2uLM/73i4xdk038QUvX9sFPFq6c3pWbyNPp0X5z1Z6W4jIHMg
        anhtMAeGmLls0rpiXR+ByrG5lxQel1w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-byWFYvCAMVyewqATwbWLDw-1; Mon, 09 Aug 2021 03:41:38 -0400
X-MC-Unique: byWFYvCAMVyewqATwbWLDw-1
Received: by mail-wm1-f71.google.com with SMTP id o26-20020a05600c511ab0290252d0248251so4326954wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 00:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EKDuFOXcudRR7I95TUwGAE5VyDFCMtB+gvkbBiNEmAE=;
        b=JesS22p67taahBCE2xRh5tEMerU0tKy4aIB5Y9wLmXIP7biu2WVyR9m4ynVbcn+43w
         cSFx/2UgUddDWkDayBbg5Rj0TG87UKeBAY55CNi3W+kihuqGucl/5kxOdGIcB9GPSO94
         s9CbNtWbBKVsZ1puUv6T6pK+8cnT9VywIwfg6TTqy4w4RDPRMYZqxJD7CqFd/G0UHLLk
         raiOsGvNax3NIpeh86YaQ/dvEpwFGQ2pUJP40BpUtPc9+p6mhU8z7CNhCazziEE7bhE2
         +cdoRr7jHhnnvfXaoS+B3z+lMxFXqZacRO4g5nxWUJgr2gWAO5vyrLPqEZ1HWUTGerFx
         3x/g==
X-Gm-Message-State: AOAM530Km4ZkwfSvZAzX4w/PiJRfRxOfEpboZA71Svp+9OGQG8tvStFg
        MPCIe4dOJlXdJhpeqL6jN/T58uIolbaxbH/vo4Ka0ZIwOBqJV3VagxMNyydzxPGKJYI/LiIuxmr
        YNu19fwBZrW3DId7R/T7WmKF5rtbi/XGDppFAgsb0Ki8qtPsbhqDyW67SnCVfzu/a4gzYTfFA
X-Received: by 2002:a05:600c:2248:: with SMTP id a8mr10951232wmm.80.1628494896864;
        Mon, 09 Aug 2021 00:41:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBjfqegUXUj0G3xjeCjq++n5NBqn1S/Z5VUnLcosVs95+fyJXmZVKh5wXsx6d1EodG9WjJuA==
X-Received: by 2002:a05:600c:2248:: with SMTP id a8mr10951214wmm.80.1628494896660;
        Mon, 09 Aug 2021 00:41:36 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id c190sm16925787wma.21.2021.08.09.00.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 00:41:36 -0700 (PDT)
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20210805190253.2795604-1-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time
 parameter.
Message-ID: <28b57903-fae6-47ac-7e1b-a1dd41421349@redhat.com>
Date:   Mon, 9 Aug 2021 09:41:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805190253.2795604-1-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.21 21:02, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset add support for kernel boot time adjustable MAX_ORDER, so that
> user can change the largest size of pages obtained from buddy allocator. It also
> removes the restriction on MAX_ORDER based on SECTION_SIZE_BITS, so that
> buddy allocator can merge PFNs across memory sections when SPARSEMEM_VMEMMAP is
> set. It is on top of v5.14-rc4-mmotm-2021-08-02-18-51.
> 
> Motivation
> ===
> 
> This enables kernel to allocate 1GB pages and is necessary for my ongoing work
> on adding support for 1GB PUD THP[1]. This is also the conclusion I came up with
> after some discussion with David Hildenbrand on what methods should be used for
> allocating gigantic pages[2], since other approaches like using CMA allocator or
> alloc_contig_pages() are regarded as suboptimal.
> 
> This also prevents increasing SECTION_SIZE_BITS when increasing MAX_ORDER, since
> increasing SECTION_SIZE_BITS is not desirable as memory hotadd/hotremove chunk
> size will be increased as well, causing memory management difficulty for VMs.
> 
> In addition, make MAX_ORDER a kernel boot time parameter can enable user to
> adjust buddy allocator without recompiling the kernel for their own needs, so
> that one can still have a small MAX_ORDER if he/she does not need to allocate
> gigantic pages like 1GB PUD THPs.
> 
> Background
> ===
> 
> At the moment, kernel imposes MAX_ORDER - 1 + PAGE_SHFIT < SECTION_SIZE_BITS
> restriction. This prevents buddy allocator merging pages across memory sections,
> as PFNs might not be contiguous and code like page++ would fail. But this would
> not be an issue when SPARSEMEM_VMEMMAP is set, since all struct page are
> virtually contiguous. In addition, as long as buddy allocator checks the PFN
> validity during buddy page merging (done in Patch 3), pages allocated from
> buddy allocator can be manipulated by code like page++.
> 
> 
> Description
> ===
> 
> I tested the patchset on both x86_64 and ARM64 at 4KB, 16KB, and 64KB base
> pages. The systems boot and ltp mm test suite finished without issue. Also
> memory hotplug worked on x86_64 when I tested. It definitely needs more tests
> and reviews for other architectures.
> 
> In terms of the concerns on performance degradation if MAX_ORDER is increased,
> I did some initial performance tests comparing MAX_ORDER=11 and MAX_ORDER=20 on
> x86_64 machines and saw no performance difference[3].
> 
> Patch 1 excludes MAX_ORDER check from 32bit vdso compilation. The check uses
> irrelevant 32bit SECTION_SIZE_BITS during 64bit kernel compilation. The
> exclusion does not break the check in 32bit kernel, since the check will still
> be performed during other kernel component compilation.
> 
> Patch 2 gives FORCE_MAX_ZONEORDER a better name.
> 
> Patch 3 restores the pfn_valid_within() check when buddy allocator can merge
> pages across memory sections. The check was removed when ARM64 gets rid of holes
> in zones, but holes can appear in zones again after this patchset.
> 
> Patch 4-11 convert the use of MAX_ORDER to SECTION_SIZE_BITS or its derivative
> constants, since these code places use MAX_ORDER as boundary check for
> physically contiguous pages, where SECTION_SIZE_BITS should be used. After this
> patchset, MAX_ORDER can go beyond SECTION_SIZE_BITS, the code can break.
> I separate changes to different patches for easy review and can merge them into
> a single one if that works better.
> 
> Patch 12 adds a new Kconfig option SET_MAX_ORDER to allow specifying MAX_ORDER
> when ARCH_FORCE_MAX_ORDER is not used by the arch, like x86_64.
> 
> Patch 13 converts statically allocated arrays with MAX_ORDER length to dynamic
> ones if possible and prepares for making MAX_ORDER a boot time parameter.
> 
> Patch 14 adds a new MIN_MAX_ORDER constant to replace soon-to-be-dynamic
> MAX_ORDER for places where converting static array to dynamic one is causing
> hassle and not necessary, i.e., ARM64 hypervisor page allocation and SLAB.
> 
> Patch 15 finally changes MAX_ORDER to be a kernel boot time parameter.
> 
> 
> Any suggestion and/or comment is welcome. Thanks.
> 
> 
> TODO
> ===
> 
> 1. Redo the performance comparison tests using this patchset to understand the
>     performance implication of changing MAX_ORDER.


2. Make alloc_contig_range() cleanly deal with pageblock_order instead 
of MAX_ORDER - 1 to not force the minimal CMA area size/alignment to be 
e.g., 1 GiB instead of 4 MiB and to keep virtio-mem working as expected.

virtio-mem short term would mean disallowing initialization when an 
incompatible setup (MAX_ORDER_NR_PAGE > SECTION_NR_PAGES) is detected 
and bailing out loud that the admin has to fix that on the command line. 
I have optimizing alloc_contig_range() on my todo list, to get rid of 
the MAX_ORDER -1 dependency in virtio-mem; but I have no idea when I'll 
have time to work on that.


-- 
Thanks,

David / dhildenb

