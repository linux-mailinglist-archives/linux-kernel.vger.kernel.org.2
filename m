Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06F333EA4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCQGzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhCQGyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:39 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C5C061760
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u10so508197ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhYSMBoAMdltkZMW4za7BQw7Eq1RdA2946QBXoxuj2o=;
        b=s74V75N38hXLRjrQQeMu2+UVl92T8xNavldg21iHPOAevTh5DUx++Wl3vcNcX+FT9+
         g/YGCa6bDAx+gT+uRB+KZR10FBcoOEe+Mg2bsbEuKRk5s7gEh1kAenwA/dVN5Js0uSs4
         VFWlFWpFm28P0f+X+R7KvgIIG4vLgABLQaAFx5D50No2ERX74H6m21VvZSecY3J8zqxS
         4mZTVDP2a2F8J8YMjXnzJ4iItaDzftwbg/GpSbXtO5Lfl4Z9xYG9QPbIvvFQqJbX/Dn6
         k7enGOriVblr2IJIdFEWO2VikOAplPx+RRtW+mA8p2zcC5zSvjlk/CXW98Wpymwddu6Z
         sc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhYSMBoAMdltkZMW4za7BQw7Eq1RdA2946QBXoxuj2o=;
        b=J6spaT3Y0r0wK697ZEMc/ec+n/SXt3gd8xMU/IbFSUz/0AMOZj6fE2i4VRY9BrT4gg
         7B+wjm6eKviJfhNvII22XdVORg/xQo43KEv6Xhcb77yndS0NdfG4MDieeQwo6yfpmF1L
         PyaZvcJQLabTLb1PgWEh92vc0Wty9Nrg/FKzX7aCJl9wBaBNPLfHSenaMEHsQNQqLRQH
         SLuU6bD0tSZ0h0fzWmXOWWGF9FNEJ1EUIXsmoci+eAaHfUVgITNnbVHR/swSDJ4CVoVG
         i56nv5aDWcEMkJj5zM0SkiOLZYGG+AtmDjlTM0ArUwum3s6fpBdYtnJWc6ssFUHSZAWp
         u/Aw==
X-Gm-Message-State: AOAM530J/uKRFFAdTvotkSVG9ZtzoYHtOByNrjv+zyCYZbCZ4BI75SzK
        jTvqyl9BxJpKaksYFWwcQ5Y=
X-Google-Smtp-Source: ABdhPJx3avdxAibEeITNeedGUKNjltSIU1t0k3JerUfE7B9WeUpRFZ0cRIecnqLhMb/VXPI5k+K2Mg==
X-Received: by 2002:a05:6e02:f03:: with SMTP id x3mr6322007ilj.296.1615964068298;
        Tue, 16 Mar 2021 23:54:28 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 08/19] dyndbg: accept null site in ddebug_proc_show
Date:   Wed, 17 Mar 2021 00:54:01 -0600
Message-Id: <20210317065412.2890414-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
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
index 0c535f3c2ba9..1f0cac4a66af 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -918,18 +918,27 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
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
2.29.2

