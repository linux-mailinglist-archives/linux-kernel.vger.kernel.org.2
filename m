Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5A942AC40
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhJLSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbhJLSoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:44:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A782C061749
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:42:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h125so369347pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wN8CEqu9IDhN0o8bgtb7CzSHPiAoXV5xxvj/l+eqo8c=;
        b=YO5QWcxWa939WoPA4A04cnQQOESQqDbcYZ0LefOb+NhyG0OV3S+ksmjmE9biKAwBXE
         dSrCBz3Hs2Hf7vjjlnq0MWXQnqEu1IJiK/+qAtvZKza3i83ZPIejzVzouNAtDspVHd3B
         Uu2EBXG842Y2sISfzLUdzk7w2s6XI69NX5Fudvixn79eRoxlSMlyJlVs+bfSF35VPjqm
         DLu99R/A7Adft3pLfThhfzDI8PGh5E7tEDAKA/wzfL3BgfBwc75qil6KWLyNMUVI1pmD
         gx8WxLuqbaWLAk783vyPo6lvT7lPvGiiaMU6LbRxN0eB/H4OPfRBf+5T6kND/yYNpAzS
         FA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wN8CEqu9IDhN0o8bgtb7CzSHPiAoXV5xxvj/l+eqo8c=;
        b=XMJzD1BqFnYFjJ5vNeuLMhl0DL+Hzvtsfmxg1ANnULN0i4NsCNbd+7Lfh36ZdRTgF9
         HigLZclC3SiuP73cEAlQUykkhSoHrFGbHisgmRkqQ5gAv0u/BoWRRwHwPJiEDP6Du9zF
         ChcBZMqmA1GeCmH72JM+1arlh/XbsZv3DbylkG5QMSeUuvctz7ODeZmKFTrLN0VI98Jr
         6ir5a7IKE2Ee3VHqrgmysP2I/D43eLQi9KkgX3WfYkAfLjJS4T2fUG3Ek/rDFeWuJI4h
         tkIOdgtpmlC5Ksc+Y1b7BMhIkcTzWDgB/B8UAYfMbbQgO5ul9XpfQSv3ZY6ET1vg4DEu
         L8xA==
X-Gm-Message-State: AOAM530I+IONH+zoRO1JITMQS5mnpEK49brVeGB7lCJoJHDlcLo8bomc
        CsIblkXOMcjfH+NbE6IrO/vYVvdR1ys=
X-Google-Smtp-Source: ABdhPJxduJAk6Xr98sXwk0uPwXHBuMn4GKm7PUtk0Vv2ad+dZdtFlIr+N2W/NtXxsMMhowCWGsWFeA==
X-Received: by 2002:a05:6e02:14d3:: with SMTP id o19mr26151385ilk.156.1634063609658;
        Tue, 12 Oct 2021 11:33:29 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x5sm2257999ioh.23.2021.10.12.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:33:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/5] dyndbg: use alt-quotes in vpr-infos, not those user might use
Date:   Tue, 12 Oct 2021 12:33:08 -0600
Message-Id: <20211012183310.1016678-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012183310.1016678-1-jim.cromie@gmail.com>
References: <20211012183310.1016678-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   echo format $str +p > control

can be finicky from within a script, `awith respect to quoting
of input terms, so lets not complicate things by wrapping that input
with either quoting char, using <%s> instead.

This draws a checkpatch warning on pr_cont() altered quoting.
no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e645807cb20a..75e702223730 100644
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

