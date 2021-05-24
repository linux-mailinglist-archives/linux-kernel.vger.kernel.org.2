Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBBD38E6CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhEXMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232371AbhEXMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621860241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbivfGwbAhsgULM6quDs35DJY7OTXofKsxhLnAK0xUE=;
        b=TV1kg9QDHI7r2eZVLFXeBOqWgFzbR+HFcQDyeJnxnozHbZ6XRDAhwBVSLQ1UlJDglassTv
        iNbI577zU5MaxkCsftX7/lUwNiF8bsl8+nXTT+HPWEwnU76QZ6Cx3Cjck/gPDacGX88xrN
        NiUow8beMIP0Q3Sdaui/2V/Tvd45vUE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Njoy2nyvNiq69Qd3t9dqYg-1; Mon, 24 May 2021 08:43:59 -0400
X-MC-Unique: Njoy2nyvNiq69Qd3t9dqYg-1
Received: by mail-ej1-f72.google.com with SMTP id bw21-20020a170906c1d5b02903df8cbe09ccso713888ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UbivfGwbAhsgULM6quDs35DJY7OTXofKsxhLnAK0xUE=;
        b=ZxeGrQjhg3XdJSrRX9EktNEQ0B+BhJ8ErpKk/6ew8GCwwyw+eY3iffhJz2wN6uCv1/
         sIKcRF2uoFI6dzyu9o9DjWAJjjZJq7c+acbfQE1GoxOzVa3HKtdezr0QxGjiKIZdGF38
         KrM2YSd1K2cN/H1kkeQU1dBdI91TZGXq4xYuizzpXu476QmShtpOfTmq2DLKwQAhXSYX
         CThJydDk3z+QN/x1QzN9lSs0ABVGDKJWJh6uc2rKXNgb6hfUJqP/jmU70uyd2na8GPkH
         qFzv/2MDLg4EfISp6jj3ygJlR/5lESy1KwoVhWgkxJOB5gwr7QoOQUKyd8roEFKEk4Jq
         nT1A==
X-Gm-Message-State: AOAM532Xh19ODAL+AQI/6r4FUMyBI2wFyV85ksvl5wQxxtRjw9mwppwt
        VDOBXF4XITwUIaSiTDUMBgb72SZAWZRfDIegBeNne9rjthy6riKRr35GCQqTBC+8ajdleWJGjy+
        pa7f+OqYByPVI5LjmUtgBWebI
X-Received: by 2002:aa7:ca10:: with SMTP id y16mr24950886eds.280.1621860238474;
        Mon, 24 May 2021 05:43:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAF2QStbIRjkz0M4bV4sNJWomerCznJQK325bD7BNUHka9iswFnKIWWCqHKgftjQ2j26PeSQ==
X-Received: by 2002:aa7:ca10:: with SMTP id y16mr24950868eds.280.1621860238287;
        Mon, 24 May 2021 05:43:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x16sm7750849eju.30.2021.05.24.05.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 05:43:57 -0700 (PDT)
Subject: Re: [PATCH v5 0/7] Lazily allocate memslot rmaps
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>
References: <20210518173414.450044-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85bdd768-d7a3-100c-aade-ef5910b6e729@redhat.com>
Date:   Mon, 24 May 2021 14:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518173414.450044-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/21 19:34, Ben Gardon wrote:
> This series enables KVM to save memory when using the TDP MMU by waiting
> to allocate memslot rmaps until they are needed. To do this, KVM tracks
> whether or not a shadow root has been allocated. In order to get away
> with not allocating the rmaps, KVM must also be sure to skip operations
> which iterate over the rmaps. If the TDP MMU is in use and we have not
> allocated a shadow root, these operations would essentially be op-ops
> anyway. Skipping the rmap operations has a secondary benefit of avoiding
> acquiring the MMU lock in write mode in many cases, substantially
> reducing MMU lock contention.
> 
> This series was tested on an Intel Skylake machine. With the TDP MMU off
> and on, this introduced no new failures on kvm-unit-tests or KVM selftests.
> 
> Changelog:
> v2:
> 	Incorporated feedback from Paolo and Sean
> 	Replaced the memslot_assignment_lock with slots_arch_lock, which
> 	has a larger critical section.
> 
> v3:
> 	Removed shadow_mmu_active as suggested by Sean
> 	Removed everything except adding a return value to
> 	kvm_mmu_init_tdp_mmu from patch 1 of v2
> 	Added RCU protection and better memory ordering for installing the
> 	memslot rmaps as suggested by Paolo
> 	Reordered most of the patches
> 
> v4:
> 	Renamed functions to allocate and free memslots based on feedback
> 	from David.
> 	Eliminated the goto in memslot_rmap_alloc, as David suggested.
> 	Eliminated kvm_memslots_have_rmaps and updated comments on uses of
> 	memslots_have_rmaps. Suggested by Paolo.
> 	Changed the description on patch 7 to one Paolo suggested.
> 	Collected Reviewed-by tags from David.
> 	Dropped the patch to add RCU notations to rmap accesses.
> 
> v5:
> 	Responding to comments from Sean.
> 	Improved comments
> 	Swapped args to kvm_copy_memslots to match memcpy
> 	Fixed some line wrap and declaration style issues
> 	No longer check if memslots have rmaps before operations which
> 	iterate through active_mmu_pages
> 	Re-added the kvm_memslots_have_rmaps helper
> 	Fixed a couple missing unlocks for the slots_arch_lock

Queued (with minor conflicts), thanks!

Paolo

