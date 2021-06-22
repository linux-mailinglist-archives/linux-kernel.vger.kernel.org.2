Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF73B0BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhFVSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhFVSAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:00:22 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68BCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:05 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z5-20020ac86c450000b029024e9a87714dso109037qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=CIzHUFEr3GeKAMXjnbC+xjP+Eg1EK4JnSnmAhJQMsJE=;
        b=WCs4PSsVQ6zrFs+0qZ1BRM00puOifY/e7Ztf88WvlGbmeunkDfepfkdfmUClSsXwDb
         yYQg4I6Ik2sHs8so3Ax10vc+kOszdU+ckAiqLmdc6AqRNtoGS0PA0hsbE33mF3XNmeIC
         DLFtsBHvpG6t4RG683rfJ+4GRl7aauHp8lTQHu/+Z1vaLDoz0djw/NYlwnQky6HhvXs3
         gyK1NQmyQOUA6NeoyS/OSIk4z46/FrlaxOI92qekb+EpFVkBKqLKS+3Mq9ykzdNUXF/0
         GVSB7DSwc8Zo3tTakIaMC3ZLzQj+3pMBzUYnKhq8lwn8LFsM56oHTbZdP8Db3xJVWjnZ
         yegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=CIzHUFEr3GeKAMXjnbC+xjP+Eg1EK4JnSnmAhJQMsJE=;
        b=OC8hOPmHyIsdbUJU4Vov/q/zfz+EYHZYDWKbRHFqUTtIjg7iEUroWlAfsyZOm9+oxW
         ztxeCt9zjzP5+b9xEBqg/mAhuFP5X06gVzeA44njLqZuIsCPu2hddMh+uj2B4iXCdQv/
         sDVtf2Gyi5OnBBmrsJL9BnirkXf6EPHwMfYdej5GtN1syVqgCJCIbhp7jDDwL/PU6nYx
         KntQRexcUvzkHil86I+1HAC3+2+PHmKydVPSp4TTW9PSK4S5NAfNQKW8z8JuSe7yOt4F
         +8CAdcFJFO9PKi6CosSXm6BG5QJX6MGtR7b4vyQJKpWyyh55ZYkV/Y/6qiD9PDm0mNfj
         cqCw==
X-Gm-Message-State: AOAM533N0HNLJySWN1fhAPQONg13rmld3pV8t2xJSgfeoVB9AHiiEUut
        E6/ZuRUT3mPTZMDmFjfwX3qdk1lIVRY=
X-Google-Smtp-Source: ABdhPJzmgHHM+NNllA3I3T3c3z6tsMtbpsbsqUrpXg0+3SYN522sb9bhMpGy7zTaTjtwVkUL+G7w7vnCA84=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a5b:4c6:: with SMTP id u6mr6647323ybp.31.1624384684905;
 Tue, 22 Jun 2021 10:58:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:56:49 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 04/54] KVM: x86/mmu: Use MMU's role to detect CR4.SMEP value
 in nested NPT walk
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the MMU's role to get its effective SMEP value when injecting a fault
into the guest.  When walking L1's (nested) NPT while L2 is active, vCPU
state will reflect L2, whereas NPT uses the host's (L1 in this case) CR0,
CR4, EFER, etc...  If L1 and L2 have different settings for SMEP and
L1 does not have EFER.NX=1, this can result in an incorrect PFEC.FETCH
when injecting #NPF.

Fixes: e57d4a356ad3 ("KVM: Add instruction fetch checking when walking guest page table")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 823a5919f9fa..52fffd68b522 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -471,8 +471,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 error:
 	errcode |= write_fault | user_fault;
-	if (fetch_fault && (mmu->nx ||
-			    kvm_read_cr4_bits(vcpu, X86_CR4_SMEP)))
+	if (fetch_fault && (mmu->nx || mmu->mmu_role.ext.cr4_smep))
 		errcode |= PFERR_FETCH_MASK;
 
 	walker->fault.vector = PF_VECTOR;
-- 
2.32.0.288.g62a8d224e6-goog

