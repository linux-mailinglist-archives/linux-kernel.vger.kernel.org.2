Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3250A3A7480
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFOC7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhFOC7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:59:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:57:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 11so7675897plk.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yfG43b2K5TzVk5ZU+QSFD/NukUJWMplQuDr+tXNhQQ=;
        b=Zp8KnLUSatybticlxZJApD0i9G8GXZx7RpoNRl1/7XodZnv+q2U9g29MDo5vvrQxLQ
         7Y/gzsANS6ZqQigBUlcKaa7bQlBiMlZ6WyHTlqx9NI+D6nSRIgUkUIPH5IEvWv+o+xOX
         R+avk3QSGA1U5XWfPL50c0h907VeEKM8o1Qvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yfG43b2K5TzVk5ZU+QSFD/NukUJWMplQuDr+tXNhQQ=;
        b=LApXq6/35MNI9yMH7jPcPSjUlkjN2tx1iZv9ktzBsHru/jk4wktlsfO4u+jnBJR13H
         ycbPk7NzhgZOHCce6RlB1/ifwHB8VPnaKRMqBuutwSrlHkRREHlLX0l+drdW74HpANBk
         /Z6H1oVQsAi3uYJdQMVD5S8LkJIOk5wOo/BkNxl2heSPVv9vNTP5pNikjofu8no4ln+u
         T2xZqUxXToaFMLlJIghS/fRoMUiLeyJ5/vxzJUN8n2cTCutL5wacuKg7BARwjCZ5mDrs
         6OLSkMuqvXNpIzT70xYFQdwbi+gALzNSxd+0o9p51YSo6+1M0N9kd/rQ8xB/AO+wLEkX
         MzCw==
X-Gm-Message-State: AOAM530cLynIYUtai+9fYE2ccLtZB5HRX1Z/PYGiZ9kXmSggIebMWnGE
        yXYY5p5d8VnU5e7qp6ptHKC88o5N2ml9Hw==
X-Google-Smtp-Source: ABdhPJwayJvIluspopg5KlfYC5uZhjdSK6RLrVbRnbo5dYy82BcNvz2/dLQevVxTLK0wqyDRuuEEFA==
X-Received: by 2002:a17:902:d888:b029:11c:1010:f0ea with SMTP id b8-20020a170902d888b029011c1010f0eamr1621088plz.68.1623721639363;
        Mon, 14 Jun 2021 18:47:19 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id n14sm13096115pfa.138.2021.06.14.18.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:47:18 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     elver@google.com, Daniel Axtens <dja@axtens.net>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v12 2/6] kasan: allow architectures to provide an outline readiness check
Date:   Tue, 15 Jun 2021 11:47:01 +1000
Message-Id: <20210615014705.2234866-3-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210615014705.2234866-1-dja@axtens.net>
References: <20210615014705.2234866-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow architectures to define a kasan_arch_is_ready() hook that bails
out of any function that's about to touch the shadow unless the arch
says that it is ready for the memory to be accessed. This is fairly
uninvasive and should have a negligible performance penalty.

This will only work in outline mode, so an arch must specify
ARCH_DISABLE_KASAN_INLINE if it requires this.

Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Daniel Axtens <dja@axtens.net>

--

I discuss the justfication for this later in the series. Also,
both previous RFCs for ppc64 - by 2 different people - have
needed this trick! See:
 - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
 - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
---
 mm/kasan/common.c  | 4 ++++
 mm/kasan/generic.c | 3 +++
 mm/kasan/kasan.h   | 4 ++++
 mm/kasan/shadow.c  | 4 ++++
 4 files changed, 15 insertions(+)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 10177cc26d06..0ad615f3801d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -331,6 +331,10 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 	u8 tag;
 	void *tagged_object;
 
+	/* Bail if the arch isn't ready */
+	if (!kasan_arch_is_ready())
+		return false;
+
 	tag = get_tag(object);
 	tagged_object = object;
 	object = kasan_reset_tag(object);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 53cbf28859b5..c3f5ba7a294a 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -163,6 +163,9 @@ static __always_inline bool check_region_inline(unsigned long addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
+	if (!kasan_arch_is_ready())
+		return true;
+
 	if (unlikely(size == 0))
 		return true;
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8f450bc28045..19323a3d5975 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -449,6 +449,10 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
 
 #endif /* CONFIG_KASAN_GENERIC */
 
+#ifndef kasan_arch_is_ready
+static inline bool kasan_arch_is_ready(void)	{ return true; }
+#endif
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 082ee5b6d9a1..74134b657d7d 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -73,6 +73,10 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
 
+	/* Don't touch the shadow memory if arch isn't ready */
+	if (!kasan_arch_is_ready())
+		return;
+
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
 	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
-- 
2.27.0

