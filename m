Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA537AEC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhEKSxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhEKSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:40 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4139FC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:30 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e2so18082217ilr.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhCiWTrLaek2l7vUen81GgzaKiSCRGwtP17K82jei8A=;
        b=Yhx1L10EEQDF9KD2LDl5eJfcnHTASJESzEYK0s/A3gNp+lePUTEQT1LFN8Mj73dwiK
         g49vxxv+ybCQQALpP5kuMlnYjVnD7TW6QZks5w8gLmJTuGl5BpbZGoCSVFtXOpvbSbKM
         qYHm7CLaJq021V4cJglqkml/tZkmzs/BpnIA0UdUGvXEgOO8ucgA1jGxUKtqrkZxVSCD
         KojoHWyyUEWVAiBVrZ0iD0Qr/PbA/dPs0Runf+Tgvd1/oRfe2q0YYN6wGLWnHALm5et/
         qJhA87XYL42lICWQS2g89yG0x+jgaXx/Oqw5fUpliLuPglH52kA3fxwcRyB9hCg396hO
         LIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhCiWTrLaek2l7vUen81GgzaKiSCRGwtP17K82jei8A=;
        b=rPVhm3dCW2CZjMhKfvtAltSwGxair+BfmTkk+YCfh4FeHnnKAOSDBN+LjFDIMegDzY
         Fam5g2Ca4vVDnsjQieW/1Mai7fTeQNMlxQQU6o9dsWzliQ2D0j1earYgJ4105y0FsBkR
         jSMbdIZvij6lb3lrgeeRnYIseD1UxgCm/n3oY80KiUPfXGH9PWDLpY5oOCMWJ7pNA5qv
         b3jYBql5eRDO8TqHkoVSPwiUsMRdlsMzb8Uq68UoIy1KDkm93AVvfj+eHJRcgDWs63NY
         hPTvwUXJXVjaDrvWdpJgV8ozi6LzglOcM0wTBFRp3lqmTzuhQ4/MnlAS6XCxvnoEeD7K
         LxNg==
X-Gm-Message-State: AOAM530VBwVHXhxwyOLZo6SS+Iqwjyv8aq9P34y2oi5zA1jcGzJzka5v
        c/VsolG/dE2EBKXHsBLQa6A=
X-Google-Smtp-Source: ABdhPJw0bBk5w3RUzzAen2n0A4ZC46f1p52jWlNLNunZfi+6JyH1Sp29JsV5c3WV+JHeDh4c01tL1w==
X-Received: by 2002:a05:6e02:80b:: with SMTP id u11mr28566931ilm.153.1620759090309;
        Tue, 11 May 2021 11:51:30 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 11/28] dyndbg: refactor ddebug_alter_site out of ddebug_change
Date:   Tue, 11 May 2021 12:50:40 -0600
Message-Id: <20210511185057.3815777-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the JUMP_LABEL/static-key code to a separate function.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5faf49054b1d..a4ddafdbd9a1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -191,6 +191,18 @@ static int ddebug_match_site(const struct ddebug_query *query,
 	return true;
 }
 
+static void ddebug_alter_site(struct _ddebug *dp,
+			      struct flag_settings *modifiers)
+{
+#ifdef CONFIG_JUMP_LABEL
+	if (dp->flags & _DPRINTK_FLAGS_PRINT) {
+		if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
+			static_branch_disable(&dp->key.dd_key_true);
+	} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
+		static_branch_enable(&dp->key.dd_key_true);
+#endif
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -227,13 +239,9 @@ static int ddebug_change(const struct ddebug_query *query,
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
 				continue;
-#ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
-					static_branch_disable(&dp->key.dd_key_true);
-			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
-				static_branch_enable(&dp->key.dd_key_true);
-#endif
+
+			ddebug_alter_site(dp, modifiers);
+
 			dp->flags = newflags;
 
 			if (dc)
-- 
2.31.1

