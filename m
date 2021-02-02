Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E314430CAE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhBBTEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbhBBTBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:01:36 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73732C0611C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:58:07 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id k90so15031235qte.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=863KxC1/6wBl/LmIsFwRhyyYIQNzbKOVVmGrH1lkP6c=;
        b=gfvaiNF1NesUPe/yD6AqhBvDIl5DAFchc6PFaK0jSnOdybyrSDKCylQvIGkLEXblHG
         rK8cpdJLhOHMv1bDVrraUfpnmJCuzVDKrJV5iYNsAKOYKCHDjQ+dzA9QDZinOrMc09qP
         es4LquQhqfvgoj2/xhLvLYjNZ0O89UQyeFctLDUL5y79Mk6khvhBsSQsnOakpRfs1hhu
         elkBUzH4B58FDZIBsg+U3M5VhqQ+1mSTnhVecz6qCUySWr0C22+DrjTZiA7+DYjyMeZh
         bhZO00jg/Cah5u1uA4fHUVWJSLDzFsbfftXbInJb1FKvtgWKmAx5nQYth8znMBdc98aH
         SYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=863KxC1/6wBl/LmIsFwRhyyYIQNzbKOVVmGrH1lkP6c=;
        b=l1/C4r6+Ux0kncM095dsuzbhzo1P/sM11rgLNu5fs6loWm4+DWudmCMZNEGV9yWjMD
         DcosAOWIV1nUL5sAW0lWo2p+scLJKybLERkDRIDkSd0K8t85KK/M+gXIBSsWgfHYW27x
         Wr6kjc763o2/b01OVkJJRtd6tuNMXsQiVV0NRG8CgZ03v7Ck9A76Hy1TvEKUvI4smdug
         5ItLPKy7zxP+gLc2QfMNF6ZJDwHEMWtnLG0IWF4hmG9KksM5q8UtfL81agkrMrQehAAK
         KCd+iNm2F7LWxdDYSXg8p8fV5+fHMNLoDzmqQH3j6BA8Qt8pf3JMz+4lzghpr/CmyW9r
         4ipQ==
X-Gm-Message-State: AOAM533deOf8y4d5WNhKfLrDUuhEO04R+5xQpZj8zgi6lB11haeVF+54
        U5001ErLrsB1VbkZzngAMI0/ERn3d4wiYymSFiYkmQ1nhtpRMkyHNNl6LgdeVYZWCd9fVoBIwX6
        Kq5y5u/uoRkFQ7VnxQVtEz0VaLdw8B232K0/WsvAwvBGv83fQxINfMkrxtgLc6lJVyTRBC62c
X-Google-Smtp-Source: ABdhPJwrmTTtJgDxk79E2bRzdxXBq4ABPCviRTbWISZT3iVQAzKTtwCOhfo+RFy+5vn9G+bIlyfZ80k96DmZ
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a0c:fcca:: with SMTP id
 i10mr22127299qvq.38.1612292286580; Tue, 02 Feb 2021 10:58:06 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:22 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-17-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 16/28] KVM: x86/mmu: Clear dirtied pages mask bit before
 early break
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

In clear_dirty_pt_masked, the loop is intended to exit early after
processing each of the GFNs with corresponding bits set in mask. This
does not work as intended if another thread has already cleared the
dirty bit or writable bit on the SPTE. In that case, the loop would
proceed to the next iteration early and the bit in mask would not be
cleared. As a result the loop could not exit early and would proceed
uselessly. Move the unsetting of the mask bit before the check for a
no-op SPTE change.

Fixes: a6a0b05da9f3 ("kvm: x86/mmu: Support dirty logging for the TDP
MMU")

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index aeb05f626b55..a75e92164a8b 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1007,6 +1007,8 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 		    !(mask & (1UL << (iter.gfn - gfn))))
 			continue;
 
+		mask &= ~(1UL << (iter.gfn - gfn));
+
 		if (wrprot || spte_ad_need_write_protect(iter.old_spte)) {
 			if (is_writable_pte(iter.old_spte))
 				new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
@@ -1020,8 +1022,6 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 		}
 
 		tdp_mmu_set_spte_no_dirty_log(kvm, &iter, new_spte);
-
-		mask &= ~(1UL << (iter.gfn - gfn));
 	}
 }
 
-- 
2.30.0.365.g02bc693789-goog

