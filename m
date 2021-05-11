Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A544037AEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhEKSxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbhEKSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41484C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:29 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z1so10201606ils.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7hQGSQuKR4sAj9RAyVubeatxnEwd+8g9Z/5RIBV+x4=;
        b=LAl6WYqQ5oNZ+/ftE8WCTgl6PWkHtm5wTyxt9+bKNDbB0+GdFJWNEC0BfvPDdGZFEa
         1VfKdclNchgDTw6/+YwScmO6R0/VYnUqp4/GWudQO4WzTTFN9NNEHOmhSKeqyAe9P+0P
         2O09xfPaMSuxljzBQz0/ED22HSxrMzqOUvM1RlRvy/kwnkF8D2JLhZ1wQiTMG0xjROXR
         iQEQZ8qH59sTK4sVyHCC/yyljM2iUaNyq/i1hA6w6odH1lOQIEh4dr+sj0MqH7w28UMe
         3JTleZcEdkf0GSoLkaiORK/+TSl5ARzzyYaI1dlubqtUf9BeM5clPsbJ6P+JQi77xJ7i
         DciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7hQGSQuKR4sAj9RAyVubeatxnEwd+8g9Z/5RIBV+x4=;
        b=JXukitZfYKFCQJdDs4PqhBRiaJAIWv1PAtIfDU3OtuoiOlssm6XTMsDPSY12YtWau9
         6HP+HbhnRFOurbwHNKHGQlz44as4I3ozLtCkcFX9qok7LY07gkOUbqEE1MLtC0jBzluK
         MpfpmC/a+Fhocu/pWEiggLHmeX4Q/Qep5wACJQNLO081PC3lWN6YjE+qi/0oHIDTqcEe
         ExbHfparP/0XlrCXvDnY3PfBnnx2swoSdAJ5LH+8TpRXUeblPiZ8OaPtB+ote2XhveHZ
         87uevGZmylCcqBjkP1HkrE8n9wOn8n3oSYpzUk9lOE6/rDBkx0xxvFUfyDvSWTOTcjf8
         EgKQ==
X-Gm-Message-State: AOAM533GnIyPPmH7zYOtf6DHVi2hXaj9mldpDZ96MI5FAeq83RYFXkzW
        fv4sipRgiRv5rJHHLV9bVGU=
X-Google-Smtp-Source: ABdhPJz5vY3J4iH6mxxGAcckjD1E3A+hfMKv1yCPzUuGXaAllWJ0VEdlszZaY+BOi6QtjCMCrX9mpg==
X-Received: by 2002:a92:b711:: with SMTP id k17mr17595756ili.210.1620759089375;
        Tue, 11 May 2021 11:51:29 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 10/28] dyndbg: accept null site in ddebug_proc_show
Date:   Tue, 11 May 2021 12:50:39 -0600
Message-Id: <20210511185057.3815777-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accept a ddebug record with a null site pointer, and write abbreviated
output for that record that doesn't include site info (but does
include line-number, since that can be used in >control queries).
Also add a 2nd header line with a template for the new output.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fb8547feb061..5faf49054b1d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -923,18 +923,27 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
-			 "# filename:lineno [module]function flags format\n");
+			 "#: filename:lineno [module]function flags format\n"
+			 "#| [module]:lineno flags format\n"
+			);
 		return 0;
 	}
 
 	dc = dp->site;
-
-	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dc->filename), dp->lineno,
-		   iter->table->mod_name, dc->function,
-		   ddebug_describe_flags(dp->flags, &flags));
-	seq_escape(m, dp->format, "\t\r\n\"");
-	seq_puts(m, "\"\n");
+	if (dc) {
+		seq_printf(m, "%s:%u [%s]%s =%s \"",
+			   trim_prefix(dc->filename), dp->lineno,
+			   iter->table->mod_name, dc->function,
+			   ddebug_describe_flags(dp->flags, &flags));
+		seq_escape(m, dp->format, "\t\r\n\"");
+		seq_puts(m, "\"\n");
+	} else {
+		seq_printf(m, "[%s]:%u =%s \"",
+			   iter->table->mod_name, dp->lineno,
+			   ddebug_describe_flags(dp->flags, &flags));
+		seq_escape(m, dp->format, "\t\r\n\"");
+		seq_puts(m, "\"\n");
+	}
 
 	return 0;
 }
-- 
2.31.1

