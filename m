Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92942C87C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhJMSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbhJMSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80194C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h185-20020a256cc2000000b005bdce4db0easo4051812ybc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d0myA17I+7bzLvfYc8WHo0j2jMBEdMbw8i8TN5wyosE=;
        b=IU3puBL85zj6Lx8k4sxk1Vw+UZ6n0eSMGWYdDv1HWpAXtehTLImiKTIqNI8ZzKWioc
         xbaEb9HE2+3N/olyHG5DVJLiXbVoy0RO2zUjcSarVnPNKEcgdKzM3cDxTPJFmh4PlC+b
         ldsZU8MjooW18ndQoHH87+8/Nuo6wlM6oH2aome4v3bBD7Edom65JnzvsVOTp8a7nAed
         Rp4Sm+0/cvPA3aDMSFrMaDfOBHSEzhGzJClJCQmvjBAtPBZ7jRWoXXyBRk8YvF9hOw7O
         oZ3k2eNIWusXbwJ8H2QpYVeDxQT4vRxeLHjR7/djcxp/tjqb4McdBXKezl/BNfwDYy2/
         wfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d0myA17I+7bzLvfYc8WHo0j2jMBEdMbw8i8TN5wyosE=;
        b=su/GwXmkNCq65lHaHOokg43jNQBnSBCgdbJIotdaESdrhq34BMVhPEnwRVUQZbSpcl
         t6rjvy6zbA6ToBmweQjhf57oYqTLVMvrTDQeNkGt0ckf5p1F8tdzGdgY5pEi3zEL4cd2
         uDVEQkrsVln18Xg/hXuZ8IZikLWOXMzWoD+Pt8uTiBqf7pzkcBlx1mvbI+c9NdJsE4n4
         aIBDFDoNkcERzC4aL3au37zV2j8uMjBKJBCvARCbIFYMFkwUU6p4yEnL/BQGdfLDLB+6
         aQej/Czl8kaDQXIQ6Mt/34OcvD3GaZrfseUwkm2o7z6x8wPqJhAWg1Xz9ektuwg+bW1k
         9SPQ==
X-Gm-Message-State: AOAM530TH7DCEz3+s1k504sPUvdYvi/T9PiJVI5SV9vdCo9vUJMuwnSj
        AgMvMV9p1JCKkNMSTTxkFyZK7zkc3Rh3Oi5JpnA=
X-Google-Smtp-Source: ABdhPJxLofLw24b6KvMkb6/9IfjRE3ce7HS8wD/+pToqpEp8bcshKcziZt+D/7ShfGQQfccqAkKGNoZFIxuIjeB6ZBA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:2456:: with SMTP id
 k83mr938311ybk.415.1634149037711; Wed, 13 Oct 2021 11:17:17 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:50 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; h=from:subject;
 bh=O+PaBODm9kG+zFsWMVfjJTxNTAynccnVKijauL7nZZs=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKZHb4In89UMhF2olHlFGx0ZeS0I2mAiB4jtqJV
 2JFSlHeJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimQAKCRBMtfaEi7xW7lC7C/
 0Sbg2PtH7Pl511XtaTsCmo5QTlsiT11zPMwNMKZFjvfs+Zwl6eRCQuD+xiyyk4trIYyM5GQb3uQlSS
 YnvMpRVXK36rC1oommRCtB/94BDa2DvfQy7i86807BVBUH79CfVaGYHXckT8OP3tqaGnOxOvzVaT3F
 +X8RB8thB49j+gL4DjOODm5pzIlh+3OH+WjaLeHgY9sKjHM2uANWABcTHnJa094vL6CBoGx449aNZ6
 +EUTS9HaqcL+t+8APLql7yjP6gR57DmzDAAskjz6gGv/64g/N3622JQ4XMV6bcgzohUIK5hIBTHUSJ
 11VyzFRULvgWkc96JEQHHf942vLVMciwgiEz9vIOlbNQC7L75gwmLoWE+pPRfmpA6NvwAjy5e8sv8y
 ACaTfL6pG86uCqQortI9EWay8zCj2FyTcZdH8dpOnRoSmGTodcqdcBmADYh2a+dWKP5YoZKhNHm0g3
 oL0rNliTUkp3ZAktvtEh3ZsFC7VZUML8ePWx6zPhnDZho=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 07/15] lkdtm: Disable UNSET_SMEP with CFI
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

Disable the UNSET_SMEP test when CONFIG_CFI_CLANG is enabled as
jumping to a call gadget would always trip CFI instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 4282b625200f..6e8677852262 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -367,7 +367,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 void lkdtm_UNSET_SMEP(void)
 {
-#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML) && !IS_ENABLED(CONFIG_CFI_CLANG)
 #define MOV_CR4_DEPTH	64
 	void (*direct_write_cr4)(unsigned long val);
 	unsigned char *insn;
-- 
2.33.0.1079.g6e70778dc9-goog

