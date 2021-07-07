Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84A83BEA88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhGGPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232050AbhGGPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625671078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLKo2OPwq2DZHj/O8dwU7gitKGZtqVoZ1OSqBdlhM9o=;
        b=EtmpQqOfzfR4D54HvlT8Iq/xD7q0rCfa/3jVptQEdUTE+Tkcy8LGaYUvnJMmMtI13C9jD9
        kDgGA/gKxTVyAO1oPO8dq+AmdMFM9TzNKy6hecn7ZoGS+sP80I70YebOf2c/eatmSxac6I
        mwNTS5LSXD3x1bMy0LywvFkLUwps6FU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-A5F0J6g3N4SAGAXO4Kv6Eg-1; Wed, 07 Jul 2021 11:17:57 -0400
X-MC-Unique: A5F0J6g3N4SAGAXO4Kv6Eg-1
Received: by mail-wm1-f70.google.com with SMTP id m5-20020a05600c3b05b029020c34fd31cfso602366wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 08:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fLKo2OPwq2DZHj/O8dwU7gitKGZtqVoZ1OSqBdlhM9o=;
        b=HUbaZoBYqAMHzWr+/8q1zGoL/Jp5XMenG/5PIJpuJc6tZHX9iMgEzpBXX0K6xX36OQ
         byH6Lr/UfTvMqkrt5Vc4QPWvm6pmvvWVmbKwx/BMA8wYuem/MSWpAvtXUP8Z5gBr+TqQ
         +mXW3ZFuYhDH8CNcVAnkGciiVQ42005TsHAans50zdGpeeQ5PbI0/E4Ygf+4OAnjK1G8
         HmswMszxWVZc6aaPVwTNPR/YzGS16IrSGOKr6E9rTQCFjZQvyXgfy3C1KSuy2RK0rR0n
         UEAZffhD0dcDv+TLs+bgnIr9koZoHYxNxPgqMwSqqVTfPkZByFmtzz9hVq/8vZ5JQkUv
         MdKQ==
X-Gm-Message-State: AOAM533TnbZl0e1FnWDTDWnmkQGQWIDc8blAS9qJe0HWx/Wuni8DfP4S
        0KgC1M1rV2r9hjqh3UYR9xZ8QcLQfMLua97y3tJiLhP7l55EaGYC5qoWfOzqR+obqkWL1tw3aJ8
        97qq+6AssQZaP39+AAuCuid9v
X-Received: by 2002:a05:6000:1a87:: with SMTP id f7mr28329930wry.172.1625671075959;
        Wed, 07 Jul 2021 08:17:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzah6urErPg+YyoBdeo4INZfgkKtMjv5hY7UoQ8zErjkgLHiY+CIDanzMoZE9NYHKyRE1GXlQ==
X-Received: by 2002:a05:6000:1a87:: with SMTP id f7mr28329899wry.172.1625671075625;
        Wed, 07 Jul 2021 08:17:55 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23579.dip0.t-ipconnect.de. [79.242.53.121])
        by smtp.gmail.com with ESMTPSA id x17sm25630828wrn.62.2021.07.07.08.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 08:17:55 -0700 (PDT)
To:     Hui Zhu <teawater@gmail.com>, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@antfin.com>
References: <20210623115839.3524-1-teawater@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] virtio-mem: Add support of memory_hotplug.memmap_on_memory
Message-ID: <bc36b6fe-0d1a-6fe2-e8f3-49bbcaebcf41@redhat.com>
Date:   Wed, 7 Jul 2021 17:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623115839.3524-1-teawater@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.21 13:58, Hui Zhu wrote:
> From: Hui Zhu <teawater@antfin.com>
> 

Sorry for the delay, once I was back from vacation my inbox was 
overflowing :)

