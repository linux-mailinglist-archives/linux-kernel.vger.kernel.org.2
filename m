Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1933CCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhCPFJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbhCPFI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:27 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90CBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id m7so16801207iow.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbEO5J6TrCUtPHJZSZY2F/E+EXeJvx/lKUsjdm8XGmk=;
        b=aiIfFGrOdQyu8krbUFtMs5VnkLjjS55RMZarcfoe6WK3STcortl/FLogr2k+Bu0Wgn
         rQLOughpvx1eAcQjXvGkGzuOBqJBcTgFvWZ6LySvRSvftqyqWHzwwktuVk969wDrf7He
         9QnDp/RvczH0Xgt0GCWDe0R5txNq4RKyJYz1tsXRs6NQfmuMIzcH/nDyMe6x852L1b9O
         c8UBpASnin/53BaO1gvwvvFC/jetQLEl789c640bgNTqcEqsMycJahrNPCUe9W/tNHWT
         ZADXVzQ0mb0dfC2xwLYa9bpUIW9mgHVAU8RlfW5PpomR+JfhpVNmMlSecMtl70QTe/aY
         WPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbEO5J6TrCUtPHJZSZY2F/E+EXeJvx/lKUsjdm8XGmk=;
        b=QbbPmkWy40DFusggk9fq0wQRAkaIkmyAP2KKD8Zg96Nuw09Il+ya5YJrsYJ4wbkKkD
         eyyQJv4z90zwN3AIUfxPYgk/WB/sZNXLusForOQFIjN2aU7fdbEDu4IMfuNjXlB239Ba
         hGLTt24V68RbzL6dZjoKFMLJHPNr+TIaszxEEs1bq+isdHr96PYMUVOf1h6+8li+gnyf
         mmcBHm1JFbvbX3AXXCjcFLjCMyV0AZAD4YB0s2FMvE5wmGirs9WaoE6bL4NsIT+g5rph
         xsfrXaTI459GfZjwaEqyqOVs6laEtofUcSu/pLowzvb6SxFqMpA07KtSZNUJVXUnUspw
         OA4A==
X-Gm-Message-State: AOAM530M2fi0LiIhmofnGeNu4kNP4zuofvDs1IurvrV94BrN0DhO1deY
        ZSvYfU+7rB6/2yusF1U6VzY=
X-Google-Smtp-Source: ABdhPJxVxzYKn3Emfzf5vqsxaEuMWgpJh4zNfjx7UquLi52VQOVs5V8JeLwdad7b4wUR2xpIGI5bMg==
X-Received: by 2002:a5e:8416:: with SMTP id h22mr2081612ioj.119.1615871306341;
        Mon, 15 Mar 2021 22:08:26 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 07/18] dyndbg: accept null site in dynamic_emit_prefix
Date:   Mon, 15 Mar 2021 23:07:50 -0600
Message-Id: <20210316050801.2446401-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 prints use site->member, protect them with if site.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 151e55ab6bb5..0c535f3c2ba9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -631,15 +631,19 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
-		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->modname);
-	if (dp->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
-		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->function);
+
+	if (desc) {
+		if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+			pos += snprintf(buf + pos, remaining(pos), "%s:",
+					desc->modname);
+		if (dp->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+			pos += snprintf(buf + pos, remaining(pos), "%s:",
+					desc->function);
+	}
 	if (dp->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				dp->lineno);
+
 	if (pos - pos_after_tid)
 		pos += snprintf(buf + pos, remaining(pos), " ");
 	if (pos >= PREFIX_SIZE)
-- 
2.29.2

