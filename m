Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02C1379BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEKAkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhEKAkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:40:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE8C061763
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i190so14764430pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJWqF1l7JEMhfTSAMN74xGPitTqml4QrDOfgb/mUZPk=;
        b=WbzeIHfGDt63kCkUjaBikTyBcRY/ZDKry+3OoLw5BuxuBqqfkhfcnkq+2k1URPpqX0
         QAnx52NV3Bm4+47/3heqwqNYhDUG4PuMRbXHuzUk5KeRv4gqQRqIu+lGtCtTDhod6tfB
         Ak6TQ5qnfQQZa75ceGGJlW4nVqDnch9yJaMM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJWqF1l7JEMhfTSAMN74xGPitTqml4QrDOfgb/mUZPk=;
        b=SG3TGB+ZpI9WP1LJ9ofqFqeqL+Zir6afH9SICxXiTpgWcmaz4uWY6RkH952uZ3zbFh
         GYhX3JNxA2cWFC2S4GDWU5CYmaALvrxRASFVFO6pkDy2usICPDChQGgevg0cXWGI8XSV
         gSc0uhmivAVzNwzjkctL9lBaxJhGviLyE8/pJDvRVcw38SDPWPM6nN+zATLKh63VRZCg
         dKwb8b3AajeU2HrX18D6dygis28iqy5Va7fheyHAn2+N/RwkHeyiynqDSPJ5nSuFfGqF
         VQ/GZqsN+VPcMOVs4AmX0nQUJOA0tjPBsWqx2HeWqcavPcPxjn4/1FHzNXMbjAIq0La9
         gsHw==
X-Gm-Message-State: AOAM532R20tDNpYckN71XwEjgc3bYEYK2Jl6xNOtkL82LuZnIZz7Rp/i
        NCYL+OyYSs8iJFr6C4PYCXUo2g==
X-Google-Smtp-Source: ABdhPJyMcN8nhffXO0KOaOE5ORvRU3RWHd9iiSe4s6LJkbYE/BwIifqzKxZr2J3QeOvT3KSIIk7g/Q==
X-Received: by 2002:a63:e105:: with SMTP id z5mr8347510pgh.321.1620693535506;
        Mon, 10 May 2021 17:38:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:38:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 06/13] arm64: stacktrace: Use %pSb for backtrace printing
Date:   Mon, 10 May 2021 17:38:38 -0700
Message-Id: <20210511003845.2429846-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the new printk format to print the stacktrace entry when
printing a backtrace to the kernel logs. This will include any module's
build ID[1] in it so that offline/crash debugging can easily locate the
debuginfo for a module via something like debuginfod[2].

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Link: https://fedoraproject.org/wiki/Releases/FeatureBuildId [1]
Link: https://sourceware.org/elfutils/Debuginfod.html [2]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d55bdfb7789c..ddb64ada74c2 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -129,7 +129,7 @@ NOKPROBE_SYMBOL(walk_stackframe);
 
 static void dump_backtrace_entry(unsigned long where, const char *loglvl)
 {
-	printk("%s %pS\n", loglvl, (void *)where);
+	printk("%s %pSb\n", loglvl, (void *)where);
 }
 
 void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
-- 
https://chromeos.dev

