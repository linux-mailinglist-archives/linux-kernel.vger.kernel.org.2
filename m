Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FF242C588
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbhJMQBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhJMQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:01:06 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470C9C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:03 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id j19-20020adfb313000000b00160a9de13b3so2360068wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jY5Bguf6FHbyrvp9n+fOCeNfdUoUza19VDS/XHTNadE=;
        b=a2bOxgesO4qShM9iZUtwxpNLNxvAtISKgoXG58VYG79ZxfXEvlG4txY+QkZoEO33fr
         k8oSCXYH8GFser7sVBGps8Vjd1hFlXGn5Ts0CCcl2YJqxk3xdJFxAIsh+rBQxP2SkpQQ
         q347qvkPHogVXKP8Z/gA0OMQ6RXw4b7Pj69mipXSocgiJn7uu/wVPB7Ljf7jnX5yMZdN
         5FKtQ19TMmETiAtK1UX8oROSHR0BqOCK12jCUhWEAqJJ9V5EaIC1BevZLvOQtIxRv/we
         3alhXG4rLviir9mjCOgr2Z2d38wDI2PSOWjG2Wb6omWVPHFuxiTwi3WQoexeHeTBEv+V
         rfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jY5Bguf6FHbyrvp9n+fOCeNfdUoUza19VDS/XHTNadE=;
        b=riKCx+kCVDc+Pk66P1nRKmqbyG6wvIZqS9HBr+Cv6XvReM7F9s+vCz8pQsNi6agMNu
         L0rbr4ctmhlJKIIktXOAlYqiWuLFh8qFWUyGK5VWtwPnu1O+MgulD1f3pOvQuzKWAF+E
         tzphoQ88S0CIhw/QbM1ACQ/tZ88j4kB+6I2Tx3Riw3LWZ8QSTVPEL20Xjz139hFe5Ole
         1ZO9BLmRx64u3D1WgZTnUwgy0KQELw9dTjpxdpo1ZYunP9zlmpPX35A06t6FPeieXcgk
         SzQrjKIJItq5h2/21pMKM2X7yGRCP9c/qcY3eSQqRqEXdxQAAAMmy5przJ/TJ4RH+Pv/
         V5/Q==
X-Gm-Message-State: AOAM530DNNXeOpwK3675U9OgKaHxiBTmBM4AHek5c1rxB8+B4YaLuE0h
        Lo51MsPMxRsN3YZianpI1ZRiGDbB9AqT
X-Google-Smtp-Source: ABdhPJxV4HY2vWNYpk4jg87UJ31CTmQTVWpbTKB1UxegDt8PV1t1yvNzHY7X12YOZjtv1MWET7xESBbrbphK
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:adf:a31d:: with SMTP id
 c29mr40005842wrb.381.1634140741873; Wed, 13 Oct 2021 08:59:01 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:27 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-13-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 12/16] KVM: arm64: Move hyp refcount helpers to header files
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon need to touch the hyp_page refcount from outside
page_alloc.c in nVHE protected mode, so move the relevant helpers into a
header file.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 18 ++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 592b7edb3edb..e77783be0f3f 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -12,6 +12,24 @@ struct hyp_page {
 	unsigned short order;
 };
 
+static inline void hyp_page_ref_inc(struct hyp_page *p)
+{
+	BUG_ON(p->refcount == USHRT_MAX);
+	p->refcount++;
+}
+
+static inline int hyp_page_ref_dec_and_test(struct hyp_page *p)
+{
+	p->refcount--;
+	return (p->refcount == 0);
+}
+
+static inline void hyp_set_page_refcounted(struct hyp_page *p)
+{
+	BUG_ON(p->refcount);
+	p->refcount = 1;
+}
+
 extern u64 __hyp_vmemmap;
 #define hyp_vmemmap ((struct hyp_page *)__hyp_vmemmap)
 
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 38accc2e23e3..0d977169ed08 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -144,24 +144,6 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 	return p;
 }
 
-static inline void hyp_page_ref_inc(struct hyp_page *p)
-{
-	BUG_ON(p->refcount == USHRT_MAX);
-	p->refcount++;
-}
-
-static inline int hyp_page_ref_dec_and_test(struct hyp_page *p)
-{
-	p->refcount--;
-	return (p->refcount == 0);
-}
-
-static inline void hyp_set_page_refcounted(struct hyp_page *p)
-{
-	BUG_ON(p->refcount);
-	p->refcount = 1;
-}
-
 static void __hyp_put_page(struct hyp_pool *pool, struct hyp_page *p)
 {
 	if (hyp_page_ref_dec_and_test(p))
-- 
2.33.0.882.g93a45727a2-goog

