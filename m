Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652F03889DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbhESIxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343811AbhESIxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F3816135C;
        Wed, 19 May 2021 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621414311;
        bh=bQ4zdt635g4sFZM4c0ICU0CBur6ckO5NTfp+HGWkbcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBHen7eHiJyOGZpM9jXTJaKQSWgznPHv993d0y8Pnz4sPDc5HRlkNj3xv45W4VKTK
         mi8Xhf1XaEetmhDKk7djKskgO21KG2dR7UczwMiLu9bRq6RQ4avuEuYtTdZDWmFjWF
         9mevYgE95CmzauANKEEa7oFXz8JGngSmAdIyR7IYuFb+ZccgZsOWKdwj+eC/Oq6bW3
         eAANTT1ZzZfkI461WnxDxWQrOlWyBciazLFU/xk1JbQplnfAKijZzy9OR56TitxRpB
         bFfovMTIyG0ZNwmSEWYTdfZ5O6moL1sOXqF7h7n/IXnxT9vvTyqkiHtxLoPx/spCgo
         BUAnFWpgMD3Yg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ljHvh-007gYM-Ky; Wed, 19 May 2021 10:51:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] docs: ABI: iommu: remove duplicated definition for sysfs-kernel-iommu_groups
Date:   Wed, 19 May 2021 10:51:44 +0200
Message-Id: <ec33e8e9b8f120232ffb3b9fcc99c97b87f242e3.1621413933.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621413933.git.mchehab+huawei@kernel.org>
References: <cover.1621413933.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./scripts/get_abi.pl is reporting a duplicated definition for
/sys/kernel/iommu_groups/reserved_regions, both at the same
file:

	Warning: /sys/kernel/iommu_groups/reserved_regions is defined 2 times:  Documentation/ABI/testing/sysfs-kernel-iommu_groups:15  Documentation/ABI/testing/sysfs-kernel-iommu_groups:27

Fix it by merging those into an unified entry.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-iommu_groups | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index 0fedbb0f94e4..eae2f1c1e11e 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -25,14 +25,10 @@ Description:    /sys/kernel/iommu_groups/reserved_regions list IOVA
 		the base IOVA, the second is the end IOVA and the third
 		field describes the type of the region.
 
-What:		/sys/kernel/iommu_groups/reserved_regions
-Date: 		June 2019
-KernelVersion:  v5.3
-Contact: 	Eric Auger <eric.auger@redhat.com>
-Description:    In case an RMRR is used only by graphics or USB devices
-		it is now exposed as "direct-relaxable" instead of "direct".
-		In device assignment use case, for instance, those RMRR
-		are considered to be relaxable and safe.
+		Since kernel 5.3, in case an RMRR is used only by graphics or
+		USB devices it is now exposed as "direct-relaxable" instead
+		of "direct". In device assignment use case, for instance,
+		those RMRR are considered to be relaxable and safe.
 
 What:		/sys/kernel/iommu_groups/<grp_id>/type
 Date:		November 2020
-- 
2.31.1

