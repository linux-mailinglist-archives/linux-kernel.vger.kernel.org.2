Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8038A30CB43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbhBBTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbhBBS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:59:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39888C0612F2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:57:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x4so2533536ybj.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KYVd6fUQw3zIOqAGEpGtYtjC1FQT+zrejnhSTvgL1Tc=;
        b=AbpanSfQAKLYwwX/pQuSNKeFHr4axrcCDvd62suB3GmDBdzIgiYdCdzSU4mns/bb7s
         a9Ee+nd9i7nsCQoujjH+slrX1c943W0QHX6Jv7Cgx9L/gZrGM9jyW+8MzaHhJktg36/3
         XoGH5dQdlgilaYiE30BZN2sSC+tNUsK9ZlqUe2pLgAucdYkMKrOtbHFvy9idE1YeCVQJ
         cmBW1MhPJigCh2nv0G8CngVoj0RdP3aDG45cHxi5Wjk5bsmFhJ76Hhy+ENvn2JpnjKv+
         2mP4Yw5dtmybP1Uqo9W0d3PbOXMw0lIT8vSv+nzas46LrzHEON0j8m9GGNyBJZE2Q63Q
         BfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KYVd6fUQw3zIOqAGEpGtYtjC1FQT+zrejnhSTvgL1Tc=;
        b=cnayjroSxRX/0OWgMKHadykBnn9K0+avXwDaj9L2uHm1J72zACfcoNcexCySmwtfMs
         8UhowIkYVTQG4W4l+7zr8GIOwNPllHbjhFRSS2aDmCFRErenHc6Bz202UcW3yPfXPmCK
         CTO5hcy61vBOx4tdKtzZq/HgdvqFwnDlp9GEYieGhn8fFM73uyuD4ymWbMi1ODN08sz0
         jEAAV1InvDBaVUJEOHiZPJo2E5+BWg/hx1gLGRzKsoEStnfId/LW2hPZ+9AaN76Yif2D
         AjnfOFKYpyvjzz+S1zTHnBbacAAjcqmy31GH7/q9UovD4j/sHtrviNmXkAbuh0H2lbuf
         TqlQ==
X-Gm-Message-State: AOAM5323rlcnrPaMpAQ2Y+fB9H6onNVMryqHl4bBkV77+WBOcMWnKVJu
        FGtxU9lKL+g+/mTzob8ojJI6Czif4D+QpoQuNzgeHByHUENYgOYFW870ZbXe8j/JtKCTOElnAsP
        h6jAcZ2PjgeXWTAlU3LXtUau6zQ0WVLme68yYp7I13JT4dm7GZkUnRkpu1lUfMbsIScmyteAa
X-Google-Smtp-Source: ABdhPJwbOZw3GpJNQQ/n0bg2L6ItJcBXZkWD0jzrdbnmEfZlWs/Wz2K6OMts+qvcqYo7IMhvQJ5WsYdQd26f
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a25:b745:: with SMTP id
 e5mr34704252ybm.518.1612292276425; Tue, 02 Feb 2021 10:57:56 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:16 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-11-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 10/28] KVM: x86/mmu: Fix TDP MMU zap collapsible SPTEs
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

There is a bug in the TDP MMU function to zap SPTEs which could be
replaced with a larger mapping which prevents the function from doing
anything. Fix this by correctly zapping the last level SPTEs.

Fixes: 14881998566d ("kvm: x86/mmu: Support disabling dirty logging for the tdp MMU")
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c3075fb568eb..e3066d08c1dc 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1098,8 +1098,8 @@ bool kvm_tdp_mmu_slot_set_dirty(struct kvm *kvm, struct kvm_memory_slot *slot)
 }
 
 /*
- * Clear non-leaf entries (and free associated page tables) which could
- * be replaced by large mappings, for GFNs within the slot.
+ * Clear leaf entries which could be replaced by large mappings, for
+ * GFNs within the slot.
  */
 static void zap_collapsible_spte_range(struct kvm *kvm,
 				       struct kvm_mmu_page *root,
@@ -1111,7 +1111,7 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 
 	tdp_root_for_each_pte(iter, root, start, end) {
 		if (!is_shadow_present_pte(iter.old_spte) ||
-		    is_last_spte(iter.old_spte, iter.level))
+		    !is_last_spte(iter.old_spte, iter.level))
 			continue;
 
 		pfn = spte_to_pfn(iter.old_spte);
-- 
2.30.0.365.g02bc693789-goog