> We did some virtio-mem resize tests in high memory pressure environment.
> Memory increases slowly and sometimes fails in these tests.
> This is a way to reproduce the issue.
> Start a qemu with a small size of memory (132Mb) and resize the
> virtio-mem to hotplug memory.
> Then will get following error:
> [    8.097461] virtio_mem virtio0: requested size: 0x10000000
> [    8.098038] virtio_mem virtio0: plugging memory: 0x100000000 -
> 0x107ffffff
> [    8.098829] virtio_mem virtio0: adding memory: 0x100000000 -
> 0x107ffffff
> [    8.106298] kworker/0:1: vmemmap alloc failure: order:9,
> mode:0x4cc0(GFP_KERNEL|__GFP_RETRY_MAYFAIL),
> nodemask=(null),cpuset=/,mems_allowed=0
> [    8.107609] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 5.13.0-rc7+
> [    8.108295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [    8.109476] Workqueue: events_freezable virtio_mem_run_wq
> [    8.110039] Call Trace:
> [    8.110305]  dump_stack+0x76/0x94
> [    8.110654]  warn_alloc.cold+0x7b/0xdf
> [    8.111054]  ? __alloc_pages+0x2c2/0x310
> [    8.111462]  vmemmap_alloc_block+0x86/0xdc
> [    8.111891]  vmemmap_populate+0xfc/0x325
> [    8.112309]  __populate_section_memmap+0x38/0x4e
> [    8.112787]  sparse_add_section+0x167/0x244
> [    8.113226]  __add_pages+0xa6/0x130
> [    8.113592]  add_pages+0x12/0x60
> [    8.113934]  add_memory_resource+0x114/0x2d0
> [    8.114377]  add_memory_driver_managed+0x7c/0xc0
> [    8.114852]  virtio_mem_add_memory+0x57/0xe0
> [    8.115304]  virtio_mem_sbm_plug_and_add_mb+0x9a/0x130
> [    8.115833]  virtio_mem_run_wq+0x9d5/0x1100
> I think allocating 2 Mb contiguous memory will be slow and failed
> in some cases, especially in high memory pressure environment.

So, interrestingly, what failed was the 2 MB allcoation. But 
vmemmap_populate() on x86-64 will actually fallback to individual 4k 
allcoations. See arch/x86/mm/init_64.c:vmemmap_populate_hugepages(), 
which falls back to vmemmap_populate_basepages().

We could certainly think about silencing this warning (GFP_NOWARN) and 
instead printing a clearer warning like "vmemmap: populating huge page 
failed; falling back to populating base pages"

Did you also see a "virtio_mem virtio0: adding memory failed: .." device 
warning? If not, adding memory did succeed! Although it's suboptimal.


> This commit try to add support of memory_hotplug.memmap_on_memory to
> handle this issue.
> 
> Just let SBM mode support it because memory_hotplug.memmap_on_memory
> need a single memory block.
> 
> Add nr_vmemmap_pages and sbs_vmemmap to struct sbm.
> If memory_hotplug.memmap_on_memory is open, pages number of a memory
> block's internal metadata will be store in nr_vmemmap_pages.
> sbs_vmemmap is the number of vmemmap subblocks per Linux memory block.
> The pages in the vmemmap subblocks should bigger than nr_vmemmap_pages
> because sb_size need to span at least MAX_ORDER_NR_PAGES and
> pageblock_nr_pages pages (virtio_mem_init).
> All the pages in vmemmap subblocks is not going to add to the buddy
> even if the pages that are not used to store the internal metadata
> (struct pages) because they should not work reliably with
> alloc_contig_range().
> 
> When resize virtio-mem, sbs_vmemmap is going to count in
> virtio_mem_sbm_plug_and_add_mb, virtio_mem_sbm_unplug_any_sb_offline
> and virtio_mem_sbm_unplug_any_sb_online.
> Because internal metadata also need the real pages in the host to store
> it.  I think resize virtio-mem size same with the actual memory
> footprint
> on the host is better if we want setup a memory cgroup for QEMU.

So the main thing I dislike about the current RFC state is the waste of 
memory we signaled to the device we are going to use, but we are not 
actually able to use. The remaining stuff looks reasonably clear to me, 
although we could do some refactorings to make it read a bit nicer.

The "loss" currently corresponds to 2 MiB for a 128MB memory block -- 
that's 1/64 of all added memory and just as much as the vmemmap itself!

I don't see an easy way around this when keeping the subblock size at 2 
MiB. We'd have to mess with "partial subblocks" when processing (un)plug 
requests, which is just plain ugly.

There is a big TODO item on my toto list to teach alloc_contig_range() 
to handle pageblock_order properly and I shall start working on that 
soonish. [1]

What I think we should do is


1. Implement the "memory_hotplug.memmap_on_memory" optimization for big 
block mode with a single memory block only for now (Linux also only 
supports this). Environments that desparately need this optimization can 
set "force_bbm=1" when loading the virtio-mem module.

It already has the correct flow -- virtio_mem_bbm_plug_and_add_bb() and 
virtio_mem_bbm_remove_and_unplug_bb(). We'll have to teach:

* virtio_mem_bbm_notify_going_offline() /
   virtio_mem_bbm_notify_cancel_offline() about the special vmemmap
   ranges
* virtio_mem_bbm_offline_remove_and_unplug_bb() about the special
   vmemmap ranges

I think that should be mostly it, but there might be more.

2. Optimize alloc_contig_range() such that we can drop the MAX_ORDER - 1 
requirement. With most devices, we can then use a subblock size of 
pageblock_order (2MiB on x86-64).

3. Pick up a reduced variant of your RFC that implements the 
optimization only if the sbm.vmemmap pages span complete subblocks. That 
removes the need for sbm.nr_vmemmap_pages and consequently results in no 
loss of plugged memory.

[1] 
https://lkml.kernel.org/r/c8e21ac4-ace7-3176-8782-535bd6590583@redhat.com


> @@ -1534,12 +1615,15 @@ static int virtio_mem_sbm_prepare_next_mb(struct virtio_mem *vm,
>   static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
>   					  unsigned long mb_id, uint64_t *nb_sb)
>   {
> -	const int count = min_t(int, *nb_sb, vm->sbm.sbs_per_mb);
> +	int count = min_t(int, *nb_sb, vm->sbm.sbs_per_mb);
>   	int rc;
>   
>   	if (WARN_ON_ONCE(!count))
>   		return -EINVAL;
>   
> +	if (vm->sbm.sbs_vmemmap)
> +		count = max_t(int, count, vm->sbm.sbs_vmemmap);
> +

If you exceed original *nb_sb (which can happen on bigger memory blocks 
like with 2GB where the vmemmap actually spans multiple subblocks), you 
can try plugging more than requested from the hypervisor.

You'd instead have to return with -ENOSPC in case *nb_sb does not at 
least span vm->sbm.sbs_vmemmap.

[...]

>   		/*
>   		 * Remove the block from Linux - this should never fail.
>   		 * Hinder the block from getting onlined by marking it
> @@ -1840,6 +1934,23 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
>   		rc = virtio_mem_sbm_remove_mb(vm, mb_id);
>   		BUG_ON(rc);
>   		mutex_lock(&vm->hotplug_mutex);
> +
> +		/* Remove vmemmap pages. */
> +		if (vm->sbm.sbs_vmemmap) {
> +			rc = virtio_mem_sbm_unplug_sb(vm, mb_id, 0,
> +						      vm->sbm.sbs_vmemmap);
> +			/*
> +			 * Just warn because this error will
> +			 * not affect next plug.
> +			 */
> +			WARN_ON(rc);

We should avoid WARN_ON() and instead use dev_warn() for cases that can 
actually happen. With panic_on_warn(), which some distributions enable, 
we can crash the kernel.

I think error handling might also not be correct. We'd actually want to 
set the state to something like VIRTIO_MEM_SBM_MB_PLUGGED, to retry 
unplug later. Further, we'd want to return to the main loop to retry 
fixing this up.

Because if you leave the vmemmap blocks plugged, 
virtio_mem_sbm_plug_and_add_mb() will later keep failing with invalid 
requests from the hypervisor I guess.

[...]

> -	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
> +	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, vm->sbm.sbs_vmemmap,
> +				vm->sbm.sbs_per_mb - vm->sbm.sbs_vmemmap)) {
>   		mutex_unlock(&vm->hotplug_mutex);
>   		rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
>   		mutex_lock(&vm->hotplug_mutex);
> -		if (!rc)
> +		if (!rc) {
>   			virtio_mem_sbm_set_mb_state(vm, mb_id,
>   						    VIRTIO_MEM_SBM_MB_UNUSED);
> +			/* Remove vmemmap pages. */
> +			if (vm->sbm.sbs_vmemmap) {
> +				rc = virtio_mem_sbm_unplug_sb(vm, mb_id, 0,
> +							vm->sbm.sbs_vmemmap);
> +				/*
> +				 * Just warn because this error will
> +				 * not affect next plug.
> +				 */
> +				WARN_ON(rc);
> +				if (!rc) {
> +					if (*nb_sb >= vm->sbm.sbs_vmemmap)
> +						*nb_sb -= vm->sbm.sbs_vmemmap;
> +					else
> +						*nb_sb = 0;
> +				}
> +			}
> +		}

Same comments as for virtio_mem_sbm_unplug_any_sb_offline().

>   	}
>   
>   	return 0;
> @@ -2444,6 +2578,15 @@ static int virtio_mem_init(struct virtio_mem *vm)
>   		       memory_block_size_bytes() - 1;
>   		vm->sbm.first_mb_id = virtio_mem_phys_to_mb_id(addr);
>   		vm->sbm.next_mb_id = vm->sbm.first_mb_id;
> +		if (mhp_supports_memmap_on_memory(memory_block_size_bytes())) {
> +			vm->sbm.nr_vmemmap_pages
> +				= PFN_DOWN(PFN_DOWN(memory_block_size_bytes()) *
> +					   sizeof(struct page));

I feel like we want memory hotplug code / vmemmap code to tell us 
instead of calculating ourselves.



-- 
Thanks,

David / dhildenb

