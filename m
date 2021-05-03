Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E403720A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhECTlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhECTlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:41:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 12:40:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z6so6820341wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 12:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t1/jVKqUe82uM/b8ER0363WbTTrWds0L2r2AHxiXmAY=;
        b=AK2zbdQErhrHNq5X9Qxpa2X8Wvzm8FL/o5nRoiyFDK6yAyC2TwLZ7v4vDjSEXZlGed
         lID90ZweN9d3XiCe+PtOBBg4ZCsNHoXCN12hC8s++OFgiHRUCO/0Jy/EBwkRvYXwVwm3
         uGYoqWlAW03GW2I53RWzkkKhRLIVjj6BXH75l8OwmuRMDXm8pCNIEnxMiabzzS2seRQ0
         /ar3P2sewad0QPv7qURlBkfTsOtxXmVjOGlc0C/ZWEfzuEtk+dwGoRe105KO7wd56N8H
         uz07A49C1OpLVF+RD1XKEGzVouYek9KnHLRYa0hfLihTRQCR2BEfJBE7TiXou7iFpsEs
         P4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1/jVKqUe82uM/b8ER0363WbTTrWds0L2r2AHxiXmAY=;
        b=of5bSdfEzn+FgtbMYKn56tSEjelDVDDB9nqWMxNxEmIhhZLMuD985n3+xY7uO9QjSY
         IfVEdfOZoa4rLFsJELdxLlOEx3Y/vpDzdNkFNtYtR/rQd3F1nS+shXcEM/nsw/0Mwhtq
         Q+260TwXUzHu7anyLAa/2RE+7CgJCKpWhOweAAB3qu3sEcyNa3qcU2nG2dWRKEgrSCuq
         kyfs2h1O2kbV7885y+Hkihs9xntH6em2dkPm29XdfyOgwqxh/baUh/T1ekUJlspDlR60
         T8VKQ0L8LPAwtRFkill7cnlz8wZIjPLK9KBPIRdRF2nRebB7ez94N3UQmlPGB7P4vmDf
         sQZw==
X-Gm-Message-State: AOAM532wtUbwgQg+Lw5y0bQjYX0c++vrCeny2elxt6JuLN8m3dBIW5qi
        E2ogn8cb/OsJjiNmjTrIAGkDYhZxg1H/TQ==
X-Google-Smtp-Source: ABdhPJw1ojrvDSG+HQmOVpPZGqj1GKAoImg3XEcNQ5Lv4XcMhRsICFrTghPRMRVsiKwsvD/HwsIo0w==
X-Received: by 2002:a5d:64e4:: with SMTP id g4mr26997779wri.366.1620070844038;
        Mon, 03 May 2021 12:40:44 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:915c:8fda:c2d8:722c? (p200300ea8f384600915c8fdac2d8722c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:915c:8fda:c2d8:722c])
        by smtp.googlemail.com with ESMTPSA id d127sm353689wmd.14.2021.05.03.12.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 12:40:43 -0700 (PDT)
Subject: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log with
 debug messages
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
Message-ID: <6d55670d-2f06-d768-699f-5a79cece6ce0@gmail.com>
Date:   Mon, 3 May 2021 21:40:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e820 emits quite some debug messages to the dmesg log. Let's restrict
this to cases where the debug output is actually requested. Switch to
pr_debug() for this purpose and make sure by checking the return code
that pr_cont() is only called if applicable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/x86/kernel/e820.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0d..67ad4d8f0 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -465,6 +465,7 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 	u64 end;
 	unsigned int i;
 	u64 real_updated_size = 0;
+	int printed;
 
 	BUG_ON(old_type == new_type);
 
@@ -472,11 +473,13 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 		size = ULLONG_MAX - start;
 
 	end = start + size;
-	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
-	e820_print_type(old_type);
-	pr_cont(" ==> ");
-	e820_print_type(new_type);
-	pr_cont("\n");
+	printed = pr_debug("e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
+	if (printed > 0) {
+		e820_print_type(old_type);
+		pr_cont(" ==> ");
+		e820_print_type(new_type);
+		pr_cont("\n");
+	}
 
 	for (i = 0; i < table->nr_entries; i++) {
 		struct e820_entry *entry = &table->entries[i];
@@ -540,7 +543,7 @@ static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type o
 /* Remove a range of memory from the E820 table: */
 u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
 {
-	int i;
+	int printed, i;
 	u64 end;
 	u64 real_removed_size = 0;
 
@@ -548,10 +551,12 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
 		size = ULLONG_MAX - start;
 
 	end = start + size;
-	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
-	if (check_type)
-		e820_print_type(old_type);
-	pr_cont("\n");
+	printed = pr_debug("e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
+	if (printed > 0) {
+		if (check_type)
+			e820_print_type(old_type);
+		pr_cont("\n");
+	}
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry = &e820_table->entries[i];
@@ -1230,7 +1235,7 @@ void __init e820__reserve_resources_late(void)
 		if (start >= end)
 			continue;
 
-		printk(KERN_DEBUG "e820: reserve RAM buffer [mem %#010llx-%#010llx]\n", start, end);
+		pr_debug("e820: reserve RAM buffer [mem %#010llx-%#010llx]\n", start, end);
 		reserve_region_with_split(&iomem_resource, start, end, "RAM buffer");
 	}
 }
-- 
2.31.1


