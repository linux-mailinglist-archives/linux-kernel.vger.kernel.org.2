Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E873643F424
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJ2AxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 20:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2AxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 20:53:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0754EC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:50:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d3so13260140wrh.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8g4RDYLQyNG9ZMdk4Hxtngf0/pIGQ9iK+1OvmNdSMc=;
        b=G45gcvq3QfMGeRiWkPge0w/mwzWzpth8eKoJidXiK5znoWHiDJ1tXdugyMFkuWAHzD
         4rhqVcEHHV9yU7+gNA6/RCu/fYL4ZKVdQT3cKdZYXxp9jjgZSRNr0ylPwEtkxb8fRIit
         Bh4rfalOtqadeovwDwzbspQ+s19J9vvLSiqS99Y5y0j/S7Qpvca4GN3V+sBCKpt965mN
         l2Qe0ioslACo+xtQcXohCS8NgBLd4gWy0jnwOGo9h42K9tfSjt/Dxlk5cKJ5HLYLXLvz
         GmXMZ+Ze6b3dq791idwF48/VJABvanQtrSaHFUAcHC0neeJKn84vlfXdXzPwxXQqi+oa
         S+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8g4RDYLQyNG9ZMdk4Hxtngf0/pIGQ9iK+1OvmNdSMc=;
        b=WB0kc3+ehTXEejSFJJTjOIQ9FhHHTDgKmC38zXKDSv1n69AnKZ4p8eH3B5+6II2iis
         ZregZZujXkxk42je7WmzT4PXNdklXr7++Mui8wi+TYpwRDO16+XzD0suooq0qhLsRqpB
         7dx5OkE4x8pssFQYw4rk0P6WYkEXCCzTs0R909w+PdRRY6XXymmC2IRhb5RjgO/wCSbe
         KGISHvN2jPELgfWV6xspmsr3dB43Av8CroKoPrngopZA3dOsjhSR8RmRo5/pjTbzYaKB
         GLLL38RCrMFcgBIpm8btXdfsTqxCcVzjhMejrw45wZ3Beda9xlwmuEmJn//QmLUo8xFs
         g7Zw==
X-Gm-Message-State: AOAM530qDCK4j0MAMXR22qQioGFgpzechwRyOtMN+a2wVbutBihF/AjA
        ya0W4vJyFi4QITfQLhnkG98c+VUMYiw=
X-Google-Smtp-Source: ABdhPJz/8n9hRbO3LFoNr2azmoC5Czn1zUla10qtFxjleUJ8Nb25eg0mWHiViK1cUpdzV2FiExEeXQ==
X-Received: by 2002:adf:f486:: with SMTP id l6mr9958940wro.375.1635468634633;
        Thu, 28 Oct 2021 17:50:34 -0700 (PDT)
Received: from WRT-WX9.. ([95.179.207.30])
        by smtp.gmail.com with ESMTPSA id o2sm4500852wrg.1.2021.10.28.17.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 17:50:34 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mm/damon: remove return value from before_terminate callback
Date:   Fri, 29 Oct 2021 08:50:23 +0800
Message-Id: <20211029005023.8895-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the return value of 'before_terminate' callback is never used,
we make it have no return value.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 include/linux/damon.h | 2 +-
 mm/damon/dbgfs.c      | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 50c6eb0dee1f..041966786270 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -322,7 +322,7 @@ struct damon_callback {
 	int (*before_start)(struct damon_ctx *context);
 	int (*after_sampling)(struct damon_ctx *context);
 	int (*after_aggregation)(struct damon_ctx *context);
-	int (*before_terminate)(struct damon_ctx *context);
+	void (*before_terminate)(struct damon_ctx *context);
 };
 
 /**
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index befb27a29aab..eccc14b34901 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -645,18 +645,17 @@ static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 		debugfs_create_file(file_names[i], 0600, dir, ctx, fops[i]);
 }
 
-static int dbgfs_before_terminate(struct damon_ctx *ctx)
+static void dbgfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
 
 	if (!targetid_is_pid(ctx))
-		return 0;
+		return;
 
 	damon_for_each_target_safe(t, next, ctx) {
 		put_pid((struct pid *)t->id);
 		damon_destroy_target(t);
 	}
-	return 0;
 }
 
 static struct damon_ctx *dbgfs_new_ctx(void)
-- 
2.32.0

