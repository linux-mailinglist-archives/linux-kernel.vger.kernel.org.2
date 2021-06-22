Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A683B00DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhFVKBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhFVKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:01:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6624C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:59:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o21so10171940pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fWyxVP5TubxadYnG5B6dMDsoSFF6OPmW883RO9Ii+UI=;
        b=R24mIOPvoHL3hw4UXY7zM5quCmSotsIYa02egM0qd9OR0RxqZWYIzSN52aXPi0dr8I
         OvXjT0VPpyU0heqADJonB1miSJ/T0HhOo0M0IGWycC1MtbGUj2EGuW7zM61Nl/osWB53
         EawnGc4BkjIoeyj2uE2p8hWSLmYOAj9dM5YpRxfpnZN5rI+MmX4MHwX3srdbhq4ZEkXR
         XmdaJX9UeTB3HO9A40gSR4iWhxysEIet/M0xq+Q6uCYqigtGB1Z13tjylU3RfmtsKAbs
         Nz8Fu8RulQQPr3fxpm7Fmifh3J4nEDQYt/jdBpTT5pK8KsV1JiuCjzU0uEIDm/e4N0rZ
         m5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fWyxVP5TubxadYnG5B6dMDsoSFF6OPmW883RO9Ii+UI=;
        b=b+eRqk8T0XLmOBc/qngadurIjpZphEhc4I6j8G/KO83yNrxq5wXbiipgbH536c+Qg+
         KmBt1wf6fpFDIU80YoVJsbLheMme5AoYF8LUwL9zEWA+lG/KkW3eWvZeKEiIwfHt/pcl
         2jLolSyfL7bMdR9/4TM6dmbMzal9ZjmgT9sX4eQ+c6BnwWP0HQDROJEq8z85UEtiPSmv
         g49Df0dx5pGnbAcui6fZH3T8lPSb/zoLYOMkS+qR93ES+BKIDx7wNWzq4JG57cX1Lyjg
         elEynfZLOPw2hyiJW5c5xKLfNjKRreDNqW/LaA/Nu+Y+WhmJ2gk50ERml2/nrGUozh/s
         e4Tw==
X-Gm-Message-State: AOAM533g2cJ70PYihvHQe075vRVU5zXiP+Q7u0w2XuxcWtYaMKEmdxBE
        w/3k7L2f03Y8JTXKvgm1l6E=
X-Google-Smtp-Source: ABdhPJyei2FVezO07TmiytsjbpVEf8ctrqRTAqb156L9ShGWVBs/ivSPgelXJ0B+0pOT15GOPkQkoA==
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr3293153pjb.124.1624355974371;
        Tue, 22 Jun 2021 02:59:34 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id o20sm1814577pjq.57.2021.06.22.02.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 02:59:34 -0700 (PDT)
From:   gumingtao <gumingtao1225@gmail.com>
X-Google-Original-From: gumingtao <gumingtao@xiaomi.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        gumingtao <gumingtao@xiaomi.com>
Subject: [PATCH v3] slab: Use __func__ to trace function name
Date:   Tue, 22 Jun 2021 17:59:25 +0800
Message-Id: <31fdbad5c45cd1e26be9ff37be321b8586b80fee.1624355507.git.gumingtao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1624355507.git.gumingtao@xiaomi.com>
References: <cover.1624355507.git.gumingtao@xiaomi.com>
In-Reply-To: <cover.1624355507.git.gumingtao@xiaomi.com>
References: <cover.1624355507.git.gumingtao@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to use __func__ to trace function name.

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

