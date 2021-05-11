Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAED37AED1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhEKSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhEKSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:53:02 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671CBC06134C
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:51 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o21so18778500iow.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/Ph7k82kiUENJBSQiDSR8itgIh5RXyi6b0YkXaL6Qw=;
        b=BdHqxobx3i0b8GFby3ylXvLvy5TPzMJHaZElk+Rric9BlIXo/eZoPETSI69DwIDOyb
         qMzvAlAQ8IQa75MMu3o6phnrh7J2iWj41hr2aTQfhoINsY8bDgSE67fn1w6eLeDz9rPV
         r4MihMi0N1wvc3cA3R9iAhw/YoTaDHZvzPJ+qtskdkSjfmwligZc/T3ybGAh8DXo50eE
         IcbrW1wVbCkW/w+kwGKPxbT5ZTSj5fWm+ZkdPAz0coqBZ5KjCIOogdrIzucq+KytsPDB
         QftccG/y/a3Fkw68Yg+8cIPxLCRpXVBoGtypkty4GZIe4A2zbB2BXt3UtVJn8pwM5EKK
         fAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/Ph7k82kiUENJBSQiDSR8itgIh5RXyi6b0YkXaL6Qw=;
        b=ZGTENLkUb0s9oV8STzolZcb11+d0i9WPr2zRE7Av5dGKZysm/rYD6nPC00UIqFzANC
         zrffyomr0OAMmXzyZ3pC4NwxEopYGzGYZyOMCWeEx3EWlYNy+JpIzyAEdFbdE2ZVdNYp
         AInnF4m4lWDdrAhEkRhyw97pg/nXk4QB96DI+KW8ftZsea1qsTyya1GBf2HXj/FFDE0c
         YAghpYjQole2n5wNLRGtZ1q9eYhbTNiy++aB+xDmyafJe+61eEo2baLVz98kWThP9AqP
         G6rOO3yx9W3BIm+T6FaqPRhK7WYHeGz3X7pxui1vzmLG3wMPVXA0xqyC0bhn2L3IM0Bn
         QgWQ==
X-Gm-Message-State: AOAM533AGZulLWRIvumt6qRtnVGVGyxGksz7xFCDz+Qxe5MxNC+Re40j
        5n/K9dvAWoQ42dt/0207LEg=
X-Google-Smtp-Source: ABdhPJw9zXD4acEMCHtf8ziT4UiNL1akEatl5yiLTN/4mh7ecijp7Sy9AyKLLwHBM60t5xCoa+5XEA==
X-Received: by 2002:a6b:d10c:: with SMTP id l12mr23361714iob.179.1620759110663;
        Tue, 11 May 2021 11:51:50 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:50 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 22/28] dyndbg: fix NULL deref after deleting sites
Date:   Tue, 11 May 2021 12:50:51 -0600
Message-Id: <20210511185057.3815777-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After `echo module main +D > control` zeros the site pointer for
main's callsites, `cat control` causes a NULL deref in
ddebug_site_get().  Fix this with:

- in vpr_infos, avoid dp->site->module, use dh->sites[dp->_index]
- qualify WARN_ONs that test against dp->site.

Also return dp->site, which may be null.  This restores the
abbreviated control output of deleted sites, rather than pretending it
wasnt deleted.

Deleting sites isn't an important feature, and its current form will
be obsolete when the site pointer gets dropped.  Its also pointless if
the site data is in compressed blocks.  But its still worthwhile to
maintain !site robustness for a bit.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index af9791258f8f..d0477450ec0c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -154,8 +154,8 @@ static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 
 	if (dp >= __start___dyndbg && dp < __stop___dyndbg) {
 
-		v5pr_info("get: %s is builtin: %d %d %s:%s:%d\n",
-			  dp->site->modname, dp->_index, (int)(dp - dh),
+		v5pr_info("get: %s is builtin: %d %s:%s:%d\n",
+			  dh->site[dp->_index].modname, dp->_index,
 			  dh->site[dp->_index].filename,
 			  dh->site[dp->_index].function, dp->lineno);
 
@@ -165,15 +165,16 @@ static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 			 dp->_index == (dp - __start___dyndbg) &&
 			 dp->_index == (&__start___dyndbg_sites[dp->_index]
 					- &__start___dyndbg_sites[0])));
-
-		WARN_ON(&__start___dyndbg_sites[dp->_index] != dp->site);
+		if (dp->site)
+			WARN_ON(&__start___dyndbg_sites[dp->_index] != dp->site);
 	} else {
 		v4pr_info("get: %s is loaded: %d %s:%s:%d\n",
-			  dp->site->modname, dp->_index,
+			  dh->site[dp->_index].modname, dp->_index,
 			  dh->site[dp->_index].filename,
 			  dh->site[dp->_index].function, dp->lineno);
 	}
-	WARN_ON(&dh->site[dp->_index] != dp->site);
+	if (dp->site)
+		WARN_ON(&dh->site[dp->_index] != dp->site);
 
 	return dp->site;
 }
-- 
2.31.1

