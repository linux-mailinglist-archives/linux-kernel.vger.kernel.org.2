Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350AC3E48B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhHIPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbhHIPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:28 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85384C061799
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:07 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id v6-20020a0cf9060000b029035546f11a23so1029804qvn.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0U6bEbFLcZw+EVlWCQFxbjscDvzC1GFCLaFxX8mML7w=;
        b=kOLCXZaTuLa+M/eAksDlmTXxarvjJi/4V0U691zcl9If3pch1JmCrYhjGOY8XVKtJE
         6NuTYclkw0GPt0FK2mSGr3hTr4kwtJkTW+ezZALU33xRPk28YsNg05w+3w7O4PtRSL8i
         wrjld/G5kuClFhvVfczeYTwUpwU7xzbTze9JQU4DBSUbnKUAk+5TmjEX1GPeAbpvo7EB
         8VtQ67ClSRfBWW+SLvG80L6+JEtKS6B+eU5WjxhSeBvp0pLR+HNQV+YuuMmfIvZp+APm
         fiAK3U3VTWGVuBaz5uZbFLU0vd0fRk8vYM5Ajv1XJbbeZUdR+aL0PvPbhBv8YESCUjpZ
         TKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0U6bEbFLcZw+EVlWCQFxbjscDvzC1GFCLaFxX8mML7w=;
        b=SzGcK9mVuShS9ii6/0COcJxTgLQllweBqk/15/O5UfM0ii9kB9TBTdU9c41X5/xJp2
         gRREoqZeFRug1msdM1GzIWEFHV6X5wnVzTJQ7qlkcFKsCG6oG/2eYQ+higkihKodvUQ+
         NZ+1ovoCd1B2MLoAJe7sDUpmP7akRfkkbZQ7h392JcJwBYaO/dDBNN117aSYqGFEBrkN
         5Wh5M+16kPywf9IFYQShv2/eeNM1SWygDEhw5XzKYgLCczrW6HGA4A0BR2CwdF6gbxx1
         Y3bxz7HThXgx9rg6c9m8HH8pLRMeTZF7DwsFHYNXUPACzg5TDd5s1idh7LmCN6rRe/LT
         1o2A==
X-Gm-Message-State: AOAM532diJy7xy6x0DvqQhBjp+QQXee7qJKkEOU/1d2ChU+uXn5+hqzH
        yssRbUS1mOkaaYzLizI1wuTI6iL+v3vP
X-Google-Smtp-Source: ABdhPJyLymu2D60zHUrmLqd+Yu9r4hpSVIXHgBvGpH3s/oeTvKgBK0EWZGKeXuUJmU+jyvIS3H1jipiit27T
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:62c:: with SMTP id
 a12mr14308495qvx.49.1628522706714; Mon, 09 Aug 2021 08:25:06 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:34 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-8-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 07/21] KVM: arm64: Rename KVM_PTE_LEAF_ATTR_S2_IGNORED
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ignored bits for both stage-1 and stage-2 page and block
descriptors are in [55:58], so rename KVM_PTE_LEAF_ATTR_S2_IGNORED to
make it applicable to both. And while at it, since these bits are more
commonly known as 'software' bits, rename accordingly.

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 4dff2ad39ee4..59a394d82de3 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -36,6 +36,8 @@
 
 #define KVM_PTE_LEAF_ATTR_HI		GENMASK(63, 51)
 
+#define KVM_PTE_LEAF_ATTR_HI_SW		GENMASK(58, 55)
+
 #define KVM_PTE_LEAF_ATTR_HI_S1_XN	BIT(54)
 
 #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
@@ -44,8 +46,6 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
-#define KVM_PTE_LEAF_ATTR_S2_IGNORED	GENMASK(58, 55)
-
 #define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
 #define KVM_MAX_OWNER_ID		1
 
-- 
2.32.0.605.g8dce9f2422-goog

