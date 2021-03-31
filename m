Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF8350129
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhCaNVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:21:45 -0400
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:34810 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbhCaNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:21:13 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id D1121540562;
        Wed, 31 Mar 2021 21:12:57 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/ttm: cleanup coding style a bit
Date:   Wed, 31 Mar 2021 06:12:51 -0700
Message-Id: <20210331131251.60883-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGEIdQ0xPTxlPGkMfVkpNSkxKQk1ITENLTUpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K006Szo4HD8IFjUYNy8ONFYw
        GBVPCRhVSlVKTUpMSkJNSExDSE1IVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFKQk1JNwY+
X-HM-Tid: 0a78886a678ab038kuuud1121540562
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
drivers/gpu/drm/ttm/ttm_bo.c:52:1: warning: symbol 'ttm_global_mutex' was not declared. Should it be static?
drivers/gpu/drm/ttm/ttm_bo.c:53:10: warning: symbol 'ttm_bo_glob_use_count' was not declared. Should it be static?

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 101a68dc615b..eab21643edfb 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -49,8 +49,8 @@ static void ttm_bo_global_kobj_release(struct kobject *kobj);
 /*
  * ttm_global_mutex - protecting the global BO state
  */
-DEFINE_MUTEX(ttm_global_mutex);
-unsigned ttm_bo_glob_use_count;
+static DEFINE_MUTEX(ttm_global_mutex);
+static unsigned int ttm_bo_glob_use_count;
 struct ttm_bo_global ttm_bo_glob;
 EXPORT_SYMBOL(ttm_bo_glob);
 
-- 
2.31.0

