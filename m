Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B752433E595
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhCQBFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232452AbhCQA7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:59:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3B7F64FBC;
        Wed, 17 Mar 2021 00:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615942783;
        bh=Hu7eLsX0xzzWq8Az1HGRu3h9HNzL7mi7VCU2Z64f044=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cB0LuZBo3+74PwFzXbpniIujspfJnMmlXfj/vgGZgOs2Nh4SYllnsZPx2HFQmaL1/
         ZdVekNeWQh6oooEgndMAy4QZhlAUorWacyQU9Ob3pdmS50gpBLbBFFN5dH7ha756Xm
         vh8kpIbHfau/lGwCFNfc6eUX1u/6i+ss7AY0b/PnM5+p3ni+AiUoU/o3edl0LTf+OO
         qx2uHiRzkrxGqDsNk5llHS3+vm/1c1D9iYsliOegwSOTfJQKMU9PSVkFzjIP8Yjx1f
         Oa9cR8I1eIqE74/tl6DSg/p2e4jjfHk2+TxkKTWizAqV484PYt2PSlwsxnaNnAV9Xh
         8WOpodbIXmIiQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 18/21] drm/radeon: fix AGP dependency
Date:   Tue, 16 Mar 2021 20:59:17 -0400
Message-Id: <20210317005920.726931-18-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005920.726931-1-sashal@kernel.org>
References: <20210317005920.726931-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit cba2afb65cb05c3d197d17323fee4e3c9edef9cd ]

When AGP is compiled as module radeon must be compiled as module as
well.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 83cb2a88c204..595d0c96ba89 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -156,6 +156,7 @@ source "drivers/gpu/drm/arm/Kconfig"
 config DRM_RADEON
 	tristate "ATI Radeon"
 	depends on DRM && PCI && MMU
+	depends on AGP || !AGP
 	select FW_LOADER
         select DRM_KMS_HELPER
         select DRM_TTM
-- 
2.30.1

