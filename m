Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA903CD2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhGSKHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbhGSKHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:13 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39A9C061766
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:48 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h11-20020ac8138b0000b029025f8084df09so5933427qtj.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9b2DYjQT7/g/R4ArAtIC/jYlBeWl0FTuTlWq0insfwk=;
        b=PqGcmBO2wTNT/PQffInicuYzE+ddpQibVhLtljlpqJEXnf4+QFhSeP67SvzmIU5KQS
         9Y8K7fKXU8Yc2JMPC9ZkvCioxx6Ssjg4gKGnar073enL+Qbu9mfXxey6Dr18AIdn2GyM
         Xcnr9YSul/mEPJCH8qfFwsaTQpnmJsqjqkfMVu5HSANq7OT62XP9gVzuUPOKP0g0bz56
         VQvMF7nmoLyBRZ7zawRL2TtSoSiM5+3X3gxQFB8vZtyLtEjeCydgiiPljiynVaYzAwX/
         lEJosv5Ud8X0u1ZfKviLaU84GaSDjbTS3GbiU1t4IlJ14sXx5GQjYGyJZQu2fpJGo0wu
         QkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9b2DYjQT7/g/R4ArAtIC/jYlBeWl0FTuTlWq0insfwk=;
        b=ZVUOMXZ7yVzyJnPFQlQ/yeCbizR333Td6VDviOB0apG92QiXRU19ZfHL8CMfOAR0CN
         Fp9DNBn/cWjGAS4MajuzC69MDNeVrOqatqQpklnshjsAmSNoBLbPOJsMjNbBng7p17sG
         2DsygA5bl1rEV8Pv09hzTgEGJgVR6krQ5+SwGL7kpThokykphmEGqipTmXEnh0m32nso
         x79r2bTV1ISi8eJLxfuM/OwZJR5VEQESI+9kKoM/WUSDaQPM8ssSQNY+iOAXGYkpvB5Q
         FLCTXwBLYtgWdgIXmITOvryjxnsWLW2h89Ny1kLckiC6B4pgSO+Yf+MhG6n6FxLKtenD
         mYUA==
X-Gm-Message-State: AOAM530FVCwexeu84P6cStcuwvKCYsAyvo9vhTN20mB45DJYQ7WqTqVS
        z6RWlCeu5PVWz2nicFK3u/bEUilZNhJj
X-Google-Smtp-Source: ABdhPJxrGQcU/bELmtAI4DiOZarAZdNIyxfly8cWQksXRDD7AQeTy6wEy0Y1zFBuD/hd8VGZA2WdmEFZdPU1
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a0c:ca0f:: with SMTP id
 c15mr24195317qvk.58.1626691672637; Mon, 19 Jul 2021 03:47:52 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:26 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-6-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 05/14] KVM: arm64: Don't overwrite ignored bits with owner id
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

The nVHE protected mode uses invalid mappings in the host stage-2
page-table to track the owner of each page in the system. In order to
allow the usage of ignored bits (a.k.a. software bits) in these
mappings, move the owner encoding away from the top bits.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index a60653cbd8e5..a0ac8c2bc174 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -50,7 +50,7 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
-#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
+#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(9, 2)
 #define KVM_MAX_OWNER_ID		1
 
 struct kvm_pgtable_walk_data {
-- 
2.32.0.402.g57bb445576-goog

