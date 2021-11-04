Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5844575B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhKDQma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230420AbhKDQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636043990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtWxj5bVWIRUkIdmlTWUpr8g05fwqa8qk6FC6Lvym2I=;
        b=InkJMKKXawQ7M3YH2y+wPQfzddUFedlfTXQV11jS2tbvXVO6j7TNv/1R1cY/epPsm1robr
        stA+XfAHNgcfH3WVjyU/IAOTtrZoHyM9aE2yEK93XWW9cGo7Ydw7yWM96ticyUbhMywJHC
        kjz2bHTzlXHsbBpizv+DKpTlcQgVR3U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-e7IaO5YRNrG5238Ah2YFkA-1; Thu, 04 Nov 2021 12:39:49 -0400
X-MC-Unique: e7IaO5YRNrG5238Ah2YFkA-1
Received: by mail-wm1-f71.google.com with SMTP id l187-20020a1c25c4000000b0030da46b76daso4600496wml.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WtWxj5bVWIRUkIdmlTWUpr8g05fwqa8qk6FC6Lvym2I=;
        b=CQSD04SHcln8FXi9Tc1oBvUOJNNpvT00QZ8ae5AOvU00f2bYUirHBEp+AqTJCXahvx
         vQmh9NRWefjzfl3gZ7hhM3aHbmA60DUpQYk+kQ1K8+L6XAsdcFk6BmmdX/SZRVeppiCy
         ay8PlTMYceYeWxPdftN4HLAga7n2yju8z5CePVscuLRRFviEV0DgeyTvWoucZzz0R72d
         SccMeKu3n2Uu/ckv4x1lNbLJv5EEH86bC2YxTexEMicYYnmlWkMBcKSHXbk+ZM/1ryBf
         jLLeWd1KOEJCoynW5N33EnRu58DKsLEjlzwj499TsznC+PCcG75/65csxthc5qTu9F6X
         +Oyg==
X-Gm-Message-State: AOAM533PhLWEJR0qQKGJJz3CUTkG45sk+jLBJ6zSdWLLK+cW8sgTptvU
        SiLEX61bZmWKDpOAGAROKTxCCt0gDyp791KrjbAQ8ihDJMr85Xj7xWKYHnkLtAJLvp0DmsJaQye
        Hm1g+9oP5WAYv4OdKoXgVDozH
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr24191264wmn.190.1636043985918;
        Thu, 04 Nov 2021 09:39:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIH+cjej3i1dltEBRmTsfN3a+98KZkYrNCWjyE5e0C19BkFlHpqTrypOIBu2BPOpHV6iXeUQ==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr24191228wmn.190.1636043985650;
        Thu, 04 Nov 2021 09:39:45 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id u16sm8594883wmc.21.2021.11.04.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:39:45 -0700 (PDT)
Message-ID: <3190fc080138108c189626e22676aaae80b72414.camel@redhat.com>
Subject: Re: [mm/page_alloc]  5541e53659: BUG:spinlock_bad_magic_on_CPU
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        ppandit@redhat.com
Date:   Thu, 04 Nov 2021 17:39:44 +0100
In-Reply-To: <20211104143809.GB6499@xsang-OptiPlex-9020>
References: <20211104143809.GB6499@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 (3.42.0-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-04 at 22:38 +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 5541e5365954069e4c7b649831c0e41bc9e5e081 ("[PATCH v2 2/3] mm/page_alloc: Convert per-cpu lists' local locks to per-cpu spin locks")
> url: https://github.com/0day-ci/linux/commits/Nicolas-Saenz-Julienne/mm-page_alloc-Remote-per-cpu-page-list-drain-support/20211104-010825
> base: https://github.com/hnaz/linux-mm master
> patch link: https://lore.kernel.org/lkml/20211103170512.2745765-3-nsaenzju@redhat.com
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +--------------------------------------------+------------+------------+
> >                                            | 69c421f2b4 | 5541e53659 |
> +--------------------------------------------+------------+------------+
> > boot_successes                             | 11         | 0          |
> > boot_failures                              | 0          | 11         |
> > BUG:spinlock_bad_magic_on_CPU              | 0          | 11         |
> > BUG:using_smp_processor_id()in_preemptible | 0          | 11         |
> +--------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [    0.161872][    T0] BUG: spinlock bad magic on CPU#0, swapper/0
> [    0.162248][    T0]  lock: 0xeb24bef0, .magic: 00000000, .owner: swapper/0, .owner_cpu: 0
> [    0.162767][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc7-mm1-00437-g5541e5365954 #1
> [    0.163325][    T0] Call Trace:
> [ 0.163524][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
> [ 0.163802][ T0] dump_stack (lib/dump_stack.c:114) 
> [ 0.164050][ T0] spin_bug (kernel/locking/spinlock_debug.c:70 kernel/locking/spinlock_debug.c:77) 
> [ 0.164296][ T0] do_raw_spin_unlock (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/asm-generic/qspinlock.h:28 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140) 
> [ 0.164624][ T0] _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:194) 
> [ 0.164971][ T0] free_unref_page (include/linux/spinlock.h:423 mm/page_alloc.c:3400) 
> [ 0.165253][ T0] free_the_page (mm/page_alloc.c:699) 
> [ 0.165521][ T0] __free_pages (mm/page_alloc.c:5453) 
> [ 0.165785][ T0] add_highpages_with_active_regions (include/linux/mm.h:2511 arch/x86/mm/init_32.c:416) 
> [ 0.166179][ T0] set_highmem_pages_init (arch/x86/mm/highmem_32.c:30) 
> [ 0.166501][ T0] mem_init (arch/x86/mm/init_32.c:749 (discriminator 2)) 
> [ 0.166749][ T0] start_kernel (init/main.c:842 init/main.c:988) 
> [ 0.167026][ T0] ? early_idt_handler_common (arch/x86/kernel/head_32.S:417) 
> [ 0.167369][ T0] i386_start_kernel (arch/x86/kernel/head32.c:57) 
> [ 0.167662][ T0] startup_32_smp (arch/x86/kernel/head_32.S:328) 

I did test this with lock debugging enabled, but I somehow missed this stack
trace. Here's the fix:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7dbdab100461..c8964e28aa59 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6853,6 +6853,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
        pcp->high = BOOT_PAGESET_HIGH;
        pcp->batch = BOOT_PAGESET_BATCH;
        pcp->free_factor = 0;
+       spin_lock_init(&pcp->lock);
 }
 
 static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
@@ -6902,7 +6903,6 @@ void __meminit setup_zone_pageset(struct zone *zone)
                struct per_cpu_zonestat *pzstats;
 
                pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-               spin_lock_init(&pcp->lock);
                pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
                per_cpu_pages_init(pcp, pzstats);
        }

-- 
Nicolás Sáenz

