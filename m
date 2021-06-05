Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B137239C6F4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 11:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFEJIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 05:08:39 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:29604 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFEJIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 05:08:38 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d86 with ME
        id DM6o2500821Fzsu03M6oW4; Sat, 05 Jun 2021 11:06:49 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 05 Jun 2021 11:06:49 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/amdgpu: Fix a a typo in a comment
Date:   Sat,  5 Jun 2021 11:06:45 +0200
Message-Id: <ea7ecbef546a03ef71d65bfe82608bb347e6f3c2.1622883895.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/than/then/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 89ebbf363e27..1476236f5c7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -662,7 +662,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
  * @error:	error number
  * @backoff:	indicator to backoff the reservation
  *
- * If error is set than unvalidate buffer, otherwise just free memory
+ * If error is set then unvalidate buffer, otherwise just free memory
  * used by parsing context.
  **/
 static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
-- 
2.30.2

