Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8D93624C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhDPP7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:59:30 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:56420 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbhDPP72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:59:28 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d18 with ME
        id tTyz2400G21Fzsu03Tyz5Q; Fri, 16 Apr 2021 17:59:00 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 16 Apr 2021 17:59:00 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] checkpatch: Improve ALLOC_ARRAY_ARGS test
Date:   Fri, 16 Apr 2021 17:58:57 +0200
Message-Id: <a1ac975aaabc9f71397b75254f833920428411e0.1618588673.git.christophe.jaillet@wanadoo.fr>
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
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 44b9dc330ac6..c778edfdbad7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7006,9 +7006,9 @@ sub process {
 		}
 
 # check for alloc argument mismatch
-		if ($line =~ /\b(kcalloc|kmalloc_array)\s*\(\s*sizeof\b/) {
+		if ($line =~ /\b(devm_|)(kcalloc|kmalloc_array)\s*\(\s*sizeof\b/) {
 			WARN("ALLOC_ARRAY_ARGS",
-			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
+			     "$1$2 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
 		}
 
 # check for multiple semicolons
-- 
2.27.0

