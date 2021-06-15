Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF53A76C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 07:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFOFx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 01:53:27 -0400
Received: from m12-16.163.com ([220.181.12.16]:43848 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhFOFxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 01:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0d+6Q
        DjQqm2k4gejTiAFSIHmhOWpq1SXRcL3sEt28mY=; b=Yu99bC6yZYtPa/iKCnt0K
        JgWGk3bhr6KGDH8N3Y83GP/ekHQBBUX6oomTvUqteGhWGkIqWJ31HrLTOsPWKUVo
        tubUkrw41jNeWgfEY9mv9j7A2D60vJc4IJeWQ0i5lNomFFv8lS7Tsug+ozFC/zJO
        e+Qf5brkT6ccLtQ6KpDQ+M=
Received: from localhost.localdomain (unknown [218.17.89.111])
        by smtp12 (Coremail) with SMTP id EMCowADXJjJ4P8hgdEa1xQ--.61515S2;
        Tue, 15 Jun 2021 13:49:58 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tangchunyou@icubecorp.cn,
        tangchunyou <tangchunyou@163.icubecorp.cn>
Subject: [PATCH 2/2] drm/panfrost:report the full raw fault information instead
Date:   Tue, 15 Jun 2021 13:49:31 +0800
Message-Id: <20210615054931.707-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADXJjJ4P8hgdEa1xQ--.61515S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw15XrWrZFy3Kry3Cw17Wrg_yoWfZwc_u3
        W7ZrnxXrsIyFn0kwsayan7urySvryUZw40yw1xGr9Fk3W5A3sFg3s2vrs8Zr18Ww45ZF1D
        tanFqF1Fyry7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU58R67UUUUU==
X-Originating-IP: [218.17.89.111]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiTh2xUVUDKIBvdwABsU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@163.icubecorp.cn>

of the low 8 bits.

Signed-off-by: tangchunyou <tangchunyou@163.icubecorp.cn>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 1fffb6a0b24f..d2d287bbf4e7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -33,7 +33,7 @@ static irqreturn_t panfrost_gpu_irq_handler(int irq, void *data)
 		address |= gpu_read(pfdev, GPU_FAULT_ADDRESS_LO);
 
 		dev_warn(pfdev->dev, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
-			 fault_status & 0xFF, panfrost_exception_name(pfdev, fault_status & 0xFF),
+			 fault_status, panfrost_exception_name(pfdev, fault_status & 0xFF),
 			 address);
 
 		if (state & GPU_IRQ_MULTIPLE_FAULT)
-- 
2.25.1


