Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0253B2590
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFXDn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhFXDnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:43:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A1C061760
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:41:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s14so2744980pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvVNbLnwqJAIYi/oiSLioHcxV6FtIVBfZ8nguMWCTFE=;
        b=gUFBIaMMZ1d3pt0GkDSe2NiIRaSGldh05CajT4om97f0wQSzL0x8j2RMIxpLd2Us0v
         IURILWgkklaZE0j6t8K/lCQ42QWj0/9j8vXatmOsNbzRQH3UCZFs5mfL67RPu1w3gHWK
         FKQl5/txcTBPVVBgLDeooy7VhwpG+jnMWjoL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvVNbLnwqJAIYi/oiSLioHcxV6FtIVBfZ8nguMWCTFE=;
        b=jhECj5pOGT95jKYRxmZFfhE9/WAPMqcMdEZ55QbonTOeCZtBrtWTVGZ7VagHmRffmd
         757lej8kQb1I4UOX464+k5jLkLIdfNjB3yo6heawA6I1DJTlEHcJgk2TqEY9N9JbcFse
         uJW0YKC4zuNQOAf5X02sk0aEqCc50bjyG7I7ecLa2jPWi0YqC2IHwqRGd0YwIaGKTdfF
         psF7XXy1TvpYHXdVG0Z3XDDg0j9i47qFJ9AE8DeSi8m4uENxY1G3GhRrByZnP620gi8C
         xvgbYQoXvceBD5hVfr/pcSmVaicUsbea6BpKSGwMVbH1zqBMVPDoEZHBQauXEYuG+oA7
         DbRQ==
X-Gm-Message-State: AOAM531JyDqwwISAFqlu4SvfP65F+gIatJM3xRAFdji1fegDYhXuIyiq
        IxunBEQzoFQA1kcKRMdFapgo9T6waOX05w==
X-Google-Smtp-Source: ABdhPJzmWte/VMqL+/sIhBU5wbozLQoCL7Iah3oMqjhyr7uichTCCCil0qJE2gDAROVokeV7Jiagow==
X-Received: by 2002:a63:501f:: with SMTP id e31mr2748949pgb.231.1624506064897;
        Wed, 23 Jun 2021 20:41:04 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id y7sm1137228pfy.153.2021.06.23.20.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 20:41:04 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v16 2/4] kasan: allow architectures to provide an outline readiness check
Date:   Thu, 24 Jun 2021 13:40:48 +1000
Message-Id: <20210624034050.511391-3-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624034050.511391-1-dja@axtens.net>
References: <20210624034050.511391-1-dja@axtens.net>
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
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

--

Both previous RFCs for ppc64 - by 2 different people - have
needed this trick! See:
 - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
 - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series

Build tested on arm64 with SW_TAGS and x86 with INLINE: the error fires
if I add a kasan_arch_is_ready define.
---
 mm/kasan/common.c  | 3 +++
 mm/kasan/generic.c | 3 +++
 mm/kasan/kasan.h   | 6 ++++++
 mm/kasan/shadow.c  | 6 ++++++
 4 files changed, 18 insertions(+)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 10177cc26d06..2baf121fb8c5 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -331,6 +331,9 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 	u8 tag;
 	void *tagged_object;
 
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
index 8f450bc28045..4dbc8def64f4 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -449,6 +449,12 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
 
 #endif /* CONFIG_KASAN_GENERIC */
 
+#ifndef kasan_arch_is_ready
+static inline bool kasan_arch_is_ready(void)	{ return true; }
+#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
+#error kasan_arch_is_ready only works in KASAN generic outline mode!
+#endif
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 082ee5b6d9a1..8d95ee52d019 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -73,6 +73,9 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
 
+	if (!kasan_arch_is_ready())
+		return;
+
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
 	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
@@ -99,6 +102,9 @@ EXPORT_SYMBOL(kasan_poison);
 #ifdef CONFIG_KASAN_GENERIC
 void kasan_poison_last_granule(const void *addr, size_t size)
 {
+	if (!kasan_arch_is_ready())
+		return;
+
 	if (size & KASAN_GRANULE_MASK) {
 		u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
 		*shadow = size & KASAN_GRANULE_MASK;
-- 
2.30.2

