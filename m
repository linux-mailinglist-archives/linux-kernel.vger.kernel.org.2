Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6EA3979FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhFASX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbhFASXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA15C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:22:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g6so176084pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPjY3p17RpdUxmvaUzvStFXowgAqs5bSM8U5J4753tM=;
        b=JdKbC5WayUy2DBLywV0jSbrlIjP/2nSMm9wzijAMUyrJfbt/taBTudIdXt9r2Q7J8+
         LlAwIX8W7OjgLZCIgQ21bDoc7TAkhJOOynZgop0OLwTDkaFFdBIk//n7/kuf514UU4Vq
         RLKf6Fw9Ep1MDXX/3JOCXAt0xQL2GN94FRDk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPjY3p17RpdUxmvaUzvStFXowgAqs5bSM8U5J4753tM=;
        b=MdwYUTy6Q9Z2Kg7Ch3Cs9la/e3N9znYMrS2Nk156peD4GUq1m0qAMk9kQl2iYV8XGl
         JbCQLgLmg6Dc9uAhjLmfWTmSPurzDTGOoP9XmCUZxEB54xa9m1ieIer8DI9rzgzhgcY5
         W4EEkFa6s7Q90z4UyejXKXuHBMeHkihNwOPp0mdK1m/ZLNg7mbnRg2iW91tsR21OgLMl
         xSWyzzR6pNg2zrh2X0Pplqeznz4saT2BsgNeeakserorZrnAyjxFlZV2+GcthhtZBrz2
         Wc1ICv0C8/f/pZRFtAvOE98LALbV/zb6JllvFgG+eHDKNUugUOTMVXf5e+EAKifWM5i9
         Ee0g==
X-Gm-Message-State: AOAM530Pg2T54nHZUQIeByd5P29V9EyHwKkpnIQ+FnWyOH33F2KT32Ur
        uP8+Em7hp2SJlKrgRS4iwcMXJg==
X-Google-Smtp-Source: ABdhPJw35jzyT/JFV/F68qpD5e6asH7oVRjLNYleVcXFqZXGe2B72Cc7Y+nPOxbvoNAkIjfZYCR+ZQ==
X-Received: by 2002:aa7:82c6:0:b029:2d8:9160:5942 with SMTP id f6-20020aa782c60000b02902d891605942mr22919323pfn.78.1622571730084;
        Tue, 01 Jun 2021 11:22:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ee82:b2a7:c8bd:18e7])
        by smtp.gmail.com with ESMTPSA id g29sm14510982pgm.11.2021.06.01.11.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 11:22:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug is enabled
Date:   Tue,  1 Jun 2021 11:22:02 -0700
Message-Id: <20210601182202.3011020-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210601182202.3011020-1-swboyd@chromium.org>
References: <20210601182202.3011020-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obscuring the pointers that slub shows when debugging makes for some
confusing slub debug messages:

 Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17

Those addresses are hashed for kernel security reasons. If we're trying
to be secure with slub_debug on the commandline we have some big
problems given that we dump whole chunks of kernel memory to the kernel
logs. Let's force on the no_hash_pointers commandline flag when
slub_debug is on the commandline. This makes slub debug messages more
meaningful and if by chance a kernel address is in some slub debug
object dump we will have a better chance of figuring out what went
wrong.

Note that we don't use %px in the slub code because we want to reduce
the number of places that %px is used in the kernel. This also nicely
prints a big fat warning at kernel boot if slub_debug is on the
commandline so that we know that this kernel shouldn't be used on
production systems.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/kernel.h | 2 ++
 lib/vsprintf.c         | 2 +-
 mm/slub.c              | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 15d8bad3d2f2..bf950621febf 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -357,6 +357,8 @@ int sscanf(const char *, const char *, ...);
 extern __scanf(2, 0)
 int vsscanf(const char *, const char *, va_list);
 
+extern int no_hash_pointers_enable(char *str);
+
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(const char *ptr, char **retptr);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f0c35d9b65bf..cc281f5895f9 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2186,7 +2186,7 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 bool no_hash_pointers __ro_after_init;
 EXPORT_SYMBOL_GPL(no_hash_pointers);
 
-static int __init no_hash_pointers_enable(char *str)
+int __init no_hash_pointers_enable(char *str)
 {
 	if (no_hash_pointers)
 		return 0;
diff --git a/mm/slub.c b/mm/slub.c
index bf4949115412..a722794f1dbd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4460,6 +4460,10 @@ void __init kmem_cache_init(void)
 	if (debug_guardpage_minorder())
 		slub_max_order = 0;
 
+	/* Print slub debugging pointers without hashing */
+	if (static_branch_unlikely(&slub_debug_enabled))
+		no_hash_pointers_enable(NULL);
+
 	kmem_cache_node = &boot_kmem_cache_node;
 	kmem_cache = &boot_kmem_cache;
 
-- 
https://chromeos.dev

