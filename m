Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C94931A949
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhBMBHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhBMBGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:06:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95BCC061794
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:05:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i2so1588217ybl.16
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=K6GpRs9FR8BeiWVjAaubiS/GB9p5ADQHu9rZN6FFHVQ=;
        b=L5fSLUAHoVIcedkgWCwU3hPyKW4aU3nlVu1zHtinTYWv7ikUhlJ0+JGT7Ek5gD0zxO
         26uS1yYQzOCiAQC7l0fELfn+rbjT+muiIraHQc7YLm8x/EkMFqHX822srIEB8B+gAzuH
         8wWLa3VskNVfQAEVXmgkN4Ax0dt56CfD0uzKyOuKRU6a34hSYthHuPcBOYKXLMq/Y2Qd
         DSDkWLWrAeV3eV5EhkAH+n/PUNITw30XJ5V1eeGjHXFvwMmR/oUY4HQIxtgy3BEkQY+l
         17hCtpujPDxZhb16gNcqJ7+3mEMSkqgcNSyTpKePvKvF3vXZDB0Bnx4LICRqSho3N1YF
         P0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=K6GpRs9FR8BeiWVjAaubiS/GB9p5ADQHu9rZN6FFHVQ=;
        b=kddpvfttUzE7L93uuxE7uRMM2K0l/cijBL3EEuJSLcTuNsE1JLvTEhxit2tOskrc9q
         vDJblpRt4r22tk+j32poNFTQ5RL4Hz5QUAF0yuGpuKSqX6ljMXukEjkfBVwvf0DugmHL
         pzrPiqabVinBNruEQQ6wn5XKoiv+zXr4Rounqx4FsV3IZ0+o5kjU5vjIWwXjDAe60KeE
         C4ZKBLqjar3hrXcJKQn9LVRHkXPG5rCmCaIhjvpaUwPKfsWDqlnMgY38OwFpMX7yDlA+
         3vdi+NGnhQbGsgsE7BmhiTzMTBj66D+yosTZSMDe79cR0sp+cNG7cyCnpL83Cb+GhS4h
         NiMg==
X-Gm-Message-State: AOAM530AFVrpesnWLXL95AfkLty9P9n1XQCOhRq23bWKfcDW8dw8u68w
        xH4942FcIwa+Xl9L9lGSSUF3P1m52zQ=
X-Google-Smtp-Source: ABdhPJyqPwzyhV5/NL+RxD+oLqbn8FweVhzS2bV2tQiUSPPujPrp/n+aapmAsQ4H5GF50ExYUBZGWrS7EGs=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b407:1780:13d2:b27])
 (user=seanjc job=sendgmr) by 2002:a25:c943:: with SMTP id z64mr7637015ybf.367.1613178337159;
 Fri, 12 Feb 2021 17:05:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 Feb 2021 17:05:13 -0800
In-Reply-To: <20210213010518.1682691-1-seanjc@google.com>
Message-Id: <20210213010518.1682691-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210213010518.1682691-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 4/9] KVM: VMX: Truncate GPR value for DR and CR reads in
 !64-bit mode
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop bits 63:32 when storing a DR/CR to a GPR when the vCPU is not in
64-bit mode.  Per the SDM:

  The operand size for these instructions is always 32 bits in non-64-bit
  modes, regardless of the operand-size attribute.

CR8 technically isn't affected as CR8 isn't accessible outside of 64-bit
mode, but fix it up for consistency and to allow for future cleanup.

Fixes: 6aa8b732ca01 ("[PATCH] kvm: userspace interface")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e0a3a9be654b..115826a020ff 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5067,12 +5067,12 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		case 3:
 			WARN_ON_ONCE(enable_unrestricted_guest);
 			val = kvm_read_cr3(vcpu);
-			kvm_register_write(vcpu, reg, val);
+			kvm_register_writel(vcpu, reg, val);
 			trace_kvm_cr_read(cr, val);
 			return kvm_skip_emulated_instruction(vcpu);
 		case 8:
 			val = kvm_get_cr8(vcpu);
-			kvm_register_write(vcpu, reg, val);
+			kvm_register_writel(vcpu, reg, val);
 			trace_kvm_cr_read(cr, val);
 			return kvm_skip_emulated_instruction(vcpu);
 		}
@@ -5145,7 +5145,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 		unsigned long val;
 
 		kvm_get_dr(vcpu, dr, &val);
-		kvm_register_write(vcpu, reg, val);
+		kvm_register_writel(vcpu, reg, val);
 		err = 0;
 	} else {
 		err = kvm_set_dr(vcpu, dr, kvm_register_readl(vcpu, reg));
-- 
2.30.0.478.g8a0d178c01-goog

