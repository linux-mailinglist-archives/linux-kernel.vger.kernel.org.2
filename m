Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1E41D685
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349506AbhI3Jlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235763AbhI3Jls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:41:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B22F861528;
        Thu, 30 Sep 2021 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632994805;
        bh=wOt9jZmhTVjWjdolsLlR9yYRuRFJaVnlaBXOLwXCd+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POhzjXJ/HgDLDn/ghqUQ79hWlqi378PpzsW3R/DoDMNpbqemv2gQT/IoD/OO11ITD
         U2jD7xx/5hqQ4rxy7CrZK+9wVOEl5NrNkrM1r1LtovDcDWdxj/0LZQAq4vSbGfNi+x
         O2CctveX0iITipzCiP8iwFyq9YffWcbFbBsA+QJpBJHHfx+me4BYlajd9+vjCZEJcj
         AFcKfoM6IHrJ8yB4066PDIEUUIkfYxHv54HivyTVGTXSCHDhWD74V4ZeCdkpq8KPMW
         cObRmjanxS6AHUcnGMn+WI6L5ggxpD8YrJUZVzzQ98KZVLx60OpwMSl03zHAN3BS4J
         HjG5jA+B0Hwmg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVsXr-002AEu-L6; Thu, 30 Sep 2021 11:40:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts: get_abi.pl: fix fallback rule for undefined symbols
Date:   Thu, 30 Sep 2021 11:39:59 +0200
Message-Id: <a3ba919e9a9208a5f012a13c9674c362a9d73169.1632994565.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632994565.git.mchehab+huawei@kernel.org>
References: <cover.1632994565.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rule that falls back to the long regex list is wrong:
it is just running again the same loop it did before.

change it to look at the "others" table.

That slows the processing speed, but provides a better
list of undefined symbols.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1632994565.git.mchehab+huawei@kernel.org/

 scripts/get_abi.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index d32dcd7cca5d..2f3674bb3c9e 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -746,7 +746,7 @@ sub check_file($$)
 	}
 
 	if ($leave ne "others") {
-		my @expr = @{$leaf{$leave}->{expr}};
+		my @expr = @{$leaf{"others"}->{expr}};
 		for (my $i = 0; $i < @names; $i++) {
 			foreach my $re (@expr) {
 				print STDERR "$names[$i] =~ /^$re\$/\n" if ($debug && $dbg_undefined);
-- 
2.31.1

