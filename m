Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9468D33EA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCQHGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:06:15 -0400
Received: from m12-13.163.com ([220.181.12.13]:53371 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhCQHGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=BsnDQRQbFMwwF7cEx0
        327jzQBYlVPRRMuaFhV+cYzQo=; b=ANyX8wIN+TQSFKTP47QI1vlXxVXECEs76o
        +5RYrKIrjyDwmX0s5/o3Af99DFDefohg0tCYbpG7CeevNnUAFfdzoq6Hesk+eNtq
        S7/Hidzw4k+diFszU0tAwWC1asH468F09ZmeZjao28+UJC6H09F24Z2Cy5MoosOk
        SoU5gUGmk=
Received: from COOL-20200923LL.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowAAnBI15n1FgM8udBg--.13183S2;
        Wed, 17 Mar 2021 14:19:42 +0800 (CST)
From:   Guoqing chi <chi962464zy@163.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, chiguoqing@yulong.com
Subject: [PATCH V2] iio:imu:mpu6050: Modify matricies to matrices
Date:   Wed, 17 Mar 2021 14:19:30 +0800
Message-Id: <20210317061930.478-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowAAnBI15n1FgM8udBg--.13183S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy7tw4ruw4fXrWDKF4UArb_yoWkXrg_A3
        W09r4vkr40yw1vqa92ya17J3yDKas5JFn2v3WUGa1Iv343Aan8C3Wqyr4DZF4UWr1YkF13
        W3Z5GrWSyw13ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8NAw7UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbBiB5YRFaD+Q5JuAAAsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Chi <chiguoqing@yulong.com>

The plural of "matrix" is "matrices".

Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
---
V2:fix "complex number of" to "plural of".

 include/linux/platform_data/invensense_mpu6050.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/invensense_mpu6050.h b/include/linux/platform_data/invensense_mpu6050.h
index 93974f4cfba1..f05b37521f67 100644
--- a/include/linux/platform_data/invensense_mpu6050.h
+++ b/include/linux/platform_data/invensense_mpu6050.h
@@ -12,7 +12,7 @@
  *			mounting matrix retrieved from device-tree)
  *
  * Contains platform specific information on how to configure the MPU6050 to
- * work on this platform.  The orientation matricies are 3x3 rotation matricies
+ * work on this platform.  The orientation matrices are 3x3 rotation matrices
  * that are applied to the data to rotate from the mounting orientation to the
  * platform orientation.  The values must be one of 0, 1, or -1 and each row and
  * column should have exactly 1 non-zero value.
-- 
2.17.1


