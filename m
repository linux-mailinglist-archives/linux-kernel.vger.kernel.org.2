Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14FA3B3AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 04:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhFYCGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 22:06:13 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:46492 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFYCGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:06:12 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 86DD1B1916;
        Fri, 25 Jun 2021 10:03:49 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.240.82.166])
        by smtp.263.net (postfix) whith ESMTP id P1334T140034502022912S1624586622420447_;
        Fri, 25 Jun 2021 10:03:49 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7e806d5e61b4e62798b4abb7502b1da4>
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
Subject: [PATCH] drm/amdgpu: use kvcalloc for entry->entries
Date:   Fri, 25 Jun 2021 10:03:44 +0800
Message-Id: <20210625020344.30979-1-huqiqiao@uniontech.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

malloc_array + __GFP_ZERO is the same with kvcalloc.

Signed-off-by: huqiqiao <huqiqiao@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b8c31e3469c0..5cadfadc625f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -909,7 +909,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 
 		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
 		entry->entries = kvcalloc(num_entries,
-					sizeof(*entry->entries), GFP_KERNEL);
+			sizeof(*entry->entries), GFP_KERNEL);
 		if (!entry->entries)
 			return -ENOMEM;
 	}
-- 
2.11.0



