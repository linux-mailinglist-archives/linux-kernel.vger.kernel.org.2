Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05883E1F59
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbhHEX3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhHEX3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:29:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30161C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 16:28:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso7536102wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 16:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=es0c3UxZ2e0+HJ2C3RZ1dKundYuljCUkYocdB08kQuo=;
        b=X851qTKkbNn0uyUqdHEwWSWMD0UlYkODROOF3fPzBJ0PjY2idf9i8rHXRd9PPNcLmo
         H8ptG7hza5Rnw2Dzofc5nNyeGaTjL3ErNphunDCrd0qy2J31+P17wToqIxAb9xmGHAJI
         M49dcMzETFDQ9Cv8vvPgUMo18QKeRtwhRPEmnZ1+xqjuAak+AbdYyB4i+/kj7f4YFlLz
         +WhH8HcvjrFjHQjQerhgnnZM2qhnJ2KdjsN8WZcPqQ/m1qQKkvy9gd8Kull8FHKKwt4S
         afeske3DOgRAx9/LjiXHPEwbFIolEhzQfakhtdFRGn6NlqVwYt3o2vNYxyC+ttWD4Pcf
         UmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=es0c3UxZ2e0+HJ2C3RZ1dKundYuljCUkYocdB08kQuo=;
        b=HXLw5jkHsHYBVGHVPR597fCXgcSrgfUn3jDGhyefaNywcup8XOcs4IeHyeouDD6KEB
         Dz9UZNJZOXw/KlZsbfgsZjGLObzPMOiKwfegA0LERT/HFg2+bSU+x6IxQS7ZUV4v4O+Z
         sQ6m69s8eWetJ6HE8dTyCFnY4bHYv4D/fd2htGoqoBlPNbQo4s4c5Nci5pyaJMgfsmCn
         APxbh6zLI0hK+AMvgDbEyJgAaslcxgfZed1Y35TaXHS5lzF1SVjfFVBpqldNL94Z6+Wn
         htfJiV1P+TCHI15RgnNT0fCfJAMq2JvkylaLD6n/vu6wJjjnK+kXYzspyMI56tnh/DHZ
         Hwfg==
X-Gm-Message-State: AOAM531ZNfNlFLJm5L3csT6IMCXD+E3eO/mn07FkBb8mcxhkYAyPKHcV
        f4CV7LONfHBU30H7UQTpo58=
X-Google-Smtp-Source: ABdhPJw0jEDrxkw3B2nUsA5wTXAt7+cIgJRZGtrtv+zWFAuSUaEwUkV7HPPMZdyKNbfw9FH67i9lEw==
X-Received: by 2002:a1c:5449:: with SMTP id p9mr17467719wmi.101.1628206130686;
        Thu, 05 Aug 2021 16:28:50 -0700 (PDT)
Received: from localhost.localdomain (i59F7252E.versanet.de. [89.247.37.46])
        by smtp.gmail.com with ESMTPSA id l4sm7516042wrw.32.2021.08.05.16.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 16:28:49 -0700 (PDT)
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        nathan@kernel.org, ndesaulniers@google.com, samitolvanen@google.com
Cc:     treasure4paddy@gmail.com, Miroslav Benes <mbenes@suse.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v4] kallsyms: strip CLANG CFI postfix ".cfi_jt"
Date:   Fri,  6 Aug 2021 01:27:38 +0200
Message-Id: <20210805232741.9501-1-treasure4paddy@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABCJKuei==gaaKw0qH1WkshcRyUbqdS_WGRWr6anYAew1HHT2w@mail.gmail.com>
References: <CABCJKuei==gaaKw0qH1WkshcRyUbqdS_WGRWr6anYAew1HHT2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang CFI adds a postfix ".cfi_jt" to a symbols of extern functions.
For e.g. this breaks syscall tracer that doesn't expect such postfix,
so strip out the postfix from the expanded symbol.

Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
---
Change in v4:
  - Remove redundant check; irrespective of LTO type (THIN/FULL),
    LTO_CLANG will be always enabled. Hence will be used as entry flag
    to check various postfix patterns.
  - And prior to stripping postfix ".cfi_jt", added a comment to
    justify why we are doing so.
 
Change in v3:
  - Modified commit message to indicate fix is for Clang CFI postfix
  - Rebased on recent patch from ndesaulniers@google.com.
    https://lore.kernel.org/lkml/
	20210707181814.365496-1-ndesaulniers@google.com/#t
  - Fix is enabled even for CONFIG_LTO_CLANG

Change in v2:
  - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
    extern function name.
  - Modified the commit message accordingly

 kernel/kallsyms.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 5cabe4dd3ff4..1b40bcf20fe6 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -174,13 +174,15 @@ static bool cleanup_symbol_name(char *s)
 	 * foo.llvm.974640843467629774. This can break hooking of static
 	 * functions with kprobes.
 	 */
-	if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
+	if (!IS_ENABLED(CONFIG_LTO_CLANG))
 		return false;
 
-	res = strstr(s, ".llvm.");
-	if (res) {
-		*res = '\0';
-		return true;
+	if (IS_ENABLED(CONFIG_LTO_CLANG_THIN)) {
+		res = strstr(s, ".llvm.");
+		if (res) {
+			*res = '\0';
+			return true;
+		}
 	}
 
 	/*
@@ -194,6 +196,17 @@ static bool cleanup_symbol_name(char *s)
 		return false;
 
 	res = strrchr(s, '$');
+	if (!res) {
+		/*
+		 * In case of non static function symbol <funcsym>,
+		 * the local jump table will have entry as <funcsym>.cfi_jt.
+		 *
+		 * Such expansion breaks some built-in components,
+		 * e.g. syscall tracer. Hence remove postfix ".cfi_jt".
+		 */
+		res = strstr(s, ".cfi_jt");
+	}
+
 	if (res) {
 		*res = '\0';
 		return true;
-- 
2.17.1

