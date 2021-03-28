Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A528934BF00
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 22:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhC1UuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 16:50:18 -0400
Received: from iodev.co.uk ([46.30.189.100]:49614 "EHLO iodev.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhC1Utq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 16:49:46 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Mar 2021 16:49:45 EDT
Received: from localhost (121.130.77.188.dynamic.jazztel.es [188.77.130.121])
        by iodev.co.uk (Postfix) with ESMTPSA id 6640028187;
        Sun, 28 Mar 2021 22:40:09 +0200 (CEST)
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] checkpatch: Use python3 by default with spdxcheck.py
Date:   Sun, 28 Mar 2021 22:41:11 +0200
Message-Id: <20210328204110.12776-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to override this via the PYTHON environment variable.

Some systems still provide Python 2.x under the python name for
compatibility reasons; plus the spdxcheck.py script already specifies
python3 as it's interpreter.

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index df8b23dc1eb0..3f7516e262b3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -68,6 +68,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
 my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
+my $python = $ENV{'PYTHON'} || 'python3';
 
 sub help {
 	my ($exitcode) = @_;
@@ -1000,10 +1001,10 @@ sub is_maintained_obsolete {
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
-	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
+	return 1 if (!$tree || which($python) eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
 
 	my $root_path = abs_path($root);
-	my $status = `cd "$root_path"; echo "$license" | python scripts/spdxcheck.py -`;
+	my $status = `cd "$root_path"; echo "$license" | "$python" scripts/spdxcheck.py -`;
 	return 0 if ($status ne "");
 	return 1;
 }
-- 
2.31.0

