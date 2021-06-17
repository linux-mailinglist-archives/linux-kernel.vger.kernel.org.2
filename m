Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40613AAE67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFQIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:07:22 -0400
Received: from m12-16.163.com ([220.181.12.16]:38865 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhFQIHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QFYIE
        t9Pi7GZDRA4DoHzffGVm8DJVk6OokwIXh3NOxA=; b=nt0EpLHF7BDGRXSKAinhb
        32Nd+MYZ4JD3w7VfkvsHcVdY4zEKyPwyv4llWA/hduEMS+SmoB3Luo8Gw5nR8Jj0
        1+b2yp85g8mdUlQpKbbFJhssVPqjTNcGLvNcKfXaV742ZcU+4otd1kiT03QM8G0c
        eL9EHxp0//hGORUVm4snWw=
Received: from localhost.localdomain (unknown [218.17.89.111])
        by smtp12 (Coremail) with SMTP id EMCowADnWEMJAstggjs1xw--.18915S2;
        Thu, 17 Jun 2021 16:04:32 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ChunyouTang <tangchunyou@icubecorp.cn>
Subject: [PATCH] drm/panfrost:modify 'break' to 'continue' to traverse the circulation
Date:   Thu, 17 Jun 2021 16:04:14 +0800
Message-Id: <20210617080414.1940-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADnWEMJAstggjs1xw--.18915S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy8CF15Xr1fuF1kZw43Jrb_yoWDGFX_ur
        1UXr9xur4ayr1q9a1IvF4xuryYq3y5X3yxZ3W7K343Ca4UCr13C3s2vF4UZryUCFyUAF98
        ta10vr1FyrsrtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5PpnPUUUUU==
X-Originating-IP: [218.17.89.111]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiHhG0UVSIvQhW5QAAsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChunyouTang <tangchunyou@icubecorp.cn>

The 'break' can cause 'Memory manager not clean during takedown'

It cannot use break to finish the circulation,it should use

continue to traverse the circulation.it should put every mapping

which is not NULL.

Signed-off-by: ChunyouTang <tangchunyou@icubecorp.cn>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 6003cfeb1322..52bccc1d2d42 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -281,7 +281,7 @@ static void panfrost_job_cleanup(struct kref *ref)
 	if (job->mappings) {
 		for (i = 0; i < job->bo_count; i++) {
 			if (!job->mappings[i])
-				break;
+				continue;
 
 			atomic_dec(&job->mappings[i]->obj->gpu_usecount);
 			panfrost_gem_mapping_put(job->mappings[i]);
-- 
2.25.1


