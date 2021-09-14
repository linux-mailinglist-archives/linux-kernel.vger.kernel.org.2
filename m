Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15C40B79A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhINTMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbhINTMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:18 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A5C061767
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:00 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id t18-20020a05620a0b1200b003f8729fdd04so755600qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l9mJIyUqootgRNTBiBt+8dXdqm6+1gSNLr/rJAR02zA=;
        b=Pf/yJENmsDHPVrKOCs7o0dEbd5TU3p9BMGkHoeSTGNwEHhjRdzECfmow0BqmDVllQz
         WKMtAPK4Pk4TXKh+amiaqRBh3Z3ALCtQ+FoD9wpIk7jwBrnXo5xYiPQMvtgOt8qpO1Fn
         vyNMoxgcPqs92XItc5iiF6novLQFrcrVSeLVUB7OQXAIS+DzFr+YNd9WsbP35QBUGY/w
         CoHeipLM8r6/4fIjMDyjZ9Fa/xBaOvjx+2tFlFAhJ7bSzOV3gKce0DyhFJk9ifg33+RT
         gnj+Q7Ex/GF/BS40DWaQVwVC2SCGv1otH0UsAaqDOZaX5fjAikeCuE1uEpent+K6JVXz
         Q3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l9mJIyUqootgRNTBiBt+8dXdqm6+1gSNLr/rJAR02zA=;
        b=Tig63ovDMH12tKUzl37quKQjnFyWa5x7K9VIoJVc0XZheZuakPn2W4+182QLFL2TzP
         0T4KJ3zVKheyhVWGcnt7uzoI5vJMtwoOhOXrjYC7QN8PGLVHxyOMzpaoyAnA/WPv5CCo
         okhSXZXD1dFsX0X9onRD1dLHS4ySFMJz41d49PdzRJxMZ2ARGJ6OXuSCophb49DaVcAI
         XogWRbKh95yVCYcZR1rSRM5bsVVjYGy3UZp+tN6m63jNUxd1fiBepJId90z3l58mbszE
         M4kF14tmZx6gS1Q5UzT0N6Id8fQs8Rsj1SXHYP1qRkHhMl4+PQnZGqlBB6vWUBRIHwLR
         Xw1g==
X-Gm-Message-State: AOAM531DL9tcOrkMh72Flg28dCWHKvZ2r/WHSLlSWbIn5sAe5XhMaP0P
        jxYQlYvsyBndcoA5HljoAPF0MXPjdrLGRl+yE7M=
X-Google-Smtp-Source: ABdhPJzHZdT/l7HIAU895z7Y+lhZHXrnjfKLISS83BOwvoTWOV5t3zlx6Jm6b8gbenEqLpa7OhId1hiwrbltZ8OOHvI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a0c:ab08:: with SMTP id
 h8mr7159579qvb.41.1631646660085; Tue, 14 Sep 2021 12:11:00 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:34 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 05/16] tracepoint: Exclude tp_stub_func from CFI checking
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If allocate_probes fails, func_remove replaces the old function
with a pointer to tp_stub_func, which is called using a mismatching
function pointer that's will always trip indirect call checks with
CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
tp_stub_func to allow it to pass CFI checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/tracepoint.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..58acc7d86c3f 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -99,10 +99,7 @@ struct tp_probes {
 };
 
 /* Called in removal of a func but failed to allocate a new tp_funcs */
-static void tp_stub_func(void)
-{
-	return;
-}
+static DEFINE_CFI_IMMEDIATE_RETURN_STUB(tp_stub_func);
 
 static inline void *allocate_probes(int count)
 {
-- 
2.33.0.309.g3052b89438-goog

