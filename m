Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A16E3C173A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhGHQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229566AbhGHQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625762589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D66C027ALMZX8KmiIGzWW2xf5pX3PYyC6v7g+QXpb8U=;
        b=AGW+HInTcftCd+hZEEmV+mZk0GMTkaznEpqBx0Co3/j4cHA73uHkJKjtnHdP66U93giJH5
        QAV+81hxU1qkIF47IDlCnbYCoU0rNM121PWI90Xci16EPOCjbRntqCARw53AQ+rM8FZghU
        PvKjf6y6123hprtE6NEOBEabfKUuMqY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-dgAgOoLyPo-gAQRtdltr2w-1; Thu, 08 Jul 2021 12:43:07 -0400
X-MC-Unique: dgAgOoLyPo-gAQRtdltr2w-1
Received: by mail-ed1-f69.google.com with SMTP id z5-20020a05640235c5b0290393974bcf7eso3623678edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 09:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D66C027ALMZX8KmiIGzWW2xf5pX3PYyC6v7g+QXpb8U=;
        b=dJIUs1rZgBmEYB3ZTBYr7DAmox8A1HU9jT7kzQr+nbS9K76JHICa+RkO13rnFsv28K
         yEG10UODwgYLml5WN392q3zPaPIxJv8cJVUDClS+WCmmsUi22qVQP3bNM1tGhAI1/vxA
         UsnB9pxgpVN7U5XwGUFLRc+XOT2A+QivAmAOvp9LHg2uayvMe+RunDVOwOqDFJ0PdQj5
         1QtLbf9QPx7ti/vfqcYkulbSfroIz9XLBHYWBhw9BmmXbshXTVIbkODUNyL2J35IIvaL
         +9ti1Omigm7BuzJA1iLHzwfRrkdncS7Onwo4/AFO0OjQN9AVNjdkcYpum05GphsmWSW1
         Tepw==
X-Gm-Message-State: AOAM530CWmGso0UwoK8CgebuYVGAI/Eboqloydp4tmiNH2Mli694pqlS
        xEkAtKwEA4LEQIu7psmjiVciPvKAyTzbnx1FLX5X7nKwXCC9kuJaxG0GtaDoYAP8kVu+kzz8khA
        cOPvdvTmM9fZA5LWbow4hvYjC
X-Received: by 2002:a05:6402:50c6:: with SMTP id h6mr39709587edb.296.1625762586739;
        Thu, 08 Jul 2021 09:43:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjgIagSVZlBFLz6289dyKlXMEisgWewUN7ov4BwrNX4oVQl4QAdly/6faGn+deCRC/YbC93A==
X-Received: by 2002:a05:6402:50c6:: with SMTP id h6mr39709567edb.296.1625762586559;
        Thu, 08 Jul 2021 09:43:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p19sm1488014edr.73.2021.07.08.09.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 09:43:06 -0700 (PDT)
