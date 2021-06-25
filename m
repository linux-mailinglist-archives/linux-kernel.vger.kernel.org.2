Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96F53B3AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 04:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhFYCf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 22:35:57 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:56676 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhFYCfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:35:52 -0400
Received: from localhost (unknown [192.168.167.225])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7CB96AFF1D;
        Fri, 25 Jun 2021 10:33:31 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.240.82.166])
        by smtp.263.net (postfix) whith ESMTP id P31196T139969978935040S1624588406684274_;
        Fri, 25 Jun 2021 10:33:31 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <82ebafcd2d8448668e02a058c521561b>
X-RL-SENDER: huqiqiao@uniontech.com
X-SENDER: huqiqiao@uniontech.com
X-LOGIN-NAME: huqiqiao@uniontech.com
X-FST-TO: alexander.deucher@amd.com
X-RCPT-COUNT: 5
X-SENDER-IP: 58.240.82.166
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   huqiqiao <huqiqiao@uniontech.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        huqiqiao <huqiqiao@uniontech.com>
Subject: [PATCH] drm/amdgpu: use kvcalloc for entry->entries.
Date:   Fri, 25 Jun 2021 10:33:30 +0800
Message-Id: <20210625023330.17463-1-huqiqiao@uniontech.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc_array + __GFP_ZERO is the same with kvcalloc.

Signed-off-by: huqiqiao <huqiqiao@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9acee4a5b2ba..5a012321d09e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -909,8 +909,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 
 		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
 		entry->entries = kvmalloc_array(num_entries,
-						sizeof(*entry->entries),
-						GFP_KERNEL | __GFP_ZERO);
+			sizeof(*entry->entries), GFP_KERNEL);
 		if (!entry->entries)
 			return -ENOMEM;
 	}
-- 
2.11.0



