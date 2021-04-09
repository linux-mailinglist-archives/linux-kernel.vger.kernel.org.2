Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD17635911B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 03:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhDIBCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 21:02:07 -0400
Received: from m15113.mail.126.com ([220.181.15.113]:49228 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhDIBCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=fHB/+dK6Mq9Z5oA7Lj
        LWEposRFG9O6Ln3UZNEI50HN8=; b=F1ZvPebr1a47K3BmCsHrDgc/ilqPNyfTva
        HQTvHC5nBe1UNhMHvroG4X362sGBLURh9yWWM0tuykefmPZJg8x9H312SzBxwCYZ
        cOuZ0Ov8ImN/IaQAb0NecXgBvEC5wc9Koa21/9DQ0LnE+Xl+q4z5cTDE7MxsthLL
        IUABXFIKI=
Received: from localhost.localdomain (unknown [106.19.194.64])
        by smtp3 (Coremail) with SMTP id DcmowAAnL+tzpm9gcYu_QA--.50335S2;
        Fri, 09 Apr 2021 08:57:25 +0800 (CST)
From:   wangyingjie55@126.com
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, mikita.lipski@amd.com,
        eryk.brol@amd.com, aurabindo.pillai@amd.com, Wayne.Lin@amd.com,
        luben.tuikov@amd.com
Cc:     wangyingjie55@126.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/amd/dc: Fix a missing check bug in dm_dp_mst_detect()
Date:   Thu,  8 Apr 2021 17:57:20 -0700
Message-Id: <1617929840-13269-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcmowAAnL+tzpm9gcYu_QA--.50335S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xry8AryxKFWfZryUWw45KFg_yoW8JF1Up3
        yUtrZrXr1kZa12934DAF1ruFZ0ya4kXFWUKrWUuw1Y9a48Grs8JayrJrnrWasrWrZIk3y3
        Za17X3y7XF1q9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbJ5wUUUUU=
X-Originating-IP: [106.19.194.64]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbi7hZvp1tC6ZkkMwAAsO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yingjie Wang <wangyingjie55@126.com>

In dm_dp_mst_detect(), We should check whether or not @connector
has been unregistered from userspace. If the connector is unregistered,
we should return disconnected status.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8ab0b9060d2b..103dfd0e9b65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -271,6 +271,9 @@ dm_dp_mst_detect(struct drm_connector *connector,
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_dm_connector *master = aconnector->mst_port;
 
+	if (drm_connector_is_unregistered(connector))
+		return connector_status_disconnected;
+
 	return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
 				      aconnector->port);
 }
-- 
2.7.4

