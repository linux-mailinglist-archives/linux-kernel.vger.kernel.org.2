Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80C240B1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhINOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234727AbhINOrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:47:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 472A66113B;
        Tue, 14 Sep 2021 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630763;
        bh=lI1w9x4hOGt7ahglETEdAwjjs375/M+trlKJhjqNggw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Txcuju1ffTI3KgmwFFEb7P0D/rgQFRYnn+0901J6YR7W9IEL/9P31SL/hq4OsbxhW
         nwTIaY8Qtx148csOAiBXmWufxs0eti9nbv+7dfhXDoM8En+4spNhXD6Gdt2aIF6ChL
         KUh5MomTzJQEYtp8V8eLKJCyP2Q+1OvnRoXWNcuzRtCO7Vh1oE1OrGWyuQkiTEL/Vd
         qC1Sx1OIs3EMHDwB1nbjrEEvm4Ec5nBAo3o2p2dJaqaubMrT4B4FAPYW0UweSFoPXB
         D/chSZ8H9+dpkVhEPoUFIuQnjzQ3l4QxaEOhFO0Zzkp8AyS+UmKcYkgdIhRS4jWewt
         FexjUvBVwTPTw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9hB-000Kz6-AV; Tue, 14 Sep 2021 16:46:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] scripts: get_abi.pl: Better handle multiple What parameters
Date:   Tue, 14 Sep 2021 16:45:54 +0200
Message-Id: <482520587937d412d9114b0c0a35fdc6ddefd444.1631629987.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629987.git.mchehab+huawei@kernel.org>
References: <cover.1631629987.git.mchehab+huawei@kernel.org>
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
 scripts/get_abi.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index d7aa82094296..3b25d0a855ad 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -129,7 +129,7 @@ sub parse_abi {
 				push @{$symbols{$content}->{file}}, " $file:" . ($ln - 1);
 
 				if ($tag =~ m/what/) {
-					$what .= ", " . $content;
+					$what .= "\xac " . $content;
 				} else {
 					if ($what) {
 						parse_error($file, $ln, "What '$what' doesn't have a description", "") if (!$data{$what}->{description});
@@ -239,7 +239,7 @@ sub parse_abi {
 	if ($what) {
 		parse_error($file, $ln, "What '$what' doesn't have a description", "") if (!$data{$what}->{description});
 
-		foreach my $w(split /, /,$what) {
+		foreach my $w(split /\xac /,$what) {
 			$symbols{$w}->{xref} = $what;
 		};
 	}
@@ -328,7 +328,7 @@ sub output_rest {
 
 			printf ".. _%s:\n\n", $data{$what}->{label};
 
-			my @names = split /, /,$w;
+			my @names = split /\xac /,$w;
 			my $len = 0;
 
 			foreach my $name (@names) {
-- 
2.31.1

