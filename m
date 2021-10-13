Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2327242C87A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhJMSTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbhJMSTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89571C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so4031608ybk.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pwc+FjCPki+pUsdoZo4XtJgdpZmZm/wSJdGRGya5uYY=;
        b=gOF7RA7uIlhQH2y6fpTZ/eYAsnv1UDVeHBdG5Kz1y5KjInfhB/skiCNuMhYaz6eYMP
         6GeQ2qks2JCVGdaRZGOZLkvn8C/4B/RAaTLcXXC2JWDx4WcSdWIwcHfkX81YLVBXmS23
         QztXIV6wFQRws60P9NG88hizCJNTlWFUA/gCLyntCxc2YYRnSw0HQb0eY9wLpXIUaetJ
         /3F+yRlpTuztm2JCTPrGCw4izcPp406dteS3fYtJaRbRREtcpZV02aA5BiXGg9J8FHPl
         5Ik8sgKoc95K5v9HO3PCu+zEclGvM0zPjV1HMq6Vuhjg/uV+pgU1gcZEO5PHwQhx0fOh
         qsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pwc+FjCPki+pUsdoZo4XtJgdpZmZm/wSJdGRGya5uYY=;
        b=ZDS52Vpsjz/r43Wv5+2qSed7q0s7owS3LhCbavzzhzf9mwnKg0+9h0d6boaVBgQQim
         scptfVV07NSPqFp49eaBvdqVAs/14jn9lUVNfkqE2BI1fkGr3iKHrUES5FgkbHhtwU/B
         4a8lQ8I0LLasdN8YLlPjqzlaMv4IhUvd1tgAC9xVNWZe3K9oo4pyUoFs7J+BKPTzOfrI
         m4JVpKNO/B/YydCHdcT2792i5+GcR5VsfzyeuzlSCmqIZhjcdiGXav0WkqZmZ5MbY8pe
         mCubjsHuPxk4scA/npYnyDvV5z06MC0IIckVGefuAyxBeB0es7mwArt3qZmZxHkNLi2m
         fUew==
X-Gm-Message-State: AOAM531NwW3We6FczPkYdH21/OMX8df+O3MRzURBUI1qoXwL2Ovr0xNV
        oeo2AqANDvVqe2ShTo9ZaKA8IFAvRLisQMHbOsA=
X-Google-Smtp-Source: ABdhPJyWPDqKT324szFJC4m98Gmao0mZQffA/TQHyI6vRVx35cd0fK6KMipKD9p3PzfsdYuss7rwTR0Khdlr26P6Xwk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:3444:: with SMTP id
 b65mr1043658yba.14.1634149032759; Wed, 13 Oct 2021 11:17:12 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:48 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; h=from:subject;
 bh=BL9K7dUCONXE4VvXTqnjSPxrA+FUfOmovuNFxXJ8MRk=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKZY/qhtY/5gujF/wKD5yM9Ja1YB+6s4Oesturj
 aO9VY8yJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimQAKCRBMtfaEi7xW7jcGDA
 CpV1/NduuFcm3XECRF3c5hFL6tJA8OCSbz+U3Zgb1RZh2f0MRl+klpd04bXkPbEBdveq6mfleQeGGH
 gbW51ynVOOFQ8jhVJRwWaf0TKudEr46kKi9XrXPPz81eIatGXP5tFmYpV8hwLX1fjQw9xy94z66T0s
 U8SJzEYszjKtbHIfP+IDX0BcdEl/zd67ZgvmepKwivvX/1B11iC8rSN8iEzO167nOHET7Q3d9b6yYV
 baaovxkM36P3Lo4LuWtwO1zfcb1Qq9Yfgn3QpOqDAKT0RkXWhoH45GZfYB0yi1EOOQbrXeHi7XWANV
 ArCGDunFiLdLhFt9VWvmPGqBcb5YHmllurJe+UxIKtSBWmqIAeUVAEt0WFuXnJ3Otx+ahNYyFo7Djk
 LimIQquwgKSfEXEYUl9NwfcbZ0jSccnFx5n1D3CVFuCV3QDrchxDrl1VXorvxRdsqDc4Cg4tbUP7qo
 4RS4vYNlusrgwq/ARKH95rzQ7yvYLG7UObThxGmXXX4P8=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 05/15] tracepoint: Exclude tp_stub_func from CFI checking
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If allocate_probes fails, func_remove replaces the old function
with a pointer to tp_stub_func, which is called using a mismatching
function pointer that will always trip indirect call checks with
CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
tp_stub_func to allow it to pass CFI checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 kernel/tracepoint.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..8a0d463c8507 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/tracepoint.h>
+#include <linux/cfi.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
@@ -99,10 +100,7 @@ struct tp_probes {
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
2.33.0.1079.g6e70778dc9-goog

