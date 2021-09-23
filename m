Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E99415FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbhIWNcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241188AbhIWNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2A0261107;
        Thu, 23 Sep 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632403814;
        bh=FYVJM2GwGMS5WMys6r7EKWhr4H+w6ngEGjF+61p6Uwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYFpmt176UES0I88W3A9CrfNXITMkDwcv0e5kczSBg3/2uiA4lcnV6xTzrnpc1rz9
         DqsYpGasmEuLFghb5mIJsNOowOTSFr+ZgDOAvUoLgMb6Cm9qsRLPFc3TWDA+Mo181C
         d4UN8bMydm0qQX101lZUvuEvdH+J0tQaJMu8AoerWEZM/aoEgIuPwQRL3xh06dzffH
         FIzBYlbEq7DI5DUlzYVqQP1ME7ZPtRYq5gstlxYVupgkuP8lgnyXnD95mnpWjfH1Xp
         fdc4k4aJVbZY+aIpCvs6m4VeppufS3WjMEOVpSNVh39QRxGlArkNwLNIN+RbVSeZOK
         jzh8ciZbHeczA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTOnk-000neA-Sm; Thu, 23 Sep 2021 15:30:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] scripts: get_abi.pl: Ignore fs/cgroup sysfs nodes earlier
Date:   Thu, 23 Sep 2021 15:30:04 +0200
Message-Id: <3e2f5591b350c769cdf1a896c14555f4b7b94e6a.1632402570.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632402570.git.mchehab+huawei@kernel.org>
References: <cover.1632402570.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to speedup the parser and store less data, handle
fs/cgroup exceptions a lot earlier.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 8f69acec4ae5..41a49ae31c25 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -551,6 +551,10 @@ my @files;
 my $escape_symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x29\x2b-\x2d\x3a-\x40\x7b-\xfe]) }x;
 sub parse_existing_sysfs {
 	my $file = $File::Find::name;
+
+	# Ignore cgroup and firmware
+	return if ($file =~ m#^/sys/(fs/cgroup|firmware)/#);
+
 	my $mode = (lstat($file))[2];
 	my $abs_file = abs_path($file);
 
@@ -571,9 +575,6 @@ sub parse_existing_sysfs {
 sub check_undefined_symbols {
 	foreach my $file (sort @files) {
 
-		# Ignore cgroup and firmware
-		next if ($file =~ m#^/sys/(fs/cgroup|firmware)/#);
-
 		my $defined = 0;
 		my $exact = 0;
 		my $whats = "";
-- 
2.31.1

