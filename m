Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7537AEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhEKSwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhEKSwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:31 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754B9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:24 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d24so9284406ios.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZkviL91C3S/9XGWOAEsFN6SwEwgKBbc6qaVmyj/czk=;
        b=ht6EjtpH+LwfipsvifQcYTFOoQzDQKwxEEL7FJoNg2SPggbyZlLt6MaRZpkWFUt2iz
         HHXfeLAWlGcovpiK45++gYuGOtahHTGxLrczNlQOy6ZcTPOHQa0oERsvlmgvenjsMs6c
         SJ99BUGK8MbxK9N0ZqBjQgFxnJlSSTlEH1sDpasFbHgN3r4Xd7UWRTetiIsRfUMRsoCS
         VhyGoi1XhL+dXHg8LlsL8n+l83/+uhGmnpY8heRC/gGeL8srVNDtAk04VtUXJgMohVU/
         Bbg4l6S9y7YBHiuprhperdYKKGdIYPWpymcOLuL9hZ9FkQEHOz1woh97I85tGPltfbmW
         04Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZkviL91C3S/9XGWOAEsFN6SwEwgKBbc6qaVmyj/czk=;
        b=bbNhf6+Qr+o4x1CmwVCYgdGtGQLfEojgYivct6xyzBjwlIOkWv06tYT5cP6l62j4HR
         2edsbQsMVK8B1F+slYxrZNX2lXe7ttigVdjLh/WtCNc4dmKYhLtE6XnOL0tv2tAIUqiy
         Cp/wA9hoC3g9at4zbFwpUHGAuOFsagRFI0tKF91ylltUt0McK0BM1rx61wjgLTRi6cJB
         Afyreb/NEY8Wqqgk/6/88wITPIHLyOAXE1D2MmI/XEQufP0umVA7Ui7wRZvPrUUSRdZA
         77giKO7BzsyDTVvZJKNGv28HVAaI22cV6I3HUIf36RfdZip+hWALGe0/aG4RswWp43BA
         yz5g==
X-Gm-Message-State: AOAM531cmydDeOZ97KznseTQyFGGqlWymH6MXrcWeB1nlnomq7p0tFts
        LnEhOfTMu4rIZq84/TFH5h8=
X-Google-Smtp-Source: ABdhPJxzpAnZ6yyG6y/pP46Oicb8855pCdM+WeFMnHZ4XRPMivf+4zeW3JPkZjxJ20KrXfuAfg8YuA==
X-Received: by 2002:a02:b717:: with SMTP id g23mr29183874jam.109.1620759083943;
        Tue, 11 May 2021 11:51:23 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 04/28] dyndbg: __init iterate over __dyndbg & __dyndbg_site in parallel
Date:   Tue, 11 May 2021 12:50:33 -0600
Message-Id: <20210511185057.3815777-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In HEAD~1, a new elf section was added, and dynamic_debug_init() got
minimal adjustments; basically s/iter/iter->site/ where needed.

Now we rework the for-loop for clarity:
. iterate over both sections in parallel (iter & site)
. demote iter->site indirection (1st step towards dropping site)
. add __(start|stop)___dyndbg_sites decls (init'd in vmlinux.lds.h)
. add/rename several iterator/mod_start variables for clarity.
. add BUG_ON(iter->site != site)
. var rename n to site_ct

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c1c2c90ed944..5a33143215a4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -41,6 +41,8 @@
 
 extern struct _ddebug __start___dyndbg[];
 extern struct _ddebug __stop___dyndbg[];
+extern struct _ddebug_site __start___dyndbg_sites[];
+extern struct _ddebug_site __stop___dyndbg_sites[];
 
 struct ddebug_table {
 	struct list_head link;
@@ -118,6 +120,7 @@ do {								\
 
 #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
+#define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
@@ -1086,11 +1089,12 @@ static int __init dynamic_debug_init_control(void)
 
 static int __init dynamic_debug_init(void)
 {
-	struct _ddebug *iter, *iter_start;
+	struct _ddebug *iter, *iter_mod_start;
+	struct _ddebug_site *site, *site_mod_start;
 	const char *modname = NULL;
 	char *cmdline;
 	int ret = 0;
-	int n = 0, entries = 0, modct = 0;
+	int site_ct = 0, entries = 0, modct = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1101,23 +1105,29 @@ static int __init dynamic_debug_init(void)
 		ddebug_init_success = 1;
 		return 0;
 	}
-	iter = __start___dyndbg;
-	modname = iter->site->modname;
-	iter_start = iter;
-	for (; iter < __stop___dyndbg; iter++) {
+
+	iter = iter_mod_start = __start___dyndbg;
+	site = site_mod_start = __start___dyndbg_sites;
+	modname = site->modname;
+
+	for (; iter < __stop___dyndbg; iter++, site++) {
+
+		BUG_ON(site != iter->site);
 		entries++;
-		if (strcmp(modname, iter->site->modname)) {
+
+		if (strcmp(modname, site->modname)) {
 			modct++;
-			ret = ddebug_add_module(iter_start, n, modname);
+			ret = ddebug_add_module(iter_mod_start, site_ct, modname);
 			if (ret)
 				goto out_err;
-			n = 0;
-			modname = iter->site->modname;
-			iter_start = iter;
+			site_ct = 0;
+			modname = site->modname;
+			iter_mod_start = iter;
+			site_mod_start = site;
 		}
-		n++;
+		site_ct++;
 	}
-	ret = ddebug_add_module(iter_start, n, modname);
+	ret = ddebug_add_module(iter_mod_start, site_ct, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.31.1

