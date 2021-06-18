Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D213AC6DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhFRJNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFRJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:13:45 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3F5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:11:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 480A0C800BC;
        Fri, 18 Jun 2021 11:11:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id zECRVlP9FH1x; Fri, 18 Jun 2021 11:11:33 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37f3949001760E5710682cA7E.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:1760:e571:682:ca7e])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id E17E4C800BA;
        Fri, 18 Jun 2021 11:11:32 +0200 (CEST)
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
Subject: [PATCH v4 02/17] drm/amd/display: Add missing cases convert_dc_color_depth_into_bpc
Date:   Fri, 18 Jun 2021 11:11:01 +0200
Message-Id: <20210618091116.14428-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618091116.14428-1-wse@tuxedocomputers.com>
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert_dc_color_depth_into_bpc() that converts the enum dc_color_depth to
an integer had the casses for COLOR_DEPTH_999 and COLOR_DEPTH_111111
missing.

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

