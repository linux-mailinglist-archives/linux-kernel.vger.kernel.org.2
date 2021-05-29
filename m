Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A8C394E13
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhE2UFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhE2UEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:16 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D5C061342
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:38 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so7033315oto.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LABlo1p+aBjx0H3cS7b5JckXpiQnVJ+VgTZfeBuRQk=;
        b=smNaf37/0hJ7HrIvkbCuSg5mFEhLLgoBSt/DPMOmlUHk49v361t8YsqKUtMcuE26oF
         KPaNIy0H7ddAWQMgMzyOkHrb+WG+2xsc9VEa0tSUSEyxhpOUC+4rMxPFqV/c2urh/W9G
         W+NsoyY+650u7FZegkOS57qM7rIt4tgRZ9bGfRjwqNeykFdBRjqVGmgLKB4H5g3R8QYw
         bh7kzhSFIS/q/WNhiGdeijTFTnC+c7GZ9BFnYxK0iE350CLTPZmeNdomdis4vzSQ+EA7
         +DHmr1PaI80I0XFJRivtkBoKrUhdsCypG+Jk9v36v1ginPAYEMBElE8KxjBkjyZshMxP
         uKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LABlo1p+aBjx0H3cS7b5JckXpiQnVJ+VgTZfeBuRQk=;
        b=oGLvP01gSVr+Ef/XIWPTOxZ6EqEc1PPEUEfOJzMAZMenVhh+KrNR3LhQNdwh4D7WC8
         RsDyZmpQfI5z6lLUhppj95WftBTB16YpRF3vTH7jjjll5IwAsnTUmQCc2qlM6U+7KBIw
         qQfdZud4smZTFASdT4ytgqOTpgCLl/wNI32+YZtnY2MnBK0wEcF/uspN3zAN2hEd2SJu
         n+UM2+GSUdTjvI56XpFm0lbNo+SmcWTvYH/re1tY/tHtZ3AWdOy3dZLbVvlSEjcxpgD2
         SkzIH4TuNIZtAzP2IQGmygxBuUwgTLit2gZiuWHHM+guVMuP2I4RkRf754915KE2KC+h
         dFpg==
X-Gm-Message-State: AOAM5301WoN7iDArsC8zYYWy1wlBzptUVRPOteUj8cxtX0LNWzhXq6k6
        7YXZLoqPM3nbtus0xI8QIQk=
X-Google-Smtp-Source: ABdhPJyMVZovIQVlkM4/i++M/UDjIbIM8AJJvpPKahLeSPzARlXrAOTqhDqDgqds/IG/KCCvPOFgwg==
X-Received: by 2002:a9d:7286:: with SMTP id t6mr1826395otj.6.1622318557408;
        Sat, 29 May 2021 13:02:37 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 23/34] dyndbg: fix NULL deref after deleting sites
Date:   Sat, 29 May 2021 14:00:18 -0600
Message-Id: <20210529200029.205306-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
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
index 014e3a79d8e9..a7840584b402 100644
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

