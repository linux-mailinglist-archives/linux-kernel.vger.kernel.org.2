Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6744415FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbhIWNcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241222AbhIWNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0A9F61278;
        Thu, 23 Sep 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632403814;
        bh=msj1HjB4sc3NrsgvWpq1oIvIRROwT8HAcjlFieJYSPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQBNG1ocba3HbisA6audvQ3c3CGkS6sar9a+6cECKnCc4DvVQN3fmdUMd5zuGVxgC
         qnvFMHwIsu5JZ+b4HOaDECAWlbcCLmukFB8VVglRC3Xyg3Y4LCWC8bIhxh3rlSLUEg
         lnxQ1KayR8ceu1z9eWpa7OFtX7MwZ/eh2X2tBewHP6GFfg1H8WW9M7W9fA5dgm15/b
         WD12TBS5H9wCWlcyHQdTX3z/X++xFQandLKpSquaDLb77E1oix1VEaT918G8q6DrMg
         4QkItnmICvH3NafrNgQCIKkxOER8VEyZktNwLSh2wwNnzs+WF+OZ+zVObx2z4Jp7be
         HSYq9QaXlDnIg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTOnl-000neM-07; Thu, 23 Sep 2021 15:30:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] scripts: get_abi.pl: Better handle leaves with wildcards
Date:   Thu, 23 Sep 2021 15:30:07 +0200
Message-Id: <79b7d3f8e57dce31e11f8a2d410877b1c803c8a8.1632402570.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632402570.git.mchehab+huawei@kernel.org>
References: <cover.1632402570.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the the leaf of a regex ends with a wildcard, the speedup
algorithm to reduce the number of regexes to seek won't work.

So, when those are found, place at the "others" exception.

That slows down the search from 0.14s to 1 minute on my
machine, but the results are a lot more consistent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index bb80303fea22..3c0063d0e05e 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -665,7 +665,7 @@ sub get_leave($)
 	# However, there are a few occurences where the leave is
 	# either a wildcard or a number. Just group such cases
 	# altogether.
-	if ($leave =~ m/^\.\*/ || $leave eq "" || $leave =~ /^\d+$/) {
+	if ($leave =~ m/\.\*/ || $leave eq "" || $leave =~ /\\d/) {
 		$leave = "others";
 	}
 
-- 
2.31.1

