Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE2394B15
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhE2ISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhE2ISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 04:18:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBEFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x18so5002562pfi.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fex-emu.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8so5JgsWBpl7r6OCPXx44TGNibG9hAFt0VH6FSUTak=;
        b=RPgwtKT7YgranCz1O7JfEayBmawWEdAosfDr5dg2UCXM3mHcGZb/evMDTHslbZj6Jx
         TQ9Bd7nlxrpVuRBG4qkk0B0KitmGsti/B8b5XuTmzHaSVXkpAhi0N9X8vZHaJUVINoD6
         5frSdimeaWQECknMTqHgRUY4i9BSLI2qzBlemI/2LFMsDAIAlcZqk5cOLpWMbbVpyWqo
         U84ko2HU9TiRmzmGvnzhhCrp+/5EmqQaYkgyXI81bh4agtZVfW/cCnP0pSmsfknmH1qI
         6slyTbdND3xbWKMW56tZjuQLYFf5wEdfLhfSgwh53Lxo43V+5hpWuK9HGucYxiiCnN0b
         838g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8so5JgsWBpl7r6OCPXx44TGNibG9hAFt0VH6FSUTak=;
        b=CmsVXu5WrwO171236Lb/+INicJMQm0yPnukhJXns9ofOMQvtJu3IdHVe0PMkce2i3H
         UmSO57IMPpSO5frwobtU5rPvmGtXlptUZx2KDG7PQ1LDlMFRfvVj7FFAHFL5Oy9P1XwP
         ckKXaPU0eddB8lkugmZrmxewSl9gvlzHwLeFTrb+wJK97IindwHBYlm+y7V/rUY+O8yh
         Vlditf+VSujXB1BxaVgw2qpPvEtlzRjXJahFm0IlJ83l1W+TILVCopzh2oraGQ222x5/
         ttcrF8egmh0Qzx6eCfqxSHtlPE+5xcjrovsatfPzeFjTEM4jr/UNBfUcXf3atigk5rq0
         jcKg==
X-Gm-Message-State: AOAM532d0CVOcW/6SypEdin9SxqJ0D4w/bUcmL07E8Tgl5TGmWoezBj+
        D/HS4Hi0YjWyAHgj8DpmZakxUA==
X-Google-Smtp-Source: ABdhPJzn+MX6kRCVqpnQVq4mBAvNxH51Xual9OywVkFMp37IMBUO31aOH8woriYCPQIB2DHSyUNlBQ==
X-Received: by 2002:aa7:84c7:0:b029:2e9:2d18:54a5 with SMTP id x7-20020aa784c70000b02902e92d1854a5mr7637289pfn.44.1622276214755;
        Sat, 29 May 2021 01:16:54 -0700 (PDT)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id b12sm6613960pgs.52.2021.05.29.01.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 01:16:54 -0700 (PDT)
From:   houdek.ryan@fex-emu.org
X-Google-Original-From: Houdek.Ryan@fex-emu.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>
Subject: [PATCH 4/4] arm64: tools: Update syscall user dispatch tests
Date:   Sat, 29 May 2021 01:16:20 -0700
Message-Id: <20210529081620.164422-5-Houdek.Ryan@fex-emu.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
References: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Houdek <Houdek.Ryan@fex-emu.org>

This is a fairly trivial change to support syscall user dispatch in
these selftests.

One of the tests is relying on the syscall to return the syscall number
in the return. Which is a byproduct from the scnum and return registers
being the same.
Since arm64 places the scnum in x8 and the return in x0 it just needs to
move the result over.

Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 .../selftests/syscall_user_dispatch/sud_benchmark.c      | 2 +-
 tools/testing/selftests/syscall_user_dispatch/sud_test.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
index 073a03702ff5..6059abe75cb3 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -41,7 +41,7 @@
  * out of the box, but don't enable them until they support syscall user
  * dispatch.
  */
-#if defined(__x86_64__) || defined(__i386__)
+#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
 #define TEST_BLOCKED_RETURN
 #endif
 
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b5d592d4099e..11cf4ad6aa6e 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -150,6 +150,15 @@ int si_errno;
 
 static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 {
+#ifdef __aarch64__
+	/* This test expects the syscall number will be returned in r0
+	 * Copy it over from r8 which is the scnum in the ABI
+	 */
+	ucontext_t *_context = (ucontext_t *)ucontext;
+
+	_context->uc_mcontext.regs[0] = _context->uc_mcontext.regs[8];
+#endif
+
 	si_code = info->si_code;
 	si_errno = info->si_errno;
 
-- 
2.30.2

