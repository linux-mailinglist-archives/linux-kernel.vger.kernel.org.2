Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1379C3C7E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 08:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbhGNGIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 02:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbhGNGIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 02:08:45 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569DDC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 23:05:54 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a2so1326344pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppHFClBmou+wDWa7k4twWkEoYyTiXZqWEIzN7kP4rq8=;
        b=n7LKPSA9VQeDBp6yC6XnVJ9wtVBFxCjXB2Uvlet8npCvajRFxjzD+nVkJzeYSM8ZL6
         01H1nqrIN9IKRLzZAEok09TwYBhl8Ru+nlmWmlxanHsDMmVhSeJ/sG4j97aH2WU0keua
         k+sjA2FdQUKjOTUGm/C/+jBUKLjWNsYcirHM5/VtMEl6rY7oHGhwlX0c4ksSlI9jcr8M
         KE0C/YL09JI/t17P/mXtRSHJ2rWr4qc42X+uE/4Gy1kMYC/ZjKsoQIIt/vYWesc4nsHt
         g6ourV/aAW925TYk5QT5o6fjOCeMANI2oFzHY9tw4ftOZk4QB+ronqwaBkwb2QPlF6wx
         tu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppHFClBmou+wDWa7k4twWkEoYyTiXZqWEIzN7kP4rq8=;
        b=GF2hUgXi1iwpBjyt91AkcHfMAKyheUFFP0cWlm04yFJpqRPtjthh/Yqm+H9TprGrst
         TzdAzb7nPOnxcDA+repuq9+xvbf8+/63TeiKlETltI0iE3hedF20tSpiDjRYxdzmSzqp
         pZ3Jq/xOe00ruprIFQ6m3X4ZB3fjh0+RlqzdwLhGVIB6TyKPT/9rcJZ6Jd4F/yfmzyJZ
         7VkRv7dxrbFdpc4fNfn496cboN5HAggE91JdPKYjW+oAL2lAdLkwmwcrHZ90NXTsfGWH
         f4oRUpDekQf/raiM/QjIX/k+JKlO34l1+0pmXbP4lAl8oo5sgq+R4bOFsEYZ/abD1j+N
         MwPQ==
X-Gm-Message-State: AOAM5337oDyVXvoxQM6ouBtZ6e3EVDQzypSJKxIJA9rmL/eVr1zfY2Tz
        mRvFEyci07z3bsIBV8XLViHDQJ8k9kSvpg==
X-Google-Smtp-Source: ABdhPJycmDc3QYd1LeeySaWLpuYCcc2CV0ohPc5492tTRk/feAB/gwC94/CweLT8VtbhcXD0Vxi7kA==
X-Received: by 2002:a63:794:: with SMTP id 142mr2790336pgh.344.1626242753511;
        Tue, 13 Jul 2021 23:05:53 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.109.231])
        by smtp.googlemail.com with ESMTPSA id y7sm1217066pfy.153.2021.07.13.23.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 23:05:52 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, mikelley@microsoft.com,
        Ani Sinha <ani@anisinha.ca>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] checkpatch: add a rule to check general block comment style
Date:   Wed, 14 Jul 2021 11:35:39 +0530
Message-Id: <20210714060539.2163014-1-ani@anisinha.ca>
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
+    /* foo */

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+    /*
+     * foo

WARNING: Block comments use a trailing */ on a separate line
+     * bar */

total: 0 errors, 3 warnings, 0 checks, 11 lines checked


For a non-networking related code we see the following when run against
the same file:

$ ./scripts/checkpatch.pl -f arch/x86/kernel/t.c
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
+    /* foo */

WARNING: Block comments use a leading /* on a separate line
+    /* foo

WARNING: Block comments use a leading /* on a separate line
+    /* foo

WARNING: Block comments use a trailing */ on a separate line
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

