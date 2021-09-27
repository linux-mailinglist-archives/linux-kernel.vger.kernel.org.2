Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795E0419566
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhI0Nvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234587AbhI0Nvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92C2361041;
        Mon, 27 Sep 2021 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750595;
        bh=zD4KYLKbpYsa+QdN3zoc7BXcSqR3F/IXfm8tiArJ/CQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TB8Ghz8NNJyqXO/SbVTTdGbuqc655VYelCJDzALh3QgVRMO0Wdn5aJEt9Rj8MYjKH
         66MKjPIuSQcKq4/WliDtaDMyeMp0ZvSADI5Si1iUi08DuEWCnv5EHXAJiaJtYLkV0I
         JYL1D94ugRt0EKZByivf7kkk5y7p/U/fPxNZ2dKBJW9Q/dWM9KFF5LBqbCawZYd0A7
         mCsKp0hPZxnqhCF/EgckRGXtFWwMYSzWFdpDaTq+LJ+hX0kN+kw4dtxQZ33rY66nNo
         L1a1GAj4etuTbB1cGVinvfqtv1J34HVIIJWUSJQ4la/WsVfKl7vC0Z+BqOwq0k10a9
         DUvq0xNk3TQpQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUr0z-000AjY-Ki; Mon, 27 Sep 2021 15:49:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] scripts: get_abi.pl: fix parse logic for DT firmware
Date:   Mon, 27 Sep 2021 15:49:50 +0200
Message-Id: <1c806eaec96f6706db4b041bbe6a0e2519e9637e.1632750315.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750315.git.mchehab+huawei@kernel.org>
References: <cover.1632750315.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make any sense to parse ABI entries under
/sys/firmware, as those are either specified by ACPI specs
or by Documentation/devicetree.

The current logic to ignore firmware entries is incomplete,
as it ignores just the relative name of the file, and not
its absolute name. This cause errors while parsing the
symlinks.

So, rewrite the logic for it to do a better job.

Tested with both x86 and arm64 (HiKey970) systems.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1632750315.git.mchehab+huawei@kernel.org/

 scripts/get_abi.pl | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 26a3f8ff566a..d14f5cfc3138 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -635,20 +635,30 @@ my $escape_symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x29\x2b-\x2d\x3a-\x40\x7b-\x
 sub parse_existing_sysfs {
 	my $file = $File::Find::name;
 
-	# Ignore cgroup and firmware
-	return if ($file =~ m#^/sys/(fs/cgroup|firmware)/#);
-
-	# Ignore some sysfs nodes
-	return if ($file =~ m#/(sections|notes)/#);
-
-	# Would need to check at
-	# Documentation/admin-guide/kernel-parameters.txt, but this
-	# is not easily parseable.
-	return if ($file =~ m#/parameters/#);
-
 	my $mode = (lstat($file))[2];
 	my $abs_file = abs_path($file);
 
+	my @tmp;
+	push @tmp, $file;
+	push @tmp, $abs_file if ($abs_file ne $file);
+
+	foreach my $f(@tmp) {
+		# Ignore cgroup, as this is big and has zero docs under ABI
+		return if ($f =~ m#^/sys/fs/cgroup/#);
+
+		# Ignore firmware as it is documented elsewhere
+		# Either ACPI or under Documentation/devicetree/bindings/
+		return if ($f =~ m#^/sys/firmware/#);
+
+		# Ignore some sysfs nodes that aren't actually part of ABI
+		return if ($f =~ m#/sections|notes/#);
+
+		# Would need to check at
+		# Documentation/admin-guide/kernel-parameters.txt, but this
+		# is not easily parseable.
+		return if ($f =~ m#/parameters/#);
+	}
+
 	if (S_ISLNK($mode)) {
 		$aliases{$file} = $abs_file;
 		return;
-- 
2.31.1

