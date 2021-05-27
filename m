Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF2392E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhE0Mxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhE0Mx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:53:26 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB80DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:53 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id n127-20020a1c27850000b02901717a27c785so1453203wmn.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Byq3teaLV2n+YzpfRy9Lkrwtyz9tACaM8wDIjUMnhpc=;
        b=lh3itUSKrY99HR4eVX5Kbop9zhHjelSV5Tk0fWZiJ9sUfR4ERy+T5lGBjCz/duYdnl
         kGkbRalNQtA2P8Y0x9AuQts+PtFMMV4Twn9z5LBtYsCtzuOsQwApQ9msA6YyUSd0L9kr
         9uo4im5pV2Vfxkb39c1oXswe8RHMs28B40q7MqOi3d5tWR8vdUH1kSgUwquRqY9ZHNYh
         DPiymqTjegRTcs/yRjGTDtnhWm70YHVyMrJdLewGX2zGwBjl7lV8+fHtPLOB5VBtFc23
         shccUlzY2zH/UCB6UeC1Jr/WQJf3uNRFlQ+E8cRqzchohQRyWGeILnf9albgfmXsYbY4
         29Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Byq3teaLV2n+YzpfRy9Lkrwtyz9tACaM8wDIjUMnhpc=;
        b=F/uvd9GkazExfaMkFX4EdE12wL5hU0XDqCiZR3qnYgAS0Na/RBnKw6vbeQAVZ2qgF7
         jns1bQMEN9uUMimn3nwy/n+PfbHkWpHqVsWiX+YJWeZxdmItbY7qaf/VO4gI0X5+iz7g
         q9YPsARLtlbIKrlKOura4TYRyswnxjv4GQ8TK9ji9gSpAakKUrWXDSFf9HJtpirKfN0G
         dnlB2K81sBwJ2zl7GeABPd+q9fVF0EHwiYHheq8MJAqGJixT3Ex2F3VZuQtpe+cZL2Xm
         OgpEDr+yHKZAiaGn5xkqKBEePCYnlLpFXwLe23m85DZsWaXjZ0wN+xlub2Fv7nWtJLi1
         41CA==
X-Gm-Message-State: AOAM532Wyg6WkGj2A9O4vSw4KBJzDQ28JOKhgaOw9SPxpOUIxTf44twU
        BxT3ir6WMJOL2oyCfhpDQ1Vwtd+/VF4v
X-Google-Smtp-Source: ABdhPJx/lfTo0VRFwUG+jBpYqhQ9SqHdKxuCeQn/auIpBlo6JTHBRUm8dOoTIg4a0j6u0pDOtb1DO+Pb2vgH
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:3515:: with SMTP id
 h21mr8321374wmq.148.1622119912227; Thu, 27 May 2021 05:51:52 -0700 (PDT)
Date:   Thu, 27 May 2021 12:51:34 +0000
In-Reply-To: <20210527125134.2116404-1-qperret@google.com>
Message-Id: <20210527125134.2116404-8-qperret@google.com>
Mime-Version: 1.0
References: <20210527125134.2116404-1-qperret@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 7/7] KVM: arm64: Use less bits for hyp_page refcount
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
 arch/arm64/kvm/hyp/include/nvhe/gfp.h    | 2 ++
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index d420e5c0845f..a82f73faf41e 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -24,6 +24,8 @@ struct hyp_pool {
 
 static inline void hyp_page_ref_inc(struct hyp_page *p)
 {
+	if (p->refcount == USHRT_MAX)
+		BUG();
 	p->refcount++;
 }
 
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
 
-- 
2.31.1.818.g46aad6cb9e-goog

