Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6337AEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhEKSwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhEKSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:34 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356E6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:27 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k16so5078875ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XoeV1CIyKryeNzxxt5mlrf/4FcTSldzarEqWBQPGNdM=;
        b=jiMcXG4zKPDWdEDeFEfp7Wxzaoya/ZEkEcM9vBOGps7AKUfCKS4UV/tMiAOvCtVG1F
         69GNW/TyDoFvqKkgS59LI/zcZPmd18pJdgxuY6XrlzkHnqgPB9O1K/yyllhsYbT55GbC
         Ljzz31TRhCibHIaj8XP/VYqif/02Iwe3XElm157hVmjNQM4Tc0JrvjtT/xo5VYf35F+l
         sqnoHQEPplWTAO7j/goCj9FIE0q3xFMy0YSilDHdDNQ+ViWqmHaIp4n90iJMGvMkD3Xr
         rJG+Nyk9xXyARYU1wDoHVdMQHL6vypuMVt9pC3S1TeRcBKeujcP3ISpy9lGYcdK4Fi2n
         pW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XoeV1CIyKryeNzxxt5mlrf/4FcTSldzarEqWBQPGNdM=;
        b=gfIy9K7bvT52QTGJYw/gDyHGhtj+iTQu7SWWrfNX3wZC2EuHj1LYi9AIApzgVxCIYL
         cGDyl1PN6Q8pFoyMLKu37eBJrsvvFaUKHBxKMObEZJDSFhq33wVGfvo4ff87pRPUDD4O
         EBGSuMowAkE33EoLPF2uHQDC+Zz0iSFrTYgLehD/GVwbuqMiBpl0YRLPwiswNwzqVZX9
         tQiMofRMDM+/rzfZWfDpT8oDLb5NM6CRH8zX2JG8RgeG+Y0xl7Uu6L/ss+ScjFVVBkEj
         H6pcN1+6umVgNm7cdVlcfLyoMa8RIUaHncM99ZygUPrQUAznpN94tdBi6rb0RzRjWngJ
         r+mA==
X-Gm-Message-State: AOAM531VUx7sPPm7OoSW5ELZDFjINazL06ZGK3/XsutnREfqlWh5cN6o
        aYMW5iag4y7xCssw4szmTzE=
X-Google-Smtp-Source: ABdhPJzT38saFp5RPxsUsgX8AOZfspvCsMbU8J/sSMPLhxAy9yKP0XWHcUJeYPZURWh98vWkeTvIFg==
X-Received: by 2002:a6b:6c18:: with SMTP id a24mr23927594ioh.21.1620759086691;
        Tue, 11 May 2021 11:51:26 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:26 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 07/28] dyndbg: hoist ->site out of ddebug_match_site
Date:   Tue, 11 May 2021 12:50:36 -0600
Message-Id: <20210511185057.3815777-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
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
index 47d427b82ae1..0896c681db40 100644
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
2.31.1

