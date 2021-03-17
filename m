Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2633EA48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhCQGz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhCQGyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:37 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55382C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:26 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id t6so508405ilp.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7gJDm//nE7YrQlUfHhXLgYQ+mx5uNNItz6wizp7fm0=;
        b=N55gUv76O5RQxEozVTxyq5hEc/HRFAsGgSGVHzSLTb2LujMhSM9iUlK1lox9HmJ0o/
         7xN3palcU7WVPS+RraXO8Mu+C74PxnG487KJUdiONq4BmAomDEIrpUdCARLNYIOHDdmT
         yhYPFbHCqkful6TEPhmr6+pNeQCRB/VGYaZXqkF3tM0agexPJwoYIAkdl9Zu/PMaFfan
         cQsP4Ma3uXAKCCw8eTqXAfJkXkfeUOlcu49rxSRsQdMR3JnWCuj8Sp2C9C3NyrIN9LnT
         cIihiuU14TSlOjETlvkVJFXfVkPTqzTk2U3aaYE39D8tjEt2XjnkAMW3vjJEmIfgmM8a
         xc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7gJDm//nE7YrQlUfHhXLgYQ+mx5uNNItz6wizp7fm0=;
        b=rkxNoVhKTSeR8v2OOvNPyhKn5NwcvR/QKuNoG4mlhbeHh5CxNeUh/dq8Vxx2CyneMX
         ZgwuJhE3hGgUspVsWinsEcu5jnN+oSFoyUEpzmuT4/W4z+zHa03OsaiKNKvmnNxGYZzn
         OsbJE9eheNkm4DUVCwvxy9Riqy1dO2eumMOp2qc7KGwSUpvuL+ladJwRqPlaBlyQLigX
         8nkxrfn6NWaXWB9Mo+M47E5BNukvLfjMF+3zsKU0+TJuX1cihAML59+ybHZuVkuWvFza
         bjsUev3dPcE7iEaxjC1n3/5Jhr6khm9tDgN3v9IQQ4zpvoFlyVgb1W7kLFjBwD12mdnB
         Zmpg==
X-Gm-Message-State: AOAM533GU2vOT/FZiJ5pmBmZIZwo85+bS9vbetzqca76REMdxnF1Z718
        xEM4qGUvxBdEmy4Yp0JoifA=
X-Google-Smtp-Source: ABdhPJwF43ZuZyFtBgz3Co3S2u+Zh+LW20ybLXT4H3OgFs8IbYARZMT8rWLfS+A2BOJ4t5bEUGqHyg==
X-Received: by 2002:a92:d4c9:: with SMTP id o9mr6536456ilm.165.1615964065840;
        Tue, 16 Mar 2021 23:54:25 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 05/19] dyndbg: hoist ->site out of ddebug_match_site
Date:   Wed, 17 Mar 2021 00:53:58 -0600
Message-Id: <20210317065412.2890414-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
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

