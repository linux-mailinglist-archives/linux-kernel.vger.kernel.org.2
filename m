Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B170341CBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbhI2Sjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346311AbhI2Sjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:39:37 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D7EC061769
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:55 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a11so3915455ilk.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtPmqQ91Iiv2A/tiZ8ipW2z/8PGMUj2G/iFIYHWOhTc=;
        b=iNML7LvsUNIYPGQOVk6Wsd6+/82MxO+h8D5/isVUWuaJFeCrUHmJZhr+DEo7krvWEP
         /MzP+JbUeobmLe90rpCs/9TuAaMapouqtQtuhMHZtbdGYBBlB+Is3qTvy02XzvuQtMsv
         H+44madI9ryjS4hOl9B7z5wOdf67K3Le0zcF7vuVTceeM3H6n8j0GljEPJ6KwnfTR7N/
         19QoD4V/sx6qJlf38YtpLoYFsGftPLvJyPAdjUQUg320rC/14uJfLZi2IslWaVdTvl8y
         nxo8fO/eOT7pPMc/q15pxsLesQMlRsOp1XxHaBfP7q9jMrbVRuaeZmLi/N/DahCRhBIm
         Yalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtPmqQ91Iiv2A/tiZ8ipW2z/8PGMUj2G/iFIYHWOhTc=;
        b=BDg9geO8xWgkDYm32QeqfoXg3Ed7i9jMK1WsX6tOGUlHzPtVUXHZDSSqVCx/qEji+O
         xIVLTmAiSKAWhrZmQLFv+VKS8rOYYznIKfpjH8/pt3uzuDTL3wTYAKnEFE/flm4UySdm
         rbuwzk1s7y9vxZr63cQaQqMJL1FlNDHmvYBmn76F0O4I26nGUUsWHFNN216SfI8XD3dt
         rX5tlkmllCQos4XgOFTVCj9dJIdD6O4lX/oMvzA9ESkNAHvSJCik1sUIbw5lUBXu8EFM
         bGRN9sXiyhhkJNfOgoVJuifOSUUN5eCaeIn9FrUgKe4dWNGcv05vjtArRJAkNcAwTJdF
         jQpQ==
X-Gm-Message-State: AOAM530we4+TY/ZwFSy96gACq5KCl2HF7ub66rbLeDDmnKDijNzXAGoW
        Abbvb5YNd+Yu1cfag0xMsMA=
X-Google-Smtp-Source: ABdhPJxxJ48IlQiRpGYgYF2E3RgyT8z5VSoyHZJZpQf6Sha4yzvUFR/U/M1Jwf+e/fgwkQIGPJrqjQ==
X-Received: by 2002:a05:6e02:893:: with SMTP id z19mr898146ils.224.1632940674444;
        Wed, 29 Sep 2021 11:37:54 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y2sm317041ioj.12.2021.09.29.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:37:54 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 6/6] dyndbg: no vpr-info on empty queries
Date:   Wed, 29 Sep 2021 12:37:35 -0600
Message-Id: <20210929183735.6630-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929183735.6630-1-jim.cromie@gmail.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when `echo $cmd > control` contains multiple queries, extra query
separators (;\n) can parse as empty statements.  This is normal, and
pr-info on empty command is just noise.  Also change varname.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8230fdc66d9d..1b83f8f897c3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -520,9 +520,9 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 static int ddebug_exec_queries(char *query, const char *modname)
 {
 	char *split;
-	int i, errs = 0, exitcode = 0, rc, nfound = 0;
+	int qct, errs = 0, exitcode = 0, rc, nfound = 0;
 
-	for (i = 0; query; query = split) {
+	for (qct = 0; query; query = split) {
 		split = strpbrk(query, ";\n");
 		if (split)
 			*split++ = '\0';
@@ -531,7 +531,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		v2pr_info("query %d: <%s> mod:<%s>\n", i, query, modname ?: "*");
+		v2pr_info("query %d: <%s> mod:<%s>\n", qct, query, modname ?: "*");
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
@@ -540,10 +540,11 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		} else {
 			nfound += rc;
 		}
-		i++;
+		qct++;
 	}
-	v2pr_info("processed %d queries, with %d matches, %d errs\n",
-		 i, nfound, errs);
+	if (qct)
+		v2pr_info("processed %d queries, with %d matches, %d errs\n",
+			  qct, nfound, errs);
 
 	if (exitcode)
 		return exitcode;
-- 
2.31.1

