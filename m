Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEACF3EC2A9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 14:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhHNMna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 08:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHNMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 08:43:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EE6C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 05:43:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so8615102wmi.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A3zBG3rR+R25Si1zQzd3YIu1279pPhec/mpvO3yWcnY=;
        b=t7/jwf0zn5VZhrkAGarZZVoRlSKX96aV1arZJfcoMsUE1e99k2uVAFdgcjJgHtOzl2
         McDEH6FSIA+bm6YEyrVG2GkMCFP98parvRVWz/YnpeMrhklX4WZ0yWRalv2hotCkwzpg
         QH7N9IQUxkMqPeVPeTZwUGgnYA3JVCTS7vpxo49z5q8oaSlj6z4QM4jERK1KQZvCSokL
         y1JpI0R3fRv/5PHHWaC9N2f/rDnSVAGZvunNcHUujGyEpf+b++PVNK82x9sEUz7pUJ7y
         /D+bKGVBSpsFyy5up0ZUmmnUhmIjFY0gyjQT403D4RZvshg2Nos7BSeEn5qFdXwJ6DiD
         nORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A3zBG3rR+R25Si1zQzd3YIu1279pPhec/mpvO3yWcnY=;
        b=pIwf61CSEwxD6van1128adO9K7nNOMgXgRz8arVPS0cs0aGZeUW66yHq1/htYFF4mA
         apB9gsK+CAPLRKQfWrYsFKiA3kC5fmrKsBBcMjZ+RR16+kb76L41I8QEdntamIRwzH9M
         S68S1nLiYjpXxuGoAk3Z8iRMNmVVUqWckl6F0WJFNyOhrfPZg7ZEtZAnDQfyLdLjyePr
         oC00/qbX6EymrB7jZIZmpeZVGQv4Dvk4njN51tPTykn8Yty59lNAJSy6srfDTQ/YUdSw
         cedH0DQLVs1kNBUi0PtJIhSGij/YE9qjRJSMqvGOl9LRbdCuuXwsLLlQkDRGkCfmliIT
         3crQ==
X-Gm-Message-State: AOAM5316obIjUzBcSkJ2UwPfMzQ++5rMc7yx8Fr9FDX1FUKSkM6d1EVf
        hkVvTMFSL0ISOHRhd6teRzI=
X-Google-Smtp-Source: ABdhPJzqaGg/z8cZXrNJXL5SGfFC9N/93VuYApqd4ZQsE+DEIMUeb2M8JpjFuMKysktBrf+wMYRMeA==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr7004614wmb.59.1628944978437;
        Sat, 14 Aug 2021 05:42:58 -0700 (PDT)
Received: from pswork.fritz.box (187-64-142-46.pool.kielnet.net. [46.142.64.187])
        by smtp.gmail.com with ESMTPSA id q3sm4030100wmf.37.2021.08.14.05.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 05:42:57 -0700 (PDT)
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     jeyu@kernel.org, keescook@chromium.org, nathan@kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com
Cc:     treasure4paddy@gmail.com, Miroslav Benes <mbenes@suse.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v5] kallsyms: strip CLANG CFI postfix ".cfi_jt"
Date:   Sat, 14 Aug 2021 14:42:19 +0200
Message-Id: <20210814124224.8551-1-treasure4paddy@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABCJKue6dYBYTJtyX6oE8Lq1LVHcS+vq+Z4cRE2-Tut8GRHjPQ@mail.gmail.com>
References: <CABCJKue6dYBYTJtyX6oE8Lq1LVHcS+vq+Z4cRE2-Tut8GRHjPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang CFI adds a postfix ".cfi_jt" to a symbols of extern functions.
For e.g. this breaks syscall tracer that doesn't expect such postfix,
so strip out the postfix from the expanded symbol.

Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
---
Change in v5:
  - Also remove explcit config check for postfix ".llvm." as LLVM
    renames even in full LTO case

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

 kernel/kallsyms.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 5cabe4dd3ff4..c8ef618e2a71 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -174,7 +174,7 @@ static bool cleanup_symbol_name(char *s)
 	 * foo.llvm.974640843467629774. This can break hooking of static
 	 * functions with kprobes.
 	 */
-	if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
+	if (!IS_ENABLED(CONFIG_LTO_CLANG))
 		return false;
 
 	res = strstr(s, ".llvm.");
@@ -194,6 +194,17 @@ static bool cleanup_symbol_name(char *s)
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

