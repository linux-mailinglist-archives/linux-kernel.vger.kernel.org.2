Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0F93889D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbhESIxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343835AbhESIxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7933B613AF;
        Wed, 19 May 2021 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621414311;
        bh=NlLcWXrsPCb7tI/gIFVfQEynar9Mia2SzKwequY2ueU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQoU5ZGEuvW/WJFlzl/H1AqcEsC+CJn/Y5FvFnponFCCdKqHNzRcE/LVnbnEtyqqg
         FE5/DfRx+V2LZrW0jPBGWQ3ieqyZyahOC6mT0CWaO0q7YvK4YP/0edcLODl3lM5Cxh
         cGT09gNfEduYBrSA/ByISUgEqjSg2tJLNIf2sm78eGTuJhIDC7gvsE9CnvsKW40EaL
         Vy4PtIofTMGxThEHORCHbdHSsRbXY0ONWQUeScFV/VUK/yScSn00++0QDdF7OTez1r
         3M5CwhNIPv2yNEI1JWWQR3IVAp/pEMseud1a0/931NqEoeTsK1dkZyxtDgvEgIicwW
         vttZemfc2aT8g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ljHvh-007gYU-O0; Wed, 19 May 2021 10:51:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] docs: ABI: sysfs-class-led-trigger-pattern: remove repeat duplication
Date:   Wed, 19 May 2021 10:51:46 +0200
Message-Id: <394580bd2e007ffb640f97212973a772ed8f0409.1621413933.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621413933.git.mchehab+huawei@kernel.org>
References: <cover.1621413933.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by scripts/get_abi.pl:

	Warning: /sys/class/leds/<led>/repeat is defined 2 times:  Documentation/ABI/testing/sysfs-class-led-driver-el15203000:0  Documentation/ABI/testing/sysfs-class-led-trigger-pattern:28

The definition for the EL15203000 is just a special case of
the sysfs led class. So, drop it and mentions the possible
exception at the class definition.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../ABI/testing/sysfs-class-led-driver-el15203000        | 9 ---------
 .../ABI/testing/sysfs-class-led-trigger-pattern          | 3 +++
 2 files changed, 3 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-el15203000

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-el15203000 b/Documentation/ABI/testing/sysfs-class-led-driver-el15203000
deleted file mode 100644
index 04f3ffdc5936..000000000000
--- a/Documentation/ABI/testing/sysfs-class-led-driver-el15203000
+++ /dev/null
@@ -1,9 +0,0 @@
-What:		/sys/class/leds/<led>/repeat
-Date:		September 2019
-KernelVersion:	5.5
-Description:
-		EL15203000 supports only indefinitely patterns,
-		so this file should always store -1.
-
-		For more info, please see:
-		Documentation/ABI/testing/sysfs-class-led-trigger-pattern
diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
index d91a07767adf..8c57d2780554 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -35,3 +35,6 @@ Description:
 
 		This file will always return the originally written repeat
 		number.
+
+		It should be noticed that some leds, like EL15203000 may
+		only support indefinitely patterns, so they always store -1.
-- 
2.31.1

