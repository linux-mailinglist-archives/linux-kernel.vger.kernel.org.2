Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34C3BB754
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGEGym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 02:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhGEGyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 02:54:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A9FC061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 23:52:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i94so20683676wri.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0PAq5gly45ZNE8e5BiWwjKT7YlCoXcC5+DypWR8xekQ=;
        b=teM2Bdl5BmbHgjRb4mT+Wc5tlBFFsvI/WLte/ypgOKGUdnv1OQ7Q4UHv391bGmdF2m
         fbjqfqpuKXxhzxCDJDI2lq3ePRxzqLiM9pmXPifuVuP3zMWZKJFPU5YmAOCjpcVqeuT+
         69FZ6JbInI1FogYB3U3CtedBGOV4antwVdPDtoL9m15ETVWCn02f42eWwCd74Kmoq9Ah
         X4zfSED0QHJhts6U9sEG7pgUZbDUQuGpITSr78bulxMXcFqeIVR8K9Byj/P1E/6F5Lm7
         X9tkyUNtOZePnWwwfgmgIa1wZgiLvobUBXGpjyW7Im9d22zS83wFUbpQWU8F6BI7Nsn/
         pxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0PAq5gly45ZNE8e5BiWwjKT7YlCoXcC5+DypWR8xekQ=;
        b=uYBGVDUsJl4gzV87LojaVnbfJd6iFBM0N1N5ghuSdRFz1Hvxtz2cu8BeIXLnjsbP75
         d5J3JH7+QWqTCZcwmnRrFPBov/EYO9cF6vgYYASEJkDnd+sYbbLye/GJBsaax++S9h51
         06qUMsIvAfR+7pW1en3mjSTOLgqL+jpVIejd9ZLvRQGq7lo4DVPDX4NQEiWRzXWFT6MZ
         J4JoQWYTP2tmnuo/oDeUJyQ91F8i8J12Og7FBPjp4WNfcd0PKK5FrsCQkc20JHExeJDX
         ykvAW9YRRECFflCLqap5OrjDMM82IVPTi1Bp/W48SQ2lvs2KTluueXNDtZ1hhHc5VZZx
         Mh9g==
X-Gm-Message-State: AOAM531T+dGoSpmSX4GCnWYoa9hvmDA/dpcaUt5lYkx070pCOkm6AXu8
        jOZL20H4I/qVW5JTxMCfmYgxtw==
X-Google-Smtp-Source: ABdhPJyNpOR+dyomUYhPcFDJgtUd7h/Ep6MW12XYAeNSolQ+4SM8/CIDil3Trk4tn13tfpTuwHudRw==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr13930736wru.380.1625467922388;
        Sun, 04 Jul 2021 23:52:02 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:dddd:647c:7745:e5f7])
        by smtp.gmail.com with ESMTPSA id a4sm11784090wru.55.2021.07.04.23.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 23:52:01 -0700 (PDT)
Date:   Mon, 5 Jul 2021 08:51:55 +0200
From:   Marco Elver <elver@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     yee.lee@mediatek.com, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, nicholas.Tang@mediatek.com,
        Kuan-Ying.lee@mediatek.com, chinwen.chang@mediatek.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v5 1/2] mm: introduce helper to check slub_debug_enabled
Message-ID: <YOKsC75kJfCZwySD@elver.google.com>
References: <20210705024101.1567-1-yee.lee@mediatek.com>
 <20210705024101.1567-2-yee.lee@mediatek.com>
 <YOJ6aPuNOtzjVhBC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YOJ6aPuNOtzjVhBC@casper.infradead.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 04:20AM +0100, Matthew Wilcox wrote:
> On Mon, Jul 05, 2021 at 10:40:57AM +0800, yee.lee@mediatek.com wrote:
> > From: Marco Elver <elver@google.com>
> > 
> > Introduce a helper to check slub_debug_enabled, so that we can confine
> > the use of #ifdef to the definition of the slub_debug_enabled_unlikely()
> > helper.
> 
> We don't usually embed '_unlikely' in function names; we
> just do:
> 
> static inline bool slub_debug_enabled(void)
> {
> 	return static_branch_unlikely(&slub_debug_enabled);
> }

The names are identical, this obviously won't work:

In file included from mm/slub.c:21:
mm/slab.h:219:20: error: ‘slub_debug_enabled’ redeclared as different kind of symbol
  219 | static inline bool slub_debug_enabled(void)

But it seems that someone had the same idea, and this merge window got a
__slub_debug_enabled() with 792702911f58.

Yee, can you replace this patch with the below:

From: Marco Elver <elver@google.com>
Date: Wed, 30 Jun 2021 20:56:57 +0200
Subject: [PATCH] mm: move helper to check slub_debug_enabled

Move the helper to check slub_debug_enabled, so that we can confine
the use of #ifdef outside slub.c as well.

Signed-off-by: Marco Elver <elver@google.com>
---
v6:
* Move helper instead of introducing a new one.
---
 mm/slab.h | 15 +++++++++++----
 mm/slub.c | 14 --------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 67e06637ff2e..f997fd5e42c8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -216,10 +216,18 @@ DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 extern void print_tracking(struct kmem_cache *s, void *object);
 long validate_slab_cache(struct kmem_cache *s);
+static inline bool __slub_debug_enabled(void)
+{
+	return static_branch_unlikely(&slub_debug_enabled);
+}
 #else
 static inline void print_tracking(struct kmem_cache *s, void *object)
 {
 }
+static inline bool __slub_debug_enabled(void)
+{
+	return false;
+}
 #endif
 
 /*
@@ -229,11 +237,10 @@ static inline void print_tracking(struct kmem_cache *s, void *object)
  */
 static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
 {
-#ifdef CONFIG_SLUB_DEBUG
-	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
-	if (static_branch_unlikely(&slub_debug_enabled))
+	if (IS_ENABLED(CONFIG_SLUB_DEBUG))
+		VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
+	if (__slub_debug_enabled())
 		return s->flags & flags;
-#endif
 	return false;
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index 2ee43ff667a5..090fa14628f9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -119,25 +119,11 @@
  */
 
 #ifdef CONFIG_SLUB_DEBUG
-
 #ifdef CONFIG_SLUB_DEBUG_ON
 DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
 #else
 DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
-
-static inline bool __slub_debug_enabled(void)
-{
-	return static_branch_unlikely(&slub_debug_enabled);
-}
-
-#else		/* CONFIG_SLUB_DEBUG */
-
-static inline bool __slub_debug_enabled(void)
-{
-	return false;
-}
-
 #endif		/* CONFIG_SLUB_DEBUG */
 
 static inline bool kmem_cache_debug(struct kmem_cache *s)
-- 
2.32.0.93.g670b81a890-goog

