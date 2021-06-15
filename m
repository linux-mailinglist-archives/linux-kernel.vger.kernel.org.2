Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563F73A8299
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhFOOVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhFOOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:19:57 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9AC061A32
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:38 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 73078C800AB;
        Tue, 15 Jun 2021 16:14:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id uKqjFBh7Z-Zi; Tue, 15 Jun 2021 16:14:36 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F3949009F7CF2Abd5Da2787.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:9f7c:f2ab:d5da:2787])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 112A4C80095;
        Tue, 15 Jun 2021 16:14:36 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v3 02/14] drm/amd/display: Add missing cases convert_dc_color_depth_into_bpc
Date:   Tue, 15 Jun 2021 16:14:13 +0200
Message-Id: <20210615141426.6001-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141426.6001-1-wse@tuxedocomputers.com>
References: <20210615141426.6001-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert_dc_color_depth_into_bpc() that converts the enum dc_color_depth to an
integer had the casses for COLOR_DEPTH_999 and COLOR_DEPTH_111111 missing.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 44757720b15f..cd1df5cf4815 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6705,6 +6705,10 @@ static int convert_dc_color_depth_into_bpc (enum dc_color_depth display_color_de
 			return 14;
 		case COLOR_DEPTH_161616:
 			return 16;
+		case COLOR_DEPTH_999:
+			return 9;
+		case COLOR_DEPTH_111111:
+			return 11;
 		default:
 			break;
 		}
-- 
2.25.1

