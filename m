Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F930CACA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhBBTAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbhBBS6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:58:23 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EECC06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:57:42 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f6so7649620pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gBakp41ktk4jgkeZgHcExRdbU8Ig7SZgvQMSmr/VLBU=;
        b=UP9UzJfzEe9/Ly/yxN5Gjfj7iCf04Nj5PvrnWKJvXZSvijmzu3M/fLZnQDrbW/Wtx6
         R7DZZ5/gcOxTtdPj3Y1x8Mk/x4GBKvI1qdaNlihuUHMQtkgpJhlJmGHPXSYETV0yUcgX
         1Uoem/JJthQoPjSd6iWa/PgbA1tKRBNAwtmUyRpZlyg38kE7m6Vdvk6G60EQMZkU8eVF
         ln5XTvOQHOFrKytwn2RQoDNDqTGo4sXMrj4sGLL8T7/V/uJ8VyQ1LAAB/zR+A13ZAMVr
         Ash90jAsH7cqQAIrK5v7MQvB7aKZmUAqfcpHhbiXyk8dNo+CS8uGxEIrpIs24/JkuVv6
         MehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gBakp41ktk4jgkeZgHcExRdbU8Ig7SZgvQMSmr/VLBU=;
        b=BtquoCgdaxqNf0nNRAJaCLEyHE8WoywSywIubrbvhhiFxwPlAI7jGoQZM42LaZjlI6
         iZtZTXAe8tpehjV0tXEXJXFL+DMt1ZQ/ULiZ7dV99dPu75lVHINMuC/15GNA2PK4moU6
         BMdt6vuE6Ai1R4Loo0c0Fie0FHTEHSxeunb84oz7WAIt5dNwJ3sgnUEH9485RpuZyZYe
         TLjF8/qXwzwNRTeGfHLqFXZ5xgaDfVJe0DnvxX4AL4kAZJkAFoxYx8fKVhX463/LikHf
         faxJo3IKKYq2YT1TTBJN9AtojKsRYQd94d0PoWKkJYl5+ToNV09Lj54RGUYSVvWfLMr+
         2W/Q==
X-Gm-Message-State: AOAM531B7OAFMoYvMP2MH/07DvmvGR4U0OovsEFtKjIEy0r2PpXjItDC
        Ahbj9GOqyrwL07XGVln1Jo6J1KMHK97uqRfSlCjgOyeif2sBFJv/Uv8XW9c/XZFf6q7YNtEhAQ4
        G6mY/RduqItlZANkBz56A0qSbI2XCnUPzJ9Az0d4IHNo9g+BB0+hvXqsugqLURPV+ERmhQDsX
X-Google-Smtp-Source: ABdhPJzeRZOFIX9a/bG5Hmq6Upkz91nse9rF4JC93D5n4GvGY/qHC0TkdleD1Uz3WAjRhhnaXuHiUszMatv4
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:aa7:85cc:0:b029:1be:181e:32af with SMTP id
 z12-20020aa785cc0000b02901be181e32afmr23215062pfn.50.1612292262260; Tue, 02
 Feb 2021 10:57:42 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:08 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-3-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 02/28] KVM: x86/mmu: Add comment on __tdp_mmu_set_spte
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

__tdp_mmu_set_spte is a very important function in the TDP MMU which
already accepts several arguments and will take more in future commits.
To offset this complexity, add a comment to the function describing each
of the arguemnts.

No functional change intended.

Reviewed-by: Peter Feiner <pfeiner@google.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index e9f9ff81a38e..3d8cca238eba 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -357,6 +357,22 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 				      new_spte, level);
 }
 
+/*
+ * __tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
+ * @kvm: kvm instance
+ * @iter: a tdp_iter instance currently on the SPTE that should be set
+ * @new_spte: The value the SPTE should be set to
+ * @record_acc_track: Notify the MM subsystem of changes to the accessed state
+ *		      of the page. Should be set unless handling an MMU
+ *		      notifier for access tracking. Leaving record_acc_track
+ *		      unset in that case prevents page accesses from being
+ *		      double counted.
+ * @record_dirty_log: Record the page as dirty in the dirty bitmap if
+ *		      appropriate for the change being made. Should be set
+ *		      unless performing certain dirty logging operations.
+ *		      Leaving record_dirty_log unset in that case prevents page
+ *		      writes from being double counted.
+ */
 static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
 				      u64 new_spte, bool record_acc_track,
 				      bool record_dirty_log)
-- 
2.30.0.365.g02bc693789-goog

