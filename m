Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F191D30CB44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhBBTTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbhBBS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:59:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE33C061355
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:57:55 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p19so12593637plr.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=B0VigK2P5ak64VCq6hWJQFhuqtks7N3lzzr7PnL5znA=;
        b=f10BMaH1rM64eodNhWOBnAnthqsNAHjjKYrvC9ZophPlUZRe2fDKTrcdwVRetQigOD
         8BKXc5ZpDg8iWDD/te/SmQKPVJPIOlbvZypVTq3M7TaSk387aVTmcZENyujIqiSq9tjK
         NdTRVdp2eXPSFOeo8C4RCyriGl/ze9F/o9s6L0cjEntCb2PSbFYcJMryUHz9evMXzv40
         hbu9zFHK7IPejA27L+onORHo8do7QuTyU+ymwx0Y+fgBMqV4IBkPbA8RhZTbfa/ohpd/
         GbjVsUYW1aXlOT///YnQFIUDV/VDdOm9wu2Xi04D/qMmcy1fvxjueT2AKSW+dd1AdPsp
         Imlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B0VigK2P5ak64VCq6hWJQFhuqtks7N3lzzr7PnL5znA=;
        b=PvGQcVQiz6SxnSJrUyIYa/vdpy+mZJ+DQR1pj+aI9VU4GJHnS7jlKaA5IPNl1RmftO
         bDFYbPTVGQ9ytJ/vS63NocW0n6IDY3JnS9REns0S7MZBqfvorZSUvF1TsC7M6wK9b+PU
         h18i7637Tofl3H3kQ5vjJ9QHx4rxrJH5pAB/a8DXAdOInbaTzFGCEk+eKqVshyp2rzCW
         XDADZAazmHNAQBjlctBuIsn/lruViePMZF48RU4nQhbQkDKeglp7OzLv993Cu1SrxM9j
         j4oEKhT/eWPKAM3e2uMyP/oEGXUjJ+sXhoDvyW5JZZHrRkjsexCrN8pbYcTLQ/ezquta
         aFAQ==
X-Gm-Message-State: AOAM533jsylQ/NJC6e7aZAJngH8M0mf7Yg9z2WXI6b8uXMiQl24IsRrc
        +ya2NVDIEg2gBjaU/H5/oXESTAW1a+pE93qaC8pr/SDmMxUyKM4kO03rQUEKzFBpdwx1PQmoN8k
        8kDyY7UUp9uX6IQgMXCEGStyose/b+ulI3o4hanAyxX9L4Xf2zT/nSCcej870JHHAh0HQWI0l
X-Google-Smtp-Source: ABdhPJykMdXaaVCk0ONAntUZG48nUEsuDAg3ibhbZYtyiHnZr+MJZXWrl2Xj/U3/Z2Wq1xNJK2nW5Nb2e5lN
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a17:90a:8d83:: with SMTP id
 d3mr614578pjo.0.1612292274520; Tue, 02 Feb 2021 10:57:54 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:15 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-10-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 09/28] KVM: x86/mmu: Fix braces in kvm_recover_nx_lpages
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

No functional change intended.

Fixes: 29cf0f5007a2 ("kvm: x86/mmu: NX largepage recovery for TDP MMU")
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6d16481aa29d..60ff6837655a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6005,10 +6005,10 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
 				      struct kvm_mmu_page,
 				      lpage_disallowed_link);
 		WARN_ON_ONCE(!sp->lpage_disallowed);
-		if (sp->tdp_mmu_page)
+		if (sp->tdp_mmu_page) {
 			kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn,
 				sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level));
-		else {
+		} else {
 			kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
 			WARN_ON_ONCE(sp->lpage_disallowed);
 		}
-- 
2.30.0.365.g02bc693789-goog

