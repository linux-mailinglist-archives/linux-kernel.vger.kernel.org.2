Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00D032F393
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCETLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCETLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:11:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F26C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:11:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id h10so4102860edl.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IrbPr2dxqhk1LIshWckizJrjWuDkNE3QCmnBYka+BEI=;
        b=IiS41fasXdQwaDOHMZSyrA6ibGAJNX+B+j6PCVlFBzpuFru8pT8e+Txn2xZiK4H8HK
         0KhdvxzWcty6y9XpMeJgewQlJtwVkzLfsnVeZjZPbYY1W576h0f4I8SytVfcCCfkwsDL
         nI0YUTo1qcsiapbFjpWtH9nSgxIZCECRxaOzQQmYRsBA6xLRYFwYlU24gAOnkM1vR/gB
         8E6KMZVT3Vx/CIcM0RJQ97RA8sX7gFJmV9dMuKIGvQQR+lGA7SNKWFd6rZjk7ZKy/EqF
         djxPpgem1IneOQQm3BC04pACjKVMlfRGG6kD/+0dINoYkrCq3xoK/1192v1VBIGLeqsK
         FD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IrbPr2dxqhk1LIshWckizJrjWuDkNE3QCmnBYka+BEI=;
        b=oIkawZsaOMBwOQXBl3hnQ4yl61BLxbpsiykbr/0xMOLDTlJuW0yOt7R5tkE32ZQc7Y
         oLTBzAZtf8PLYnCof+dP7HSXTEMY62komeN633U10jN7csy2w0mE1IDAz7kinYmmgoDM
         WUwnHqyMZcs9uW8iw28uaZxUFqosv/C49TFMtmeaza3w0/MoJNswFFAfw/cR5JRj/O8h
         M/o0IEnaDK4mkuLkrPsRZIq5up+k8hEZ+S0+m88ZAPAglKhTrKmCdsZx5Da1zxSx/jTb
         VTWdW0KCIGfikneM6pM6IrSXWC2bsuWa9WO9u8Gi+HXc417kWcAbo6Yim65Rw/73ANqi
         D15A==
X-Gm-Message-State: AOAM531HtB8pEbn1YiBXMbCvNg6K4XmZSiqRPRdGHrnjN6hDKWwYb1JW
        fGQmt3dXnVRDGjEsv5slWAI=
X-Google-Smtp-Source: ABdhPJyEncuNScBLMIBXfjNQ1HGMuNCBiziSthU5xntMW0yw9BwiB9d7763rjwregyBESusRYm3+KQ==
X-Received: by 2002:a05:6402:5:: with SMTP id d5mr10659194edu.121.1614971490101;
        Fri, 05 Mar 2021 11:11:30 -0800 (PST)
Received: from LEGION ([27.255.58.138])
        by smtp.gmail.com with ESMTPSA id bm21sm1952508ejb.100.2021.03.05.11.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:11:29 -0800 (PST)
Date:   Sat, 6 Mar 2021 00:11:23 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     musamaanjum@gmail.com
Subject: [PATCH] kvm: x86: annotate RCU pointers
Message-ID: <20210305191123.GA497469@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the annotation to fix the following sparse errors:
arch/x86/kvm//x86.c:8147:15: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//x86.c:8147:15:    struct kvm_apic_map [noderef] __rcu *
arch/x86/kvm//x86.c:8147:15:    struct kvm_apic_map *
arch/x86/kvm//x86.c:10628:16: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//x86.c:10628:16:    struct kvm_apic_map [noderef] __rcu *
arch/x86/kvm//x86.c:10628:16:    struct kvm_apic_map *
arch/x86/kvm//x86.c:10629:15: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//x86.c:10629:15:    struct kvm_pmu_event_filter [noderef] __rcu *
arch/x86/kvm//x86.c:10629:15:    struct kvm_pmu_event_filter *
arch/x86/kvm//lapic.c:267:15: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//lapic.c:267:15:    struct kvm_apic_map [noderef] __rcu *
arch/x86/kvm//lapic.c:267:15:    struct kvm_apic_map *
arch/x86/kvm//lapic.c:269:9: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//lapic.c:269:9:    struct kvm_apic_map [noderef] __rcu *
arch/x86/kvm//lapic.c:269:9:    struct kvm_apic_map *
arch/x86/kvm//lapic.c:637:15: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//lapic.c:637:15:    struct kvm_apic_map [noderef] __rcu *
arch/x86/kvm//lapic.c:637:15:    struct kvm_apic_map *
arch/x86/kvm//lapic.c:994:15: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//lapic.c:994:15:    struct kvm_apic_map [noderef] __rcu *
arch/x86/kvm//lapic.c:994:15:    struct kvm_apic_map *
arch/x86/kvm//lapic.c:1036:15: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//lapic.c:1036:15:    struct kvm_apic_map [noderef] __rcu *
arch/x86/kvm//lapic.c:1036:15:    struct kvm_apic_map *
arch/x86/kvm//lapic.c:1173:15: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//lapic.c:1173:15:    struct kvm_apic_map [noderef] __rcu *
arch/x86/kvm//lapic.c:1173:15:    struct kvm_apic_map *
arch/x86/kvm//pmu.c:190:18: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//pmu.c:190:18:    struct kvm_pmu_event_filter [noderef] __rcu *
arch/x86/kvm//pmu.c:190:18:    struct kvm_pmu_event_filter *
arch/x86/kvm//pmu.c:251:18: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//pmu.c:251:18:    struct kvm_pmu_event_filter [noderef] __rcu *
arch/x86/kvm//pmu.c:251:18:    struct kvm_pmu_event_filter *
arch/x86/kvm//pmu.c:522:18: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//pmu.c:522:18:    struct kvm_pmu_event_filter [noderef] __rcu *
arch/x86/kvm//pmu.c:522:18:    struct kvm_pmu_event_filter *
arch/x86/kvm//pmu.c:522:18: error: incompatible types in comparison expression (different address spaces):
arch/x86/kvm//pmu.c:522:18:    struct kvm_pmu_event_filter [noderef] __rcu *
arch/x86/kvm//pmu.c:522:18:    struct kvm_pmu_event_filter *

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 arch/x86/include/asm/kvm_host.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 84499aad01a4..ad675c8c05e7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -958,7 +958,7 @@ struct kvm_arch {
 	struct kvm_pit *vpit;
 	atomic_t vapics_in_nmi_mode;
 	struct mutex apic_map_lock;
-	struct kvm_apic_map *apic_map;
+	struct kvm_apic_map __rcu *apic_map;
 	atomic_t apic_map_dirty;
 
 	bool apic_access_page_done;
@@ -1030,7 +1030,7 @@ struct kvm_arch {
 
 	bool bus_lock_detection_enabled;
 
-	struct kvm_pmu_event_filter *pmu_event_filter;
+	struct kvm_pmu_event_filter __rcu *pmu_event_filter;
 	struct task_struct *nx_lpage_recovery_thread;
 
 #ifdef CONFIG_X86_64
-- 
2.25.1

