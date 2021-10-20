Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850304345AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJTHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhJTHH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634713514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35y2oJPKGIhyU2nCIHyJg/ZrrRxLsNbgvcLNljtqazA=;
        b=FJVc2+4oGgwzXfJ5WCtcJqwQ6Q2O9jwRIRxgg0xNe/kH9W+1r8vc1OWjTDV/AuVs/JL+cj
        PBQLH0VUwJEZNNaizC0td6X9zurN76GeTS1QGkhZ03kxbAjH+8Tz4gkFnBoxfHbzXLYNMB
        r2I85Dpvbu9P2WRNnxz5mLYH6/cUre4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-BLD2G5wlPI6eNKORQ8FZXw-1; Wed, 20 Oct 2021 03:05:13 -0400
X-MC-Unique: BLD2G5wlPI6eNKORQ8FZXw-1
Received: by mail-wm1-f69.google.com with SMTP id s26-20020a7bc39a000000b0030d9db6c428so3660007wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=35y2oJPKGIhyU2nCIHyJg/ZrrRxLsNbgvcLNljtqazA=;
        b=cRvzA2eSqG3ZuqVEIfAyX5mNhcpl2Sf9IHzArhm0pdMJT2QU4OHyChfNugEluBzmnO
         b7nYBb9WW6oc1AuRPF48che/NS07j0qrekfrG4a30y076J8It8xiUqJ1/DReD3N8rBKP
         n/RkwW7WQat1WQ3RCXXeWxozg3Vvp60n//5t4CGB/DLenC3tcndrsLjcUo3IhhOn4DLp
         Tbw6KpzPl2MVsqs71UKCkEcwS5CpdmW4R5LveE+enKS6f/UoxrtfBMhbpCXEkVdG+LG1
         9sp5mU5HEjz10+saG46hjk0sTqMNvzZmZc6rbjwrxR+nd/nNSf0aNiUrH6lwspzxraXb
         MESw==
X-Gm-Message-State: AOAM532MnaUour57jWiokKW7AcrjpJNEtc0Gz9tIntQxQ5VAy6YpBJSj
        vRHRQKsTad6KHxI0dwPhBDV5X9W0JXSnztfp5CICVBOsK2B3Mu8SloKJNaJsKZmxQgt4lZc1iKX
        OLxtUpMAVvoE57zgPz7RbmbFQ
X-Received: by 2002:a05:600c:3595:: with SMTP id p21mr11775709wmq.71.1634713512067;
        Wed, 20 Oct 2021 00:05:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk6OfhEHciiYXtYwi1laCzH5NY8srNxdl7VlBDBdvynLL/kHwQ9eswHQRrNC0sCGwPh70QuA==
X-Received: by 2002:a05:600c:3595:: with SMTP id p21mr11775649wmq.71.1634713511608;
        Wed, 20 Oct 2021 00:05:11 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63d4.dip0.t-ipconnect.de. [91.12.99.212])
        by smtp.gmail.com with ESMTPSA id b3sm1172920wrp.52.2021.10.20.00.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 00:05:11 -0700 (PDT)
Message-ID: <4858258b-8fb9-b060-8724-25c89ba2ce0e@redhat.com>
Date:   Wed, 20 Oct 2021 09:05:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Jianyong Wu <jianyong.wu@arm.com>, akpm@linux-foundation.org,
        mhiramat@kernel.org, peterz@infradead.org
Cc:     rostedt@goodmis.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, justin.he@arm.com, nd@arm.com
References: <20211020020712.90240-1-jianyong.wu@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] init: avoid race condition of update page table in
 kernel init
In-Reply-To: <20211020020712.90240-1-jianyong.wu@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.21 04:07, Jianyong Wu wrote:
> Race condition of page table update can happen in kernel_init as
> both of memory hotplug module init and the following mark_rodata_ro can
> update page table. The function excute flow chart is:
> 
> -------------------------
> kernel_init
>   kernel_init_freeable
>     ...
>       do_initcall
>         ...
>           module_init [A]

Nit: virtio-mem adds memory via a workqueue, not directly during
module_init.

