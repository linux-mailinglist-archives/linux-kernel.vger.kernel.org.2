Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8A33EA41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhCQGzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhCQGyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EFEC061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:31 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f20so39833171ioo.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0l3a9Uzu/ZRgWPegPcgX+r7C1XlHwt5hH3uR9JYCAhU=;
        b=pTpnd8jG0uXzVvxiyKK5NSrtLnBHlwqhCtIYkmCB7CTmWvHqSCphX7f0+KzpkMIUjw
         7011B/ATZoKzfIrP3xn0FyLJ4hYGFDPg9StrjCE79gUQ0bvA7Pj37u3B8YJK5W1a+hzL
         3IvoPnbTe7FL/x3rq3QJcqOjGhe+Q6aMD007WUJwz+u7w6V6h7zAu5sfNFHXVUv8g42p
         NJMTQKNw5ns7lVFaesWqA9MVBjI2CQ1Nawd+NMxmfoSeKAF9AYmFNWr3wPACeLA/0/rS
         foi33btf7XsXK4V8RHZ2fyneSgOmW9QtNBCk0XbHLxn1N9OPq/8bJXbfv43D9nRDzzbu
         dGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0l3a9Uzu/ZRgWPegPcgX+r7C1XlHwt5hH3uR9JYCAhU=;
        b=Cuu490Xhmlm0WCPAyEt+v1z+FkYBfu6bGUBJGk93DXSsfppUQRFaiE8W6j7p93k5iG
         2aiCtyiQpcdwzOG8Zpe/LMKlqHg2RkOHrRtusJbMpoLJDKoxgVGqYn8ht/gJTQ2X4Odo
         fzmEg/piht1b3/L/xIFa8Z+s/GAH2XccevDXVrru8JHK8Gsf7jPRnq/ywmOtbVF6MkrR
         8/li/evTZ/GMKhUAFfwaOwvHXrUVhGBu3Z3yebSLVrXecd/RCtrx9TVDsArCOOdUjOo8
         CPDFYLCrtwMqLJqorymp1wH/yZo1KAeJy/6ncv/HC/MXLmXH3DDNuIWcDnJs/ijRnTBk
         BJvg==
X-Gm-Message-State: AOAM531Hb8AQWBLedyyPzGfIpuHlAi2y/KQD1KzAmf2W/1l/D2VSjU+b
        FDOXuMdej+NnFt5hFkxdfiiZdxH9kwGMsw==
X-Google-Smtp-Source: ABdhPJxgPRtXqWWF9Zxa2OK48conZ5eSmJImjX56PHGy+iUV7Z88xaVRJEkTgX6e8Xs4APw+/ARe+Q==
X-Received: by 2002:a02:24a:: with SMTP id 71mr1836680jau.22.1615964070936;
        Tue, 16 Mar 2021 23:54:30 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 11/19] dyndbg: refactor ddebug_alter_site out of ddebug_change
Date:   Wed, 17 Mar 2021 00:54:04 -0600
Message-Id: <20210317065412.2890414-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
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
index 2d011ac3308d..6fbd9099c2fa 100644
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
2.29.2

