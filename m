Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C189B41CBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbhI2Sjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346286AbhI2Sje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:39:34 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C23C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e144so4368021iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtyfhtpoTpWNqrmgO7aoESnnAyoMrxyI5ewD5qgTRnU=;
        b=AxqdZ9j9i/3g55Cds5ktjaX7HGjZVE6M54hzCv5vUJIrhKFyzKojyfYcym+3fWGZzQ
         905PzG+OvLgMhwJnHThfSHeyZvNbhGH7q2hb2yXKaP8yK8dmN1m/ckucz0YEZYHEH8E3
         ZsbMdnkf99O25Q75dA8GBB913PQmEVtpoeegYBGsDs/TaHsZ2TAREZlRtp9okfVNM5wq
         KMerrBAVzNqaP36DC5xhAIMZxddgy5kZRu8/tvvJ6S1UKN5KTBlLzMx8PbZJSiWaQOjr
         p3nTs3O+DOyl/AvYipriRbwyvf3f3ei2FDuUvXIrIrfAO9anrP9rUdKmL32W0CZyk7GD
         WAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtyfhtpoTpWNqrmgO7aoESnnAyoMrxyI5ewD5qgTRnU=;
        b=iWRATs6I78d8UZmPoOrFRdGEMj++3ayxguej4ACDZ9iaYKYxsEoHKAt4gD0Yx22VTl
         R6GYG6KBCU5goJP8324UWRgFlZ9NIbK83UTENf3dL0koOqL9rQTJ6QJS0nxuBQ48s9su
         a8W+UHtjd5RULsj9UGaYGfZmy1MPOU/WstdhYpBO3Giob8S1aJchp9x/0PoRHMN5tHBd
         Yndn85+gWs0X9qtGfMHdDK0YFYWBMtbeZGcToUuYRUuz6n8dzXF01Ol/Oho02H+hvVD4
         0WgPOW746Ckfks61ag5dAAmaSmOhYt7cU4KJTi6XagtuRbRXHS8B3vjz/bjXuqi9V1T4
         biMQ==
X-Gm-Message-State: AOAM532mpGk6LG52mkmDGRF+vlksy1vwVz2cc6AKq5n3aqpYvMe8yywZ
        Q5wLJa2IJ1uq9HA4UL1QrAs=
X-Google-Smtp-Source: ABdhPJyf4EctdWB7PuY3nL03nh+uFKh6M4AM9bC4oO3ubqCGgVklCuwLybmO/8LTYPdPBT0+3AEaBg==
X-Received: by 2002:a05:6638:14d0:: with SMTP id l16mr1134363jak.142.1632940672623;
        Wed, 29 Sep 2021 11:37:52 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y2sm317041ioj.12.2021.09.29.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:37:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 4/6] dyndbg: use alt-quotes in vpr-infos, not those user might use
Date:   Wed, 29 Sep 2021 12:37:33 -0600
Message-Id: <20210929183735.6630-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929183735.6630-1-jim.cromie@gmail.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`echo format $str +p > control` can be finicky with respect to quoting
of input terms, so lets not complicate things by wrapping that input
with either quoting char, using <%s> instead.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 47286a73fff4..d762bf4172f4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -132,7 +132,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 			fmtlen--;
 	}
 
-	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
+	v3pr_info("%s: func=<%s> file=<%s> module=<%s> format=<%.*s> lineno=%u-%u\n",
 		 msg,
 		 query->function ?: "",
 		 query->filename ?: "",
@@ -279,7 +279,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		int i;
 		pr_info("split into words:");
 		for (i = 0; i < nwords; i++)
-			pr_cont(" \"%s\"", words[i]);
+			pr_cont(" <%s>", words[i]);
 		pr_cont("\n");
 	}
 
@@ -419,7 +419,7 @@ static int ddebug_parse_query(char *words[], int nwords,
 			if (parse_linerange(query, arg))
 				return -EINVAL;
 		} else {
-			pr_err("unknown keyword \"%s\"\n", keyword);
+			pr_err("unknown keyword <%s>\n", keyword);
 			return -EINVAL;
 		}
 		if (rc)
@@ -449,7 +449,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
+	v3pr_info("op=<%c>\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -531,7 +531,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		v2pr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		v2pr_info("query %d: <%s> mod:<%s>\n", i, query, modname ?: "*");
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
@@ -1000,7 +1000,7 @@ static int ddebug_dyndbg_param_cb(char *param, char *val,
 static int ddebug_dyndbg_boot_param_cb(char *param, char *val,
 				const char *unused, void *arg)
 {
-	vpr_info("%s=\"%s\"\n", param, val);
+	vpr_info("%s=<%s>\n", param, val);
 	return ddebug_dyndbg_param_cb(param, val, NULL, 0);
 }
 
@@ -1011,7 +1011,7 @@ static int ddebug_dyndbg_boot_param_cb(char *param, char *val,
  */
 int ddebug_dyndbg_module_param_cb(char *param, char *val, const char *module)
 {
-	vpr_info("module: %s %s=\"%s\"\n", module, param, val);
+	vpr_info("module: %s %s=<%s>\n", module, param, val);
 	return ddebug_dyndbg_param_cb(param, val, module, -ENOENT);
 }
 
@@ -1030,7 +1030,7 @@ int ddebug_remove_module(const char *mod_name)
 	struct ddebug_table *dt, *nextdt;
 	int ret = -ENOENT;
 
-	v2pr_info("removing module \"%s\"\n", mod_name);
+	v2pr_info("removing module <%s>\n", mod_name);
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-- 
2.31.1

