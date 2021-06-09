Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E583A20EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhFIXpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhFIXpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:45:09 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878CC0617AE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 16:42:54 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r17-20020ac842510000b02902456ec03025so8442567qtm.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=TSyhgxkAM87zPQDaBTB/xYIGoMe0SaHqhMUIzhv8SIc=;
        b=uAMj2WkqpBB4NV2SMlBv+LrSjvGsZgAFPCUKGdnlt4go5X6wG+GmFSR0KLzuX/PVbZ
         OAKh5QDgt5Q1OGS7e2dDtyN08kHG5SeRB4uBeduWhaq+63jDEA3KvST5qi77s/+BZUC1
         Aeowf1/E6dAnI1Gg9ibHAijPlDTQHgxpPsl9duyrM2ymFI8Xzt2caAriDboHDXm6ma3y
         e22v2GJ6swXY+gSKwr58QSKwO4FzW99NFvVYwz+Jt4CH00t+zeJy36tN6gq6enzNhYmI
         W5P6+ACmEzBZJIvnIAKvNdrfKeO2L09H6zUMSPlnLbELvLFKWoc3hiPzJjUeGyIlXLbL
         soiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=TSyhgxkAM87zPQDaBTB/xYIGoMe0SaHqhMUIzhv8SIc=;
        b=YIQ1P6+FDEIVE7TsyVngc1+CuXs5ZyBBjWZ48Oj7/wUGsSkjelECrsZfrMM7DRZzl3
         95TkFIO7rx7kLd9mBU+MZMEHaLYjIImo/us1ibbkYj/XI0e0a9lgzeGpg+1ut3lyCpzl
         CrwePtu98cf32bjqhnClRcAKS+IldXWnwMTeNcUEHqorBlnVcjBmhKrn/9+ac2T+b+BN
         JhjVhz+br7zeNoxUhESDCnogpsM3Amv9rPJ3kn31NG23x2gCd2DCaQXqL/S1T8zxi6tM
         aembaYYlsIWS1Rasuf/bWZ1q6CXKKl5HU3RLftAjWmv99yprhNJMHhpe7QoFGi1enHSg
         B59w==
X-Gm-Message-State: AOAM530fnovCJx68FjVm6MB8/GWDF5U4z/qlOKhEsEvc0kVm/xhM1TU8
        +2RncqYITUBT+o0mjZSbn1O4F7FA6sU=
X-Google-Smtp-Source: ABdhPJxt9s6tpqX+2vXnuajtY+tmND2r+hdonH3bjIK3Ank/XmwdAQ1TFT/vKoKqFPLk2R1fpLNcv5HUggQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:8daf:e5e:ae50:4f28])
 (user=seanjc job=sendgmr) by 2002:ad4:4dcb:: with SMTP id cw11mr2243546qvb.54.1623282173808;
 Wed, 09 Jun 2021 16:42:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  9 Jun 2021 16:42:25 -0700
In-Reply-To: <20210609234235.1244004-1-seanjc@google.com>
Message-Id: <20210609234235.1244004-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210609234235.1244004-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 05/15] KVM: x86: Uncondtionally skip MMU sync/TLB flush in MOV
 CR3's PGD switch
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop leveraging the MMU sync and TLB flush requested by the fast PGD
switch helper now that kvm_set_cr3() manually handles the necessary sync,
frees, and TLB flush.  This will allow dropping the params from the fast
PGD helpers since nested SVM is now the odd blob out.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e2f6d6a1ba54..02ceb1f606f4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1136,7 +1136,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 		return 1;
 
 	if (cr3 != kvm_read_cr3(vcpu))
-		kvm_mmu_new_pgd(vcpu, cr3, skip_tlb_flush, skip_tlb_flush);
+		kvm_mmu_new_pgd(vcpu, cr3, true, true);
 
 	vcpu->arch.cr3 = cr3;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

