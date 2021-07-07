Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C863BF133
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhGGVIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:08:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34236 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhGGVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:08:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 167L64BT123290;
        Wed, 7 Jul 2021 16:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625691964;
        bh=cBdek8vW38iLskZ5uj04DHrfr+HzrGMK3kExFl48NHk=;
        h=From:To:CC:Subject:Date;
        b=FVZhsIn4emD1AsiQnUpSveuG2cQ66eTt5jBT3RcuVcrasjv6QGDs+YTDLuCKLi4tF
         7aY/qLmgfd5O03U6gPnW6sAKjzUREmawwMVR/rPCw7YZYYtNe7tvO3h6+yFw5WM4jp
         6XcpJtw95FW21PQYZ+HKINJI58xnEbL0XlfabRNY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 167L63t1114961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Jul 2021 16:06:04 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 7 Jul
 2021 16:06:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 7 Jul 2021 16:06:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 167L63wR061298;
        Wed, 7 Jul 2021 16:06:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-spdx@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Bert Vermeulen <bert@biot.com>
Subject: [PATCH] scripts/spdxcheck-test.sh: Drop python2
Date:   Wed, 7 Jul 2021 16:06:00 -0500
Message-ID: <20210707210600.7266-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d0259c42abff ("spdxcheck.py: Use Python 3"), spdxcheck.py
explicitly expects to run as python3 script, there is no further point
in attempting to test with python2.

Cc: Bert Vermeulen <bert@biot.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Also see checkpatch.pl patch
https://lore.kernel.org/lkml/20210505211720.447111-1-linux@roeck-us.net/

PS: While it may be debatable if *ever* there is going to be a python4
and hence leave the for loop alone (in addition to reducing the
diffstat). I just took the path where I hope if we ever see that day,
we pick one version.

 scripts/spdxcheck-test.sh | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/scripts/spdxcheck-test.sh b/scripts/spdxcheck-test.sh
index cfea6a0d1cc0..cb76324756bd 100644
--- a/scripts/spdxcheck-test.sh
+++ b/scripts/spdxcheck-test.sh
@@ -1,12 +1,10 @@
 #!/bin/sh
 
-for PYTHON in python2 python3; do
-	# run check on a text and a binary file
-	for FILE in Makefile Documentation/logo.gif; do
-		$PYTHON scripts/spdxcheck.py $FILE
-		$PYTHON scripts/spdxcheck.py - < $FILE
-	done
-
-	# run check on complete tree to catch any other issues
-	$PYTHON scripts/spdxcheck.py > /dev/null
+# run check on a text and a binary file
+for FILE in Makefile Documentation/logo.gif; do
+	python3 scripts/spdxcheck.py $FILE
+	python3 scripts/spdxcheck.py - < $FILE
 done
+
+# run check on complete tree to catch any other issues
+python3 scripts/spdxcheck.py > /dev/null
-- 
2.32.0

