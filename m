Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8591E31B705
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBOKXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:23:52 -0500
Received: from m12-11.163.com ([220.181.12.11]:46163 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhBOKXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=qILXK4GORBkA7fjOMr
        MyU72nwmgjVF7Si6pXWrVEMZU=; b=Nx1c/GJQpxF9wDcInVh27Undlz2HAywEjs
        HZjIn2kzhlrj2E/RUgocfdTUjExJyS769GRsCs4e/f9wbbwqt9e7SVen5T9bMQxg
        cH+d8B3VbJbdi8i70f11r+sZNTskBrDJqYVOreJys/r3rzT5AcCkwjgKLvowSs0c
        s95mB//So=
Received: from localhost.localdomain (unknown [125.70.196.55])
        by smtp7 (Coremail) with SMTP id C8CowACnI7Q8SypgiR08Nw--.5666S2;
        Mon, 15 Feb 2021 18:21:52 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Chen Lin <chen.lin5@zte.com.cn>
Subject: [PATCH] drm/radeon: Remove unused function pointer typedef radeon_packet3_check_t
Date:   Mon, 15 Feb 2021 18:21:29 +0800
Message-Id: <1613384489-3102-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: C8CowACnI7Q8SypgiR08Nw--.5666S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1UZr4DuryxJw4DGw4rKrg_yoW3Wrc_Kr
        10q34aqa4kArs2q3W5uFsrJFyjkrW09r48Gw1Fqr93tayqqr1rZFySkr1xZrs8Aa1SgFnx
        J3ykXF13Aws3tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0_ucJUUUUU==
X-Originating-IP: [125.70.196.55]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/1tbiXAA6nlXlytycbQAAsv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lin <chen.lin5@zte.com.cn>

Remove the 'radeon_packet3_check_t' typedef as it is not used.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 drivers/gpu/drm/radeon/radeon.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 5f3adba..a1c38b5 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1111,9 +1111,6 @@ struct radeon_cs_packet {
 typedef int (*radeon_packet0_check_t)(struct radeon_cs_parser *p,
 				      struct radeon_cs_packet *pkt,
 				      unsigned idx, unsigned reg);
-typedef int (*radeon_packet3_check_t)(struct radeon_cs_parser *p,
-				      struct radeon_cs_packet *pkt);
-
 
 /*
  * AGP
-- 
1.7.9.5

