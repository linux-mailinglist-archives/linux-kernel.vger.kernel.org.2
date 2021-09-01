Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382C43FD8E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243877AbhIALlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243867AbhIALlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630496413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=htX3SEQ964s41lDg9EGqcJ8fzTVeLHq32V4/nO823PM=;
        b=ElkG6lmLvemwzbdGdlaYpnSbb1tknPYJ2hsLcNfCPR0el6A2rybgbb3BYFyzO4qnedJk1u
        5fOZZhTY/7I9dn0B4+0qpO/DAJy9DsUjcHdvzuwmT+vghWVWrAWADXdO4DylitSinMQuMu
        kcl/fy4V2WptQ6oPgfbSvDocrAc0NO0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-NYg33O1nP4GFmPD_AAUR2A-1; Wed, 01 Sep 2021 07:40:12 -0400
X-MC-Unique: NYg33O1nP4GFmPD_AAUR2A-1
Received: by mail-wr1-f71.google.com with SMTP id z16-20020adfdf90000000b00159083b5966so677656wrl.23
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 04:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=htX3SEQ964s41lDg9EGqcJ8fzTVeLHq32V4/nO823PM=;
        b=YJLPS/ro32t8ZtqLzamjfBZsOVu78vjbH8WCSfWKZCFrCGS+LMB2Rvej2bLHhfJ/yF
         4J7STMF2q0Tr3aM6gr5fimrbb8CqIx7MSO5t78ILbN+Lvz7H6LdH+rNJOALJnM/OjTo+
         kZurVWT3tdf7CtJAkosU2l+gh2KVslZUWVRIo1VDRTfCD/RFcAc+JuKRYrEc1I1/M9iP
         CT+aeUlHuAh630ajbXP+kDgdlwEKr8HU+Y8UdYIdEb42WvECrS71XOsUOeBn153OvFfm
         EC04o3oh7qLf2N1hRYgOcq4VZydxCfZvcw8LHTqjiBiYOP5r37MubAd35TbMYJgxDYaF
         IHdQ==
X-Gm-Message-State: AOAM532yLQvpYRRj0b/Fd4Bxpb1d/J61ZkjN+4wUC9FIUmSw3pTDibDZ
        KynnU7fERR+SWnV0QuNiDu6VC0R9Vb7jsygYua0XsJAn9Q4cr09M3ZdITgkvEZ+Mf9DCbQCxNId
        k1lLiUq7l9qbEYuakunGXGYqhc+/3ZQ3/4Y8AAU8vWSbvjdgmotYgmYkhlPAlI6BqQt82FsiVuP
        Tz
X-Received: by 2002:a1c:a187:: with SMTP id k129mr9255079wme.66.1630496411388;
        Wed, 01 Sep 2021 04:40:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqN074acM9MZoe5SBgP0NRERPgwEIUkWaC5frtJM8C6IM5OiqoEuDa7hI8e3EHO9OQpryO3A==
X-Received: by 2002:a1c:a187:: with SMTP id k129mr9255055wme.66.1630496411155;
        Wed, 01 Sep 2021 04:40:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g11sm20780933wrx.30.2021.09.01.04.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:40:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix kernel crash upon unbinding a
 device from uio_hv_generic driver
In-Reply-To: <20210901112500.7q4oxjtesiuniop3@liuwe-devbox-debian-v2>
References: <20210831143916.144983-1-vkuznets@redhat.com>
 <20210901112500.7q4oxjtesiuniop3@liuwe-devbox-debian-v2>
Date:   Wed, 01 Sep 2021 13:40:09 +0200
Message-ID: <878s0go76u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Tue, Aug 31, 2021 at 04:39:16PM +0200, Vitaly Kuznetsov wrote:
>> The following crash happens when a never-used device is unbound from
>> uio_hv_generic driver:
>> 
>>  kernel BUG at mm/slub.c:321!
>>  invalid opcode: 0000 [#1] SMP PTI
>>  CPU: 0 PID: 4001 Comm: bash Kdump: loaded Tainted: G               X --------- ---  5.14.0-0.rc2.23.el9.x86_64 #1
>>  Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
>>  RIP: 0010:__slab_free+0x1d5/0x3d0
>> ...
>>  Call Trace:
>>   ? pick_next_task_fair+0x18e/0x3b0
>>   ? __cond_resched+0x16/0x40
>>   ? vunmap_pmd_range.isra.0+0x154/0x1c0
>>   ? __vunmap+0x22d/0x290
>>   ? hv_ringbuffer_cleanup+0x36/0x40 [hv_vmbus]
>>   kfree+0x331/0x380
>>   ? hv_uio_remove+0x43/0x60 [uio_hv_generic]
>>   hv_ringbuffer_cleanup+0x36/0x40 [hv_vmbus]
>>   vmbus_free_ring+0x21/0x60 [hv_vmbus]
>>   hv_uio_remove+0x4f/0x60 [uio_hv_generic]
>>   vmbus_remove+0x23/0x30 [hv_vmbus]
>>   __device_release_driver+0x17a/0x230
>>   device_driver_detach+0x3c/0xa0
>>   unbind_store+0x113/0x130
>> ...
>> 
>> The problem appears to be that we free 'ring_info->pkt_buffer' twice:
>> first, when the device is unbound from in-kernel driver (netvsc in this
>> case) and second from hv_uio_remove(). Normally, ring buffer is supposed
>> to be re-initialized from hv_uio_open() but this happens when UIO device
>> is being opened and this is not guaranteed to happen.
>> 
>> Generally, it is OK to call hv_ringbuffer_cleanup() twice for the same
>> channel (which is being handed over between in-kernel drivers and UIO) even
>> if we didn't call hv_ringbuffer_init() in between. We, however, need to
>> avoid kfree() call for an already freed pointer.
>> 
>> Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/hv/ring_buffer.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
>> index 2aee356840a2..314015d9e912 100644
>> --- a/drivers/hv/ring_buffer.c
>> +++ b/drivers/hv/ring_buffer.c
>> @@ -245,6 +245,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
>>  	mutex_unlock(&ring_info->ring_buffer_mutex);
>>  
>>  	kfree(ring_info->pkt_buffer);
>> +	ring_info->pkt_buffer = NULL;
>
> This certainly won't hurt.
>
> I would however like to wait till Andrea and Michael go over the
> reasoning of this patch before doing anything.
>

Thanks,

the counter-intuitive thing here is that the channel sometimes continues
to live after hv_ringbuffer_cleanup(): when we unbind a device from
in-kernel driver and give it to uio_hv_generic the channel is handed
over from one driver to another.

> Wei.
>
>>  	ring_info->pkt_buffer_size = 0;
>>  }
>>  
>> -- 
>> 2.31.1
>> 
>

-- 
Vitaly

