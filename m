Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6561E40D54F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhIPJBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235020AbhIPJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21A6F61214;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782802;
        bh=/gTtdkHXx1jI6ewBAwsc8ZqU2Y29Oq1glLytoFarCxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+e8bBdEhq+DtEckcct2l4N4D0R0tKnJ402A1DKu1HUTyJIqq38sYQwSu6yCOohz4
         SYikGNbd5DuL4eE3S9QnxxB2VCFG9E4UGJIj8XAxsjQizYBSZNKyfwJXy8oT7iV4aA
         VpMHq/Dlm9ica5RmVDvTulDdktCg3wXNXQLDX/hWVX3lpwA5sPqFocP9ONgK4zLBc3
         rKDzZYa1NtFHeR52Xw8NAOqOc4s5wnhc2jYYBGsV39rcTeE8Gfz7WiKKSA9V4n7ce7
         LltWwoNVRPDTu/tUP63qmBE2IVE8ujUHB0aBb8ovXBm8RzqFz8L/+cV7BackC6wN25
         dKsvAOOtqc6Yw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFQ-001qjl-Dt; Thu, 16 Sep 2021 11:00:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/30] ABI: security: fix location for evm and ima_policy
Date:   Thu, 16 Sep 2021 10:59:31 +0200
Message-Id: <b2563ac34c2e234cdd728f0c701b57ac9023c45a.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The What: definitions there are wrong, pointing to different
locations than what's expected.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/evm        | 4 ++--
 Documentation/ABI/testing/ima_policy | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index 553fd8a33e56..4b76a19b7bb4 100644
--- a/Documentation/ABI/testing/evm
+++ b/Documentation/ABI/testing/evm
@@ -1,4 +1,4 @@
-What:		security/evm
+What:		/sys/kernel/security/evm /sys/kernel/security/*/evm
 Date:		March 2011
 Contact:	Mimi Zohar <zohar@us.ibm.com>
 Description:
@@ -93,7 +93,7 @@ Description:
 		core/ima-setup) have support for loading keys at boot
 		time.
 
-What:		security/integrity/evm/evm_xattrs
+What:		/sys/kernel/security/*/evm/evm_xattrs
 Date:		April 2018
 Contact:	Matthew Garrett <mjg59@google.com>
 Description:
diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 5c2798534950..2d84063d196f 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -1,4 +1,4 @@
-What:		security/ima/policy
+What:		/sys/kernel/security/*/ima/policy
 Date:		May 2008
 Contact:	Mimi Zohar <zohar@us.ibm.com>
 Description:
-- 
2.31.1

