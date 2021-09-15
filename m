Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773A140CAA9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhIOQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhIOQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:41:55 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB45C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:36 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id j18so4219598ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/16IPATfLgdmiX/J8L+UemcIsELjpW//BCTY5UOTDZc=;
        b=F4lYbdy1XsW0VGz/Rzh+Aj72ATUvnLbalD6Ptxz76xKFknccKr4/wNjNNRxA3f+rOO
         cAhMSwo4XDdnHamdzMuLRquJ1avmiwtnTl55cs8KGZY/swZQDWzGHa6rRlvBdAcpjlXf
         XCTpPYWxBvGK0pq9hFa6/TFkehZJ2DMble4ADj5SNb9YE4pVsN9XG3KDDlmp1wSlZM/j
         VZ6qfhPUzGjNacIUClrpXGhFIfwsDaWu9KcP+CoxSEH+bXnFwf3YrbETpDHh0fmpCNQR
         1guofFqzln+fFtLDfrs/2gq9fwfOlsst+Ka0U+X5CcDx82LeMKryhPO7j3x8Kc+p9VB1
         20ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/16IPATfLgdmiX/J8L+UemcIsELjpW//BCTY5UOTDZc=;
        b=nWLesb/SRXsRI9hLCnazYzqSi8489zvcU3A4rS8r8rBzwYEvsSwxMTrSqsoRFiFIKJ
         2ziKwNRk7fATc1aVm70oLq/UAM7eJ/I46fJM4ulMmIx6naBV3HEjpiOuL7qIqUDSYKi3
         O/g1WTzOnIatJvVrmuB+/oAVhSk05XIH4T/XwR++FH10anShYZg9EtBHGr9Gmre38yff
         r+m55ql3M/5WWhmJmJC9xmBTq3KFMTPcp9tViza9AbuYtb0W8KyALSZ5K2SvblitfUb/
         wfrK7RdY+7sdwZhKZD68nacX0qXnphP9cF4ENci+ryjUfiIEj7UnlfzK+/7w2IjZ0N+R
         FUmw==
X-Gm-Message-State: AOAM530T2butiZ1d3lrODIRjekucXwl+3Y6vyMxR+f0+dOZfJHPXqH2T
        pD3AzXeYYYb0/AVDXTgzWlA=
X-Google-Smtp-Source: ABdhPJzarxX1asWC2Hsxhbo5NFnL6GctWrBgWA+45Dvv3G1LUT0QkB+r4NenYOzwUgzCOEmqwSXLsg==
X-Received: by 2002:a5d:935a:: with SMTP id i26mr767362ioo.79.1631724035933;
        Wed, 15 Sep 2021 09:40:35 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 06/16] dyndbg: no vpr-info on empty queries
Date:   Wed, 15 Sep 2021 10:39:47 -0600
Message-Id: <20210915163957.2949166-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
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
index abc04bf4f765..356c8231175f 100644
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

