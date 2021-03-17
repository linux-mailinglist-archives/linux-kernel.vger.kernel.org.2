Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C000033EA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhCQGzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhCQGy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:28 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0504DC061760
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id m6so506491ilh.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbEO5J6TrCUtPHJZSZY2F/E+EXeJvx/lKUsjdm8XGmk=;
        b=TPAwgTCgMMwLMUEXeE5h9XFisbZbbme5nv8AMTdPR2mI9cdlT3bXEH2Ygip//DyaRp
         aMuQWUF2jLtkUfcNRoWNk3cTq7HR4HRHB57bXMc7biRWg5aNLbLTfD/nThrE2L0OLk+a
         e9Q/l+pvAJKjkh1k/I/gxiy4b4bDay7n5t0pgm2zh/8P9zZb1JVESPcgniGZrRu4YgwB
         8T9mBwaxbom5gKY3gI+nx/K01mrl3QuGKbteDx6dnt32Xt+qG/RdI5zwQ4ai3dWeKT3+
         GIT6uJqCXc4N5MizjnIHqAKUO8U3BKwLSpVFx54tgxswizF37TTPYZJ7qAhF45zcfU5G
         fgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbEO5J6TrCUtPHJZSZY2F/E+EXeJvx/lKUsjdm8XGmk=;
        b=OCkuPuxVcQQDgqC+pHGj3cfnwneHjsAXF+BjIVTVjuqAxzEKX5Ftr8b6k0OQagC7VI
         avtwCq/maozI5qODmmx2sH6RqCPoH1nZ6pJWI5v3YTpf7yAsxzpataoPk2Y+mOC/1UOL
         hEDZM4asrevD9amxjRiamL9IdqaULKjoLLsnm4HBWAD07fqzpTGu2Ngh+0fOKfaX/5yf
         vdc7gI/VHPOgnd1vHPRvBY0Xs+xNr5cH4mDT9DVSXlfiR1R0se7EPGx+2+Rvtqg/+Gsb
         iWmEvNVqfbocS9sk68gz2tBpuVON9WP5TNxMEi3SrIMWYN5g4MpLMC2wG42A1cihSfsX
         pfNQ==
X-Gm-Message-State: AOAM531FPJMnCjBHDTDj/0AFBU7UO1JmgwHZ5G5frrDML3kxpYQfCs62
        kGW6Ict1ggEOv9nrHfIqfn4=
X-Google-Smtp-Source: ABdhPJweYekt9Xf17Kxs+FM4qODI+eqASB2Hccn0Pemvzpl50FMHmtdpVtU/QAHDca/bl7cv5FbeoA==
X-Received: by 2002:a92:740c:: with SMTP id p12mr6751232ilc.9.1615964067467;
        Tue, 16 Mar 2021 23:54:27 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 07/19] dyndbg: accept null site in dynamic_emit_prefix
Date:   Wed, 17 Mar 2021 00:54:00 -0600
Message-Id: <20210317065412.2890414-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
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

