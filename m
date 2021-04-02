Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1299D35279D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhDBIza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:55:30 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:57500 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBIz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:55:29 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 8FC374003CC;
        Fri,  2 Apr 2021 16:55:27 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/gud: cleanup coding style a bit
Date:   Fri,  2 Apr 2021 01:55:21 -0700
Message-Id: <20210402085523.76928-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUxKHhlLGEpCSxpCVkpNSkxITkhMSUxMSUNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQw6Czo4Tj8PMCovDToKCk0a
        TxwaCRxVSlVKTUpMSE5ITElMQk1CVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFKTEtMNwY+
X-HM-Tid: 0a7891cb5eb2d991kuws8fc374003cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:
drivers/gpu/drm/gud/gud_internal.h:89:2-3: Unneeded semicolon
drivers/gpu/drm/gud/gud_internal.h:107:2-3: Unneeded semicolon

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/gud/gud_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_internal.h b/drivers/gpu/drm/gud/gud_internal.h
index de2f2d2dbc60..b65105585578 100644
--- a/drivers/gpu/drm/gud/gud_internal.h
+++ b/drivers/gpu/drm/gud/gud_internal.h
@@ -86,7 +86,7 @@ static inline u8 gud_from_fourcc(u32 fourcc)
 		return GUD_PIXEL_FORMAT_XRGB8888;
 	case DRM_FORMAT_ARGB8888:
 		return GUD_PIXEL_FORMAT_ARGB8888;
-	};
+	}
 
 	return 0;
 }
@@ -104,7 +104,7 @@ static inline u32 gud_to_fourcc(u8 format)
 		return DRM_FORMAT_XRGB8888;
 	case GUD_PIXEL_FORMAT_ARGB8888:
 		return DRM_FORMAT_ARGB8888;
-	};
+	}
 
 	return 0;
 }
-- 
2.31.0

