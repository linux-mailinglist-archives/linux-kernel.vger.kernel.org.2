Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CDF33CCEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhCPFJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbhCPFIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:25 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B220C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:25 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i18so11511786ilq.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7gJDm//nE7YrQlUfHhXLgYQ+mx5uNNItz6wizp7fm0=;
        b=a5c+bu2KPCWEbL2MYD81n1LxQHgcbeKErisI2SsUvlIubg7o1syZyA227+qF99Wd1V
         D/0OLHIHCQQs9b5cSn9BbTMaNjv2lClRhD4fgsfH7hjqEN/6kM6iuo9PVXtKzWW0S0qL
         MdBiy4/dZxJ/jfvfWZPsxR/Bj6nDW0/8LF1YzelZeWX9KLmWNrguHOBp/Fc9kKzf+5Ec
         GUpvZn3xWqda2Bg2wxYyv5DuHj92++OLQgKXDkqOXeA2EJ9otMLKJ6iB6Mn+lGeZQcsl
         L5mqOA0zKU4+HtbLL9sofi0pQolTWaY9icFH3hTre4qSLIIHUHhx258sWuFAaZgAVWqN
         YB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7gJDm//nE7YrQlUfHhXLgYQ+mx5uNNItz6wizp7fm0=;
        b=kv0j64/qT/df8dsPhfMUmPjoXLKSyHs9msh2VRbAAQyAFW+AF0V5FPgbc4zH2M+I4R
         hk2Hm/nAOQuyfN8WmbNhWmSRidwuKPRg5tVTVf9LfQDj37H5rDMAAsw5lqp+t7WOod/b
         TnTq0PwrGPTFoDD/av5GO54PzLbftsUCVZ5YXZk0+w9iYbQZhywTXZhDCrmlPY/g39OA
         3GdrwAE7jYXyLOAAnLD0iU+7+lq0ejNrTBjlTRdNV58FOZIkJ83oiC1/qYb0dASn1JCu
         hGXe0C55FBJncZJV3fWvgodDnxMvXDR4OsgZcXen13zChWZHIl1Oy9pI6OdQFq4NDZsE
         6/Vg==
X-Gm-Message-State: AOAM5328deZdvGYOb0sIsD0Ano8aWqOFjs5zfZFKTRujcU+vGWK3RwiG
        qhgn1kp0ojln5RH3ohK4ils=
X-Google-Smtp-Source: ABdhPJxuok1Yky3X8FpQW6TzFM+IkGe6EJEMY5IBwwTX5brcQ0tQJxhwhkR4onyV2Z3kCur9mRnT6g==
X-Received: by 2002:a05:6e02:12e7:: with SMTP id l7mr2453410iln.32.1615871304552;
        Mon, 15 Mar 2021 22:08:24 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 05/18] dyndbg: hoist ->site out of ddebug_match_site
Date:   Mon, 15 Mar 2021 23:07:48 -0600
Message-Id: <20210316050801.2446401-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A coming change adds _get/_put abstraction on the site pointer, to
allow managing site info more flexibly.  The get/put pattern is best
done at a single lexical scope, where its more obviously correct, so
hoist the ->site ref out of ddebug_match_site, and pass it in instead.

no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index da732e0c56e3..abe3382aabd5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -143,10 +143,9 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static int ddebug_match_site(const struct ddebug_query *query,
-			     const struct _ddebug *dp)
+			     const struct _ddebug *dp,
+			     const struct _ddebug_site *dc)
 {
-	struct _ddebug_site *dc;
-
 	/* match against the format */
 	if (query->format) {
 		if (*query->format == '^') {
@@ -167,7 +166,6 @@ static int ddebug_match_site(const struct ddebug_query *query,
 	    dp->lineno > query->last_lineno)
 		return false;
 
-	dc = dp->site;
 	if (!dc) {
 		/* site info has been dropped, so query cannot test these fields */
 		if (query->filename || query->function)
@@ -219,9 +217,9 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_site *dc;
+			struct _ddebug_site *dc = dp->site;
 
-			if (!ddebug_match_site(query, dp))
+			if (!ddebug_match_site(query, dp, dc))
 				continue;
 
 			nfound++;
-- 
2.29.2

