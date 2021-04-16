Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9A362748
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbhDPR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:58:03 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:16889 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbhDPR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:58:02 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d61 with ME
        id tVxa2400P21Fzsu03VxbWS; Fri, 16 Apr 2021 19:57:36 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 16 Apr 2021 19:57:36 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] checkpatch: Improve ALLOC_ARRAY_ARGS test
Date:   Fri, 16 Apr 2021 19:57:33 +0200
Message-Id: <205fc4847972fb6779abcc8818f39c14d1b45af1.1618595794.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ variant of 'kcalloc()' and 'kmalloc_array()' are not tested
Add the corresponding check.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: use a cleaner regex as proposed by Joe Perches
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 44b9dc330ac6..23697a6b1eaa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7006,7 +7006,7 @@ sub process {
 		}
 
 # check for alloc argument mismatch
-		if ($line =~ /\b(kcalloc|kmalloc_array)\s*\(\s*sizeof\b/) {
+		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
 			WARN("ALLOC_ARRAY_ARGS",
 			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
 		}
-- 
2.27.0

