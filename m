Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE31E3EB301
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhHMIzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:55:16 -0400
Received: from smtpbg703.qq.com ([203.205.195.89]:59088 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239291AbhHMIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:55:15 -0400
X-QQ-mid: bizesmtp33t1628844876tafoo5ml
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 13 Aug 2021 16:54:35 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: nNpKvUcGwyjmNbUJ032IhxCMQOvkHqQz0wNxgj0c/GfvsTd0Rb4+LyrYZFTkR
        QF/YhqG0dTQDXAo1sOK8GbpZU+H+qmNvhm2yl7oP12+1QMs/MRojc6XVm/E6BpIOHDnNICq
        L5++Sk2yRLHHfBYHm7Ahp747iHft4EMr80DNv6tmnfbx3QAkAQzcnes40Vq3AAxs1MNq2Cn
        3lD405IMyFUmJ1PpbTBVplyllX1DKefHaVJZr2ctR3M7s3nxNjEsLUUOyg6CqzEY3jJhs5Q
        d2AEK/sDL8EN8aUJcxAxucnIcZkGsFQFOneltgGSccCNcnspuYPorJdbVU0Kypnho09oOAX
        LF5I5aYW/DzvW+NLg/zEQIQv3qScA==
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     airlied@linux.ie
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] drm: radeon: r600_dma: Replace cpu_to_le32() by lower_32_bits()
Date:   Fri, 13 Aug 2021 16:54:34 +0800
Message-Id: <20210813085434.3890-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sparse errors:
drivers/gpu/drm/radeon/r600_dma.c:247:30: warning: incorrect type in assignment (different base types)
drivers/gpu/drm/radeon/r600_dma.c:247:30:    expected unsigned int volatile [usertype]
drivers/gpu/drm/radeon/r600_dma.c:247:30:    got restricted __le32 [usertype]

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/gpu/drm/radeon/r600_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r600_dma.c b/drivers/gpu/drm/radeon/r600_dma.c
index fb65e6fb5c4f..a2d0b1edcd22 100644
--- a/drivers/gpu/drm/radeon/r600_dma.c
+++ b/drivers/gpu/drm/radeon/r600_dma.c
@@ -244,7 +244,7 @@ int r600_dma_ring_test(struct radeon_device *rdev,
 	gpu_addr = rdev->wb.gpu_addr + index;
 
 	tmp = 0xCAFEDEAD;
-	rdev->wb.wb[index/4] = cpu_to_le32(tmp);
+	rdev->wb.wb[index/4] = lower_32_bits(tmp);
 
 	r = radeon_ring_lock(rdev, ring, 4);
 	if (r) {
-- 
2.20.1



