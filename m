Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6AC41B36E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbhI1QDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241443AbhI1QDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63AB360FE3;
        Tue, 28 Sep 2021 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632844931;
        bh=qngNMSXFSnngkap5teJiBBWtOheXF8DQC5M/s8FhoRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGtz3M1MznAoom+A41wyp/PiCE3p05c8PUaXLKV7n66kWl9iFXbrDw207kvYHx81y
         F4BLMB1RFH7DSnKF0XPws72UUDV5LYCFMMPNy3a29qqkSqrWwZgw1RqzobKg+4HWav
         6bgrIsxx8yeOwGv1ITKDtg0k1fLyeoyOk8phuAPhTrqj8NxlOmNhEvJLyqLlmt2En5
         K7p+Ya+75B0fWE7x26wHNHraGDaYBY61pLkPWEuE2gEXuTHncmQvUvzSPkl3SqbW4v
         CnL6HG2+Sbcqsukgow0W438nguZGhOwP+vYhfLgOGr8G2adXHQxqtncnuhxwyA+Bq5
         DJFwFMS/6TGiw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVFYX-000Y11-Ec; Tue, 28 Sep 2021 18:02:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ABI: sys-mce: add 3 missing files
Date:   Tue, 28 Sep 2021 18:02:03 +0200
Message-Id: <e46325fc8151eba33924483413581cb3df47bf4b.1632844726.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632844726.git.mchehab+huawei@kernel.org>
References: <cover.1632844726.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 62fdac5913f7 ("x86, mce: Add boot options for corrected errors")
added three more MCE files that are also exposed currently via
sysfs.

Document them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1632844726.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-mce | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-mce b/Documentation/ABI/testing/sysfs-mce
index d0f5095da08b..5461ca8cc5f0 100644
--- a/Documentation/ABI/testing/sysfs-mce
+++ b/Documentation/ABI/testing/sysfs-mce
@@ -105,3 +105,25 @@ Description:
 
 		Unit: us
 
+What:		/sys/devices/system/machinecheck/machinecheckX/ignore_ce
+Contact:	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+When:		Jun 2009
+Description:
+		Disables polling and CMCI for corrected errors.
+		All corrected events are not cleared and kept in bank MSRs.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/dont_log_ce
+Contact:	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+When:		Jun 2009
+Description:
+		Disables logging for corrected errors.
+		All reported corrected errors will be cleared silently.
+
+		This option will be useful if you never care about corrected
+		errors.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/cmci_disabled
+Contact:	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+When:		Jun 2009
+Description:
+		Disables the CMCI feature.
-- 
2.31.1

