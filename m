Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7D3A7794
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhFOHHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:07:51 -0400
Received: from m12-12.163.com ([220.181.12.12]:53684 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhFOHHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0d+6Q
        DjQqm2k4gejTiAFSIHmhOWpq1SXRcL3sEt28mY=; b=VOs0qb0aXizVzGygAMFq0
        1hTjss1KXScgJovAWv9fKbEg/7CtliFjvWnFck3Av/9DVeJev9CbM0mXmnx4FG58
        wCTF0DJ2H8yV+kM7DmXZCg5N/WlPW1sdtXtuy5qblV3AQrravzIe2K5yDEs4LfM8
        2V56XXkO7TGXVsOMtpcz4w=
Received: from localhost.localdomain (unknown [218.17.89.111])
        by smtp8 (Coremail) with SMTP id DMCowAC3uwfuTMhgxYM7KA--.10828S2;
        Tue, 15 Jun 2021 14:47:22 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tangchunyou <tangchunyou@163.icubecorp.cn>
Subject: [PATCH 2/2] drm/panfrost:report the full raw fault information instead
Date:   Tue, 15 Jun 2021 14:46:59 +0800
Message-Id: <20210615064659.775-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAC3uwfuTMhgxYM7KA--.10828S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw15XrWrZFy3Kry3Cw17Wrg_yoWfZwc_u3
        W7ZrnxXrsIyFn0kwsayan7urySvryUZw40yw1xGr9Fk3W5A3sFg3s2vrs8Zr18Ww45ZF1D
        tanFqF1Fyry7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5emh7UUUUU==
X-Originating-IP: [218.17.89.111]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiZRmyUV8ZPKaC3wABsf
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


