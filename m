Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3CC347EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbhCXRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237423AbhCXRGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:06:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C403761A12;
        Wed, 24 Mar 2021 17:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616605575;
        bh=oqcoW7HJoAJLTDB2YUjslPy5+kOwlx9R+KaUb3Lwuww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDIaQPSTBzgmWF83nGoWBqVa4N/0K+y/SRUV8buuQ7DnbBgn6S3Ut0+4ZbYdbY0co
         krpTq2qzvIC5x7Iht3PmHuIrJruptLK6H3wc/RbgDhrXKNus7bW7VoX9++61ESasVS
         QNvG0nXgyiUnHa/gYj2Gh4uAqQ18ARUY89LqaYGtEl/lxdXLw4ufjgrLyz5a6UhWMG
         voAKHDcsPxGBVfmN6Tlwv/k+v3fX1vhP3wG20zBioGbfRCyrdG5lWcV7WZce2KzOdW
         lyFtId5iIORtvCHZidn+UZbv1j9I3pVYPlUCU7Z4S7lotQPowODebKdfHFNrhzII7J
         xYIUXsgNxKFpQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lP6xP-0011O1-Ei; Wed, 24 Mar 2021 18:06:11 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Finn Behrens <me@kloenk.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] script: get_abi.pl: escape "<" and ">" characters
Date:   Wed, 24 Mar 2021 18:06:09 +0100
Message-Id: <e02449ee86d89cd45313627b52500a6892ea37ae.1616605512.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317142238.228fb1e8@coco.lan>
References: <20210317142238.228fb1e8@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging the akpm-current tree, today's linux-next build (htmldocs)
produced this warning:

	Documentation/ABI/testing/sysfs-kernel-mm-cma:2: WARNING: Inline interpreted text or phrase reference start-string without end-string.

Introduced by commit 439d477342a3 ("mm: cma: support sysfs")

As pointed by Jonathan, the problem is this text in
sysfs-kernel-mm-cma:

	Each CMA heap subdirectory (that is, each
	/sys/kernel/mm/cma/<cma-heap-name> directory) contains the
	following items:

Is not parsed well, becase the major/minor signs need to be
escaped, when converted into cross-references.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 92d9aa6cc4f5..79d195b48652 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -305,7 +305,7 @@ sub output_rest {
 		}
 
 		my $w = $what;
-		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
+		$w =~ s/([\(\)\_\-\*\=\^\~\\\<\>])/\\$1/g;
 
 		if ($type ne "File") {
 			my $cur_part = $what;
-- 
2.30.2

