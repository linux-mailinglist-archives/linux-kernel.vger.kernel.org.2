Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A705348904
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhCYGVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:21:06 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:35120 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCYGUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:20:45 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 5360C980378;
        Thu, 25 Mar 2021 14:20:41 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drivers: gpu: drm: xen_drm_front_drm_info is declared twice
Date:   Thu, 25 Mar 2021 14:19:01 +0800
Message-Id: <20210325061901.851273-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTR4fTE1IQkofTk8fVkpNSk1NTkhJT0pOTk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PhA6Hgw6LD8OGj4eLUMtGTIL
        HTQaFBxVSlVKTUpNTU5ISU9JT0tMVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTE1INwY+
X-HM-Tid: 0a78680acc88d992kuws5360c980378
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct xen_drm_front_drm_info has been declared. 
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/xen/xen_drm_front_conn.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.h b/drivers/gpu/drm/xen/xen_drm_front_conn.h
index 3adacba9a23b..e5f4314899ee 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_conn.h
+++ b/drivers/gpu/drm/xen/xen_drm_front_conn.h
@@ -16,7 +16,6 @@
 struct drm_connector;
 struct xen_drm_front_drm_info;
 
-struct xen_drm_front_drm_info;
 
 int xen_drm_front_conn_init(struct xen_drm_front_drm_info *drm_info,
 			    struct drm_connector *connector);
-- 
2.25.1

