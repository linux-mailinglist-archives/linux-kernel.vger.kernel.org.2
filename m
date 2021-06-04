Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4830239B9A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFDNS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:18:29 -0400
Received: from srv6.fidu.org ([159.69.62.71]:35350 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhFDNS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:18:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id EB4F8C800B8;
        Fri,  4 Jun 2021 15:16:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id vq1GyM85sFO9; Fri,  4 Jun 2021 15:16:40 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300E37F2e2A0038b625C68b541A92.dip0.t-ipconnect.de [IPv6:2003:e3:7f2e:2a00:38b6:25c6:8b54:1a92])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 96F92C800BC;
        Fri,  4 Jun 2021 15:16:40 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH 1/1] drm/amd/display: Add missing cases convert_dc_color_depth_into_bpc
Date:   Fri,  4 Jun 2021 15:16:34 +0200
Message-Id: <20210604131634.6703-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604131634.6703-1-wse@tuxedocomputers.com>
References: <20210604131634.6703-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert_dc_color_depth_into_bpc() that converts the enum dc_color_depth to an
integer had the cases for COLOR_DEPTH_999 and COLOR_DEPTH_111111 missing.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 389eff96fcf6..6e82889271d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6515,6 +6515,10 @@ static int convert_dc_color_depth_into_bpc (enum dc_color_depth display_color_de
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

