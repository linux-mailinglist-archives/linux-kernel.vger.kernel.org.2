Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF2447D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhKHKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhKHKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:03:36 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC1C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:00:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v20so15411860plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 02:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DBVzytw4D1YTwYT+DsGlJJzUw8QXZnKsBeHYwTIYWwQ=;
        b=jRVncTNvDNGMR2GWFuaVIGBu/CtbGyhvjNOGLdvBDUOHw8jaM7slbhhjyrZH/B8kck
         4zrdIySul5eWNo4R7/RJkqsKNa6lkWES9tVlFEdeFrXR+txN8k71VGGZUR1f2ddKeeSW
         8kvt051PYsVtZmx74ExeYgFVDWSC17DYo4AQNS2DBuSUfWvmu2pMY7XmzaOa6txsZsIf
         tngrxhZSmahReKSSR1FY6CLBI6V5eg4V3nSw93lNu4/aNLS8iR2bx/SAgFMi3huKXgCG
         7ekZGGJFtzcejGA8crt0VL+quC+lWOfY10Xv4CBYJWviBUzEIxtQWnppriNDDT+nzGTX
         0tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DBVzytw4D1YTwYT+DsGlJJzUw8QXZnKsBeHYwTIYWwQ=;
        b=gaf/pAGfUN4r8Ts0Ed72TnRfg8tvJJK4RuY5hloO6EcFsUfLMo+xTDxkrwFdpZUA/b
         MmVo2QefmG25k0fEcXSdwfSR+KIGErNHi+YdQVPV2O8GhaVgLSLh2BLMqDBeSPyu8cqE
         tknB87IWusiJTEEhpiR42/ObgclwoNcC0S6SJcoNwFWsiW0GHZWZShg/UnIFcSDDj7Z1
         6OKJ7FhdYswYyUI1G3WmsKVCuZ6bi2/e5lcU7Xq3R5wASPppMdr3arpuK+/8gZyZDCxx
         R4od0Br2m+adrFetNUWo+GawR6Osy7StaV7fAbWksbPVn/EzZv0IfBsAAdwIqzgYAbzO
         HdpQ==
X-Gm-Message-State: AOAM533OSWaqbPb/YrHqYXzlIa4THin71mnXKi8zM21nuW/jdwcFely8
        wHQGKYzuVolcZq/ZFYcMxv0UNw==
X-Google-Smtp-Source: ABdhPJx00ktR3KeutMoUZWqJOyIr+7btkj6PJJAfLqoKZilugX89zBWFSh5p4x1JY1cTgNsCRuwQbQ==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr50598826pjb.22.1636365651996;
        Mon, 08 Nov 2021 02:00:51 -0800 (PST)
Received: from n198-098-106.byted.org ([49.7.44.144])
        by smtp.googlemail.com with ESMTPSA id k22sm14942946pfi.149.2021.11.08.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 02:00:51 -0800 (PST)
From:   Kele Huang <huangkele@bytedance.com>
To:     pbonzini@redhat.com
Cc:     chaiwen.cc@bytedance.com, xieyongji@bytedance.com,
        dengliang.1214@bytedance.com, pizhenwei@bytedance.com,
        wanpengli@tencent.com, seanjc@google.com, huangkele@bytedance.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] KVM: x86: SVM: don't expose PV_SEND_IPI feature with AVIC
Date:   Mon,  8 Nov 2021 17:59:31 +0800
Message-Id: <20211108095931.618865-1-huangkele@bytedance.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, AVIC is disabled if x2apic feature is exposed to guest
or in-kernel PIT is in re-injection mode.

We can enable AVIC with options:

  Kmod args:
  modprobe kvm_amd avic=1 nested=0 npt=1
  QEMU args:
  ... -cpu host,-x2apic -global kvm-pit.lost_tick_policy=discard ...

When LAPIC works in xapic mode, both AVIC and PV_SEND_IPI feature
can accelerate IPI operations for guest. However, the relationship
between AVIC and PV_SEND_IPI feature is not sorted out.

In logical, AVIC accelerates most of frequently IPI operations
without VMM intervention, while the re-hooking of apic->send_IPI_xxx
from PV_SEND_IPI feature masks out it. People can get confused
if AVIC is enabled while getting lots of hypercall kvm_exits
from IPI.

In performance, benchmark tool
https://lore.kernel.org/kvm/20171219085010.4081-1-ynorov@caviumnetworks.com/
shows below results:

  Test env:
  CPU: AMD EPYC 7742 64-Core Processor
  2 vCPUs pinned 1:1
  idle=poll

  Test result (average ns per IPI of lots of running):
  PV_SEND_IPI 	: 1860
  AVIC 		: 1390

Besides, disscussions in https://lkml.org/lkml/2021/10/20/423
do have some solid performance test results to this.

This patch fixes this by masking out PV_SEND_IPI feature when
AVIC is enabled in setting up of guest vCPUs' CPUID.

Signed-off-by: Kele Huang <huangkele@bytedance.com>
---
 arch/x86/kvm/cpuid.c   |  4 ++--
 arch/x86/kvm/svm/svm.c | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2d70edb0f323..cc22975e2ac5 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -194,8 +194,6 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		best->ecx |= XFEATURE_MASK_FPSSE;
 	}
 
-	kvm_update_pv_runtime(vcpu);
-
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
 	vcpu->arch.reserved_gpa_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu);
 
@@ -208,6 +206,8 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	/* Invoke the vendor callback only after the above state is updated. */
 	static_call(kvm_x86_vcpu_after_set_cpuid)(vcpu);
 
+	kvm_update_pv_runtime(vcpu);
+
 	/*
 	 * Except for the MMU, which needs to do its thing any vendor specific
 	 * adjustments to the reserved GPA bits.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b36ca4e476c2..b13bcfb2617c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4114,6 +4114,19 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		if (nested && guest_cpuid_has(vcpu, X86_FEATURE_SVM))
 			kvm_request_apicv_update(vcpu->kvm, false,
 						 APICV_INHIBIT_REASON_NESTED);
+
+		if (!guest_cpuid_has(vcpu, X86_FEATURE_X2APIC) &&
+				!(nested && guest_cpuid_has(vcpu, X86_FEATURE_SVM))) {
+			/*
+			 * PV_SEND_IPI feature masks out AVIC acceleration to IPI.
+			 * So, we do not expose PV_SEND_IPI feature to guest when
+			 * AVIC is enabled.
+			 */
+			best = kvm_find_cpuid_entry(vcpu, KVM_CPUID_FEATURES, 0);
+			if (best && enable_apicv &&
+					(best->eax & (1 << KVM_FEATURE_PV_SEND_IPI)))
+				best->eax &= ~(1 << KVM_FEATURE_PV_SEND_IPI);
+		}
 	}
 	init_vmcb_after_set_cpuid(vcpu);
 }
-- 
2.11.0

