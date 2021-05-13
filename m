Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1637F384
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhEMHY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:24:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3743 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhEMHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:24:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgjjX6KCBzqTXV;
        Thu, 13 May 2021 15:20:16 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 15:23:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH -next 3/4] drm/radeon/r100: correct function name r100_cs_packet_parse_vline()
Date:   Thu, 13 May 2021 15:25:58 +0800
Message-ID: <20210513072559.1731410-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210513072559.1731410-1-yangyingliang@huawei.com>
References: <20210513072559.1731410-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following make W=1 kernel build warning:

  drivers/gpu/drm/radeon/r100.c:1423: warning: expecting prototype for r100_cs_packet_next_vline(). Prototype was for r100_cs_packet_parse_vline() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/radeon/r100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index fcfcaec25a9e..3c4e7c15fd15 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1406,7 +1406,7 @@ int r100_cs_parse_packet0(struct radeon_cs_parser *p,
 }
 
 /**
- * r100_cs_packet_next_vline() - parse userspace VLINE packet
+ * r100_cs_packet_parse_vline() - parse userspace VLINE packet
  * @p:		parser structure holding parsing context.
  *
  * Userspace sends a special sequence for VLINE waits.
-- 
2.25.1

