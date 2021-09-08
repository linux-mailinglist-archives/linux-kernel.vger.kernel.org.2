Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363D94031D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhIHAZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhIHAZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:25:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B192C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 17:24:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f64-20020a2538430000b0290593bfc4b046so350030yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=eECNEybjWQ2PoVflYqmH9Ss/tHTEVMaEvYYBIsHokWk=;
        b=KCQwWabnOZHPBdoppj+q/i1OmGIqoG6FtmQSu3XNb4D9Z11Zr6bbEEgjmtHBtMMgfl
         6ZofGOtxUxvdQWwDKq60DBkANY/+x+K3Mr/Mvif6+Lal5SRevhy1XAF7z+DS6y/yF6ZE
         YdeVJy07desRWit2hA6abp20jtGFj063Q2R8NMbdHCp3SI5mSfdi1lrayCXCJla8f6zR
         bScLVXHxxIZXcBVA3xl7zlItog1Y/MJB7RAqtSaTp4DS1P/xu8YMWbuyPRKjS4ce1SxU
         YLpG80fqQ4dMt4a3dGdHudp7rpdUeDZi+FZV7xTb4ryQy0rfcfiomP7974s6PhxTooAK
         ZuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=eECNEybjWQ2PoVflYqmH9Ss/tHTEVMaEvYYBIsHokWk=;
        b=ZjTPZ92KXDCSO2sVjzRLsauOxJmVV+TIznZvDYISJn4feYPnVFgH+YJi4mDB+a8bB/
         BSHoksduH1lk+oCUIsn1Fp8HLzL9D8p400NbpRc8tAx0Dr+pFL0MGCtfl8z7fH8WzKy7
         Q4UxyXnKW/SZ37ZHzmAw8wWOzeuVJATo5AzrJJgR1cA2UogpHeegYZ1A1f2JmQz2s1iF
         WztVhp/7ZY46Po7bvmhEou4eAJQfog8kSa2nmbc5x1eTAF2Ax30O6RY9CsUrgjqTKJv+
         /JAn2HOnQmU7MP+6lQjGffG4meSI6iqz/XJ3/9HfG1Ap926tjVytR3M2YN4uBFS+nNve
         hKEQ==
X-Gm-Message-State: AOAM5338R3KxsSYFcz1A6gut3l0Pq0YtwiYPyY4TZ+V2hixzcHWqtbMi
        rVZKbEeym5R4uPRnz2bOXY8o6k/wLWM=
X-Google-Smtp-Source: ABdhPJyltULn5jF+JE9zJFXzO5Cg7xV9DjZaXnXK2vKEv9y1LzXZQh+tRvh/VGB2PX6cN6p1il+5mi908MU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:bd1:945f:2492:aa51])
 (user=seanjc job=sendgmr) by 2002:a25:ba08:: with SMTP id t8mr1473912ybg.111.1631060644483;
 Tue, 07 Sep 2021 17:24:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Sep 2021 17:24:01 -0700
Message-Id: <20210908002401.1947049-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] KVM: VMX: Remove defunct "nr_active_uret_msrs" field
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove vcpu_vmx.nr_active_uret_msrs and its associated comment, which are
both defunct now that KVM keeps the list constant and instead explicitly
tracks which entries need to be loaded into hardware.

No functional change intended.

Fixes: ee9d22e08d13 ("KVM: VMX: Use flag to indicate "active" uret MSRs instead of sorting list")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 4858c5fd95f2..02ab3468885f 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -248,12 +248,8 @@ struct vcpu_vmx {
 	 * only loaded into hardware when necessary, e.g. SYSCALL #UDs outside
 	 * of 64-bit mode or if EFER.SCE=1, thus the SYSCALL MSRs don't need to
 	 * be loaded into hardware if those conditions aren't met.
-	 * nr_active_uret_msrs tracks the number of MSRs that need to be loaded
-	 * into hardware when running the guest.  guest_uret_msrs[] is resorted
-	 * whenever the number of "active" uret MSRs is modified.
 	 */
 	struct vmx_uret_msr   guest_uret_msrs[MAX_NR_USER_RETURN_MSRS];
-	int                   nr_active_uret_msrs;
 	bool                  guest_uret_msrs_loaded;
 #ifdef CONFIG_X86_64
 	u64		      msr_host_kernel_gs_base;
-- 
2.33.0.309.g3052b89438-goog

