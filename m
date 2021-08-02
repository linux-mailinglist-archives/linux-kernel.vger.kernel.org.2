Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181873DD0F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhHBHIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:08:39 -0400
Received: from mail-m17655.qiye.163.com ([59.111.176.55]:25358 "EHLO
        mail-m17655.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHBHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:08:38 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17655.qiye.163.com (Hmail) with ESMTPA id 94D5440157;
        Mon,  2 Aug 2021 15:08:26 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        =?UTF-8?q?Zbigniew=20Kempczy=C5=84ski?= 
        <zbigniew.kempczynski@intel.com>,
        zhouchuangao <zhouchuangao@vivo.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/drm/i915: Remove duplicated include of intel_region_lmem.h
Date:   Mon,  2 Aug 2021 00:07:07 -0700
Message-Id: <1627888031-56048-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJOTk5WGh9LQ08dSx9DSk
        MaVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDY6ETo6LD9OLTMdDCsIMSpR
        CjwKCQFVSlVKTUlMQ0NDSktMQ0JNVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlPTU83Bg++
X-HM-Tid: 0a7b05b13dc6da01kuws94d5440157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate include header file "intel_region_lmem.h"
line 8: #include "intel_region_lmem.h"
line 12: #include "intel_region_lmem.h"

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 drivers/gpu/drm/i915/gt/intel_region_lmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
index f7366b0..119eeec 100644
--- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
+++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
@@ -9,7 +9,6 @@
 #include "intel_region_ttm.h"
 #include "gem/i915_gem_lmem.h"
 #include "gem/i915_gem_region.h"
-#include "intel_region_lmem.h"
 
 static int init_fake_lmem_bar(struct intel_memory_region *mem)
 {
-- 
2.7.4

