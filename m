Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57C437AED5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhEKSxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhEKSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:53:04 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188DDC06138E
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:55 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z1so10202613ils.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMrLgXjSzOGMax97ZAjPuKjPWtjxj0H1kJUreDJDf+w=;
        b=LEtG3ihOA1BViOl2QB/R2JmFpF3C23P8wC0ZzJFslcqKz2UrjjfCGSMJSZ8d5JuAZB
         fHWgRuGyWHmKSKwlSndj5lmEaIStkgSWtfAb7asoRdchxqocGr876VkqJQiPKbmzc/+E
         cP25XOK8KD/Q70a/FpEJgMhg3/Q9toAFwQOQ71K7rUz3YRbEtO12QnGP/FtY0bEa0nn8
         FtTxbXtkcVE5b+LFB04U1w8c15n5Duy72KlKDW4vpQttr3tkiG4s2FV3Z40bLCb7M/Xj
         VXFoaTIEd2QyQBfBF9ni1MN+rqaZSfaN+gwuaW1TgntbaJnzSvlhflL2mxX/RXUxa5Wz
         RgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMrLgXjSzOGMax97ZAjPuKjPWtjxj0H1kJUreDJDf+w=;
        b=ncVaO/Fmp2cGJ+PWRlkhTmI/bRcf4Irs7DNV/2XSkCZDoGUKqH0EZaV1i0OlBdIYah
         uLjpts+UwhXTQjO6UYDihT+YDdztRotEaEPF1R1UhhUuqvcyI5RRnkFN/xDEP1dddgyq
         Chk6Dz3SYKYQ7uQhE6tNmec83lhlMxeI9MhzVpkwhMeX9kztT6kgap6v8FjjX57jbkNz
         8qwj4e9OOTFhGNbZ1++R4ke2eAH8QvnEl1gA71LQtEPWHtQZGSwKP9lQQpHRkrXfVGM1
         vEp0olyMDYWaLJRbRI/CZDdhhWcFQud6EQ0+Cs+D8s39GKNupATUb8daKW4plZjIDjjG
         wT8g==
X-Gm-Message-State: AOAM530bP9uHchWZlMj0waYV5sQU2eeoGuUhDGMO5FymlXeekKb1/Q5Z
        pqKTokR7N9zInGV3OAPhH3s=
X-Google-Smtp-Source: ABdhPJxiVnpBHXyE95wUwqbPhaWCA00yUSuhwPCB3oYg2FrrasNkc6LPoAY8ZEZxTAHZQ5jrtpxklA==
X-Received: by 2002:a92:d3c1:: with SMTP id c1mr27604342ilh.21.1620759114551;
        Tue, 11 May 2021 11:51:54 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:54 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 26/28] dyndbg: fixup protect header when deleting site
Date:   Tue, 11 May 2021 12:50:55 -0600
Message-Id: <20210511185057.3815777-27-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a null-ptr-deref when .site info is deleted.

 #> echo +D > /proc/dynamic_debug/control

This protects the header.site pointer from zeroing; we need it for all
the SITE_CHK sanity checking.  Probably should protect against
toggling the static_key too (in the same function), but this smaller
change fixes the crash.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b61e4a211819..aa4a476d70ad 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -247,7 +247,7 @@ static void ddebug_alter_site(struct _ddebug *dp,
 #ifdef SITE_CHK
 	/* delete site info for this callsite */
 	if (modifiers->flags & _DPRINTK_FLAGS_DELETE_SITE) {
-		if (dp->site) {
+		if (dp->site && !is_dyndbg_header_pair(dp, dp->site)) {
 			vpr_info("dropping site info %s.%s.%d\n", dp->site->filename,
 				dp->site->function, dp->lineno);
 			dp->site = NULL;
-- 
2.31.1

