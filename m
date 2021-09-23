Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB049415FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241445AbhIWNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232333AbhIWNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5DC66124F;
        Thu, 23 Sep 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632403814;
        bh=9rS4pUPSq3m5Xex2MyaSw0vSn3PD/pRn6qltbTyLvcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvb4/n7OO/x+Mf+Kzkbxn1vMfiRxRMpkMqJRIpdA22GNrY1z7lwoymqxTSCoCVxyS
         iw4dL3O9JmiF5bwFzr7DGrOzi8MgbP9S+Usq0kAlI22OBYBpLKEr7JU0psRwIJhdSP
         X1Wj3LbfW0OyqYP5Vjb3tqkZwUIUy6Xl5ggwYTFTHYnORcbzANb+NxS2q/KOJVfSVj
         cU3eLgvEnBPXb2jA2/aKVcq7JzCZ4zQgf0G6ELzsk2TqcUmmqOD3LupSjif8AGcxv3
         GhGhA4Lgq1JffVUp1AgZKx79kzjrPUsUVNhNDRHDEWSoItCQCzCjVH56JChFJShzoa
         Z8yJGZb4ZCcZg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTOnk-000ndn-NO; Thu, 23 Sep 2021 15:30:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] scripts: get_abi.pl: Better handle multiple What parameters
Date:   Thu, 23 Sep 2021 15:29:59 +0200
Message-Id: <9907e61130f9839a165d039ed434f28ec80cd031.1632402570.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632402570.git.mchehab+huawei@kernel.org>
References: <cover.1632402570.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a comma here is problematic, as some What: expressions
may already contain a comma. So, use \xac character instead.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index d7aa82094296..48077feea89c 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -129,12 +129,12 @@ sub parse_abi {
 				push @{$symbols{$content}->{file}}, " $file:" . ($ln - 1);
 
 				if ($tag =~ m/what/) {
-					$what .= ", " . $content;
+					$what .= "\xac" . $content;
 				} else {
 					if ($what) {
 						parse_error($file, $ln, "What '$what' doesn't have a description", "") if (!$data{$what}->{description});
 
-						foreach my $w(split /, /, $what) {
+						foreach my $w(split /\xac/, $what) {
 							$symbols{$w}->{xref} = $what;
 						};
 					}
@@ -239,7 +239,7 @@ sub parse_abi {
 	if ($what) {
 		parse_error($file, $ln, "What '$what' doesn't have a description", "") if (!$data{$what}->{description});
 
-		foreach my $w(split /, /,$what) {
+		foreach my $w(split /\xac/,$what) {
 			$symbols{$w}->{xref} = $what;
 		};
 	}
@@ -328,7 +328,7 @@ sub output_rest {
 
 			printf ".. _%s:\n\n", $data{$what}->{label};
 
-			my @names = split /, /,$w;
+			my @names = split /\xac/,$w;
 			my $len = 0;
 
 			foreach my $name (@names) {
@@ -492,6 +492,7 @@ sub search_symbols {
 
 		my $file = $data{$what}->{filepath};
 
+		$what =~ s/\xac/, /g;
 		my $bar = $what;
 		$bar =~ s/./-/g;
 
-- 
2.31.1

