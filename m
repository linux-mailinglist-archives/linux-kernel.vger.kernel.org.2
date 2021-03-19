Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DD0341FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhCSOlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhCSOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:41:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:41:13 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id u19so3819084pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqhHo+YeTtQNKJqI1Nmg9Lhc7h/uxmrUcSCxPqX7mCM=;
        b=FyZSmlP4DGRtdJxzH1AItezVYjTeONejnnz+aTt5sRjMbNhtjZ6PX7iClDrbPlg8Tg
         e4YYc/4dlnkyvEKJTIM6zBaidNWPYG3WuWDJXK3dNsh6oY/pKl7IXzTCoPeoW3YDVW/Q
         h02HpsHMGPKu0lDL87/RE+idZVOHCCR0Z5i+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqhHo+YeTtQNKJqI1Nmg9Lhc7h/uxmrUcSCxPqX7mCM=;
        b=YO76Hf2psdnRBEh/DPc8wrVqbwRqH+15kzTErqRBcPZ6o4Ko0JuVRdRskJA5Z/jI9M
         EGYvLB1UsQZ4TGOadrIYYRNQ45WaCvmlDxKGx9uABwhzHwsuR0s39o1G/UubpQerMo8q
         nvhaB46yH4ePiKEH5XQyZ6LcacxOdtOL9oO7LbIkqVvHrmVO8aRJR9oQiCc0CCuv9M3G
         yHpOXTiLQsH8OmITsl80wQTihahKIMMl4DGjw5pZu6XkuCX3sokMMVRQ6zLA7qo9PoVH
         Tsx4kwG7Oeumq4pDXoi5BY7kf0F86LNialSh2ms6/2jf4shiYHJCCq4NZORyR3W6nsZw
         TUVQ==
X-Gm-Message-State: AOAM532MOo8GThYsXQlT0Is6hD8m/DBMsYvgIBJSISyIJf7lqEVpaGnq
        BSwwgUcIO1hM8jidb3XqopER5BDb9g+Unw==
X-Google-Smtp-Source: ABdhPJwhZsubqhuhBqxD8pjftO2o+fW3bkpwXwbu7NU660do1sNc0/EcHx+g+rkua6W/EyKwG07E8g==
X-Received: by 2002:a65:4901:: with SMTP id p1mr780094pgs.310.1616164872494;
        Fri, 19 Mar 2021 07:41:12 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-674e-5c6f-efc9-136d.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:674e:5c6f:efc9:136d])
        by smtp.gmail.com with ESMTPSA id s28sm5943535pfd.155.2021.03.19.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 07:41:12 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v11 2/6] kasan: allow architectures to provide an outline readiness check
Date:   Sat, 20 Mar 2021 01:40:54 +1100
Message-Id: <20210319144058.772525-3-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319144058.772525-1-dja@axtens.net>
References: <20210319144058.772525-1-dja@axtens.net>
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
 include/linux/kasan.h | 4 ++++
 mm/kasan/common.c     | 4 ++++
 mm/kasan/generic.c    | 3 +++
 mm/kasan/shadow.c     | 4 ++++
 4 files changed, 15 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 8b3b99d659b7..6bd8343f0033 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -23,6 +23,10 @@ struct kunit_kasan_expectation {
 
 #endif
 
+#ifndef kasan_arch_is_ready
+static inline bool kasan_arch_is_ready(void)	{ return true; }
+#endif
+
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 #include <linux/pgtable.h>
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6bb87f2acd4e..f23a9e2dce9f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -345,6 +345,10 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return false;
 
+	/* We can't read the shadow byte if the arch isn't ready */
+	if (!kasan_arch_is_ready())
+		return false;
+
 	if (!kasan_byte_accessible(tagged_object)) {
 		kasan_report_invalid_free(tagged_object, ip);
 		return true;
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
 
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 727ad4629173..1f650c521037 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -80,6 +80,10 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 	 */
 	addr = kasan_reset_tag(addr);
 
+	/* Don't touch the shadow memory if arch isn't ready */
+	if (!kasan_arch_is_ready())
+		return;
+
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
 	if (is_kfence_address(addr))
 		return;
-- 
2.27.0

