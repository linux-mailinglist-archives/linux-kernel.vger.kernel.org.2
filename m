Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1275D356A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351541AbhDGKvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:51:20 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:47211 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbhDGKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:51:12 -0400
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d41 with ME
        id pmqm240083PnFJp03mqzJ4; Wed, 07 Apr 2021 12:51:01 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 07 Apr 2021 12:51:01 +0200
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RESEND PATCH v1] checkpatch: exclude four preprocessor sub-expressions from MACRO_ARG_REUSE
Date:   Wed,  7 Apr 2021 19:50:42 +0900
Message-Id: <20210407105042.25380-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__must_be_array, offsetof, sizeof_field and __stringify are all
preprocessor macros and do not evaluate their arguments. As such, it
is safe not to warn when arguments are being reused in those four
sub-expressions.

Exclude those so that they can pass checkpatch.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index df8b23dc1eb0..25ee4fd5b118 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5736,7 +5736,7 @@ sub process {
 			        next if ($arg =~ /\.\.\./);
 			        next if ($arg =~ /^type$/i);
 				my $tmp_stmt = $define_stmt;
-				$tmp_stmt =~ s/\b(sizeof|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
+				$tmp_stmt =~ s/\b(__must_be_array|offsetof|sizeof|sizeof_field|__stringify|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
 				$tmp_stmt =~ s/\#+\s*$arg\b//g;
 				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
 				my $use_cnt = () = $tmp_stmt =~ /\b$arg\b/g;
-- 
2.26.2

