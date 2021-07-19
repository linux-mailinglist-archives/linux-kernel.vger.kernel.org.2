Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC83CD2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhGSKHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhGSKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:11 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4003AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:46 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t7-20020a0562140c67b02902f36ca6afdcso14034472qvj.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hF3abQWZBVX3OcEZC1+muydZc+hxmzmuOXsHVIQGXQY=;
        b=bKDVheVY1IoxMnY0wSKdcwzVYL3+9RUBExVTBuQLvOyjLLO3PPt0/L9UEBmEHL+1Dx
         4GCQT5nMdj7k5BCms5Cp4cMXS2yqRf69jgSSFeaoSz1jZ8avNGOl6b181XVKQ4cCFaUh
         2EXb6bfTh+tcgwI2a383qfuwgtr2+1sZO2XBFsp8DH6NTZhuD0ICB8n4FNcbW7Hlzrda
         YHTa8rkvihWr9onnhlMHiBLIYzudPGEcwL/Mb87H+EpZpOzDbgM0KKrePPGhBHLoHkMU
         i2BYhTw5ZbitjRvVXlW5OqXmbQ5tYM1XNWQVTNkVnIgSDNNNia7XPNcXQe/0SlM0ppTf
         GepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hF3abQWZBVX3OcEZC1+muydZc+hxmzmuOXsHVIQGXQY=;
        b=AIBCvICP3c/TyB0PWjRP6ZOR4fBpn5+9PFBwPbfeqQlePfRcttnQCSHUDFiUZ76wJV
         HZ+9Zo6i6H7C2+mBETgHvziy8s+HqsK6WpThpgwA6OYwgYL0NuzhKCFrD6vTl4O79cSq
         Nfd8yxiqsIwgTC1/4I6+I3rI0p1BJ/7cdgb+Kfwk//jWUkxv9EKyiDjH1yPmkTeWNkeo
         8Ote0j/+xmmzc42HqLrDoypsy5WgoxzIGuRIqwPeVXEgbIu5/WBqS+AjB3Lm1ncZNkPQ
         /mBvGK2S6QbUbbtrUoFdQ/jKU8DUO/P6DzaiFQ6F9s8YREJP29wgmhqZ6ZwRAN8VKEwX
         FRPg==
X-Gm-Message-State: AOAM533wsoaP1wHzaRfzHl92CU1eA5kGb50b7F8T04ianmXGk5niyb40
        YPT+RgsxE/1t2LL7/q8cRzVIQitISdhE
X-Google-Smtp-Source: ABdhPJywsBug5lNdL9XgQmCske7yV74xcWDxC3HLTB31TuI7A3Ec/12WOGGcTHohteYdwrcfEA0JudPZ10me
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a05:6214:1021:: with SMTP id
 k1mr24356756qvr.4.1626691670169; Mon, 19 Jul 2021 03:47:50 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:25 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-5-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 04/14] KVM: arm64: Rename KVM_PTE_LEAF_ATTR_S2_IGNORED
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ignored bits for both stage-1 and stage-2 page and block
descriptors are in [55:58], so rename KVM_PTE_LEAF_ATTR_S2_IGNORED to
make it applicable to both.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index bb73c5331b7c..a60653cbd8e5 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -40,6 +40,8 @@
 
 #define KVM_PTE_LEAF_ATTR_HI		GENMASK(63, 51)
 
+#define KVM_PTE_LEAF_ATTR_IGNORED	GENMASK(58, 55)
+
 #define KVM_PTE_LEAF_ATTR_HI_S1_XN	BIT(54)
 
 #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
@@ -48,8 +50,6 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
-#define KVM_PTE_LEAF_ATTR_S2_IGNORED	GENMASK(58, 55)
-
 #define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
 #define KVM_MAX_OWNER_ID		1
 
-- 
2.32.0.402.g57bb445576-goog

