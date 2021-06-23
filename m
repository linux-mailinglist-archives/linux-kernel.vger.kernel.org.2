Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA853B181D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFWKdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:33:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:33:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2164321916;
        Wed, 23 Jun 2021 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624444243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HCvoFUMGXgLIQO/hA7VYGyu+LChmbtQQAc+dzSw213M=;
        b=aZoZXMPpCOMVC2ogAFPWHm6UfM6wGyZMFuT8VTa0soMFVprOblOQfw5Fy0uuHHJTv3a27t
        Xo7d1yqAmdhaBHYUt4uIQZzQkR3Lo/5LUEiCkb3hs0gY8honH9x0vhZ52Z9fMz6YGDAAer
        9voXwrWqrlxNul/JB4kI1tia5H4ZxkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624444243;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HCvoFUMGXgLIQO/hA7VYGyu+LChmbtQQAc+dzSw213M=;
        b=fg1HPCSLsGLz/2D0dvo4QcmAWQiO/Ti2wKSk4zx1tioKnEA/DZu70ZP0Mc/EfCzvo9vPN/
        NSXGeQse+fnwvxBQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id D3A5BA3B81;
        Wed, 23 Jun 2021 10:30:42 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Will Deacon <will@kernel.org>, Huang Rui <ray.huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/dc: Really fix DCN3.1 Makefile for PPC64
Date:   Wed, 23 Jun 2021 12:30:39 +0200
Message-Id: <20210623103039.9881-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also copy over the part that makes old gcc handling cross-platform.

Fixes: df7a1658f257 ("drm/amdgpu/dc: fix DCN3.1 Makefile for PPC64")
Fixes: 926d6972efb6 ("drm/amd/display: Add DCN3.1 blocks to the DC Makefile")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
The fact that the old gcc handling triggers on gcc 10 and 11 is another
story I don't want to delve into.
---
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 5dcdc5a858fe..4bab97acb155 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -28,6 +28,7 @@ endif
 CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -mhard-float
 endif
 
+ifdef CONFIG_X86
 ifdef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
@@ -36,6 +37,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -mpreferred-stack-boundary=4
 else
 CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -msse2
 endif
+endif
 
 AMD_DAL_DCN31 = $(addprefix $(AMDDALPATH)/dc/dcn31/,$(DCN31))
 
-- 
2.26.2

