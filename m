Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E5399FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFCLXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:23:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3047 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCLXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:23:22 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fwjyr0GJtzWnyr;
        Thu,  3 Jun 2021 19:16:52 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 19:21:36 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 19:21:35 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <yukuai3@huawei.com>, <alexander.deucher@amd.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: [PATCH] drm: fix doc warnings in drm_atomic.h
Date:   Thu, 3 Jun 2021 19:30:51 +0800
Message-ID: <20210603113051.2095866-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603192238.0bbc6686@canb.auug.org.au>
References: <20210603192238.0bbc6686@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for parameters for
for_each_new_plane_in_state_reverse to fix warnings:

include/drm/drm_atomic.h:908: warning: Function parameter or member '__state' not described in 'for_each_new_plane_in_state_reverse'
include/drm/drm_atomic.h:908: warning: Function parameter or member 'plane' not described in 'for_each_new_plane_in_state_reverse'
include/drm/drm_atomic.h:908: warning: Function parameter or member 'new_plane_state' not described in 'for_each_new_plane_in_state_reverse'
include/drm/drm_atomic.h:908: warning: Function parameter or member '__i' not described in 'for_each_new_plane_in_state_reverse'

Fixes: a6c3c37b661d ("drm/amd/display: fix gcc set but not used warning of variable 'old_plane_state'")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/drm/drm_atomic.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 8f1350e599eb..1701c2128a5c 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -898,6 +898,10 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 /**
  * for_each_new_plane_in_state_reverse - other than only tracking new state,
  * it's the same as for_each_oldnew_plane_in_state_reverse
+ * @__state: &struct drm_atomic_state pointer
+ * @plane: &struct drm_plane iteration cursor
+ * @new_plane_state: &struct drm_plane_state iteration cursor for the new state
+ * @__i: int iteration cursor, for macro-internal use
  */
 #define for_each_new_plane_in_state_reverse(__state, plane, new_plane_state, __i) \
 	for ((__i) = ((__state)->dev->mode_config.num_total_plane - 1);	\
-- 
2.31.1

