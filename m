Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC9531A8FB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 01:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhBMAvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 19:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhBMAvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 19:51:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73316C061788
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:50:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f81so1542712yba.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4X8Xawmkqq6JrMI8EQ6Ez131d+8bBQcFXdbpvRYDUz4=;
        b=GnlMk7vhQFA5V4yJOVvifabbC2ElQwDOtmcUG44rof+fgdTrwGAFwFX4p3LG9fLNL1
         WaxcclGNJu64urykhUWGvJ++jy5bkggdIO7iB0nOvezt1DQxBx70ZyzB109ZGWQ1KRko
         xZsW64uIrhXxCvXyhiJx0h7L9Uk00AEvRY166UfiWKCjhiiylBRnm1R2ZpOX5tDzX5zp
         NGGTV/eaLw78lGrN8y9luYglA6il47mudOSGjs0bmXxZE8aqUeEyjJucAdH9kbulQwob
         TdW9q/RIhC7ZZxuXKxHk127puPNTRLP8Xmmyd5SNT83kU/GrswKAKKeqb5+lePK25SbG
         d+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4X8Xawmkqq6JrMI8EQ6Ez131d+8bBQcFXdbpvRYDUz4=;
        b=N/jcJ9K/UrTh4kAKWGwUj+KYjT2ZfMJP7wZLEQ6EuQaUpFW1yvQwePH0fs6UyOJPyL
         Xa1esSJJ63ECQj6X1Bs9MgS5OUsaqT/SoGLlSzDQOuLIcK8p8a4a7n9STpgrdFE5pfDq
         UutYaouJQOi3shjP06/gBHc7xarDXEfPIuIz1Jn7gql7YNqesKcKFUgHWGMBk7d2eBwV
         AMMD6P0ktXgo4X0ifpprtlRUKg13KM00u6SByyrinLi/ZCsf/KK5ee2MXz8DEmRdDRio
         dIJElIxzVBeiew41cB84v1AWk3A7rP3D7M9LQfBJR5y5h6qNK47Pwk6D3+cjLYfTABPF
         V9hw==
X-Gm-Message-State: AOAM5305CmV7BmmquTGOTc2rQNtotkt0uIGasy7F19Zt7ZkcBopeNMTH
        HjlHdkPJ7iOb4aJdKGJPkrhiI/31WwU=
X-Google-Smtp-Source: ABdhPJwisJLVUO82g7ZpXF02safHacPg3WhZ69zQ2JPkhSdW2WAFwkbFqEizlPxxQ/9Fc1CQ+oCBmi5Py7E=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b407:1780:13d2:b27])
 (user=seanjc job=sendgmr) by 2002:a25:e010:: with SMTP id x16mr7990153ybg.17.1613177423616;
 Fri, 12 Feb 2021 16:50:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 Feb 2021 16:50:02 -0800
In-Reply-To: <20210213005015.1651772-1-seanjc@google.com>
Message-Id: <20210213005015.1651772-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210213005015.1651772-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 01/14] KVM: x86/mmu: Expand collapsible SPTE zap for TDP MMU
 to ZONE_DEVICE pages
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Makarand Sonare <makarandsonare@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zap SPTEs that are backed by ZONE_DEVICE pages when zappings SPTEs to
rebuild them as huge pages in the TDP MMU.  ZONE_DEVICE huge pages are
managed differently than "regular" pages and are not compound pages.

Cc: Ben Gardon <bgardon@google.com>
Fixes: 14881998566d ("kvm: x86/mmu: Support disabling dirty logging for the tdp MMU")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 71e100a5670f..3cc332ed099d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1348,7 +1348,8 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 
 		pfn = spte_to_pfn(iter.old_spte);
 		if (kvm_is_reserved_pfn(pfn) ||
-		    !PageTransCompoundMap(pfn_to_page(pfn)))
+		    (!PageTransCompoundMap(pfn_to_page(pfn)) &&
+		     !kvm_is_zone_device_pfn(pfn)))
 			continue;
 
 		tdp_mmu_set_spte(kvm, &iter, 0);
-- 
2.30.0.478.g8a0d178c01-goog