Subject: Re: [PATCH] KVM: mmio: Fix use-after-free Read in
 kvm_vm_ioctl_unregister_coalesced_mmio
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210626070304.143456-1-wangkefeng.wang@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c53acbe-ccb9-4283-0634-cbf69a1052e4@redhat.com>
Date:   Thu, 8 Jul 2021 18:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210626070304.143456-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/21 09:03, Kefeng Wang wrote:
> BUG: KASAN: use-after-free in kvm_vm_ioctl_unregister_coalesced_mmio+0x7c/0x1ec arch/arm64/kvm/../../../virt/kvm/coalesced_mmio.c:183
> Read of size 8 at addr ffff0000c03a2500 by task syz-executor083/4269
> 
> CPU: 5 PID: 4269 Comm: syz-executor083 Not tainted 5.10.0 #7
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>   dump_backtrace+0x0/0x2d0 arch/arm64/kernel/stacktrace.c:132
>   show_stack+0x28/0x34 arch/arm64/kernel/stacktrace.c:196
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x110/0x164 lib/dump_stack.c:118
>   print_address_description+0x78/0x5c8 mm/kasan/report.c:385
>   __kasan_report mm/kasan/report.c:545 [inline]
>   kasan_report+0x148/0x1e4 mm/kasan/report.c:562
>   check_memory_region_inline mm/kasan/generic.c:183 [inline]
>   __asan_load8+0xb4/0xbc mm/kasan/generic.c:252
>   kvm_vm_ioctl_unregister_coalesced_mmio+0x7c/0x1ec arch/arm64/kvm/../../../virt/kvm/coalesced_mmio.c:183
>   kvm_vm_ioctl+0xe30/0x14c4 arch/arm64/kvm/../../../virt/kvm/kvm_main.c:3755
>   vfs_ioctl fs/ioctl.c:48 [inline]
>   __do_sys_ioctl fs/ioctl.c:753 [inline]
>   __se_sys_ioctl fs/ioctl.c:739 [inline]
>   __arm64_sys_ioctl+0xf88/0x131c fs/ioctl.c:739
>   __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>   invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>   el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
>   do_el0_svc+0x120/0x290 arch/arm64/kernel/syscall.c:220
>   el0_svc+0x1c/0x28 arch/arm64/kernel/entry-common.c:367
>   el0_sync_handler+0x98/0x170 arch/arm64/kernel/entry-common.c:383
>   el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:670
> 
> Allocated by task 4269:
>   stack_trace_save+0x80/0xb8 kernel/stacktrace.c:121
>   kasan_save_stack mm/kasan/common.c:48 [inline]
>   kasan_set_track mm/kasan/common.c:56 [inline]
>   __kasan_kmalloc+0xdc/0x120 mm/kasan/common.c:461
>   kasan_kmalloc+0xc/0x14 mm/kasan/common.c:475
>   kmem_cache_alloc_trace include/linux/slab.h:450 [inline]
>   kmalloc include/linux/slab.h:552 [inline]
>   kzalloc include/linux/slab.h:664 [inline]
>   kvm_vm_ioctl_register_coalesced_mmio+0x78/0x1cc arch/arm64/kvm/../../../virt/kvm/coalesced_mmio.c:146
>   kvm_vm_ioctl+0x7e8/0x14c4 arch/arm64/kvm/../../../virt/kvm/kvm_main.c:3746
>   vfs_ioctl fs/ioctl.c:48 [inline]
>   __do_sys_ioctl fs/ioctl.c:753 [inline]
>   __se_sys_ioctl fs/ioctl.c:739 [inline]
>   __arm64_sys_ioctl+0xf88/0x131c fs/ioctl.c:739
>   __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>   invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>   el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
>   do_el0_svc+0x120/0x290 arch/arm64/kernel/syscall.c:220
>   el0_svc+0x1c/0x28 arch/arm64/kernel/entry-common.c:367
>   el0_sync_handler+0x98/0x170 arch/arm64/kernel/entry-common.c:383
>   el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:670
> 
> Freed by task 4269:
>   stack_trace_save+0x80/0xb8 kernel/stacktrace.c:121
>   kasan_save_stack mm/kasan/common.c:48 [inline]
>   kasan_set_track+0x38/0x6c mm/kasan/common.c:56
>   kasan_set_free_info+0x20/0x40 mm/kasan/generic.c:355
>   __kasan_slab_free+0x124/0x150 mm/kasan/common.c:422
>   kasan_slab_free+0x10/0x1c mm/kasan/common.c:431
>   slab_free_hook mm/slub.c:1544 [inline]
>   slab_free_freelist_hook mm/slub.c:1577 [inline]
>   slab_free mm/slub.c:3142 [inline]
>   kfree+0x104/0x38c mm/slub.c:4124
>   coalesced_mmio_destructor+0x94/0xa4 arch/arm64/kvm/../../../virt/kvm/coalesced_mmio.c:102
>   kvm_iodevice_destructor include/kvm/iodev.h:61 [inline]
>   kvm_io_bus_unregister_dev+0x248/0x280 arch/arm64/kvm/../../../virt/kvm/kvm_main.c:4374
>   kvm_vm_ioctl_unregister_coalesced_mmio+0x158/0x1ec arch/arm64/kvm/../../../virt/kvm/coalesced_mmio.c:186
>   kvm_vm_ioctl+0xe30/0x14c4 arch/arm64/kvm/../../../virt/kvm/kvm_main.c:3755
>   vfs_ioctl fs/ioctl.c:48 [inline]
>   __do_sys_ioctl fs/ioctl.c:753 [inline]
>   __se_sys_ioctl fs/ioctl.c:739 [inline]
>   __arm64_sys_ioctl+0xf88/0x131c fs/ioctl.c:739
>   __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>   invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>   el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
>   do_el0_svc+0x120/0x290 arch/arm64/kernel/syscall.c:220
>   el0_svc+0x1c/0x28 arch/arm64/kernel/entry-common.c:367
>   el0_sync_handler+0x98/0x170 arch/arm64/kernel/entry-common.c:383
>   el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:670
> 
> If kvm_io_bus_unregister_dev() return -ENOMEM, we already call kvm_iodevice_destructor()
> inside this function to delete 'struct kvm_coalesced_mmio_dev *dev' from list
> and free the dev, but kvm_iodevice_destructor() is called again, it will lead
> the above issue.
> 
> Let's check the the return value of kvm_io_bus_unregister_dev(), only call
> kvm_iodevice_destructor() if the return value is 0.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   virt/kvm/coalesced_mmio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> index f08f5e82460b..0be80c213f7f 100644
> --- a/virt/kvm/coalesced_mmio.c
> +++ b/virt/kvm/coalesced_mmio.c
> @@ -186,7 +186,6 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
>   		    coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
>   			r = kvm_io_bus_unregister_dev(kvm,
>   				zone->pio ? KVM_PIO_BUS : KVM_MMIO_BUS, &dev->dev);
> -			kvm_iodevice_destructor(&dev->dev);
>   
>   			/*
>   			 * On failure, unregister destroys all devices on the
> @@ -196,6 +195,7 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
>   			 */
>   			if (r)
>   				break;
> +			kvm_iodevice_destructor(&dev->dev);
>   		}
>   	}
>   
> 

Queued, thanks.

Paolo

