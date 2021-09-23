Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D788B416261
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbhIWPuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242102AbhIWPnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:43:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FA6961263;
        Thu, 23 Sep 2021 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632411693;
        bh=hs9wTebXbUtpLtghXzenefspd1+uQbrHJz31wpQPqxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nt5gFmqWBGRYAA7xQLrb2X2AmLWusUxOAbWWT4E5Xk1ALAzDcwDZL8f5do4lgKf/D
         XbupbWRIQFbymRdaDUtxD8lsI2X63xzdzeX0aV1kAOAxzfJ44LdKblEa0BniPdXFOF
         AIMz+8HHdYnOf8l51PbV0hEgxn2A+SxrTqHun3T1zRDiG5a+iXCyhvSjghRmCju2Vr
         RpkxjVFNxT6vxZ+fhcw/zugf88HObJRRH3egjaTyBT3QSIrOgsal5WnQ4Qz5DgIDwy
         IdymS/9nZsXBLl3WkbCom0G8gpDy/YJNJ69et+hg4vxTs0ZqErzlNrVqRpb/j+a1fj
         1nZhJzJ4Du1/Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTQqp-000p6a-Uo; Thu, 23 Sep 2021 17:41:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     #@kernel.org, YUyICHTRdfL8Ul7X@kroah.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] scripts: get_abi.pl: ensure that "others" regex will be parsed
Date:   Thu, 23 Sep 2021 17:41:19 +0200
Message-Id: <9fe7ab46f67575def5db9e83034e9fab43846d84.1632411447.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632411447.git.mchehab+huawei@kernel.org>
References: <cover.1632411447.git.mchehab+huawei@kernel.org>
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

