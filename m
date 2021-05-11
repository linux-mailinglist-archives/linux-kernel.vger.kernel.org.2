Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D737AED6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhEKSxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhEKSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:53:04 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B6C061351
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id t3so19128978iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFW2fUV4S5apIt9TXKZGsIObebJdVsdqxjr+w7oZ8PM=;
        b=RfUMTS3QpJFUFcAuMUlC8ssDrXbEgtr6q0lOQAdiw1HvMLTzyWgIZYcuODtR8Fbf78
         m1yaR9wN4oiYEILIACopoVY0/AXoqgMun99SLLAoO3MfAaHp0lXRW6xQk0sBV1boC9Jk
         2c0UBOkZBLulplheqFYC8UzWTuF2Ehp4RcbU3VPno8BO+IIFCGWu2Po1yZDi0VBkW1ZV
         qFw3NDehnyNl65ZfVkM2TBiVxTwZNlbXRX+nN+NbstV4Wwz6+wJrwOQucJv8wqSOSPmQ
         nGbytwYVuH8/T6b0j12kdFqc6bED9EtY6Qed9nkIEik2C45w+dFe6l+IuT+qijsh2cfE
         25/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFW2fUV4S5apIt9TXKZGsIObebJdVsdqxjr+w7oZ8PM=;
        b=TNkv2CCVf0a+rUvw5vXSCfPWQJhNgboqtBLS0WpsJMTy/Vr6FOtqxjO2NtJW4JK4sR
         qDklUqEvPb1sQ+ZZoK8AOetK+TggWSZ8EYimP23Ojnnle4j7lHDKYNJz2vG9pP0DYBb+
         fL3AgNzy+kKHWXmSveoTN6ePvpTcPWnr9B2pZAZMX031w+8eoH71iiBSSUx+41lut1Re
         x0deta7YK2fnMkADzbofYdceLIXJFT+0rzs1bEJPdOYqJL9LS7oR2Gd0+0WwFJ798ZEp
         Gj0JeRmtESFDimq7+rxgeQkRYGEiTFztr121cjEfZXJzymRbARK0DgceHDWUuW2B38iX
         WQTw==
X-Gm-Message-State: AOAM5331Ab5l7FGTldMNVXLg4xY7LKhP6alC46xnPSMLPId9F4zZUFC2
        Q1b/uSxsP4V83d7HJJgxJtE=
X-Google-Smtp-Source: ABdhPJwG3LrJGqKaLiX+OEv4jKy41DuSJAb4+ZcfJENAHIi33C9Iw/TKSXmtOBL0T2srd2dCBmgS9Q==
X-Received: by 2002:a02:b057:: with SMTP id q23mr6582814jah.25.1620759113627;
        Tue, 11 May 2021 11:51:53 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:53 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 25/28] dyndbg: swap WARN_ON for BUG_ON see what 0-day says
Date:   Tue, 11 May 2021 12:50:54 -0600
Message-Id: <20210511185057.3815777-26-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
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
index 9551c0d406b6..b61e4a211819 100644
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

