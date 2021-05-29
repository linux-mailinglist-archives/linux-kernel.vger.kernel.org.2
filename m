Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A644394E1C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhE2UFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhE2UE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:27 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBBAC06134A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:47 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so1798483ooa.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zJmSpc1NvW/Lhza4nPi8ThdobeQkxlICyptMtNYaHMo=;
        b=XVVFOTtZ/cdBgbV2g0ePRuZYiqWkcGBYJqAxV7jA0TTKRy4Ksfenhgx4LJiU12G1IP
         2lJ9Saoxti8B104dlwHMswyrKy+P20rKrPR0vc4YXUj3yVj4/3RdA+r47DVyxuzB50Gg
         vhstcysEEp9Zg7kRWXZdNcw0p5BYNcUA/dN+0TyswNZqcGMpavvs5Yid6mqQIRyNtf2E
         mETzOquxK9r+HxkvH3i5/qgqXP4YwdVnH4DX2iXafjIzaMWeh4LCA89iG6NQAFYrDyy2
         KmIccpHUx7zvtRFqL8RMe8Qw+es1W+20L1lV70Gx4mrxYyODEmFETY8eLWwKKK1MG4pW
         B4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zJmSpc1NvW/Lhza4nPi8ThdobeQkxlICyptMtNYaHMo=;
        b=U18zd5Gvx9gEuFjDkLvJ7EfRw6lWg4C4TBLSVc0Ajmwa4zD2TNdi1s27HVMiTiQKCG
         tfAt7IihPRbEZLGFm9J0WArSDbBj6k2KyUH7QW2sbFJ29s52NCYGnpuktPkiRvV3M/ba
         Cd3Qpy37lW6JTs+KUHpzggqFTg8pChiFcM6qa5xGLxFKf80gOhrVXsQtaRpooHQsOAsg
         05z5HEVit+74+xBAZCc1BWKs7LwuMLQMC2uwntUuRPsT4q/+WNH6N5qe3diX0cxyK+Q5
         PzVRPGw0rjuufFtY0GzPWJ3DQq4HnEsXuEhColdpyiX+YLW8ewr262j4dCYMgVHiG4XU
         FT4Q==
X-Gm-Message-State: AOAM532J4NxW81eSPVuuen2dvOlBcQbbQG2kAMYILJqeqt8BycMIdUTh
        cw8ZQaHfTQDZhi8OPPeAATg=
X-Google-Smtp-Source: ABdhPJzMPvD/Vzd6pLc1jRqyVRVhPPq41TFhmY92cbFnHyvcGQdeZlfvqzLcni6c8KLc7wUaZDsQuw==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr11593353oou.23.1622318567227;
        Sat, 29 May 2021 13:02:47 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 33/34] dyndbg: pack pr-debug site-recs in builtin modules
Date:   Sat, 29 May 2021 14:00:28 -0600
Message-Id: <20210529200029.205306-34-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends HEAD~1 by packing not just into the each module's
sub-vector (slice of builtin dyndbg_sites[] vector), but into
the whole vector.

__ddebug_add_module() gets 2 new parameters to enable this; it
re-writes the packed_sites[] vector with each unique site record, and
tracks index of the last record written in packed_base.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 43f4c82d24c3..66b48f1cb2d0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1069,13 +1069,16 @@ static const struct proc_ops proc_fops = {
  */
 static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 			       unsigned int numdbgs, unsigned int base,
-			       const char *modname)
+			       const char *modname,
+			       struct _ddebug_site *packed_sites,
+			       unsigned int *packed_base)
 {
 	struct ddebug_table *dt;
 	union _ddebug_header *dh = (union _ddebug_header *) &tab[0];
 	int i, j;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
+	v3pr_info("add-module: %s.%d sites, to %d->%d\n", modname, numdbgs,
+		  base, *packed_base);
 
 	if (numdbgs && is_dyndbg_header_pair(dh, sites)) {
 
@@ -1116,12 +1119,13 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	for (i = j = 0; i < numdbgs; i++) {
 		tab[i]._back = base + i; /* index back to header */
 
-		/* find 1st row with new fn, copy it to stack on j */
-		if (sites[i].function != sites[j].function)
-			memcpy((void *) &sites[++j], (void *) &sites[i],
-			       sizeof(struct _ddebug_site));
-
-		tab[i]._map = base + j;
+		/* find 1st row with new fn, copy it to stack on packed_base */
+		if (sites[i].function != packed_sites[*packed_base].function) {
+			j++;
+			memcpy((void *) &packed_sites[++(*packed_base)],
+			       (void *) &sites[i], sizeof(struct _ddebug_site));
+		}
+		tab[i]._map = *packed_base;
 
 		v3pr_info(" %d %d %d %d %s.%s.%d\n", i, j, tab[i]._back, tab[i]._map,
 			  modname, sites[i].function, tab[i].lineno);
@@ -1140,7 +1144,10 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 		      unsigned int numdbgs, const char *modname)
 {
-	return __ddebug_add_module(tab, sites, numdbgs, 0, modname);
+	unsigned int packed_base = 0;	/* skip the header */
+
+	return __ddebug_add_module(tab, sites, numdbgs, 0, modname,
+				   sites, &packed_base);
 }
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
@@ -1253,10 +1260,12 @@ static int __init dynamic_debug_init(void)
 {
 	struct _ddebug *iter, *iter_mod_start;
 	struct _ddebug_site *site, *site_mod_start;
+
 	const char *modname = NULL;
 	char *cmdline;
 	int ret = 0;
 	int i, site_ct = 0, modct = 0, mod_index = 0;
+	unsigned int site_base;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1272,7 +1281,7 @@ static int __init dynamic_debug_init(void)
 	site = site_mod_start = __start___dyndbg_sites;
 	modname = site->modname;
 
-	for (i = 0; iter < __stop___dyndbg; iter++, site++, i++) {
+	for (site_base = i = 0; iter < __stop___dyndbg; iter++, site++, i++) {
 
 		SITE_CHK_(BUG_ON(site != iter->site));
 
@@ -1280,7 +1289,8 @@ static int __init dynamic_debug_init(void)
 			modct++;
 
 			ret = __ddebug_add_module(iter_mod_start, site_mod_start,
-						  site_ct, mod_index, modname);
+						  site_ct, mod_index, modname,
+						  __start___dyndbg_sites, &site_base);
 			if (ret)
 				goto out_err;
 
@@ -1292,7 +1302,9 @@ static int __init dynamic_debug_init(void)
 		}
 		site_ct++;
 	}
-	ret = __ddebug_add_module(iter_mod_start, site_mod_start, site_ct, mod_index, modname);
+	ret = __ddebug_add_module(iter_mod_start, site_mod_start,
+				  site_ct, mod_index, modname,
+				  __start___dyndbg_sites, &site_base);
 	if (ret)
 		goto out_err;
 
-- 
2.31.1

