Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96330CACE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhBBTAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbhBBS6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:58:33 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F8AC061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:57:46 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id a75so18156120qkg.16
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KTYEyXIgb4wI42K1yBcuqU69rlausMxtU1GwO2JJSfc=;
        b=A3SMO1A6jAqBUExSNWmRam6ysZiwsIlC52mBxT2bopExdqHIBugBrv/ileXZbdnRGF
         i8cVgOJh+zPcodoOUyleOTeF3fMbp4DaOIUDSujm6e6/7JmPxeQlrgtKDMigIhPBFzjW
         Xqiqa9WEoZ2UW+mP6GwHpblG/H2H8weZzseRVsKfn/YV7BCWl2E+gvJ1+3P7KBd7jGGp
         LnzaAVttOqPI9eBilD+UWW9acrjfAvbtPMLs/AaAe8Zff4CCewn7UMSyDnlipvlgHexG
         MDSPtzb/nEzSvA+2X8UUqlK54rdhJ9boWVXOg2MqNj8zbD0QK9BteYRh3RwsBw0UWm5Z
         60Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KTYEyXIgb4wI42K1yBcuqU69rlausMxtU1GwO2JJSfc=;
        b=Q8mW/DXSCuBc6jOoW4Txvw/MPqaxzAgY0G9/9jCV6IwD4RQLofB8DqD5D/Kg4V314Z
         OQtm4tZp30rbMeaIShYqmQ/orpFEJoj6A6VTo09O98pyF8hMK9GpZnwPIybZRF+5XJu7
         D13SuqL0c+5ESBMOcJ4Uzk77qq9SxrwVwgq2x133DITH0wf2ZAPAMjkqQVQQVhCxJTAA
         G0KuRXXLy8kHy5r3vmemRaKSA9a5NJ5Uw/skQrUnLy2lks6dyvSQ08fYYyq2sRorK6Z/
         VPpPjMbDq9dY1qCVdh/baTYwd5IPtB8p1wa8Vu1apBXi+IMBH1i2gWOXyobvC5ddrYIp
         x6+A==
X-Gm-Message-State: AOAM533qzzs1mKk+PHA7B35ci96aZFOZ8s9Xaosuuz/7H2j8VGwpgiKv
        UqraQWDcH4ZYABwiidZl3anlSNdCLRUN86/taDJNm3POYq8EiRl4/GouupRBlm4e/fONzNv7+1m
        di2/otp2iOpB8JItgKxrjLtmsr3aneRESAW3t6tf7pFmaldVIBQd+YKJtKZRJupbZY5I0BzQl
X-Google-Smtp-Source: ABdhPJw35iQ1myHf6nwzdvwrNMRryl3/GMsxE12DKFd8FH4ic90uHjpGrPkdi51usxmn3uQAKzCJ0aULv8k0
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:ad4:4f41:: with SMTP id
 eu1mr21827353qvb.34.1612292265673; Tue, 02 Feb 2021 10:57:45 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:10 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-5-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 04/28] KVM: x86/mmu: Don't redundantly clear TDP MMU pt memory
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KVM MMU caches already guarantee that shadow page table memory will
be zeroed, so there is no reason to re-zero the page in the TDP MMU page
fault handler.

No functional change intended.

Reviewed-by: Peter Feiner <pfeiner@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index b83a6a3ad29c..3828c0e83466 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -655,7 +655,6 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			sp = alloc_tdp_mmu_page(vcpu, iter.gfn, iter.level);
 			list_add(&sp->link, &vcpu->kvm->arch.tdp_mmu_pages);
 			child_pt = sp->spt;
-			clear_page(child_pt);
 			new_spte = make_nonleaf_spte(child_pt,
 						     !shadow_accessed_mask);
 
-- 
2.30.0.365.g02bc693789-goog

