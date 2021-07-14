Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2103C8668
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbhGNO50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGNO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:57:24 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28783C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 07:54:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 17so2263425pfz.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D6ZlnySp4n2JYKZ3BnTwy0o+3Z06IrEAN7j91AepWbA=;
        b=TBzn5wiz/qArllKQmKvIMY0YBIRem/ED996A0xDoCuqkK6dKUMHmbgPCBChTXLfmYy
         KqgT2VuoQuQ+ZaTFbFs9ZKeRHnmv+rVrolGKUCHqijanujwOslOYRaeGYX/5EDcGNdJ6
         Wzmid0bJCLmRqjxyXEbOA0pO6n53fT/Zj8n4rn6wvG23GmxzYZl7lBs3MewHHDuNyzIm
         NhgfbWW+a1WgGgMyLfSqv6vV36RnbBRD83nJ1GKUq2UQyMJB8Z90bKmaBk4Roou70T92
         WwTNGz8sM6GVGTiuumSBgxYTkofCk5F4iQxQx7xi/YNCw5XGkNQWEOclJIiA3ExpxdwV
         EVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D6ZlnySp4n2JYKZ3BnTwy0o+3Z06IrEAN7j91AepWbA=;
        b=P5cuCzVlLnPEKSvaEt7UzSfI4sQXM6HzZFyKx1NZUHFoN0o1jur9Ykm8S5IswjZ8a3
         JTLfTS5eAI56Sb5tYrqlQ5rQRr0uF2VBq1OJpNmfplejVyxU/SJA9atIHmFRepQ/8iBL
         gOE0agaOGiK6EuDRzBpfc45a2Fn21wB+yaN3q2dIpQA7eVriQZKSiWss4QkcIS/w6m8H
         Admj9v02b0DM88chGzC/T0Ym2VSZv5l9HJmRLNkguW8ppTqp4ddZwjGsDDFVXn30RnN8
         hIwfDmp1FyY7gCcSiOUSDkst24oQ/TwSrOOsdZMrGtgbHGrzUK5KOmQht/OfyUOfXBSD
         TC1A==
X-Gm-Message-State: AOAM531Z5f6kUjTlAwpMudHhS8CNag8vamGP/uLjDsYjZ0HT3ECWVXrX
        03760wSNqbQwprQc1d9JPA==
X-Google-Smtp-Source: ABdhPJytmXSLQnNsOiOOvEvl6ehtqWfymtV5pVH/x19S40xL1M3Ewl0Vy0jPc0IdVHs8jSu5nIZRyA==
X-Received: by 2002:a63:145d:: with SMTP id 29mr10005317pgu.135.1626274472676;
        Wed, 14 Jul 2021 07:54:32 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id e16sm3541317pgl.54.2021.07.14.07.54.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 07:54:32 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     christian.koenig@amd.com, ray.huang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] drm/ttm: add a check against null pointer dereference
Date:   Wed, 14 Jul 2021 14:54:19 +0000
Message-Id: <1626274459-8148-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling ttm_range_man_fini(), 'man' may be uninitialized, which may
cause a null pointer dereference bug.

Fix this by checking if it is a null pointer.

This log reveals it:

[    7.902580 ] BUG: kernel NULL pointer dereference, address: 0000000000000058
[    7.905721 ] RIP: 0010:ttm_range_man_fini+0x40/0x160
[    7.911826 ] Call Trace:
[    7.911826 ]  radeon_ttm_fini+0x167/0x210
[    7.911826 ]  radeon_bo_fini+0x15/0x40
[    7.913767 ]  rs400_fini+0x55/0x80
[    7.914358 ]  radeon_device_fini+0x3c/0x140
[    7.914358 ]  radeon_driver_unload_kms+0x5c/0xe0
[    7.914358 ]  radeon_driver_load_kms+0x13a/0x200
[    7.914358 ]  ? radeon_driver_unload_kms+0xe0/0xe0
[    7.914358 ]  drm_dev_register+0x1db/0x290
[    7.914358 ]  radeon_pci_probe+0x16a/0x230
[    7.914358 ]  local_pci_probe+0x4a/0xb0

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_range_manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_range_manager.c b/drivers/gpu/drm/ttm/ttm_range_manager.c
index 03395386e8a7..f4b08a8705b3 100644
--- a/drivers/gpu/drm/ttm/ttm_range_manager.c
+++ b/drivers/gpu/drm/ttm/ttm_range_manager.c
@@ -181,6 +181,9 @@ int ttm_range_man_fini(struct ttm_device *bdev,
 	struct drm_mm *mm = &rman->mm;
 	int ret;
 
+	if (!man)
+		return 0;
+
 	ttm_resource_manager_set_used(man, false);
 
 	ret = ttm_resource_manager_evict_all(bdev, man);
-- 
2.17.6

