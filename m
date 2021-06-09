Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6153A0CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhFIG60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:58:26 -0400
Received: from m12-17.163.com ([220.181.12.17]:53543 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232343AbhFIG6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lz3f5
        lhTyLWKMHP6nN8VbvMc9dljqYvQNmIhgg+abnw=; b=FtX6GBE5Jx5z6ASKgHe/I
        VultAa2jRaFdlEqf/57gjWkCI+aa3c/SpdMpGTuY/LcNgV76xjdDxJJhPbpPGMQ/
        CYUYpfZqZu9mi/xSRZ3eWqLv6VEuYFz8fX8mj87Vlf9NRXouAOPw8spOrfgEVLcw
        eDE+kmiabWFVwCwK/nGmWY=
Received: from localhost.localdomain (unknown [218.17.89.111])
        by smtp13 (Coremail) with SMTP id EcCowAAH2mHTZcBgbt9b6Q--.23240S2;
        Wed, 09 Jun 2021 14:55:20 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, tangchunyou@icubecorp.cn,
        tangchunyou <tangchunyou@163.icubecorp.cn>
Subject: [PATCH] modified: gpu/drm/panfrost/panfrost_job.c
Date:   Wed,  9 Jun 2021 14:55:04 +0800
Message-Id: <20210609065504.2194-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAAH2mHTZcBgbt9b6Q--.23240S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy8CF15XryxWr4rGFW5Awb_yoWftFX_ur
        1UXr9xWr4ayF1q9a1Iva1xur1Yq3y5Z3yxZw17K343Ca47Cr9Fk3s2vF4DZF18CryUAF98
        ta10vr1FyrsrJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnWGQDUUUUU==
X-Originating-IP: [218.17.89.111]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/xtbBRR+sUVPAMVLzgwAAsn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@163.icubecorp.cn>

The 'break' can cause 'Memory manager not clean during takedown'
It cannot use break to finish the circulation,it should use
continue to traverse the circulation.

Signed-off-by: tangchunyou <tangchunyou@163.icubecorp.cn>
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


