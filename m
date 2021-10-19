Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A734335A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhJSMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbhJSMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:42 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C320C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:29 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id p3-20020a05600c204300b0030daa138dfeso2489638wmg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lFnO3V1vcCaxCQp+VktMJcKCn5jbqprlvSckwnNsC2I=;
        b=UesM75tSQOr45py6fmGldxnFZ9qhEpvDJtfc4apxLzl+vaSpskjZwXcD+vvH4lZb71
         As8F+7i1zzMOpoNT7YUGxMUVpiB8c0NDcbRvtlAROdU3IQYsujSlMzJLH9nvz+6DLVHK
         vJRzQS7wBFHQO3YkY6Xec9Pwo6xYZSj30VNWKHbaOabamzLvVtuZDneBjv1pLT8mGCYX
         DcoRFa8C8Iwqa1uNt0xjG6wxks4HeuMis1JBBY2eEu5k9YvLWHzHgOOhKtYnx5KcDzGR
         +xuNnU1Xky1kYEkg3hTbTL4NVyJOzh3NB457XGrqSEC0sX/d9IlZuLvuuYTnTBcm4Y1m
         ZRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lFnO3V1vcCaxCQp+VktMJcKCn5jbqprlvSckwnNsC2I=;
        b=o8PVajM/poC3Jvh9Hq9cdNmsiFUAVRO/vEPGUGwFnp7rkVf48VOW726sFyLfoVOOco
         U/VF1GE8xD9QH3rlVq/pA1NmFdI61EGgSUTBP5ub32zGacygvLp/VNc5IFA/yvn8dZ8n
         ozcNYqAUhc7TojFxdF/JPnYK6vN3tocE72uUjTEwuROTuujNdo/LA+iWT568GdwG0tmf
         YtGlZ+etVK4+wUr9WNWp7NlvumZmdgUmwIcvhcnBvS84YvbTlMGxnMh+jwDGhn6TudSt
         Jv9GTmypyGQ/Fe/EF9vLgLNR5D8N4OKkveS4+f4fj58nP9Ziz+d3hywTsrc8FHmzEuQ5
         Vx6w==
X-Gm-Message-State: AOAM530fxMgZ7Ouv934TcDGd2KkMfe0tp7iX6vJT0RzfW9zAlcq0GsY7
        YhCnmD3uryGj0d21Fx9Ax9cCytS8lsGw
X-Google-Smtp-Source: ABdhPJzM8Yi1zkltqsZIknAWVlvpJd+76GDP3lU7clYj1DZGyxNzgbxFRtOLXsCPKmvrYy6VEEMSHUHhKXXR
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a7b:c441:: with SMTP id
 l1mr5486888wmi.69.1634645607924; Tue, 19 Oct 2021 05:13:27 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:58 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-10-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 09/15] KVM: arm64: Extend pkvm_page_state enumeration to
 handle absent pages
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Explicitly name the combination of SW0 | SW1 as reserved in the pte and
introduce a new PKVM_NOPAGE meta-state which, although not directly
stored in the software bits of the pte, can be used to represent an
entry for which there is no underlying page. This is distinct from an
invalid pte, as stage-2 identity mappings for the host are created
lazily and so an invalid pte there is the same as a valid mapping for
the purposes of ownership information.

This state will be used for permission checking during page transitions
in later patches.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index b58c910babaf..56445586c755 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -24,6 +24,11 @@ enum pkvm_page_state {
 	PKVM_PAGE_OWNED			= 0ULL,
 	PKVM_PAGE_SHARED_OWNED		= KVM_PGTABLE_PROT_SW0,
 	PKVM_PAGE_SHARED_BORROWED	= KVM_PGTABLE_PROT_SW1,
+	__PKVM_PAGE_RESERVED		= KVM_PGTABLE_PROT_SW0 |
+					  KVM_PGTABLE_PROT_SW1,
+
+	/* Meta-states which aren't encoded directly in the PTE's SW bits */
+	PKVM_NOPAGE,
 };
 
 #define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
-- 
2.33.0.1079.g6e70778dc9-goog

