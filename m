Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE437AECB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhEKSxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhEKSwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:51 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F2C061344
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:37 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n10so19157905ion.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rH6B1Y8q3MjL1HohSGCYSWCX5UPnZylow4i2opQMHbM=;
        b=NFlJHIjk/PDNRHFQangXdJx77gLySvGEbGxTDWq2llBhEQBjAgXbb95fn8TFFfLWUo
         6U3Uaqb9RB/7q0/uHQ65B3loUBI6KKaOEkbEUMqJAZUiXMZAL/RKtMxUgda32/YUwt9L
         Z/BqBbbBBxzlcpK+7pOgcs9lNwswGZZnonlSCqdjAfgw6vwxDrlIwls/qsx3p4Pl0sqr
         8psBZDphKP6BGGVFyTcvF2ReDgNeLCaN3v9vUkFAzw5zdLW0y1LsZxxGv0VQ5kmlzng+
         omP5/ubfaS8yrZ293O3EZK7lVQYwJYnYtE+3hqPl0Su5n/Oq2voBrGUMP1QfuxgBqq21
         nPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rH6B1Y8q3MjL1HohSGCYSWCX5UPnZylow4i2opQMHbM=;
        b=AiW5g9ZMUzH8QbxhRNM5+yr7m1XbQhynrqWft+ArNZOt97ZjpipIh8lHJ/YNN0jvBQ
         N1zI66VIPAxIj+4jBTkqG/D6UhFr8WySwGcSq2CuXnutUddudvOqKrYCqoC5zE6oBQTC
         o8K14A03l7q/5Jw2zBIl/GMUtNC2zCPMR3suh1tEgxeXCG058pdY9w8bq0LP6d580UH1
         NCPc1qeFMyjJTlpv+w0N9RRohV8+HWyzeajsfe5GvByGdUcKQ4nIg3BEIcM7gXFWDRr0
         J0CdZxg/Focf2c8vqewOr3Eohh6PEibzrkR0sWaHabxypILTEN8R6ucwer0OonVAWxPu
         D5mg==
X-Gm-Message-State: AOAM5334Bx0kzESy7woRVdhODh3Agy07PvO9rSFAyn2vaiXeKh6duNbV
        NDjdK0fst8WiNxA3uzWRv2k=
X-Google-Smtp-Source: ABdhPJwvWQ+pbKNdxpmYzkb2pNO0aP/DoUsS/MuIU6IoqmOHDEVTYnK6Jy/D9YAAHACdcEFCXJ0s6A==
X-Received: by 2002:a05:6602:24d4:: with SMTP id h20mr23481287ioe.4.1620759096947;
        Tue, 11 May 2021 11:51:36 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 16/28] dyndbg: add _index to struct _ddebug
Date:   Tue, 11 May 2021 12:50:45 -0600
Message-Id: <20210511185057.3815777-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently use dp->site to map: &__dyndbg[N] -> &__dyndbg_sites[N].
We want to drop site; new _ddebug._index provides the N.  This just
initializes that index.

ddebug_add_module()'s new job is to initialize _index.  In order to
handle builtin modules (sections contain catenated blocks of modules'
callsites) it gets a new base arg to monotonically increment _index
over multiple modules.  Since ddebug_add_module() is used indirectly
by module.c, the new arg is hidden in __ddebug_add_module(), and
defaults to 0 in the wrapper.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  2 ++
 lib/dynamic_debug.c           | 25 ++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 868e0769b72d..a15e417cbba8 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -29,6 +29,7 @@ struct _ddebug {
 	/* format is always needed, lineno shares word with flags */
 	const char *format;
 	const unsigned lineno:18;
+	unsigned _index:14;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -52,6 +53,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
+
 #ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 77c5135879c2..c5927b6c1c0c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1028,10 +1028,12 @@ static const struct proc_ops proc_fops = {
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
-		      unsigned int numdbgs, const char *modname)
+static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+			       unsigned int numdbgs, unsigned int base,
+			       const char *modname)
 {
 	struct ddebug_table *dt;
+	int i;
 
 	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
 	if (!numdbgs) {
@@ -1055,6 +1057,12 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	dt->ddebugs = tab;
 	dt->sites = sites;
 
+	for (i = 0; i < numdbgs; i++, base++) {
+		tab[i]._index = base;
+		v3pr_info(" %d %d %s.%s.%d\n", i, base, modname,
+			  tab[i].site->function, tab[i].lineno);
+	}
+
 	mutex_lock(&ddebug_lock);
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
@@ -1063,6 +1071,12 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	return 0;
 }
 
+int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+		      unsigned int numdbgs, const char *modname)
+{
+	return __ddebug_add_module(tab, sites, numdbgs, 0, modname);
+}
+
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
 static int ddebug_dyndbg_param_cb(char *param, char *val,
 				const char *modname, int on_err)
@@ -1177,6 +1191,7 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int site_ct = 0, entries = 0, modct = 0;
+	int mod_index = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1200,8 +1215,8 @@ static int __init dynamic_debug_init(void)
 		if (strcmp(modname, site->modname)) {
 			modct++;
 
-			ret = ddebug_add_module(iter_mod_start, site_mod_start,
-						site_ct, modname);
+			ret = __ddebug_add_module(iter_mod_start, site_mod_start,
+						  site_ct, mod_index, modname);
 			if (ret)
 				goto out_err;
 			site_ct = 0;
@@ -1211,7 +1226,7 @@ static int __init dynamic_debug_init(void)
 		}
 		site_ct++;
 	}
-	ret = ddebug_add_module(iter_mod_start, site_mod_start, site_ct, modname);
+	ret = __ddebug_add_module(iter_mod_start, site_mod_start, site_ct, mod_index, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.31.1

