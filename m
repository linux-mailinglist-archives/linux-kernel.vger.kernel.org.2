Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC3C41625F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbhIWPth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242096AbhIWPnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:43:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85918611B0;
        Thu, 23 Sep 2021 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632411693;
        bh=Iw2fDEKzMDejp/o4wtP5bv8wvrqWKI39WK/zq08eWqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iM32OscLv+jTz+UgdY5MhKcr2CE2aN1dorUJAeeUuMjKgK7ek2DaKAyAPdN1sKSY5
         2vqpN2B547PfD3lRkYt105YJaNzlOodv9OzSuY4z7mNP5yTxiXsquwZ7Vm6eZmreWG
         zyERNa9E+Z4jT539RFr8QeA9M/g4DNart9K2Mu4wWrfMuedY1hu5906kQ42eA5TnTy
         tmwtg/8M+OcK13odO+zvsWnouab2aEw/lzT6/Bjqk9uFq+W0KtUVUIo/yju8lWHmsg
         lHJYFWOFOzcRJkH/XRHaAN86obQ/JMkBPqMEDsh67A2mb+iyhvewNedg8WzqSQ3UJL
         RBCSpY3f4WZ/w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTQqp-000p6S-Rj; Thu, 23 Sep 2021 17:41:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     #@kernel.org, YUyICHTRdfL8Ul7X@kroah.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] scripts: get_abi.pl: stop check loop earlier when regex is found
Date:   Thu, 23 Sep 2021 17:41:17 +0200
Message-Id: <2ba722d2cdbe7c7d0f1d1b58d350052576d1d703.1632411447.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632411447.git.mchehab+huawei@kernel.org>
References: <cover.1632411447.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, there are two loops used to seek for a regex. Make
sure that both will be skip when a match is found.

While here, drop the unused $defined variable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 42eb16eb78e9..d45e5ba56f9c 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -685,7 +685,6 @@ sub check_undefined_symbols {
 		my @names = @{$$file_ref{"__name"}};
 		my $file = $names[0];
 
-		my $defined = 0;
 		my $exact = 0;
 		my $found_string;
 
@@ -711,13 +710,11 @@ sub check_undefined_symbols {
 					last;
 				}
 			}
+			last if ($exact);
 		}
-
-		$defined++;
-
 		next if ($exact);
 
-		if ($hint && $defined && (!$search_string || $found_string)) {
+		if ($hint && (!$search_string || $found_string)) {
 			$what =~ s/\xac/\n\t/g;
 			if ($leave ne "others") {
 				print "    more likely regexes:\n\t$what\n";
-- 
2.31.1

