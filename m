Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EDF33FCB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 02:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhCRBgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 21:36:42 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:56342 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhCRBge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:36:34 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 21:36:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=JTdaNFMFGx6KRvr+j3
        QK+7luM3mC2rPeQk33DAUYwV0=; b=eBgF386Hqk4pZxmsThydeT0MP53qrGIB0O
        UQezGoyvFcO2IIYaZV2R+rlRWLAZTB8B5d5M9eIN8z2cZz6ew6INvBIFD+1ix+U5
        W8P8Dr5bhZNOKoeDDCvBGwOu5yQnY0rI3OKr8adPaM0msW7pvqEZv54QctiZHvZF
        lpH7Kddxg=
Received: from COOL-20200923LL.ccdomain.com (unknown [218.94.48.178])
        by smtp3 (Coremail) with SMTP id G9xpCgAnE4AGq1Jgrx77aw--.11782S2;
        Thu, 18 Mar 2021 09:21:12 +0800 (CST)
From:   Guoqing chi <chi962464zy@163.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, chiguoqing@yulong.com,
        rdunlap@infradead.org
Subject: [PATCH V3] iio:imu:mpu6050: Modify matricies to matrices
Date:   Thu, 18 Mar 2021 09:21:03 +0800
Message-Id: <20210318012103.835-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: G9xpCgAnE4AGq1Jgrx77aw--.11782S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy7tw4ruw4fWFy3XFW5Jrb_yoWkAFb_Aw
        109r4Ikr40yw1vqas2ya17J3ykK3s5JFn2v3W8Ga1Sq345Aan8Ca1qyrWDZF47Wr1Fkr13
        W3Z5Gr4fA343WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0NeOPUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbBSQlZRFaD93vhDQAAso
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Chi <chiguoqing@yulong.com>

The plural of "matrix" is "matrices".

Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
V3:Adding Acked.

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

