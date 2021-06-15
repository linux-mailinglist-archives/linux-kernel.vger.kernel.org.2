Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC43A7778
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFOHC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:02:27 -0400
Received: from m12-13.163.com ([220.181.12.13]:46556 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhFOHCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0d+6Q
        DjQqm2k4gejTiAFSIHmhOWpq1SXRcL3sEt28mY=; b=SpIBUvU/4WSAc5AD0CZg+
        a/n83z3nMPeZYqrW2YTqLZdpPmU0CGldrfLxB+2wzJIrc5R2QDXNbKE8wcwM1PAy
        4icsvKKjHCzbexKWWNYlodCMzYcaePw3686eHZ69zwdDGQo8doroWRpr6OUnY3QL
        W/147Ap8qJAmJbUEPMeWOw=
Received: from localhost.localdomain (unknown [218.17.89.111])
        by smtp9 (Coremail) with SMTP id DcCowAAXK6ziT8hgk2j+GQ--.4532S2;
        Tue, 15 Jun 2021 14:59:52 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tangchunyou <tangchunyou@163.icubecorp.cn>
Subject: [PATCH 2/2] drm/panfrost:report the full raw fault information instead
Date:   Tue, 15 Jun 2021 14:59:36 +0800
Message-Id: <20210615065936.897-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAXK6ziT8hgk2j+GQ--.4532S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw15XrWrZFy3Kry3Cw17Wrg_yoWfZwc_u3
        W7ZrnxXrsIyFn0kwsayan7urySvryUZw40yw1xGr9Fk3W5A3sFg3s2vrs8Zr18Ww45ZF1D
        tanFqF1Fyry7KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5QzV5UUUUU==
X-Originating-IP: [218.17.89.111]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiHgiyUVSIvNiP8gAAsw
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


