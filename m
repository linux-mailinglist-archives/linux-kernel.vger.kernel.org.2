Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8833B54B2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 20:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhF0Svo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 14:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhF0Svo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 14:51:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6455C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 11:49:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so8880331pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/B0ymtcimNR7SfdkvPNRS/tYCD0gKLRQgRQfe/XPmk=;
        b=P4EoSzRyJEioZVe1Gpfb78yHN60fDhkEfSk4YGJuRb6pPt4idQQyrEGqyqmeMLPOEf
         pcWKNWkvtCaghG4Yx/dP12nURmjvezzN5wHlg8Zyxuy/jeFJg/BPVEGP/C2r7NeTBubk
         22Xx5UaS/nlhfXVPPSAD4Lu8lf2G9XtnrQ/8miJnyQ0Qr+zkeNqJWP3GgvEMuqvUJ6ZX
         HcFXp1/g6NLnr3eijk3ecOyF3dw8epjud+PyStYfQdnxi3YyMYcafS6ngaEFpuPdOjgX
         weT054BLfmzxL1AGn0y3JfpwS32l0WwWNkENDoVWuDfICrDWcplaIoOCjJ5QHOdMxU6z
         mUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/B0ymtcimNR7SfdkvPNRS/tYCD0gKLRQgRQfe/XPmk=;
        b=FmAp4xWUXWV3OKwE4I/NX2Qa8sdbX092nK9KagTAW5htyGSd8wYIegFRrTd0mGdRWT
         g9mRQWiLYYC4dLaMKBn8fE5CTAbrWeMgB9us0S7L7gZhvASdx0xNlQCE+8KnLM6RTN+r
         Eub9/JnNiYHyIfDrEgGimUZ1DOVbGSvb6nAEMNcixep4kNBDM5q/uRmjHo+QtXEaXvep
         pq+VosHdw1chDxIKWljAJazbP9+NhkdKdZBmXQU1B8Jq0A96uk3+/UvFHO+TXrOTGMKw
         rA0Xa+t0fuRkRDuFWtHP41455jK9ywcBIgdZXkCpWqtqFqWEGgZ+6DeMIVU+J4q4gMHC
         92yA==
X-Gm-Message-State: AOAM531ZuInC0kq5wR6n6fQT2r0so8J6PxswUklmm2y3DxLACkNbxoCw
        fruQNsd07GsYc1qX2u2+rws=
X-Google-Smtp-Source: ABdhPJw97cx66Om7x89feuOt432t6MUO2oDleDfByZ0VBfQ4LSAHfT739STkD4Ap54OAmIiLmiRlyw==
X-Received: by 2002:a17:90a:fa8c:: with SMTP id cu12mr8438049pjb.171.1624819759142;
        Sun, 27 Jun 2021 11:49:19 -0700 (PDT)
Received: from localhost.localdomain ([49.37.3.74])
        by smtp.gmail.com with ESMTPSA id y7sm12114478pfy.153.2021.06.27.11.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 11:49:18 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com, apw@canonical.com
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH v2] checkpatch: Fix regex for do without braces
Date:   Mon, 28 Jun 2021 00:19:09 +0530
Message-Id: <20210627184909.6000-1-dwaipayanray1@gmail.com>
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

Changes in v2:
- Check word boundary on both sides of do

 scripts/checkpatch.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8d19beca3538..64036e7eff71 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5488,9 +5488,8 @@ sub process {
 			}
 		}
 
-# Check for illegal assignment in if conditional -- and check for trailing
-# statements after the conditional.
-		if ($line =~ /do\s*(?!{)/) {
+# If we have sufficient context detect and handle do without braces ({).
+		if ($line =~ /\bdo\b\s*(?!{)/) {
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

