Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E964634A7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCZNCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230218AbhCZNBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616763707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRQaAdx++mnEYaHuCYocWMdWO77qGEyQoebROUQWcRY=;
        b=DNuCtG3xTBMYc4++TWaTCW3rfZxokKot0tFNygtr45vkgkRh2wVyO2YPYcagwEDkWrU0+T
        w9lTRDHZS6klKr6gX2bTdCvSfRlO1/Q0PwkROiUyFPkxKMCTYn0ipRSeXb9uKTfK8Wm6YJ
        ww+YJGCH4qTByjfH63qwkz4qYBkIcR4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-3GnLwMKFM_CVt1jNNl4XyQ-1; Fri, 26 Mar 2021 09:01:45 -0400
X-MC-Unique: 3GnLwMKFM_CVt1jNNl4XyQ-1
Received: by mail-ed1-f71.google.com with SMTP id i6so4392855edq.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JRQaAdx++mnEYaHuCYocWMdWO77qGEyQoebROUQWcRY=;
        b=EyO4JYy2wXvz0Oz8aRaEJ8rJk+NeAT5OwLSwXU2gCGoNmxfiGs9OsL4RC/xAwLV/8o
         3+mwMd+uJvW7h3u4xK99u/LVJurvdcvSwjBnBr8ofzAXiXB0ziLZosyZHY0Xe83uTv71
         Rz0iid5qX8YGnSc3/qyFZUGzoupzVOfGGgqTt0sfXIGr19r1lkCvWrG3049we8dYM8oP
         qPkedOXmsRPQetSK2cGcv7Sunpeq5yKuCTGwhw1Aci5kIklG25UzN2ZejYdccTLd9bfE
         DAn6RJjKfhmtxgcKzXw1f6vOl9pqJy3BWnc3QoW1AT4VfT7zGXb+e5ejgtXGcudp+4GY
         Y+7w==
X-Gm-Message-State: AOAM532rSNSqlzKFENIr66lCpvOPtEa8dBTuJsfy1riGJqUQZSaGtgMZ
        ALIWp0XfwiQJYERgWiYKA8QZG7xfFpaT0ckceE17kQarP7XxGq+jXx3tFk6bLm0MN08Bv5aQOTW
        +woazFvpHab7oEkE4PzyHcrxq/2ATz28P6ER87V+APW6WsF3VzJdFOldhYlSYSJH9QqSeSXXeQa
        o9
X-Received: by 2002:a17:906:b1d4:: with SMTP id bv20mr15320359ejb.46.1616763701809;
        Fri, 26 Mar 2021 06:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEuG33i2lwyoA414gaiALmarFRKkgBZbTIDTcF53mrBWq0VE+HhSSWFtli+8L9nxF3XVhj2g==
X-Received: by 2002:a17:906:b1d4:: with SMTP id bv20mr15319976ejb.46.1616763696619;
        Fri, 26 Mar 2021 06:01:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r24sm4150534edw.11.2021.03.26.06.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 06:01:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kvmclock: Stop kvmclocks for hibernate restore
In-Reply-To: <87h7kyccpu.fsf@vitty.brq.redhat.com>
References: <20210311132847.224406-1-lszubowi@redhat.com>
 <87sg4t7vqy.fsf@vitty.brq.redhat.com>
 <5048babd-a40b-5a95-9dee-ab13367de6cb@redhat.com>
 <87mtuqchdu.fsf@vitty.brq.redhat.com>
 <87h7kyccpu.fsf@vitty.brq.redhat.com>
Date:   Fri, 26 Mar 2021 14:01:35 +0100
Message-ID: <87eeg2cbm8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

..

> (this is with your v2 included). There's nothing about CPU0 for
> e.g. async PF + timestamps are really interesting. Seems we have issues
> to fix) I'm playing with it right now.

What if we do the following (instead of your patch):

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 78bb0fae3982..c32392d6329d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -26,6 +26,7 @@
 #include <linux/kprobes.h>
 #include <linux/nmi.h>
 #include <linux/swait.h>
+#include <linux/syscore_ops.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -598,17 +599,21 @@ static void kvm_guest_cpu_offline(void)
 
 static int kvm_cpu_online(unsigned int cpu)
 {
-	local_irq_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	kvm_guest_cpu_init();
-	local_irq_enable();
+	local_irq_restore(flags);
 	return 0;
 }
 
 static int kvm_cpu_down_prepare(unsigned int cpu)
 {
-	local_irq_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	kvm_guest_cpu_offline();
-	local_irq_enable();
+	local_irq_restore(flags);
 	return 0;
 }
 #endif
@@ -639,6 +644,23 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
 	native_flush_tlb_others(flushmask, info);
 }
 
+static int kvm_suspend(void)
+{
+	kvm_guest_cpu_offline();
+
+	return 0;
+}
+
+static void kvm_resume(void)
+{
+	kvm_cpu_online(raw_smp_processor_id());
+}
+
+static struct syscore_ops kvm_syscore_ops = {
+	.suspend	= kvm_suspend,
+	.resume		= kvm_resume,
+};
+
 static void __init kvm_guest_init(void)
 {
 	int i;
@@ -681,6 +703,8 @@ static void __init kvm_guest_init(void)
 	kvm_guest_cpu_init();
 #endif
 
+	register_syscore_ops(&kvm_syscore_ops);
+
 	/*
 	 * Hard lockup detection is enabled by default. Disable it, as guests
 	 * can get false positives too easily, for example if the host is
-- 
2.30.2

This seems to work fine (according to the log, I haven't checked yet
that PV features are actually working):

[   20.678081] PM: hibernation: Creating image:
[   20.689925] PM: hibernation: Need to copy 82048 pages
[    2.302411] kvm-clock: cpu 0, msr 2c201001, primary cpu clock, resume
[    2.302487] PM: Restoring platform NVS memory
[    2.302498] kvm-guest: KVM setup async PF for cpu 0
[    2.302502] kvm-guest: stealtime: cpu 0, msr 3ec2c080
[    2.304754] Enabling non-boot CPUs ...
[    2.304823] x86: Booting SMP configuration:
[    2.304824] smpboot: Booting Node 0 Processor 1 APIC 0x1
[    2.304952] kvm-clock: cpu 1, msr 2c201041, secondary cpu clock
[    2.305400] kvm-guest: KVM setup async PF for cpu 1
[    2.305405] kvm-guest: stealtime: cpu 1, msr 3ecac080
[    2.305786] CPU1 is up
[    2.305818] smpboot: Booting Node 0 Processor 2 APIC 0x2
[    2.305920] kvm-clock: cpu 2, msr 2c201081, secondary cpu clock
[    2.306325] kvm-guest: KVM setup async PF for cpu 2
[    2.306330] kvm-guest: stealtime: cpu 2, msr 3ed2c080
[    2.306599] CPU2 is up
[    2.306627] smpboot: Booting Node 0 Processor 3 APIC 0x3
[    2.306729] kvm-clock: cpu 3, msr 2c2010c1, secondary cpu clock
[    2.307092] kvm-guest: KVM setup async PF for cpu 3
[    2.307097] kvm-guest: stealtime: cpu 3, msr 3edac080
[    2.307383] CPU3 is up
[    2.307560] ACPI: Waking up from system sleep state S4
[    2.318778] sd 0:0:0:0: [sda] Starting disk
[    2.342335] OOM killer enabled.
[    2.342817] Restarting tasks ... done.
[    2.346209] PM: hibernation: hibernation exit

-- 
Vitaly

