Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D3C4192DC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhI0LMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233897AbhI0LMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DB2060F91;
        Mon, 27 Sep 2021 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632741062;
        bh=oMBrSxV/CfHXQt045aNo2OUaH1flC9Yc+6oSQbMxeAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIYp+LMMRols8opsCWjo79iFZvlKvRsm7+JsaTmC0dXzcCVyYSoUKRu0XMD5CgsaS
         GT6bynKop7MUpt0PYiiCJmKo6rKZ6PLKoazYLCfnsrAx639vYWrUV13CCgv9dVgiau
         ZUMaoySIDXuTF7kmrA/VOrL/jAg2E/+GyCkxJsmK1HqEAer4l3UzAWSM51WLT1rnrL
         Soqhm7D8QHaXItb87+a4zCtSqzwGtbI7oF3zukGs6exgkzR81bwAz48d5C8o1hQchS
         it/hbaVfk34CNNKJjjIKHV+DCOxP877ekloRUbttnSsWLV0Yhv7hufK9NCI/bbvFnq
         VK9Y2fdjJbnrA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUoXE-0005yT-Gd; Mon, 27 Sep 2021 13:11:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] ABI: sysfs-devices-removable: make a table valid as ReST markup
Date:   Mon, 27 Sep 2021 13:10:55 +0200
Message-Id: <bf83354747b8abaa486fe03af4be2826363469cb.1632740376.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632740376.git.mchehab+huawei@kernel.org>
References: <cover.1632740376.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 70f400d4d957 ("driver core: Move the "removable" attribute from USB to core")
added a table to the file, but not using a valid ReST format.

Change it to avoid build issues when producing documentation with
"make htmldocs".

Fixes: 70f400d4d957 ("driver core: Move the "removable" attribute from USB to core")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/7] at: https://lore.kernel.org/all/cover.1632740376.git.mchehab+huawei@kernel.org/T/#t

 Documentation/ABI/testing/sysfs-devices-removable | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
index bda6c320c8d3..754ecb4587ca 100644
--- a/Documentation/ABI/testing/sysfs-devices-removable
+++ b/Documentation/ABI/testing/sysfs-devices-removable
@@ -7,10 +7,12 @@ Description:
 		bus / platform-specific way. This attribute is only present for
 		devices that can support determining such information:
 
-		"removable": device can be removed from the platform by the user
-		"fixed":     device is fixed to the platform / cannot be removed
+		===========  ===================================================
+		"removable"  device can be removed from the platform by the user
+		"fixed"      device is fixed to the platform / cannot be removed
 			     by the user.
-		"unknown":   The information is unavailable / cannot be deduced.
+		"unknown"    The information is unavailable / cannot be deduced.
+		===========  ===================================================
 
 		Currently this is only supported by USB (which infers the
 		information from a combination of hub descriptor bits and
-- 
2.31.1

