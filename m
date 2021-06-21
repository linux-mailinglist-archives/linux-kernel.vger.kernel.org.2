Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A443AE1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 04:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFUCnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 22:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhFUCnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 22:43:15 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED17C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 19:41:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t9so12929690pgn.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 19:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tiITAbqpPnqkOi6wakpBtQx52McUyGYZCcHPIl7xsy0=;
        b=iWdhN3CFZXKaRQv+sGidLOV3CqKfQ9UOGecgei4hzaT9phkuA+bv+QF4Xiijbwr9Bf
         LAxbOmRf1eFF4PUxvbR+76UPP8RR9HW+TesgbpzrHl7e/ZEGLYXYCw4Z0YXZc36q4F/7
         RpXVGKqUv5SeXPlIj9ngMofFNAxi7fwzT8v+3gAgJIgYhDF56XNkHIs+AYAeC1vvPIeH
         01pGKE+Z2Aqk1Wm2NXKDEv63v+y7UJ4yQx1GIeJL6DwbsB2mkCb+JIROahW6uDgvWb7u
         SNmxwy1jRD/+QJXTAUuHdd7IZ5uw50hWF7cfYp+Cv+6BhNWMXdJJy9t3NnkV+ZFdUmv1
         7qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tiITAbqpPnqkOi6wakpBtQx52McUyGYZCcHPIl7xsy0=;
        b=sFbFbDMj2iqwrKpdSfZlh17SXGXv+C4w92CbjPuk3shZRlX0nzYKEYVLEWCMaRlkos
         wYSFDHUBzPx2ilWwYy40euGSLyrkc/c1hJY2j6vfxmFVQSzhF0l+Tsvx+r+2JRkV55Z5
         n5hbBl9CiNsbde2qPsIfae4VzA+Gw0R5xkCAkY3jmwB8F0YZw3VtWjtIoW+ngQ6y/5Uu
         ZbYfPyubclsXXdlYo7Z/VpSqEPWrYd1n2v7m39tw0pLh0QAi/JszgCbWevJzWEeEKVrN
         HRNVyG9fGOa+xZaXGiNiran7Phl5QowJYnj1ephV4K2BVGF/Vim15DG2tyy9j11Od0b3
         hJuw==
X-Gm-Message-State: AOAM533R5nklncBiJexaEjaS5hkPx5/uc9qlgS9z66qtH0BawXVjJawU
        omnWsE5T77zec0gkZHEhwVQ=
X-Google-Smtp-Source: ABdhPJysEGeNgCsUe0sJ7w+MeGkmUdqIzdMiUGZ6StdWmAAqML6n1yxhMF+1wkt7w9nuC5KTGTx5Cg==
X-Received: by 2002:a63:ff14:: with SMTP id k20mr2714079pgi.390.1624243261301;
        Sun, 20 Jun 2021 19:41:01 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p20sm15052178pgi.94.2021.06.20.19.41.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 19:41:01 -0700 (PDT)
From:   gumingtao <gumingtao1225@gmail.com>
X-Google-Original-From: gumingtao <gumingtao@xiaomi.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        gumingtao <gumingtao@xiaomi.com>
Subject: [PATCH v2] slab: Use %s instead of function name
Date:   Mon, 21 Jun 2021 10:40:40 +0800
Message-Id: <e73123325fa47200f7b94ce36a0152fb774c0538.1624240708.git.gumingtao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1624240708.git.gumingtao@xiaomi.com>
References: <cover.1624240708.git.gumingtao@xiaomi.com>
In-Reply-To: <cover.1624240708.git.gumingtao@xiaomi.com>
References: <cover.1624240708.git.gumingtao@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to replace the function name with %s.

Signed-off-by: gumingtao <gumingtao@xiaomi.com>
---
 mm/slab_common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index a4a5714..ffa3b11 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -378,11 +378,11 @@ kmem_cache_create_usercopy(const char *name,
 
 	if (err) {
 		if (flags & SLAB_PANIC)
-			panic("kmem_cache_create: Failed to create slab '%s'. Error %d\n",
-				name, err);
+			panic("%s: Failed to create slab '%s'. Error %d\n",
+				__func__, name, err);
 		else {
-			pr_warn("kmem_cache_create(%s) failed with error %d\n",
-				name, err);
+			pr_warn("%s(%s) failed with error %d\n",
+				__func__, name, err);
 			dump_stack();
 		}
 		return NULL;
@@ -509,8 +509,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
 
 	err = shutdown_cache(s);
 	if (err) {
-		pr_err("kmem_cache_destroy %s: Slab cache still has objects\n",
-		       s->name);
+		pr_err("%s %s: Slab cache still has objects\n",
+		       __func__, s->name);
 		dump_stack();
 	}
 out_unlock:
-- 
2.7.4

