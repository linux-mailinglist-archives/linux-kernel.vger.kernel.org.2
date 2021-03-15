Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4AE33C522
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhCOSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhCOSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:02:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D507EC061763
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q12so5223516plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0uLi49Yx6Hs1kogqwqRCUz/Bpqh/dFOqLS4VRKyyBc=;
        b=NpVfbBSkCMGMjvqUBvpnwYBUDLSg0t4mYOsEdbBvi2yZSriP+lLClj248lVLlV1mpf
         nX/stjeHOgx3unJ6YY/jz4OctbXPuxLlEunQgCM/jxtNPHvbwL+KbU7nEMw6u8yj22PF
         /M7fJIqZgumlNjIVXD5qiAhMakD1OX3Kq+TYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0uLi49Yx6Hs1kogqwqRCUz/Bpqh/dFOqLS4VRKyyBc=;
        b=Meki2/SvpfYk/oHIKg8Oa5o1d5f0aH7ojcEORJU3qSJJOkgMQfAPycCZnzBrcIzkbe
         rAKxMjVAqHd4U2ZJzsKq40zdRNwpClR7pa/G/aV08ixFwOA5n9GwkiZf3PdSvY/T3stC
         E7x4uKTfWJZFNqgK+10RaQ0wstPgECu3QyYbEaP3XbfKXT5ngyxOSNYGqL1a3hKY3ahw
         0sdo+OkDEWYpbfDEE+mleomyQaXDyte8yVn41IzkjZpmZPxu6Jzq0OTd/m6BzR97WsZQ
         yxjgeNm1MYdRSxzy9eWN0m2mDhK3/ZaRcu5n0OVtQqCrAwNwHHIg8ClJZLyr4tD5qcoR
         3yDg==
X-Gm-Message-State: AOAM532ROeIa/qBfmB5KHnBuFvnwz8LGv0B+v9aCqAaHBuAZixJskEBd
        79i+6bt0yIVWFFtTdc4F8lkioA==
X-Google-Smtp-Source: ABdhPJw3XuSiNT39U8lLpLBLKNJyfyNfidC2LZuwiQfSz+u6PVqNYpahOsQIoKSVW+ozDdUAE8Umjg==
X-Received: by 2002:a17:90b:691:: with SMTP id m17mr276901pjz.191.1615831356378;
        Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s194sm14416197pfs.57.2021.03.15.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:02:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] init_on_alloc: Optimize static branches
Date:   Mon, 15 Mar 2021 11:02:25 -0700
Message-Id: <20210315180229.1224655-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315180229.1224655-1-keescook@chromium.org>
References: <20210315180229.1224655-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=d73e14f50f59a92ac8538519f3e1f53d503ab26d; i=7VrM8Pzr5MGi8vAaDOW4xeiDtVYbjHgJsdLlT/sxDXE=; m=9pRPoTwktIPBeIWxjZ3xtu7JAekgWFD5JAmIfxnzZpU=; p=kGv6Q+SMrU5E1IdQ/vRaEbpDt4x68fXZGP3gRBxoslM=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBPoTQACgkQiXL039xtwCYmkw//V/q 8YDIGvlrMf++Qpx3Y4F3jp6BV9YPPaIeh+7wAqmOGLpfhHGIggCuroF6Bx+Pb+rJbjJa63cbQizhi k+AxuhTsUnZpfHDR4Q1TIjsYJAN8XBXR1HGAaLwnq/D20E+EJsPOMDCisEsVPuvQbJdxaW7qb0oDK vmDWKOZCcN7VIYqpXnqB897l8P5RcLTtv4l3yUs1mVosqpb+CNXMSPI1Csr3e8nrZPM5SuoYZakj2 i3gfACSgTGgzqo5KZvY58pagDyHUK7lufPiP9kwsnmq6Jv8OvlbkNQwwC8vzmek5lJ9rpju01wlDr O4a7cCdjmm2CjDMAI1maK25DDY0MkNzViwrAtSJ0g28yVrPq8OTQINu4J/oKsu8DOeU8dk+34adFn 5fSkkgS3r20gMPIrsVPDewIJBmOzWQAUbaFhoUucmBcOAHLPnmmTyOzcBqBgksXuOckNOZcwIUvys Mtb04OUCS3Pxzl1b3XcOLInfxgqm88Bre7PgJv5HvexCmdLHKJ6aCNojW9UP4qngdA/HgFkL0LTwU PwcmH+LmUx5Ofpm8QT/VEoUhjsA3j9ZHX/R7vfwe9w6Sl42G6IXNZr9Ft79uOnYTfh3rkH8ksvs/U Xmq1KzeG9cpSvVSK3U4JH8tziH45YgiOwYUOazJKUTgYCIyV6QPse1xpMvnH/cXs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and ...ON_FREE...) did not
change the assembly ordering of the static branches: they were always out
of line. Use the new jump_label macros to check the CONFIG settings to
default to the "expected" state, which slightly optimizes the resulting
assembly code.

Reviewed-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/lkml/CAG_fn=X0DVwqLaHJTO6Jw7TGcMSm77GKHinrd0m_6y0SzWOrFA@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h | 10 ++++++----
 mm/page_alloc.c    |  4 ++--
 mm/slab.h          |  6 ++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3eac80..2ccd856ac0d1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2871,18 +2871,20 @@ static inline void kernel_poison_pages(struct page *page, int numpages) { }
 static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
 #endif
 
-DECLARE_STATIC_KEY_FALSE(init_on_alloc);
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
-	if (static_branch_unlikely(&init_on_alloc))
+	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				&init_on_alloc))
 		return true;
 	return flags & __GFP_ZERO;
 }
 
-DECLARE_STATIC_KEY_FALSE(init_on_free);
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
-	return static_branch_unlikely(&init_on_free);
+	return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				   &init_on_free);
 }
 
 extern bool _debug_pagealloc_enabled_early;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..267c04b8911d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -167,10 +167,10 @@ unsigned long totalcma_pages __read_mostly;
 
 int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
-DEFINE_STATIC_KEY_FALSE(init_on_alloc);
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 EXPORT_SYMBOL(init_on_alloc);
 
-DEFINE_STATIC_KEY_FALSE(init_on_free);
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
 static bool _init_on_alloc_enabled_early __read_mostly
diff --git a/mm/slab.h b/mm/slab.h
index 076582f58f68..b0977d525c06 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -601,7 +601,8 @@ static inline void cache_random_seq_destroy(struct kmem_cache *cachep) { }
 
 static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
 {
-	if (static_branch_unlikely(&init_on_alloc)) {
+	if (static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				&init_on_alloc)) {
 		if (c->ctor)
 			return false;
 		if (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON))
@@ -613,7 +614,8 @@ static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
 
 static inline bool slab_want_init_on_free(struct kmem_cache *c)
 {
-	if (static_branch_unlikely(&init_on_free))
+	if (static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				&init_on_free))
 		return !(c->ctor ||
 			 (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)));
 	return false;
-- 
2.25.1

