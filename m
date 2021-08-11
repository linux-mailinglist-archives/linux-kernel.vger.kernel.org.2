Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5113E96E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhHKRhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhHKRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:37:06 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10B4C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:36:42 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d20-20020a05620a1414b02903d24f3e6540so1795581qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=600BfGro66ckGcCtHLsSTcvyovy+Yar8dj0tkkGK880=;
        b=L+p6M06P/C3C4ui9FQhMOHTPxJm2qikZ+jN5iqIhJgZmcX5ah7c+7XLdhiHBoQrqr5
         AeOGSAdoKCTLhHfpfnfPyRyHtFjiqcizVH+aY3LSl3A/4LQVRjG1aMVmBugLHTJlXKk0
         +g5t3jqDcQMw7giIw6Mb88GJreFp5SdVeQl0RZvMPXB3a4F8AAtLT8YYyM8IQgi3k/Ea
         NEGEmj1CnkvmyNpXuVr6XDvrdqgmFluMY9uhkWp43QnRy8deagM2lKVHMomSadhQQfd+
         svhMqj8K7ffp2UB+w5bU6499e6R4myay6uPMvzAs1JW3WpgezHuWetkNKmHDst3NTgrU
         UcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=600BfGro66ckGcCtHLsSTcvyovy+Yar8dj0tkkGK880=;
        b=MKAzH223dIQioEDyBIJJsYgXLMGYvZiidJX2ENdC8bPYt8IiXr6RC7Q4QJeoEBHq1+
         fUNY2ibgsCzjhy3WHvEexu+9NPIo1vjhLL8++KaaHf4/jyI1Tz1qfZeYJ2GqHgvXDZYH
         hlU4VOyvgLCPDEPt8k7B113Tv2X7hH7xsPo6W4X2mFJst5/fqFogsJcDZzTX860RwCEq
         wqExM0y+b5L28M8yEfn3KgLCxj1jnfBB5Ac4qJ+r8T8A3tvKudoO4TNMwh20PmeoK+dU
         hFzXZ3T15awrQCdP7SUHhKHOVU4y6mc9Mld4C8u3N8MZwBl1pQjhC2bC5jYXGChNpA6A
         +uQA==
X-Gm-Message-State: AOAM532XV9vUrfk05AatC/ad9k8VjyaOu8V12G/PZ8bjwRqeBTgEQHEA
        NtkCaxCmqb/H0KusOs5sCSQIAm9FIATV
X-Google-Smtp-Source: ABdhPJwPXKpSpNhuMaTz2hv19f1ZPNoKVo1Bsp9I8bXQZmXjrv7ZMQNSoNx0s8MSeYAAj6++CqBzRXIlgBVK
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:43fd:e634:73d9:e10e])
 (user=qperret job=sendgmr) by 2002:ad4:45a8:: with SMTP id
 y8mr20692593qvu.49.1628703402006; Wed, 11 Aug 2021 10:36:42 -0700 (PDT)
Date:   Wed, 11 Aug 2021 18:36:25 +0100
Message-Id: <20210811173630.2536721-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH] KVM: arm64: Return -EPERM from __pkvm_host_share_hyp()
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error code returned by __pkvm_host_share_hyp() when the
host attempts to share with EL2 a page that has already been shared with
another entity.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
This patch fixes a bug introduced in the stage-2 ownership series which
is already queued in kvmarm/next:

https://lore.kernel.org/lkml/20210809152448.1810400-1-qperret@google.com/

I've starred at this code for hours, but that clearly was not enough. Oh
well ...
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 8165390d3ec9..6ec695311498 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -404,7 +404,7 @@ int __pkvm_host_share_hyp(u64 pfn)
 	cur = kvm_pgtable_hyp_pte_prot(pte);
 	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
 	if (!check_prot(cur, prot, ~prot))
-		ret = EPERM;
+		ret = -EPERM;
 	goto unlock;
 
 map_shared:
-- 
2.32.0.605.g8dce9f2422-goog

