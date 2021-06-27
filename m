Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5D3B54A4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhF0SZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhF0SZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 14:25:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5FDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 11:23:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso9516550pjx.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TZ5mwEtkfDASxXFvo3AC+4V2zW8ikRGXe6cVUmj/aUE=;
        b=uGrFLcs5wQ7bJmHu2CG60ch/ymnVcCXH1h3xSfrRaoydNlZOF6NtxJUmO9/zlzMx0x
         RvEDkiVn6a+bxL3NiSNP9F+OyBK1gBH1DwjmpJxcy7srztt9v9uLuIc6fzJSB8wYYFTq
         VPVpY0RlSb4o4PUrjkY0BFazWCgbsfS73A60kitn6kmPU/i/537NbPo6CxqYyAZ/8wY8
         qgabmDQVqFoWGB4FFTEo51URlLcwQz9JVOKB//EpdoDAUe22pvhQSpUacN80l1q6vF+2
         QjDNpfBkXiuegC4ttyWYAPhxSGsAsj5rzG9ZqgDdD38J/JfTqyKVrUXN9JC3nAAniIgb
         N9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TZ5mwEtkfDASxXFvo3AC+4V2zW8ikRGXe6cVUmj/aUE=;
        b=dAmmMue/GES9ATXl2I5vWXPjC0AEbG7A7zaNJGBvgQI7o5iM1CQcr+ymJ2RMBBSEu5
         WIMl2OdXy156jxa+RTvI9i1SDht2jpZXPJVN4cPje+c/N+pDUWe4cBAz6/QdMyxcOuML
         nuKP29gedf1HO+lazRgKdb52jStLJbZFzY34hbH/FbGdogkf1/mjSJgOSGfEljvGqF9G
         rbOwTx2TSC4hZHs89sbp4uU/EQVY460vSnh16l/BdczlcRqbHwOW+5mb8RPA0b9MSxeH
         af5HLR6lSNwU0Xhxtu9HTC4WSGK48282lTL+CeVRwaz9kwIutE9EyB/srfaVFcfDIG+0
         tV+w==
X-Gm-Message-State: AOAM531Tw9mG1Kc+5d+oxIm54W2wFJA7EBe22dTI1AHHKP987Kgo07kV
        KCGBiq1dHekOdZ6RmTtdtEU=
X-Google-Smtp-Source: ABdhPJxd2rRtFWAQ8uc+ZNCQs/PukjfGimebJZRTEKwoY0/IxfgCscE+hSU4DAWza6zyKq6wxW6uPw==
X-Received: by 2002:a17:90a:6d97:: with SMTP id a23mr22928068pjk.76.1624818197152;
        Sun, 27 Jun 2021 11:23:17 -0700 (PDT)
Received: from localhost.localdomain ([49.37.3.74])
        by smtp.gmail.com with ESMTPSA id 69sm11988600pfz.110.2021.06.27.11.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 11:23:16 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com, apw@canonical.com
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH] checkpatch: Fix regex for do without braces
Date:   Sun, 27 Jun 2021 23:53:05 +0530
Message-Id: <20210627182305.4721-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regular expression for detecting do without braces
also passes when checkpatch encounters the "double"
keyword. This causes wrong recalculation of $stat in
checkpatch which can cause false positives.

Fix the regex to avoid the above. Also update the comments
for the check.

Reported-by: Alejandro Colomar <alx.manpages@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8d19beca3538..cba68420fd55 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5488,9 +5488,8 @@ sub process {
 			}
 		}
 
-# Check for illegal assignment in if conditional -- and check for trailing
-# statements after the conditional.
-		if ($line =~ /do\s*(?!{)/) {
+# If we have sufficient context detect and handle do without braces ({).
+		if ($line =~ /do\b\s*(?!{)/) {
 			($stat, $cond, $line_nr_next, $remain_next, $off_next) =
 				ctx_statement_block($linenr, $realcnt, 0)
 					if (!defined $stat);
@@ -5511,6 +5510,9 @@ sub process {
 								$offset} = 1;
 			}
 		}
+
+# Check for illegal assignment in if conditional -- and check for trailing
+# statements after the conditional.
 		if (!defined $suppress_whiletrailers{$linenr} &&
 		    defined($stat) && defined($cond) &&
 		    $line =~ /\b(?:if|while|for)\s*\(/ && $line !~ /^.\s*#/) {
-- 
2.28.0

