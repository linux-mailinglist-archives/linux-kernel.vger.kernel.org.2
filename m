Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBBF45AD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhKWUt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhKWUt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:49:56 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4E2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:46:47 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mn13-20020a17090b188d00b001a64f277c1eso2017993pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UhzMC3gbpAhepjgGNXDGMQ9GMejl51H6Lr8A14dJ5WE=;
        b=A7Kq8VbNSvNKQE0EZ9WZyxUdcgsFAVwWgZbwDSqpOLFFET3/Q7BZ8cLiG1wFxadg0W
         ueej/38HwlGhbYGNBTuoLGi+5DGb+YanH6H1YXuou3OyfA9mTyRzK+K1K6h4Gi3IZqpA
         ZOheDpT/zyvOzIo2gKXo93/nPLpWB36WqBFqDuyAMzQUmwpqF4ZmurQ70oZ6eLpnSAJ7
         9Nkt9vmaedplWbz7IrDOJuNXT41bmk506mhzG3Pmx0f5myqN/MOTL2BslJ1pNY/1yEo1
         QC6pGUME+FRUx9iBDGFDPED7FdvUaOAgricu807+2Tn/kcaJYMk0qbfPyhISJVQiwfm7
         yfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UhzMC3gbpAhepjgGNXDGMQ9GMejl51H6Lr8A14dJ5WE=;
        b=TyiSElDIg0hjUqWbb559H4agJgApLQ68NuZKxajovbknZNKjxzVKtn+fNhaVPWn7ok
         h8ECpzyj76wnhM4lLyEKW5L9NoJzzrPgeCUa316NrbjjCY7/gHXzthTVNoR9scSP5qZD
         Ec3xzlONOSBZhZ+strby+eQPRsDh9KoohkhOjZLEe49rGrB0r0vs7tvaSdb6EL7g0Ds5
         u7zVwYLT9FNmiFASQEXKLdSlMfPltrM3l9dDoeIo5U0OpEwj0aOAx8uvpkuVF2VxAqIN
         v+XMr7dgYjdhqJOxfnDOOJETdxChgAz7jsuYQTpybzSjPw61Os6Qeo5nDWWpiPq0eHtU
         +7dg==
X-Gm-Message-State: AOAM530bNmr3bqT1EoVCW9Cy8j8uF0qR3Juu9AkkNUlH1HSmfkz6dwYR
        4M280Ao4mqKUB8h7Z3BUivpZuXTO4T66JwVo
X-Google-Smtp-Source: ABdhPJzB5qfoeMNXtsmN+t/EQtIL+awdoz0JM1gizNNZ15PIzzNjopwIwclnBVASYK+9+0A9FmUuHSa007j3Z+GI
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP
 id u7-20020a170903124700b00143b9b952a2mr10645431plh.35.1637700407314; Tue, 23
 Nov 2021 12:46:47 -0800 (PST)
Date:   Tue, 23 Nov 2021 20:46:44 +0000
Message-Id: <20211123204644.3458700-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] mm, hugepages: fix size in hugetlb mremap() test
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mina Almasry <almasrymina@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugetlb vma mremap() test mentions in the header comment that it
uses 10MB worth of huge pages, when it actually uses 1GB. This causes
the test to fail on devices with smaller memories.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/vm/hugepage-mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index 257df94697a5..551e68f97926 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -18,7 +18,7 @@
 #include <linux/userfaultfd.h>
 #include <sys/ioctl.h>
 
-#define LENGTH (1UL * 1024 * 1024 * 1024)
+#define LENGTH (10UL * 1024 * 1024)
 
 #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
 #define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
-- 
2.34.0.rc2.393.gf8c9666880-goog

