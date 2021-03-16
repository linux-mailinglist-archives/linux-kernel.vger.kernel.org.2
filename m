Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213D633CCEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhCPFJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbhCPFI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:27 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99287C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:27 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id f10so11547144ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhYSMBoAMdltkZMW4za7BQw7Eq1RdA2946QBXoxuj2o=;
        b=LkeTT5yVwa5c5v+HxQKpGmb1zVN8wHi19QgQrDaOd+Ph+pC8QwpWiMvtqZLZhQAcng
         4RQRMa8knGDT325vSQwvdiwXug+DDvfctZ+yUFGDPLI1enatboiswxnm4szSkSciXCKZ
         HFZs/H3fVtAWLOv2Iayz01TZwGviVdQDIIwOHMnNd2dJCmNNVKMvjUoAO1sIB1cywJLk
         dVxTi/ERmCGrAhNIlmw2/GpeMR1+m+tGwxAauNR7/hQD1AZSzsqghaKWEfSandbQdw/e
         /xKBkjdGYy8m3ObQKbDJeVDMkD8JjPuSivVXJZv1YPKcrAF443pUmYSWqLuFKeQdbqj1
         Geaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhYSMBoAMdltkZMW4za7BQw7Eq1RdA2946QBXoxuj2o=;
        b=kt/+nu322ccRWNGzf/dSgWU4W4iWxmHLZ2aZjx28EiHP1r5C56Xyo5SOKNpDdR7dhX
         xNrQPkolDKOLDxa/b/qG/dzD0R2Hi5GBE9JRop5Om6HJ265I2GSB7xVpzn4ANCR8+xot
         8djyI4piCvm7HourLFfOlBhK77bgZgc9UhKy3IBDqVV2xGzLzYLsZSMgjxqZKdMURK/b
         C6xPDwZQSBj2E1JNtI5QFkmMIydmj+p/ctwJ0QiDgVzjVIT8rErZz8ykeljGmm9MhAIG
         jHFEUDIWn5fzvuK89e9pWrRRJbyHza55hBSU2kAXIhKTgDuIA6auU6O2Ktpe4sWLi40g
         EQbQ==
X-Gm-Message-State: AOAM530cRj8AKL0u0kcbO1X2Tyu9m7vGmO7QV/qGMErspcGOwjr98ljx
        /Mc/IEBXv1GDFW4oZSFgY9o=
X-Google-Smtp-Source: ABdhPJxNn0hXPnpIEbANL0XBeth6n+eFtlOoafOPYBQUHKk91Eu+BxukDqnPvu2ijaigFW7o23PfPA==
X-Received: by 2002:a92:d6cc:: with SMTP id z12mr2292225ilp.226.1615871307097;
        Mon, 15 Mar 2021 22:08:27 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:26 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 08/18] dyndbg: accept null site in ddebug_proc_show
Date:   Mon, 15 Mar 2021 23:07:51 -0600
Message-Id: <20210316050801.2446401-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
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

