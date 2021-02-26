Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951B5325B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhBZBEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhBZBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:04:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17957C061788
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:03:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v6so8357663ybk.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=jjFmqKl5TUSlu20yk/qEiThTFlDZmJ7vLsHCxIjCxWQ=;
        b=thzagAC2ArbMJiyjkGonrAiEV5IKDadQD3GoC8IqgDet51VKEpm93EWDj/6VzmpRuj
         a/VY0bkTye3mYeoBN4b4QNxaAR9EuZbJjUULUXiARyXHcq750mYq5777gtWqvfp2AGGA
         k/sNnEhMFooq/WTLdg12HYSxlO06Wvq5pPpfCcQxVWNJAQZXziKuk3Kgv5HFXK8R/pxp
         Hm3Htl7yVjjQUhqALGZ27qBZpp7ck0SOzJ5ndxse6+LASF4xvLQLItlyj2/cSgPdCNyS
         cVEErZByxYfDcTl9bgYYVUeEZlB8VbbfMuVdiW8Ae2vE+z0Rpr6UU+wI2chH80TVAmAF
         0P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=jjFmqKl5TUSlu20yk/qEiThTFlDZmJ7vLsHCxIjCxWQ=;
        b=Qjq/GhtfH7BUe2IojqW9Rc0KX1SFtn4B4gIUSs0uuygnsA4WWrrMWT5Yd+JqV9tuf6
         KRqfUUNLPOKgJtfc99BCMcALZHbNl5xr74dAsxa6M3KRDsbPbdzO8JCfGA41OnyjTJVo
         WP48tfUHtUFZDMoB1Da7U8wGpOUFiZsXSFaz90KhXFS5ctYch1JccU4Gnfax2z8fhthX
         lTa3v9K3TNqsLly/MU1y9Uk8V+WgG+ZVYamCJ10qpdia7YmKcN+I77Wg1Ku1Sq2lkAvI
         gAoXAAbQt4W0Kg+ewVmdiaSG21FfPoGHAm3zgOaakV4QhN42+yNGO2wXrH8GrUt1aY62
         i1JQ==
X-Gm-Message-State: AOAM532jvaursdQsWRH6WwH/AVEDAwYARUz/8Iaw6+ciyJdT13a1QDku
        nOmeifihWYQPUzy0XPgOz+sxmdzRx88=
X-Google-Smtp-Source: ABdhPJxS7wqy9jeWhEDjop15HOx+Q9pR1KowWkU+O8C8ijl/iTyZmsIqLlwpkLz1+C2/XCwoINxwcOewFn4=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a25:7312:: with SMTP id o18mr895039ybc.352.1614301418368;
 Thu, 25 Feb 2021 17:03:38 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 17:03:26 -0800
In-Reply-To: <20210226010329.1766033-1-seanjc@google.com>
Message-Id: <20210226010329.1766033-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210226010329.1766033-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 2/5] KVM: x86/mmu: WARN if TDP MMU's set_tdp_spte() sees
 multiple GFNs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN if set_tdp_spte() is invoked with multipel GFNs.  It is specifically
a callback to handle a single host PTE being changed.  Consuming the
@end parameter also eliminates the confusing 'unused' parameter.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 3290e53fb850..020f2e573f44 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1022,7 +1022,7 @@ int kvm_tdp_mmu_test_age_hva(struct kvm *kvm, unsigned long hva)
  * Returns non-zero if a flush is needed before releasing the MMU lock.
  */
 static int set_tdp_spte(struct kvm *kvm, struct kvm_memory_slot *slot,
-			struct kvm_mmu_page *root, gfn_t gfn, gfn_t unused,
+			struct kvm_mmu_page *root, gfn_t gfn, gfn_t end,
 			unsigned long data)
 {
 	struct tdp_iter iter;
@@ -1033,7 +1033,7 @@ static int set_tdp_spte(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	rcu_read_lock();
 
-	WARN_ON(pte_huge(*ptep));
+	WARN_ON(pte_huge(*ptep) || (gfn + 1) != end);
 
 	new_pfn = pte_pfn(*ptep);
 
-- 
2.30.1.766.gb4fecdf3b7-goog

