Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED668348E35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhCYKjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhCYKic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D49E561A27;
        Thu, 25 Mar 2021 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616668712;
        bh=KwApZJ8/w2jfzVZqqaL0ukDm8pZipSoobTwxn4qEIQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJCSdHy+9UxKXeOk2/OoPxU+d6t4na3ea0UkLRTbJQsHdASjpYJNY2jpQWACJw7sE
         9b0g77BMrDyMGSEOOy1nMYZkoZouwgxMyruYM5qS4MBRJ+glH5gz17FEYOIi4DsFfo
         ALDqSR3oJ/2eKSDQuy4ONGY2UsheVE13tD+QnyHoDqta2NYKU0OgaijIG11jfGajqk
         ckZfoWd9fsajcl9mWxf4S0GoGf3nVSI8VfwZJNVk85L9Fn/k0eGWPxuB4rCeZGq8fx
         jLKPrt15SRS5A2xeyJ/ku/Iw9Nd5vvdrzuWA3bAn66WS0iA3z5H5wxUymnPWAfVIKB
         JWjFSheHH4xKQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPNNl-001AvS-5R; Thu, 25 Mar 2021 11:38:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] scripts: get_abi.pl: better handle escape chars on what:
Date:   Thu, 25 Mar 2021 11:38:22 +0100
Message-Id: <29cb56def89b508fe605bcd2ba74a4376cc08e35.1616668017.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616668017.git.mchehab+huawei@kernel.org>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parser for the symbols defined on What: doesn't cover all
chars that need to be scaped, like '{' and '}'. Change the logic
to be more generic, and ensure that the same regex will be used
on both What: and when parsing the cross-references.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 92d9aa6cc4f5..a9348b9bdaa4 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -283,6 +283,7 @@ sub create_labels {
 
 # \b doesn't work well with paths. So, we need to define something else
 my $bondary = qr { (?<![\w\/\`\{])(?=[\w\/\`\{])|(?<=[\w\/\`\{])(?![\w\/\`\{]) }x;
+my $symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x2f\x3a-\x40\x7b-\xff]) }x;
 
 sub output_rest {
 	create_labels();
@@ -305,7 +306,6 @@ sub output_rest {
 		}
 
 		my $w = $what;
-		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
 
 		if ($type ne "File") {
 			my $cur_part = $what;
@@ -329,6 +329,7 @@ sub output_rest {
 			my $len = 0;
 
 			foreach my $name (@names) {
+				$name =~ s/$symbols/\\$1/g;
 				$name = "**$name**";
 				$len = length($name) if (length($name) > $len);
 			}
@@ -395,7 +396,7 @@ sub output_rest {
 					if (defined($data{$s}) && defined($data{$s}->{label})) {
 						my $xref = $s;
 
-						$xref =~ s/([\x00-\x1f\x21-\x2f\x3a-\x40\x7b-\xff])/\\$1/g;
+						$xref =~ s/$symbols/\\$1/g;
 						$xref = ":ref:`$xref <" . $data{$s}->{label} . ">`";
 
 						$desc =~ s,$bondary$s$bondary,$xref,g;
-- 
2.30.2

