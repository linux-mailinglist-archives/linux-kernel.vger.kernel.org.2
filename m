Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC8539857F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhFBJqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhFBJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:45:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10576C061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:44:07 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a193-20020a3766ca0000b02903a9be00d619so1210163qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6BW7fDsTteROuo6K5BqDbcxWDf5UHuxhaiKaGg5d2Mc=;
        b=T6g1G1dBfUxc5a4uRyN0WITPLWnvNi8vRjaU0WxUeXxRylqlrnTDVZ76WleGEclLOB
         bFAArsvkYHz97FjuhdnCCh+WEkLIwWDbGPN8HcQ78O37UJm4EoCDSqpQXeqPvmiYy6nr
         yIq1GGdZJktTkGB8wQ4EBTglMjSXseqlhcwtjeBXe9GBq8u46ny++nQ2E4bWDjknAAve
         2U2O/hlxHUJkYkpUskkdnrYRyPf0c1V6lmQnl8jnqVfGA3zTVMsoKNxQl4+tCdCbeRIj
         UPVn2XdYfC7UcpIUefZVUauC2ueC83iZpRd9bxE+tL/DUwpCrqaQCV3dz1x9aDI/G7rx
         MDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6BW7fDsTteROuo6K5BqDbcxWDf5UHuxhaiKaGg5d2Mc=;
        b=i0Sdl6Z0/45E3GHTJxMLlJCTRz7hiWxxeWNTGqqpyy5kqPv+lCB8ZEc+BlQD8SU+jR
         l4Wo3cn3ZxPC3q0dfwElB5eCxNk8kEiHkODgKAFUzWFu78yYb3aIbqIr6OZ2/dE9Qhw+
         n0tlVonOHKHmSkVYpjBpll0SWSl9hGUaotXGo+IBFHpH4tMhijJO8L7kapyD+a1wcRpd
         D/YVAUn1mptOlBiE/O8gtsSjmLj/Xz9i85j6sK3KhYa19cTAXUaRjWnp4dI97SLQk7DH
         zyyXErb3xC32CDzNyFp1StGUPKp9b0Cgd6uh6a7F6g2IgQeaLIDB4bEmoG6Ftyq5WCL6
         HX4Q==
X-Gm-Message-State: AOAM530fyXLE5c/0wYBjWpA9bNiyyTlMgRb0cIoDvMfE82yarS1YrSlx
        Yg98oD4OIHNS7njY0Jd/3bZkW1ZszSWU
X-Google-Smtp-Source: ABdhPJxl+MLQjn8yPrKOU2bQi1i+tyBz/2Fy9EQ5GBW0rZbYDu246jiWjDU3i6n0uX5Qndx78NtlHv8adJah
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:e8cd:: with SMTP id
 m13mr6368320qvo.52.1622627046193; Wed, 02 Jun 2021 02:44:06 -0700 (PDT)
Date:   Wed,  2 Jun 2021 09:43:47 +0000
In-Reply-To: <20210602094347.3730846-1-qperret@google.com>
Message-Id: <20210602094347.3730846-8-qperret@google.com>
Mime-Version: 1.0
References: <20210602094347.3730846-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 7/7] KVM: arm64: Use less bits for hyp_page refcount
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hyp_page refcount is currently encoded on 4 bytes even though we
never need to count that many objects in a page. Make it 2 bytes to save
some space in the vmemmap.

As overflows are more likely to happen as well, make sure to catch those
with a BUG in the increment function.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 3fe34fa30ea4..592b7edb3edb 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 
 struct hyp_page {
-	unsigned int refcount;
+	unsigned short refcount;
 	unsigned short order;
 };
 
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index be07055bbc10..41fc25bdfb34 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -146,6 +146,7 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 
 static inline void hyp_page_ref_inc(struct hyp_page *p)
 {
+	BUG_ON(p->refcount == USHRT_MAX);
 	p->refcount++;
 }
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

