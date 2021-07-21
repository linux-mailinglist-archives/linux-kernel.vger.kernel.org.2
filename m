Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632A43D0825
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 07:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhGUEeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 00:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhGUEcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:32:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8318BC061766
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:13:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g3-20020a256b030000b0290551bbd99700so1790992ybc.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=9I8kvfv5vG3vEdo50f//Yo9C8reQVqyT8SACyEwJ4Ic=;
        b=JnlAUk5S0RhnnffkXK0G4vaaasewgr5jlAttWZTzpyNRuVZOi8a2HF+srPr0iclt7s
         Y/cKsyQ3AU2OPCsiqUowNAuhkzpwYW9Jd23b0Fxr8+PD/ZHOW3Ny9oXheNOjEzbXrjTR
         PRS5K0P0jdl6x9nzzwL6AgfC5Ff+ufKMsiUE3MSyQZQEUO7tqk3b51/hRoFjevQP7g32
         zca/kAHbznTtaz5TbipULXP2e9TwGw15buUnYvCF1NBoDhY9gbvqIuVX+cCBz7zFI15l
         GbfrptFHYiYZbt0MnM9F3B8v0lOXkYiR59Axi4zbZdFf2yGyGBIf6bJTq+JMRmTsnnGD
         Gt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=9I8kvfv5vG3vEdo50f//Yo9C8reQVqyT8SACyEwJ4Ic=;
        b=j4g3pxtpEIxPsX5XNIUqL2mfO6Koek1yJoZYlMNDkhn25774rfj6iw3le/mMrPxstm
         x6ZbWlierukAAMGgKkN+xUA9/3w3IajYV2THxzZUCxcW1vDYTmuh7hy1R1skJSgVUTr0
         s+iV3UkUK4R38jpS32j0/Jt7vSLKL4iSfQEcnWUOT3PPjxTdnGkOCcgyzHY8jRKu/KHp
         xjx4U3YF/mRcd7zptk67f3HaSl/1WIm3QMot/cZkVG5KdfFGRnnlJUAv1qruoYyRoT3U
         rBUZA9Qb9zITTLfG43pGPR33jw98wDXbNqCg+19XKnKmApTFEIVybxJvd/fWt09QX011
         DWzw==
X-Gm-Message-State: AOAM5306x4khRbG9FYUNpZwmI8sj5oC0CzB1FYiIEASSFv2FkRwt02Ps
        Wrj3w2PutpM5WxF9h/8igapxOqen7Sdg
X-Google-Smtp-Source: ABdhPJzBrVzuo56V0U2g15OOlBBRGgASpzCO6VpOhCQpCw/CcRXdF6+d+96F4wgqc809+uJZF2z0Sy/Uoqt7
X-Received: from mihenry-linux-desktop.kir.corp.google.com ([2620:15c:29:204:4b06:fd20:8c22:9df1])
 (user=mizhang job=sendgmr) by 2002:a25:d008:: with SMTP id
 h8mr44887585ybg.215.1626844395747; Tue, 20 Jul 2021 22:13:15 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 20 Jul 2021 22:12:46 -0700
In-Reply-To: <20210721051247.355435-1-mizhang@google.com>
Message-Id: <20210721051247.355435-2-mizhang@google.com>
Mime-Version: 1.0
References: <20210721051247.355435-1-mizhang@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 1/2] kvm: mmu/x86: Remove redundant spte present check in mmu_set_spte
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop an unnecessary is_shadow_present_pte() check when updating the rmaps
after installing a non-MMIO SPTE.  set_spte() is used only to create
shadow-present SPTEs, e.g. MMIO SPTEs are handled early on, mmu_set_spte()
runs with mmu_lock held for write, i.e. the SPTE can't be zapped between
writing the SPTE and updating the rmaps.

Opportunistically combine the "new SPTE" logic for large pages and rmaps.

No functional change intended.

Suggested-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b888385d1933..c45ddd2c964f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2693,12 +2693,10 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	if (!was_rmapped && is_large_pte(*sptep))
 		++vcpu->kvm->stat.lpages;
 
-	if (is_shadow_present_pte(*sptep)) {
-		if (!was_rmapped) {
-			rmap_count = rmap_add(vcpu, sptep, gfn);
-			if (rmap_count > RMAP_RECYCLE_THRESHOLD)
-				rmap_recycle(vcpu, sptep, gfn);
-		}
+	if (!was_rmapped) {
+		rmap_count = rmap_add(vcpu, sptep, gfn);
+		if (rmap_count > RMAP_RECYCLE_THRESHOLD)
+			rmap_recycle(vcpu, sptep, gfn);
 	}
 
 	return ret;
-- 
2.32.0.402.g57bb445576-goog

