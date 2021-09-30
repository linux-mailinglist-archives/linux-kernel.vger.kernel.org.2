Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECAE41D682
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349487AbhI3Jlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349419AbhI3Jls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:41:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA41961278;
        Thu, 30 Sep 2021 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632994805;
        bh=1Vw8fcSkpK0woRsf4e90wZNiyBVuq6lfsSSLZttvsxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DODIksv/T6GvyDDqFGESqqh1R7Ir0hr+FKy3+OskLFDV8rhKYKaR8sEoA2uxFML+1
         QvccjfbuIGfEQplIhDhD5H+hsIO3Slj7Zz+ClF12vvhDHOSAJv+hKHwutkjAdmbDND
         8kmJJpGQlfKNushXrWc1NX2vA3GUBJ7Py1b4/QyvKzvlpxOgmEPpGNC3EUVKcGV7h2
         VGNmWVhsEXBkO71y6nf0iKyhAfOuQAY50vJCcW147NnuousmFJsxr9e/EG39baMQBB
         t3bddTBd5yiR0EoSCOiGNiRhvLmDphniSjRRWgMbp1IHDZtXxglr7E2fAG7chyA+U9
         yLhGeKTRAV/9g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVsXr-002AEz-MK; Thu, 30 Sep 2021 11:40:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts: get_abi.pl: better generate regex from what fields
Date:   Thu, 30 Sep 2021 11:40:00 +0200
Message-Id: <c69c01c12b1b30466177dcb17e45f833fb47713d.1632994565.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632994565.git.mchehab+huawei@kernel.org>
References: <cover.1632994565.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using repeating sequencies of .* seem to slow down the
processing speed on some cases. Also, currently, a "."
character is not properly handled as such.

Change the way regexes are created, in order to produce
better search expressions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1632994565.git.mchehab+huawei@kernel.org/

 scripts/get_abi.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 2f3674bb3c9e..6212f58b69c6 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -842,8 +842,8 @@ sub undefined_symbols {
 
 			# Convert what into regular expressions
 
-			$what =~ s,/\.\.\./,/*/,g;
-			$what =~ s,\*,.*,g;
+			# Escape dot characters
+			$what =~ s/\./\xf6/g;
 
 			# Temporarily change [0-9]+ type of patterns
 			$what =~ s/\[0\-9\]\+/\xff/g;
@@ -859,6 +859,8 @@ sub undefined_symbols {
 			$what =~ s/[\{\<\[]([\w_]+)(?:[,|]+([\w_]+)){1,}[\}\>\]]/($1|$2)/g;
 
 			# Handle wildcards
+			$what =~ s,\*,.*,g;
+			$what =~ s,/\xf6..,/.*,g;
 			$what =~ s/\<[^\>]+\>/.*/g;
 			$what =~ s/\{[^\}]+\}/.*/g;
 			$what =~ s/\[[^\]]+\]/.*/g;
@@ -891,6 +893,13 @@ sub undefined_symbols {
 			# Special case: IIO ABI which a parenthesis.
 			$what =~ s/sqrt(.*)/sqrt\(.*\)/;
 
+			# Simplify regexes with multiple .*
+			$what =~ s#(?:\.\*){2,}##g;
+#			$what =~ s#\.\*/\.\*#.*#g;
+
+			# Recover dot characters
+			$what =~ s/\xf6/\./g;
+
 			my $leave = get_leave($what);
 
 			my $added = 0;
-- 
2.31.1

