Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68533E711
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCQCmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:42:15 -0400
Received: from m12-11.163.com ([220.181.12.11]:49844 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhCQCl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=5HtyaNPvm/9jH6AOqG
        tgjca1ynouf0GSQNK5BW3hQd8=; b=PhhZzYGcqX0WsA114GEvpzUUvBHcOTxuN+
        r0m1XsqH4VQJXS3mWRH27v1lm+MPaEosg3s4H6pYsgzzH+lYhbfgpcrNoEUCMkFM
        H+J/DLlEQtI/pD1dLDFTjYKmJ+LSuleXCfRtDYasGh1mkd3E4rQ0I0VbAxBi2JAU
        i86IDFVNU=
Received: from COOL-20200923LL.ccdomain.com (unknown [218.94.48.178])
        by smtp7 (Coremail) with SMTP id C8CowAA3PTlIbFFgEbuzSg--.4296S2;
        Wed, 17 Mar 2021 10:41:25 +0800 (CST)
From:   Guoqing chi <chi962464zy@163.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, chiguoqing@yulong.com
Subject: [PATCH] iio:imu:mpu6050: Modify matricies to matrices
Date:   Wed, 17 Mar 2021 10:41:02 +0800
Message-Id: <20210317024102.419-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowAA3PTlIbFFgEbuzSg--.4296S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW5GF4UXryDGr4UZr4fZrb_yoWDKrX_Aw
        109rs2kr48tw1vqa4Iya17J3ykK3s3JFn2v3W5Ga1Iv345Aan8C3Wqyr4DZF4UWr1Fkry3
        W3Z5GrWfA343ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU089N3UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbBSRVYRFaD93IeNwAAs5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Chi <chiguoqing@yulong.com>

The complex number of "matrix" is "matrices".

Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
---
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

