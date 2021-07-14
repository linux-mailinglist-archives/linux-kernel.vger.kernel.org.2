Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE3E3C7E93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhGNGh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 02:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbhGNGhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 02:37:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B7C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 23:34:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a127so1118293pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Zv97ObQ/Z/rhqbdjveG+GUycVqcvp6CtCQ8XYCDuC4=;
        b=Zzf3zCigJnwu0GkfVV/33GMU8rqydtDXp+OF8AkpXG8e2DKa2NWZODT1VIoqQKCfSQ
         Y+yrNZsBrvk+SOGcDull7JmRBTUmBTwlCysH496dfnm9CMe8qbnTwJwbbt6YRnQRb7xw
         7MeXybxy0NDU74dp7ObdgSDsmjnZcw5PduzUvjakfN1ZkJvFFXzMDoQLaTlxflf+vR03
         qkLr6bSZ9vy6ZSDkw9bzaln5wGnmLXSZVO9sy2b7n/uCcqzUd2LM6jIb+EgUguoEjEeX
         7yNKSxULwXbC/qUGIrXNRh+JrpiAQHgb2B5HgpoB26eN4R+/RFu0sj2IALIl6oRJ1d8l
         f4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Zv97ObQ/Z/rhqbdjveG+GUycVqcvp6CtCQ8XYCDuC4=;
        b=o1xVYsWADvO8SknRET9SZCewBgj5gVxX7A/vS1vmXOFLwXQyXkQVYM30nFYc8jlQwn
         UH5iSDRoSQogezGzKcLYWAJIrXAkpYA44HUOM8HCr0MP2crprVBeWHxej/mRIRJJTnY8
         RqQ4OmB0LAwujSLE6HU6SU4g7xU76uOk1CZBC3pdsdbCVLhIZn5p71xB6YS9zYRZeEPG
         iaHoVmredkP80aZKp9twm/bHuyRUMknnGstlup35nito9GekbEJXu7T2MAc9LCtS7HEi
         xiIJeR8rpSFHu2Ir3+AdvDGbQt40DKOIJyZKSBQKf7hTLOtCf17x89qeMgYf+KEm2NU4
         K8/Q==
X-Gm-Message-State: AOAM531D9rYknyHeENo7ICb4M/Gr/dmVaWkV80CdVtBvAnG+qAeUVV7A
        2mC6S2744r4VDNJWzwFsAuc8ILaTZ8rBCA==
X-Google-Smtp-Source: ABdhPJx1No9b9oYJteDebHS1Qapi2iTA3o8n/4bqPGnDFBwRyeSQmTJP1/kBR+iRzaU1iI7SI4XTiQ==
X-Received: by 2002:a63:381:: with SMTP id 123mr8027287pgd.395.1626244472450;
        Tue, 13 Jul 2021 23:34:32 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.109.231])
        by smtp.googlemail.com with ESMTPSA id y198sm1260590pfg.116.2021.07.13.23.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 23:34:31 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, mikelley@microsoft.com,
        Ani Sinha <ani@anisinha.ca>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3] checkpatch: add a rule to check general block comment style
Date:   Wed, 14 Jul 2021 12:04:22 +0530
Message-Id: <20210714063422.2164699-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preferred style for long (multi-line) comments is:

.. code-block:: c

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

It seems rule in checkpatch.pl is missing to ensure this for
non-networking related changes. This patch adds this rule.

Tested with
$ cat drivers/net/t.c
    /* foo */

    /*
     * foo
     */

    /* foo
     */

    /* foo
     * bar */

$ ./scripts/checkpatch.pl -f drivers/net/t.c
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
line #1: FILE: drivers/net/t.c:1:
+    /* foo */

WARNING: networking block comments don't use an empty /* line, use /* Comment...
line #4: FILE: drivers/net/t.c:4:
+    /*
+     * foo

WARNING: Block comments use a trailing */ on a separate line
line #11: FILE: drivers/net/t.c:11:
+     * bar */

total: 0 errors, 3 warnings, 0 checks, 11 lines checked


For a non-networking related code we see the following when run for
the same file:

$ ./scripts/checkpatch.pl -f arch/x86/kernel/t.c
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
line #1: FILE: arch/x86/kernel/t.c:1:
+    /* foo */

WARNING: Block comments use a leading /* on a separate line
line #7: FILE: arch/x86/kernel/t.c:7:
+    /* foo

WARNING: Block comments use a leading /* on a separate line
line #10: FILE: arch/x86/kernel/t.c:10:
+    /* foo

WARNING: Block comments use a trailing */ on a separate line
line #11: FILE: arch/x86/kernel/t.c:11:
+     * bar */

total: 0 errors, 4 warnings, 11 lines checked

In the second case, there is no warning on line 4 and in the first
case, there is no warning on line 10.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

Changelog:
v1: initial patch
v2: commit log updated to reflect the output from checkpatch.pl
    when run against the same file both in networking and
    non-networking case. This helps in comparing results apples to
    apples.
v3: line numbers got lost in the commit log as git eliminated all lines
    starting with '#'. Fixed it by prefixing with word 'line'. The work
    'line' does not however appear in the checkpatch.pl output.
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..5f047b762aa1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3833,6 +3833,14 @@ sub process {
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}
 
+# Block comments use /* on a line of its own
+		if (!($realfile =~ m@^(drivers/net/|net/)@) &&
+		    $rawline !~ m@^\+.*/\*.*\*/[ \t)}]*$@ &&	#inline /*...*/
+		    $rawline =~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-blank
+		    WARN("BLOCK_COMMENT_STYLE",
+			 "Block comments use a leading /* on a separate line\n" . $herecurr);
+		}
+
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
-- 
2.25.1

