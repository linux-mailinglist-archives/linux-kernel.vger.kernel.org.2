Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31106367760
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhDVCWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhDVCWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:22:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44072C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d89-20020a25a3620000b02904dc8d0450c6so18079590ybi.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Up7S2qodevYtR008I3N0rggUDJORgGSJOkF2xutYXJ0=;
        b=iIdJsgJUtTjMzT+78kXuGep6+9QHGKme0vpzT1R8IH880SWMlq/UZlo0s4bPP04QVf
         IzzhMTDswyo0OclKvrmGOVzZsr2ue1OXAZA13fMO4nhocaYSAuh1AiaonCfqt6OFHlZh
         eUXunQu8+mQ8MIb41v5rD1DXlaNowrWtD4Fj9zi+eb494QEHW1aWRef1Nx/O1zD24vLR
         CZhFIFPfwRhtt7iBtoKpQIG1UF4dVRvqWIoPEyFFcuX4qEC8SPCcbnGnteKhMDuz1mED
         68aPhgT+WzNNpVNfSfGmaJSQQpuNAtPGzFSerpkS+Wh7P9i96HrlaMhQ/NZoh5w/w9mO
         LFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Up7S2qodevYtR008I3N0rggUDJORgGSJOkF2xutYXJ0=;
        b=AVjkeYYApZMvubekzjuOvYv7bOkylT4QQa01Cv2fiJl/3DO0Yg6+PO/TXa4PGDDVsF
         6kINF2IpbuzE5uQu0BQb315JLJSxjPxsWfTSGOjWMsSxtqf6sexE1WBCMvOvtt7kzgYh
         i2/ODXrVCtnwQEq46XgSSw8L1yYMTEORsPvd6HmkLeB4jEt3DPTDFchTWUrnAkFXWbZN
         eIgVRlbHXk+oxWlMheJF3n8V+EOi6RPG+VR0e6T0lVC0VuIlsRX69JuAY+Hlfmm3mE0a
         m0UKLlU8D/98c/Rb8XuIk6PRPAxJEypHEt5srkmIIidN2fb+BlESCfMhUooP0J8VfXBH
         4gKw==
X-Gm-Message-State: AOAM5315NtqSo3JHdS/0Nj8J4YA0lKMk/ql92snw7AuC5KWovwF0+HCp
        IqbFO0sdWs59VL865D2p5UT/DmDZTSk=
X-Google-Smtp-Source: ABdhPJxUX0Vki1uKyvSo07xv+hVDoZRWGFVlxauhxPzHSyF9jmkSBHAIz9CaOamfc2tIG6F9Sa7NdN8llGY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:69ce:: with SMTP id e197mr1491219ybc.448.1619058104503;
 Wed, 21 Apr 2021 19:21:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:21:25 -0700
In-Reply-To: <20210422022128.3464144-1-seanjc@google.com>
Message-Id: <20210422022128.3464144-7-seanjc@google.com>
Mime-Version: 1.0
References: <20210422022128.3464144-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2 6/9] KVM: nVMX: Truncate base/index GPR value on address
 calc in !64-bit
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

Drop bits 63:32 of the base and/or index GPRs when calculating the
effective address of a VMX instruction memory operand.  Outside of 64-bit
mode, memory encodings are strictly limited to E*X and below.

Fixes: 064aea774768 ("KVM: nVMX: Decoding memory operands of VMX instructions")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0e580305a1ee..4daf1ff45221 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4617,9 +4617,9 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 	else if (addr_size == 0)
 		off = (gva_t)sign_extend64(off, 15);
 	if (base_is_valid)
-		off += kvm_register_read(vcpu, base_reg);
+		off += kvm_register_readl(vcpu, base_reg);
 	if (index_is_valid)
-		off += kvm_register_read(vcpu, index_reg) << scaling;
+		off += kvm_register_readl(vcpu, index_reg) << scaling;
 	vmx_get_segment(vcpu, &s, seg_reg);
 
 	/*
-- 
2.31.1.498.g6c1eba8ee3d-goog

