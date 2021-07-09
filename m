Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6A3C2A38
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhGIUSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 16:18:03 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:20633
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhGIUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:18:02 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A8+oOA60Yl+PvqM5LTFr2bgqjBKskLtp133Aq?=
 =?us-ascii?q?2lEZdPWaSKGlfqeV7ZcmPHDP5wr5NEtKpTniAsm9qA3nm6KdiLN5VYtKNzOLhI?=
 =?us-ascii?q?LHFutfBPPZogHdJw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,227,1620684000"; 
   d="scan'208";a="387621753"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jul 2021 22:15:15 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/of: free the right object
Date:   Fri,  9 Jul 2021 22:07:17 +0200
Message-Id: <20210709200717.3676376-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to free a NULL value.  Instead, free the object
that is leaking due to the iterator.

The semantic patch that finds this problem is as follows:

// <smpl>
@@
expression x,e;
identifier f;
@@
 x = f(...);
 if (x == NULL) {
	... when any
	    when != x = e
*	of_node_put(x);
	...
 }
// </smpl>

Fixes: 6529007522de ("drm: of: Add drm_of_lvds_get_dual_link_pixel_order")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/drm_of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index ca04c34e8251..197c57477344 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -315,7 +315,7 @@ static int drm_of_lvds_get_remote_pixels_type(
 
 		remote_port = of_graph_get_remote_port(endpoint);
 		if (!remote_port) {
-			of_node_put(remote_port);
+			of_node_put(endpoint);
 			return -EPIPE;
 		}
 

