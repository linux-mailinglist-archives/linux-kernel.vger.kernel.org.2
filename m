Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5850942654C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhJHHhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229820AbhJHHh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633678534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWJM4mde5WNZKPeQbiPbITXNzh/uwce4/rOsOzTt7kA=;
        b=hL3qQ5ahDkHo+cgI7KTE5UfSTYmHgYMPixeDlMYcwBXKXIE+nmPM2s1b/mppG9uias4Ucq
        zdpDGbOoNeGj4pdHPj9hoJpGL9B7cgI3seX6+DdFwWGnlW1M1uv3yvspxN7Yj5wbai9BFl
        yjOXHnhcKjFuaIUhQPljpF2P5+XgVN8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-mVVJJg3dPsa4NVjYlmGYjw-1; Fri, 08 Oct 2021 03:35:32 -0400
X-MC-Unique: mVVJJg3dPsa4NVjYlmGYjw-1
Received: by mail-wr1-f70.google.com with SMTP id r21-20020adfa155000000b001608162e16dso6573433wrr.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 00:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TWJM4mde5WNZKPeQbiPbITXNzh/uwce4/rOsOzTt7kA=;
        b=c+2Zmd9NzKpy7KISxbE/2/WTLzHUR73cFseT5aavINDLOinD4pPsGLYdIGpPFPza7N
         ecnprYhYqMluHkwyJHbbKapEaCbn5P+EHoW6tXbHAU69vcTeTvamkKrax5KmCEptomuo
         H16efRS1VyTp0oqf/lGi0tdBL9yrqHwAfmFWEkOMdmrOBSPYdW7aAAiu9t/1NGjM8jfj
         dldhBfPBli2p34t3E4zC6igCvgT6EQVB/5/PL3LFA+bjgkLP+kh61nI5fN8hzD7QpnIv
         EgZOlCYptEaLBcpCNQwlxil6PScbeXmmXjIEiZsCLMVwHWwbMb+NMadBDLf9UBvmjq6b
         YjHQ==
X-Gm-Message-State: AOAM533ut024E/73fDFARQxMeXybHl2IXTb5vOJ3kC/ean3lspv3a0p1
        B5UBdTsbWR9+SZjpQYFa8iVhxH5tnl3h5EHb8txQm7g4w8gAscCHWV+XC3UsDWBOomHSZqVyyEO
        DMJDaP6d6BSOqDbSeqZVD9rkw
X-Received: by 2002:a05:600c:1d1f:: with SMTP id l31mr1788498wms.44.1633678531020;
        Fri, 08 Oct 2021 00:35:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFkzTDe9ji1jO/xBwXfgqZYCkTV97BH9m5OJEaRZWSr5Pr72efXoUijH5Tu+L5uftU3NbeYg==
X-Received: by 2002:a05:600c:1d1f:: with SMTP id l31mr1788478wms.44.1633678530771;
        Fri, 08 Oct 2021 00:35:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id i3sm1647345wrn.34.2021.10.08.00.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 00:35:30 -0700 (PDT)
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-3-namit@vmware.com>
 <5485fae5-3cd6-9dc3-0579-dc8aab8a3de1@redhat.com>
 <5356D62E-1900-4E92-AF23-AA5625EFFD92@vmware.com>
 <1952fc7c-fb21-7d0e-661b-afa59b4580e5@redhat.com>
 <DA49DBBB-FFEE-4ACC-BB6C-364D07533C5E@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/2] mm/mprotect: do not flush on permission promotion
Message-ID: <e01c732f-08c2-95db-dbb9-b643131b522c@redhat.com>
Date:   Fri, 8 Oct 2021 09:35:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DA49DBBB-FFEE-4ACC-BB6C-364D07533C5E@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Any numbers would be helpful.
>>
>>> If you want, I will write a microbenchmarks and give you numbers.
>>> If you look for further optimizations (although you did not indicate
>>> so), such as doing the TLB batching from do_mprotect_key(),
>>> (i.e. batching across VMAs), we can discuss it and apply it on
>>> top of these patches.
>>
>> I think this patch itself is sufficient if we can show a benefit; I do wonder if existing benchmarks could already show a benefit, I feel like they should if this makes a difference. Excessive mprotect() usage (protect<>unprotect) isn't something unusual.
> 
> I do not know about a concrete benchmark (other than my workload, which I cannot share right now) that does excessive mprotect() in a way that would actually be measurable on the overall performance. I would argue that many many optimizations in the kernel are such that would not have so measurable benefit by themselves on common macrobenchmarks.
> 
> Anyhow, per your request I created a small micro-benchmark that runs mprotect(PROT_READ) and mprotect(PROT_READ|PROT_WRITE) in a loop and measured the time it took to do the latter (where a writeprotect is not needed). I ran the benchmark on a VM (guest) on top of KVM.
> 
> The cost (cycles) per mprotect(PROT_READ|PROT_WRITE) operation:
> 
> 		1 thread		2 threads
> 		--------		---------
> w/patch:	2496			2505			
> w/o patch:	5342			10458
> 

For my taste, the above numbers are sufficient, thanks!

> [ The results for 1 thread might seem strange as one can expect the overhead in this case to be no more than ~250 cycles, which is the time a TLB invalidation of a single PTE takes. Yet, this overhead are probably related to “page fracturing”, which happens when the VM memory is backed by 4KB pages. In such scenarios, a single PTE invalidation in the VM can cause on Intel a full TLB flush. The full flush is needed to ensure that if the invalidated address was mapped through huge page in the VM, any relevant 4KB mapping that is cached in the TLB (after fracturing due to the 4KB GPA->HPA mapping) would be removed.]

Very nice analysis :)

> 
> Let me know if you want me to share the micro-benchmark with you. I am not going to mention the results in the commit log, because I think the overhead of unnecessary TLB invalidation is well established.

Just let me clarify why I am asking at all, it could be that:

a) The optimization is effective and applicable to many workloads
b) The optimization is effective and applicable to some workloads 
("micro benchmark")
c) The optimization is ineffective
d) The optimization is wrong

IMHO: We can rule out d) by review and tests. We can rule out c) by 
simple benchmarks easily.

Maybe extend the patch description by something like:

"The benefit of this optimization can already be visible when doing 
mprotect(PROT_READ) -> mprotect(PROT_READ|PROT_WRITE) on a single 
thread, because we end up requiring basically no TLB flushes. The 
optimization gets even more significant with more threads. See [1] for 
simple micro benchmark results."

Something like that would be good enough for my taste.

-- 
Thanks,

David / dhildenb

