Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405D54556CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbhKRITF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbhKRIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:17:45 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A85C0797B5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:11:53 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id g80-20020a1c2053000000b003331a764709so3996771wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JzBhpw0Qm81Z9lbF5IGyZhQAb+5o04LDLkCFlxupKLc=;
        b=J2dq7Bb9OTuiXP0AA252Vhhbu3XGqr3duXOucWG1csy7gyckiIiMwWpJQEOCYRYfwg
         TwOr1g1RYTDvwt7NCN62kuwbbMTITIMaqW/1tMbjc6fKG02JBa27YgUuArEnv0YIJkNx
         ZgKgFJdBnBFPaE9JJ5tbXXUKzcqh8R1MwYvyaiI3AjDYNW1qO+WcDTreNeP7qgt6TTMa
         TmAWysa5UItVtnxiVujTaFnon2WiU1y5A4yb0TNwtuZf5AGWUD5xRJDzOMv5xvM1G1mG
         NTLv0nkmv8YkQW40zZeBVY5+wh38COqeDm6813bXSXxHVwakR0+VEbNO6ltBvRsvbuwP
         dIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JzBhpw0Qm81Z9lbF5IGyZhQAb+5o04LDLkCFlxupKLc=;
        b=qt2mSbMhrHLTw+6mXTA9/SuZZ0bbMWUTSLu5FOMzzNVTfiN/hiqF9utBUc/g8XGOJU
         Gk0Gw4NAUOk5IhMfPat/mb/Di1S9saqNquuumTx6jVMuKvqR8HiLTioRhQSVyAkDmqI2
         GRr9UgYC+SM9A3kgibRD0rhewUlWzo+B8BZdcFEVzd9g3a4LdpYbjGfpiLo/nTTIa6qZ
         Bd9hC9GvEK6v6Z8u6y6XD3zEou3KoS9GOBxQs8q793z8MbOX+orshxerxLL3IZUeBKRW
         4T7w/XUDTBfc+/v88YpDo6zLgnqIX3MkEq26QkEisrCArl0Xf54r/n5aD2vFo4psDyEy
         sPZQ==
X-Gm-Message-State: AOAM531cD2lCq+o4ZnY93PlNQsne1E65OV6U8PpdP43I4z9QAE6KnKmw
        v9J43zrObTTFq0Y0RWHv41NVPzZtnA==
X-Google-Smtp-Source: ABdhPJwQusr3UKyMybjxK41hgl723BBYHi903/Jdub7L5Z2pzXQazmXFESlxDTaLwUt3upLKIKsJeviZ9w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a05:600c:2c4a:: with SMTP id
 r10mr7851761wmg.125.1637223111807; Thu, 18 Nov 2021 00:11:51 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:26 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-23-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 22/23] objtool, kcsan: Add memory barrier instrumentation
 to whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds KCSAN's memory barrier instrumentation to objtool's uaccess
whitelist.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 21735829b860..61dfb66b30b6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -849,6 +849,10 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_report_store16_noabort",
 	/* KCSAN */
 	"__kcsan_check_access",
+	"__kcsan_mb",
+	"__kcsan_wmb",
+	"__kcsan_rmb",
+	"__kcsan_release",
 	"kcsan_found_watchpoint",
 	"kcsan_setup_watchpoint",
 	"kcsan_check_scoped_accesses",
-- 
2.34.0.rc2.393.gf8c9666880-goog

