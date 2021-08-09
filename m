Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465A53E414C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhHIICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhHIICq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:02:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0D2060E93;
        Mon,  9 Aug 2021 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628496130;
        bh=MVV30goOOfSt5BwOYFBNw0gw59D3pYD277pFi+TFBCg=;
        h=From:To:Cc:Subject:Date:From;
        b=jzbvk3aYuaIDwlwxC+S7/YP74FnO1+VH2sb6NjhIYU6QyxHBIaVTUxxq6mzNcHtwG
         WcuN5WtIjRPaH4ne8UYeWQxW9jOJl4OQMTIFIhuRc/DCQXHkrl0+ZMVJzrirru6Psl
         dnaKhFSyMoVizH2vcln97TsTeHgv85bOe2C7SyLLS9TOhh9bi2zmtC/KPE8y8bttxj
         O9SFnUS0nlXDKBNQH5rzriemyQ1pr6ezbnrfJ/XuBzZsZDVEmgNkdGmkifNldSxsyq
         W+6Lc2rFrVv4v/qRTMgoOQrWa4g0RobkppUsy8O57ABRTr0aPKn+jcRbfpMdlUZXrp
         YIBu+iG6uTbFQ==
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH RESEND] get_maintainer: add email addresses from dts files
Date:   Mon,  9 Aug 2021 16:02:04 +0800
Message-Id: <20210809080204.8381-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINER file will get bloated quickly if individual section entry
is created for each .dts/.dtsi file.  Add the email address from dts
files to get_maintainer output for saving unnecessary patching on
MAINTAINER file.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 2075db0c08b8..15aa8f947f4b 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -436,7 +436,7 @@ sub maintainers_in_file {
 
     return if ($file =~ m@\bMAINTAINERS$@);
 
-    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
+    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {
 	open(my $f, '<', $file)
 	    or die "$P: Can't open $file: $!\n";
 	my $text = do { local($/) ; <$f> };
-- 
2.17.1

