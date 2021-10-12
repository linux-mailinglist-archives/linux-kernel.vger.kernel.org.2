Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D042AC3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhJLSlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhJLSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:41:24 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC35C061753
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:38:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id f15so67460ilu.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EaRHyBRUKNYxyFuXsjUd0687S4CA91t+I1Ml3q5IbFY=;
        b=nwdBk8fbWe7Nb+c5ZLhvyEKpPYIi9in5GuaKZnldyXg65IlVUcp7fYOp/1W5b0TbJt
         sgGBCZEUQqVIzJKGQL42Dlsc4eqc96Foi+AE/gMcZTbtTedyngmbtnKre11VysqsFQhT
         3ER42lOG4fFYDS+wSQjA4R3645zRNbAV8YYCt86TRxjsVRbFK0uMIZxB9jydXwEQrw/a
         US3aQQERw8JH9lUPeqbmSSPxYxa7UgQbSv7agyVHSK4oiP9MNd8zdSn7oLRb01FoCZQb
         38pBcBWQ1PQUfhhuLT5ov0p+yenfCPOhT4qrymAu7n76kZ7zOT8SGDBebEzqnln247GP
         hvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EaRHyBRUKNYxyFuXsjUd0687S4CA91t+I1Ml3q5IbFY=;
        b=D+SYgKu5+1fQYjQI/US67FS6bVBd1JGtxMunKret0kUFcAWvI5PdeM2sge8CHOfBvw
         Fjxa+u3k7JKk0ipq2ZNYXzFmDs9liHzOlYWeR9yaOimoXYcCjUrMng0CXaHZQSymFyFO
         gqoIjnOhbzBnRAh2hoCa201reSNmq5jyNfF3asG+c/IFI9dnkCVm0NhqrPFyaV86r29p
         vLxqyv32aUqRedp4uDnUF6yK3YVbx1CLpwjyQKWuffn0biGSZ4BytLHldscptbFSJFm2
         t2p97fRtPylv/JSFncg3uR+H0lsYjf4hfFwfPQos4HjAxeIArRXJSjAgDcGSfzF4CpKN
         WB7g==
X-Gm-Message-State: AOAM531Eub24ww0f+v0XPjN+srUCtbjyPFF0QK2TXdA3pv1/Mjk+ZXuI
        PsuSRR6WBxQBqzsAJlW/Idc=
X-Google-Smtp-Source: ABdhPJxieHQ1LZl+Dc8QV/rS9Q/8Ct9WzMsSS6hykjtxDs/CqQLst/UCpr2qdk1lNvta8w12OMR3Jw==
X-Received: by 2002:a05:6e02:bf4:: with SMTP id d20mr25998460ilu.146.1634063611779;
        Tue, 12 Oct 2021 11:33:31 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x5sm2257999ioh.23.2021.10.12.11.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:33:31 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 5/5] dyndbg: no vpr-info on empty queries
Date:   Tue, 12 Oct 2021 12:33:10 -0600
Message-Id: <20211012183310.1016678-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012183310.1016678-1-jim.cromie@gmail.com>
References: <20211012183310.1016678-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when `echo $cmd > control` contains multiple queries, extra query
separators (;\n) can parse as empty statements.  This is normal, and a
vpr-info on an empty command is just noise.  Also change varname.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18235de37f25..eef9ca92b05c 100644
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

