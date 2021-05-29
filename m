Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959F0394E07
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhE2UEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhE2UED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:03 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115FCC061763
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x15so7949262oic.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AWeRePfcuekAOmsvrqglio6uI9lGeW+QJSWDx1i3w1k=;
        b=e9f10CbO5mzNQcL71mBPBI8CFGDKZ8ul65fD7Geg+xUgi3QpHCFayMNMF40m9rbH1a
         JCBiDkL0IYtGDz/y9/VsdJrJV9tauLf5GmQLnx/4z8YoWC3h+7DOtjZVQxvemcvcjVdp
         EX1QsBJI/3pGZQT7/O0Gaq58yWUOa95QwPDCZs/jexzrDjJUrE/HAAGxdngmjfE3w6ec
         cPR1l1nu44UU+kBsVsN64LOzWrndJp36JQYMtJAaFSK4zWwAe3NkJqtK1mvl5UW+G2sc
         jTUPltRC45AQ5G+xMEO8M86Zr2uogFaXt2HFgYxWCO3bwiP9GdxA3K11f4DEEPELKVkN
         6OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AWeRePfcuekAOmsvrqglio6uI9lGeW+QJSWDx1i3w1k=;
        b=QXCMN+mYmuYjdvGJfsglWQfW1JsKexZHVlB0yFvS8nETsEzq3G5050KEH1OFlrKnsw
         HcqYKoBMeyCEuwCSLRD8Bvtu3GbluepL8nEPZf3ld2nPRKxYSO/W5QiSucO7VN5Sa4qv
         DcNmclQ/58NLLCYHMBeckSCfOXwp2iSSLL0o8LI+9m+/Kmi7vCrD1cYORkJ8ZwIMysAR
         Hs6QJ8tOR+Rbuyk9NtGei0D0ypov0x/ajScM7L4edF7iff3GCc6+5sYP+2MjR+nqnMqz
         D8zTsyubUFznfR8DimbFNhA6yYsBc0MYh+KlY2P6u1yyGloMDU7zD9CdGSwKLJ/j0Nwx
         6qbg==
X-Gm-Message-State: AOAM531mn7tc8NmSumTlAbyfqEYXgbCI/UbloiY3rzd7gDQ3F9YoUXEh
        JvU0YEZOPyzDFIuamaGfhd8=
X-Google-Smtp-Source: ABdhPJyn73YUp06jW3anj/M1N/Q4rW5QRTWddTRr+nTkEnbyBKmAsvq+meUwFUJHxLYFXmWaHZ28cw==
X-Received: by 2002:a54:4192:: with SMTP id 18mr13144277oiy.84.1622318545447;
        Sat, 29 May 2021 13:02:25 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 12/34] dyndbg: accept null site in ddebug_proc_show
Date:   Sat, 29 May 2021 14:00:07 -0600
Message-Id: <20210529200029.205306-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
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
index 868f56edf831..592aaaf79fd7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -924,18 +924,27 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
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

