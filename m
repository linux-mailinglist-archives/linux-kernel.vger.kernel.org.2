Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB63C7D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 06:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhGNEcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 00:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNEci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 00:32:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A4C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 21:29:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s18so1106290pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 21:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2ZQ8ujhWzVIK0zK2PTJkbjCuA2OkrMr2jEng12Bd3Q=;
        b=lvhb92fxw2ccVjrFAvZiR7umKlbAQwxFJUwU52ZZQ/5LC4RcV13w9x3/IpLCKNTlCQ
         pzw3BiUpagPMWG5nQgCGoxXdVJUDe27PrfNm1mIdZUOdXE+K6FQb10lTyvA0gBCMJIAY
         Az2bguTq6qX9yJKjQwVl9jyqkkOkHrxAOHQNXQkVNu0Qd9Dm3whOMIGyg3gXr/YrKCwM
         +Pd2gxZ3WFrbedeSDdw8nagWbhAltrs/yGtk1SOBUVOXX/HeNhhgCb2I2hRTMu/bkanF
         EBqW3YcmBgFg5BTmV8It0VuqwJqGDDBJbHqdh7A1+MrZR950VYbm++mMpYLHPpMMhrgG
         +dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2ZQ8ujhWzVIK0zK2PTJkbjCuA2OkrMr2jEng12Bd3Q=;
        b=Z2zD82JvVf46sEqmB9/crqkFBOQCuGaCjH6YOpTJ4HOG7uWEMuNJ5cjgSXDSSAHFlm
         c0b9WIkwqQ+UTgu9nzshTRbwiMczraOSOpR5hcoa6g4QLT7CZQOQiQR3/qpuuOoNfWj2
         iMeEOf6xmgzpMda85BkGaAp24BOTm7vMsrZiE+rEWaXQoFPBvB2t6f9UvLj/YGuQGsiK
         CziOPgxhVifFK/jXfDxIhhdpSnA2CnTe3ku6FYT84bx/mDdWxvTfL9GZUlBvhvdDaDCC
         uGOgm7NgvOSnkpy+SbuD5KxKWKJdzsfGSi6L3QdDH3Z2/SisNjkyutP7/3K+nR8OFuT+
         hQUw==
X-Gm-Message-State: AOAM530PxWTKDWMqInYxrXqQCqjt3zw8XsIklIPAixqMKdNbBG0IyjDv
        qC/9Gzv1r/u27NDD6zju5CszwctoD98K+A==
X-Google-Smtp-Source: ABdhPJy9j81oXr3JAiPOsuL5/LfqPNL5xtpBbvzgslN882UssSrD7cItt+IdR9UQwvnLHmwvtu6vNg==
X-Received: by 2002:a65:5684:: with SMTP id v4mr1045078pgs.388.1626236985212;
        Tue, 13 Jul 2021 21:29:45 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.109.231])
        by smtp.googlemail.com with ESMTPSA id x10sm820253pfd.175.2021.07.13.21.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 21:29:44 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, mikelley@microsoft.com,
        Ani Sinha <ani@anisinha.ca>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] checkpatch: add a rule to check general block comment style
Date:   Wed, 14 Jul 2021 09:59:14 +0530
Message-Id: <20210714042914.2159660-1-ani@anisinha.ca>
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

For one of my own patches where block comment did not start with an empty
line,
$ ./scripts/checkpatch.pl 0001-my.patch
WARNING: Block comments use a leading /* on a separate line
+	/* TSC should be marked as unstable only after Hyper-V

total: 0 errors, 1 warnings, 20 lines checked

The patch is question is posted here: https://lkml.org/lkml/2021/7/12/3527

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

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

