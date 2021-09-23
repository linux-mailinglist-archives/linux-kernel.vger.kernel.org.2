Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB6415FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhIWNcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241244AbhIWNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5F5C6128B;
        Thu, 23 Sep 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632403814;
        bh=hs9wTebXbUtpLtghXzenefspd1+uQbrHJz31wpQPqxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8GthFpdk9q0rCP/99lM0cJOaBiu40Df+54pfjnrTmvBLmacK9wYo5fTI+vRtwoSX
         JVmgpbJWXnK36ErAsZWFMGrIZYVaQ/j/8RUiBMSxWjkTk7I85t7w/9dIrmXOyAOk/h
         vh/hF9JsMivy5m+zA6bdNcD1VnFTDj5IQXasdimSxk8RBD/e9RGmqJB68vOVEzzyun
         cTe8DBZEpjVmRzegBR6Z1A7yAc3BICRbRnbALTcIlWTIQZ+a4LGztGFU7lnNqlezJ9
         1nrbVramlcZg604bfeTs7gws8m0Sd7V6CxE0FsF9byiGgURNFx6dfhSVodGQzXpm/d
         teb6Utp0kba3Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTOnl-000nec-58; Thu, 23 Sep 2021 15:30:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] scripts: get_abi.pl: ensure that "others" regex will be parsed
Date:   Thu, 23 Sep 2021 15:30:11 +0200
Message-Id: <3b61e86b5b2b9cd8d4b6a118f34e007f6aa64406.1632402570.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632402570.git.mchehab+huawei@kernel.org>
References: <cover.1632402570.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way the search algorithm works is that reduces the number of regex
expressions that will be checked for a given file entry at sysfs. It
does that by looking at the devnode name. For instance, when it checks for
this file:

	/sys/bus/pci/drivers/iosf_mbi_pci/bind

The logic will seek only the "What:" expressions that end with "bind".
Currently, there are just a couple of What expressions that matches
it:

	What: /sys/bus/fsl\-mc/drivers/.*/bind
	What: /sys/bus/pci/drivers/.*/bind

It will then run an O(n²) algorithm to seek, which runs quickly
when there are few regexs to seek. There are, however, some What:
expressions that end with a wildcard. Those are harder to process.
Right now, they're all grouped together at the "others" group.

As those don't depend on the basename of the node, add an extra
loop to ensure that those will be processed at the end, if
not done yet.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index f2b5efef9c30..f25c98b1971e 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -723,6 +723,22 @@ sub check_undefined_symbols {
 		}
 		next if ($exact);
 
+		if ($leave ne "others") {
+			my @expr = @{$leaf{$leave}->{expr}};
+			for (my $i = 0; $i < @names; $i++) {
+				foreach my $re (@expr) {
+					print "$names[$i] =~ /^$re\$/\n" if ($debug && $dbg_undefined);
+					if ($names[$i] =~ $re) {
+						$exact = 1;
+						last;
+					}
+				}
+				last if ($exact);
+			}
+			last if ($exact);
+		}
+		next if ($exact);
+
 		if ($hint && (!$search_string || $found_string)) {
 			my $what = $leaf{$leave}->{what};
 			$what =~ s/\xac/\n\t/g;
-- 
2.31.1

