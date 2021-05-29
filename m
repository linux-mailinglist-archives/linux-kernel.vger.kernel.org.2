Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C44394E10
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhE2UEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhE2UEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:13 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED72CC061760
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:35 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so7033265oto.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCVj9Qar9k+5REg8U2jqjHbBTBjn3JeujdnOoUT2RDk=;
        b=SZWvXZoNZk0ql1y+O5Re0kv+/n7mABxn6dgkyQFeMfLfm6QkV1kaPfEQ2lSXwpy9Zc
         tEvTKqqSehT9zC7SFBZvKH/TQTmOHqS5NaCW1hU7J1FRA0lOkgAggzFS+Nur3OIJGa7X
         rycBpUocXhQ6RzZu8dZTwvHM+Gio2VBIABOK2WBlKEaGNPS1vQ0R5ZEHVnhLp4/0m7SD
         DatMnuFN1Njo37Ai4hvwttmetzeaEmAkbU+DGgOmcfGIlNblfNqrLr30+57E6Uxgo8U7
         yZFHT0T7dJzaH+qUoKfeEqNtMepz3CJbKKfNkmwRq1jGuJxeovjsWrMD/Dc9TMKgwKyI
         r4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCVj9Qar9k+5REg8U2jqjHbBTBjn3JeujdnOoUT2RDk=;
        b=j/lFmoN8frFXLXfyZR9b7gMFd3viAVUi6IBuFOVN50a50XogoY4uwT9M+ciPLpNKX/
         Bp5KX50rkDQ7/27j2KAiptWf+iwf6K3a282C2vqP3al56sX1AS+1IovSPU3+MFlwgFWk
         ke4iNpFLH9FlOhRoDCu1w7j3VSiIgkpLNdIdJ2EyP0sfLlSVUmxMsq4xUhQ7cXvCItro
         OF1LKmWMZD1NLN9tNEIST5a90+u7jRPMF0xhqQZaExO670diG7EDj6HAEp4Jz8LlNeOE
         gt9wJjAWa+JsLz9Q0t726/eKzZ6AmUDpK6MbaR3fgCDRUUjPPEIc1FQLbvZqKdFGtXjN
         ay5g==
X-Gm-Message-State: AOAM5320bN3DvddRQET0PaiNZ9MoCazp0SaATe24FGkgs/7HiHaolw6S
        0dSth0e95MUsIE1IXoxHORo=
X-Google-Smtp-Source: ABdhPJxhhsp8RheVK0wFUS3H4x9iG+y0aZpTWj32AevnVNueoNt5b5MXw9jo+Lp4vkHEXqLML8SxGA==
X-Received: by 2002:a05:6830:4d0:: with SMTP id s16mr12374114otd.5.1622318555331;
        Sat, 29 May 2021 13:02:35 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 21/34] dyndbg: ddebug_add_module() handle headers.
Date:   Sat, 29 May 2021 14:00:16 -0600
Message-Id: <20210529200029.205306-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that header records are in the __dyndbg* sections,
ddebug_add_module() sees them when they're present (when adding
loadable modules and the 1st builtin, but not 2nd..Nth).  Teach
ddebug_add_module() to recognize and account for them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e4a22f7b153f..ad9971ded09a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1036,7 +1036,18 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	int i;
 
 	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
-	if (!numdbgs) {
+
+	if (numdbgs && is_dyndbg_header_pair(tab, sites)) {
+
+		v3pr_info(" header: %d %s.%s.%d\n", tab[0]._index, modname,
+			  tab[0].site->function, tab[0].lineno);
+		WARN_ON(tab[0].site != &sites[0]);
+		if (numdbgs <= 1) {
+			v3pr_info(" skip header %s\n", modname);
+			return 0;
+		}
+
+	} else if (!numdbgs) {
 		v3pr_info(" skip %s\n", modname);
 		return 0;
 	}
-- 
2.31.1

