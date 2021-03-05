Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7002E32E56F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCEJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:58:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCEJ6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:58:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26D6A64F1D;
        Fri,  5 Mar 2021 09:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614938289;
        bh=/lb8uN3ccDMS8ANXkjYL2gkpQf8TDnHZRLuIhsU6K5Q=;
        h=Date:From:To:Cc:Subject:From;
        b=NhlDLvtZ32Qy5Ze42To9z1nyExlHaEKoiU+ZYMkPdNC5Sll/sHGOjwLHz6SgGYhrH
         dTqSCaFpgnqSFJ/rGR0E4vShyZJ3rMxgezeJf4i57wbKnDIxi6eg2PZEb8/mOP/qbH
         T2XRiWTtPvzXH6Ro7Fx/+wwxNGTL2PpDfujAmisEqHxJxCoWsMJueaiY4d4LT7xyTR
         dAaKSlTNDS3KaCeKcpCA4dLS4RtUI7f9VZr/Xe60j82ELTRPu0BgSUAwy/sCjE+DM+
         G26yj1UlNxVR0AMJwowOEmUwU9R6lcaTFyMNiTSy30XoowkKS4yZgyzt60qhJ5OT5/
         E/iq9/zrJIoHQ==
Date:   Fri, 5 Mar 2021 03:58:07 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] drm/nouveau/therm: Fix fall-through warnings
 for Clang
Message-ID: <20210305095807.GA142125@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
index 2b031d4eaeb6..684aff7437ee 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
@@ -41,6 +41,7 @@ pwm_info(struct nvkm_therm *therm, int line)
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

