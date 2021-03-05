Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBCC32E567
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCEJ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhCEJ4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:56:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2972B601FE;
        Fri,  5 Mar 2021 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614938171;
        bh=hoQ19clzhxWtId19+87S7OFAK0lAZssf3HE94ZT3lAE=;
        h=Date:From:To:Cc:Subject:From;
        b=Cf+W81nk2RNf/cBzAjxflmCnPcLLtAEqSuukozJOPUVFblqMZjHU03gIjSZUzGCRT
         WtLkKHB64mFzN7Khk99CGVQ4tSLBtfvu7FaqG1+AcXvNf+7kQp0sTfYHnFD/2mMV+3
         S/tNiop3x1MnXm+RgQkNmA1+S/sAaq9BrFRCGn4bfO4pOyUEKv/lj6LEtCF5KfAmIc
         KG1L3dDGaYa2X9/0ew8OosbnhGWcOj0nf6H5AFDF7R2bk4tg3DQMV2RBCRvPP8jz/S
         Ch7zI3zzL/PdJbrqjv0D1Kv0jUAXy8BcNk1/muvoI+/QHCgEOf3ZElakqvtANC4paN
         ElXGZE4cYJ9FQ==
Date:   Fri, 5 Mar 2021 03:56:09 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] drm/nouveau/clk: Fix fall-through warnings for
 Clang
Message-ID: <20210305095609.GA141907@embeddedor>
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
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
index 83067763c0ec..e1d31c62f9ec 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
@@ -313,6 +313,7 @@ nv50_clk_read(struct nvkm_clk *base, enum nv_clk_src src)
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

