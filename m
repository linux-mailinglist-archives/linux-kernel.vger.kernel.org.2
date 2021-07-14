Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8093C8638
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbhGNOgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:36:11 -0400
Received: from foss.arm.com ([217.140.110.172]:35618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231977AbhGNOgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:36:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBDC731B;
        Wed, 14 Jul 2021 07:33:18 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C0C13F694;
        Wed, 14 Jul 2021 07:33:17 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH v2] drm/of: free the iterator object on failure
Date:   Wed, 14 Jul 2021 15:33:00 +0100
Message-Id: <20210714143300.20632-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712155758.48286-1-steven.price@arm.com>
References: <20210712155758.48286-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When bailing out due to the sanity check the iterator value needs to be
freed because the early return prevents for_each_child_of_node() from
doing the dereference itself.

Fixes: 6529007522de ("drm: of: Add drm_of_lvds_get_dual_link_pixel_order")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/drm_of.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v2: Fixes now refers to the original commit as suggested by Laurent, rather
than 4ee48cc5586b ("drm: of: Fix double-free bug") which only fixed part of
the problem. Note that 4ee48cc5586b is a dependency for this patch to
cleanly apply.

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 197c57477344..997b8827fed2 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -331,8 +331,10 @@ static int drm_of_lvds_get_remote_pixels_type(
 		 * configurations by passing the endpoints explicitly to
 		 * drm_of_lvds_get_dual_link_pixel_order().
 		 */
-		if (!current_pt || pixels_type != current_pt)
+		if (!current_pt || pixels_type != current_pt) {
+			of_node_put(endpoint);
 			return -EINVAL;
+		}
 	}
 
 	return pixels_type;
-- 
2.20.1

