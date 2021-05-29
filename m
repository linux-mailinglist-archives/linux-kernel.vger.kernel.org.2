Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49469394E15
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhE2UFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhE2UET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:19 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1BCC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z3so7958455oib.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBycWMfVTeN8BYdCyX3hBSKXQskHsz2IVTWruO6BZ7M=;
        b=pVzeZiynze2hxFx9oX69IiUwqV3F4BKhnPH2R22/5C8ET2nCNLChTEVT7h881YmcJB
         WLwvVS1xqxZPNOsPukr5xIk4IBfoAg5D7xOap2ddWLsLAm7uK7ne7wAdwXI9luupr9JZ
         MCbaDqghIIfB+1NypyoJ1J9tHFPtWjToPtLpv/FJCeQYWITYoAEAMKbx/E8vMch/9CZ9
         xXRiJ69+8zYyS3Ck6nMMLqWnmz6M1leMq65WmktclNtEqbmvc65f93A0+sqh4xXUARax
         aOKcebZHMl5v6iYtrzVgoUiIk1CisNRdVsSFmHXk12xycTBZXo9h/FW3XmI7lzJwd2ex
         lGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBycWMfVTeN8BYdCyX3hBSKXQskHsz2IVTWruO6BZ7M=;
        b=az5TlFhdlCHx9eLcxT1KVlGc6FIHmFSAaD3oyQg+iJBY71NabPdP4BOL8opulrMOzO
         HgSsp2sqfLkJK8Pq5kbC+/vagi5atyKYtAxrebPvTESbPVvb0NHyoLFrgcslpYMswkQI
         hTMrml3jjj2Wkr1N+kjblnRUQvPw3AkuhZtW5tAAsLgl2bqysI4c/Fo+adlQpp4uLZ9B
         6F+bma5O/Zyd2q6y5P8JeRMeIkzLgr6K3kDpPFE/B/H2exURYvMTKJECw/jVuWByR6qU
         FUeWvqyNYdj6voV9vrPz1lZDKc4fK4i7bzXgfkT7Q8OJCoQviPWGNzfwH6caO0YzyX2W
         fYWQ==
X-Gm-Message-State: AOAM5324tv0uWWlPkTZo/C4mPvePproZ8G34dIMzwhLzkT3H4v/XP0ln
        kIvoQVSUQcJKpSk9M6AOLtU=
X-Google-Smtp-Source: ABdhPJyq5LJZ6HedPUrDKxpdIvLYEWDy3rM8K2KXfYUZs4CRPB13B3iczcUrlxJGK0ZL7Iv+n6D3SA==
X-Received: by 2002:a05:6808:3a3:: with SMTP id n3mr12729713oie.134.1622318560387;
        Sat, 29 May 2021 13:02:40 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 26/34] dyndbg: swap WARN_ON for BUG_ON see what 0-day says
Date:   Sat, 29 May 2021 14:00:21 -0600
Message-Id: <20210529200029.205306-27-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HEAD~1 passed 0-day, Im not sure what it does with WARNs,
so make everything fatal, see what dies.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f333fcb6cf1f..659e864837ad 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -150,7 +150,7 @@ static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 {
 	struct _ddebug *dh = dp - (dp->_index);
 
-	WARN_ON(!is_dyndbg_header_pair(dh, dh->site));
+	BUG_ON(!is_dyndbg_header_pair(dh, dh->site));
 #ifdef SITE_CHK
 	if (dp >= __start___dyndbg && dp < __stop___dyndbg) {
 
@@ -159,14 +159,14 @@ static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 			  dh->site[dp->_index].filename,
 			  dh->site[dp->_index].function, dp->lineno);
 
-		WARN_ON(dp != &__start___dyndbg[dp->_index]);
+		BUG_ON(dp != &__start___dyndbg[dp->_index]);
 
-		WARN_ON(!(dp->_index == (dp - dh) &&
+		BUG_ON(!(dp->_index == (dp - dh) &&
 			 dp->_index == (dp - __start___dyndbg) &&
 			 dp->_index == (&__start___dyndbg_sites[dp->_index]
 					- &__start___dyndbg_sites[0])));
 		if (dp->site)
-			WARN_ON(&__start___dyndbg_sites[dp->_index] != dp->site);
+			BUG_ON(&__start___dyndbg_sites[dp->_index] != dp->site);
 	} else {
 		v4pr_info("get: %s is loaded: %d %s:%s:%d\n",
 			  dh->site[dp->_index].modname, dp->_index,
@@ -174,7 +174,7 @@ static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 			  dh->site[dp->_index].function, dp->lineno);
 	}
 	if (dp->site)
-		WARN_ON(&dh->site[dp->_index] != dp->site);
+		BUG_ON(&dh->site[dp->_index] != dp->site);
 
 	return dp->site;
 #else
@@ -1258,7 +1258,7 @@ static int __init dynamic_debug_init(void)
 
 	for (i = 0; iter < __stop___dyndbg; iter++, site++, i++) {
 
-		SITE_CHK_(WARN_ON(site != iter->site));
+		SITE_CHK_(BUG_ON(site != iter->site));
 
 		if (strcmp(modname, site->modname)) {
 			modct++;
-- 
2.31.1