> 
>   ...
>   mark_readonly
>     mark_rodata_ro [B]
> -------------------------
> [A] can contains memory hotplug init therefore both [A] and [B] can
> update page table at the same time that may lead to race. Here we
> introduce memory hotplug lock to guard mark_rodata_ro to avoid the race
> condition.
> 
> I catch the related error when test virtio-mem (a new memory hotplug
> driver) on arm64 and may be a potential bug for other arches.

Thanks for reporting, we should be able to trigger something similar
using ACPI, when hotplugging DIMMs just at the wrong point in time.

> 
> How to reproduce on arm64:
> (1) prepare a kernel with virtio-mem enabled on arm64
> (2) start a VM using Cloud Hypervisor[1] using the kernel above
> (3) hotplug memory, 20G in my case, with virtio-mem
> (4) reboot or load new kernel using kexec
> 
> Test for server times, you may find the error below:
> 
> [    1.131039] Unable to handle kernel paging request at virtual address fffffbfffda3b140
> [    1.134504] Mem abort info:
> [    1.135722]   ESR = 0x96000007
> [    1.136991]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.139189]   SET = 0, FnV = 0
> [    1.140467]   EA = 0, S1PTW = 0
> [    1.141755]   FSC = 0x07: level 3 translation fault
> [    1.143787] Data abort info:
> [    1.144976]   ISV = 0, ISS = 0x00000007
> [    1.146554]   CM = 0, WnR = 0
> [    1.147817] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000426f2000
> [    1.150551] [fffffbfffda3b140] pgd=0000000042ffd003, p4d=0000000042ffd003, pud=0000000042ffe003, pmd=0000000042fff003, pte=0000000000000000
> [    1.155728] Internal error: Oops: 96000007 [#1] SMP
> [    1.157724] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G         C        5.15.0-rc3+ #100
> [    1.161002] Hardware name: linux,dummy-virt (DT)
> [    1.162939] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.165825] pc : alloc_init_pud+0x38c/0x550
> [    1.167610] lr : alloc_init_pud+0x394/0x550
> [    1.169358] sp : ffff80001001bd10
> ......
> [    1.200527] Call trace:
> [    1.201583]  alloc_init_pud+0x38c/0x550
> [    1.203218]  __create_pgd_mapping+0x94/0xe0
> [    1.204983]  update_mapping_prot+0x50/0xd8
> [    1.206730]  mark_rodata_ro+0x50/0x58
> [    1.208281]  kernel_init+0x3c/0x120
> [    1.209760]  ret_from_fork+0x10/0x20
> [    1.211298] Code: eb15003f 54000061 d5033a9f d5033fdf (f94000a1)
> [    1.213856] ---[ end trace 59473413ffe3f52d ]---
> [    1.215850] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> [1] https://github.com/cloud-hypervisor/cloud-hypervisor
> 
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  init/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index 81a79a77db46..290c9882ba9e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1471,7 +1471,9 @@ static void mark_readonly(void)
>  		 * insecure pages which are W+X.
>  		 */
>  		rcu_barrier();
> +		get_online_mems();
>  		mark_rodata_ro();
> +		put_online_mems();

I feel like this should be handled accordingly in the arch code instead.
The arch code has to be able to deal with concurrent direct map
operations (e.g., concurrent secretmem updates, concurrent memory hotadd
/ hot removal).

I remember x86-64 serializes page table init using
&init_mm.page_table_lock and page table updates using the cpa_lock (see
arch/x86/mm/pat/set_memory.c).

The question would be: in which cases would we touch the same page
tables when adding memory while concurrently splitting such a page
table. On x86-64, IIRC, all that could happen is that we split a huge
direct mapping and replace it via a page table holding 4k mappings. This
cannot really conflict with memory hotadd, which works in at least 2 MiB
(sub-section) granularity. Two ranges couldn't silently overlap and
trigger such a race.

So I don't think something like that applies on x86-64: I've run endless
tests with CONFIG_VIRTIO_MEM=y over the years (instead of "m") and never
spotted something similar.

But why does it matter on arm64? Can you describe how the exact race
triggers?

-- 
Thanks,

David / dhildenb

