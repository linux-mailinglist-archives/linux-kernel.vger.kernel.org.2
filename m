Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDEE30B869
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhBBHI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:08:56 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56193 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232018AbhBBHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:08:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UNexAtl_1612249647;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNexAtl_1612249647)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 15:07:28 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     anitha.chrisanthus@intel.com
Cc:     edmund.j.dea@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] drm/kmb: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 15:07:26 +0800
Message-Id: <1612249646-68040-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/gpu/drm/kmb/kmb_dsi.c:281:3-4: Unneeded semicolon
./drivers/gpu/drm/kmb/kmb_dsi.c:301:3-4: Unneeded semicolon
./drivers/gpu/drm/kmb/kmb_dsi.c:318:3-4: Unneeded semicolon
./drivers/gpu/drm/kmb/kmb_dsi.c:337:3-4: Unneeded semicolon
./drivers/gpu/drm/kmb/kmb_dsi.c:361:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/kmb/kmb_dsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index 4b5d82a..231041b 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -281,7 +281,7 @@ static u32 mipi_get_datatype_params(u32 data_type, u32 data_mode,
 		default:
 			DRM_ERROR("DSI: Invalid data_mode %d\n", data_mode);
 			return -EINVAL;
-		};
+		}
 		break;
 	case DSI_LP_DT_PPS_YCBCR422_16B:
 		data_type_param.size_constraint_pixels = 2;
@@ -301,7 +301,7 @@ static u32 mipi_get_datatype_params(u32 data_type, u32 data_mode,
 		default:
 			DRM_ERROR("DSI: Invalid data_mode %d\n", data_mode);
 			return -EINVAL;
-		};
+		}
 		break;
 	case DSI_LP_DT_LPPS_YCBCR422_20B:
 	case DSI_LP_DT_PPS_YCBCR422_24B:
@@ -318,7 +318,7 @@ static u32 mipi_get_datatype_params(u32 data_type, u32 data_mode,
 		default:
 			DRM_ERROR("DSI: Invalid data_mode %d\n", data_mode);
 			return -EINVAL;
-		};
+		}
 		break;
 	case DSI_LP_DT_PPS_RGB565_16B:
 		data_type_param.size_constraint_pixels = 1;
@@ -337,7 +337,7 @@ static u32 mipi_get_datatype_params(u32 data_type, u32 data_mode,
 		default:
 			DRM_ERROR("DSI: Invalid data_mode %d\n", data_mode);
 			return -EINVAL;
-		};
+		}
 		break;
 	case DSI_LP_DT_PPS_RGB666_18B:
 		data_type_param.size_constraint_pixels = 4;
@@ -361,7 +361,7 @@ static u32 mipi_get_datatype_params(u32 data_type, u32 data_mode,
 	default:
 		DRM_ERROR("DSI: Invalid data_type %d\n", data_type);
 		return -EINVAL;
-	};
+	}
 
 	*params = data_type_param;
 	return 0;
-- 
1.8.3.1

