Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74B37AEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhEKSw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhEKSwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:38 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03793C061763
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:29 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id w7so1343477ilg.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKUtj5xFpWrKHzfDwNn5dlfDWlNqWpU9zICKw/jFmZs=;
        b=CVrTPF2f0gSY3Mvjt3pelxNj53ot8zdyqZZbTQfRWrMBJp19Qxqm4SKP88OW7uKbfY
         1HkgbTi2YK8eFOzk+PtWsULQP0gfQpauVrXbOPpyPiKb6GxsS1FF9aF7lDJqE2AeJ9bY
         C0A1Y5nzZehb5W38XwDPVgk1wI3WttvaoNfysLa+5sxU8zMCprgcWHs6OU7wLb92ocmB
         ge01Jgh40m+zG/NecEml74/4mIjVnOH9iMgxSA6fGBxD1/1/RSZCpEijyh8ETtXLpra9
         GX4JGfqmj9ivdd6ys5386kxDpjDATJjv7SS8n/ZttZFRARae/qIv9HPiP0Rg6Fzy/LOX
         TKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKUtj5xFpWrKHzfDwNn5dlfDWlNqWpU9zICKw/jFmZs=;
        b=ebnGixiEIdGg/sOuhq8gT400v9OJmx6Ihw4SG3YwSaCg1huawUuX9x56Ya3LGXFAGY
         o4ndryj82yn4BE2szcyOVUVAG0YlyB16BxoioVMwUWLJDaN3DouSBEYBOldub8TuP/BV
         vowOG0iwC/1d8ZEX7jBz2BxPaqHb+FRuERac/Xrsn5s6VJgL+1vkxmO57PjVueUne7n2
         EBJzMHpC9gUpKJ+elcIe1Z5MbwQjEliLem0uvO1saXdjoCi6S/gwqLU3G4mnWS0Nv6sa
         wUkT5M4/YGMAYBV0KJ0IIAjH5mtih+ruACDzgM9kSFPUXRY+Yi8DYvwatF9rvWnjwpKh
         KdRw==
X-Gm-Message-State: AOAM53154Ib53LKzS/MLPGAP1HDFdEElKHEkgJ//Htl+VCPcXy45soo9
        7YuQ857qn6rvJCdORi5eXFQ=
X-Google-Smtp-Source: ABdhPJyVXABAr/pZSxRKQedughfiD2JS/O36Hv2xerHpCrNdA+O895Nnd5Y6s3T4zAGL9M3Vubxgiw==
X-Received: by 2002:a92:c50c:: with SMTP id r12mr27664795ilg.281.1620759088517;
        Tue, 11 May 2021 11:51:28 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 09/28] dyndbg: accept null site in dynamic_emit_prefix
Date:   Tue, 11 May 2021 12:50:38 -0600
Message-Id: <20210511185057.3815777-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
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
index fa89d69dad4e..fb8547feb061 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -629,15 +629,19 @@ static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
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
2.31.1

