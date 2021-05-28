Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA069394332
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhE1NIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbhE1NHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:07:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41EBC061763
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e12so5282576ejt.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCinzeYxY1ACn5rVFsalymDNpiU4s0UULJ02Uf8Q/Xg=;
        b=fZyN+lO4LFqwFoO/0z3KNjFxtMLxQzWT8zoJyQ7UJJup0gRGyBHAsep+UMq5f4nWyc
         0dp/kp10b0V7xAJFvPPLIO1dEti3HqArWKb/SZjPk4YqBwM2hTL6l5Ve5ptRtAng3zQE
         NN6cKmdmx/aOBVkXGJuxBRbsj/VBxffvNjhIhChQSMVXTN978VZqmTDXOqBhn0EOStkZ
         mJb56Mn7hS1E3IwqB22Nn9zm4hH6SAPO5xfaDFcprAnzYYd8unjZ5AWA0HHMukiyM7DZ
         FmBYvtR+wE/lHOm5Iym4enQmYTGcKS4A7Ze4u4IQW1kDyOL/lcndOEV7P2go2GNDIm4W
         /pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCinzeYxY1ACn5rVFsalymDNpiU4s0UULJ02Uf8Q/Xg=;
        b=NKTv3elYY1Sitvma6kyEw45c1xUPMq0ZbwSV+bdHaJJICsXQssjCBlSpL2hE3gRAN8
         484ybC1dH3/GawR4ol6hFr4rrGRKqMBU3fvAsIxaCm3351BDcRhm63D+EkhbEHJKX51a
         MIQZ7UReexErSne8IkTD3BJ8u1GsgmKhGJNVlBDYAryzVuUbf5uGqhQ8Rb4lIW3w8rQV
         xFRAjYOajtJn9AcQO3w9Bb/oAXDLMDJUbfGAOcYCQnV4+AHvSEgHyplGxqleLxGiHD3c
         t9gDqpQW9Y3GF1Jc9Zi4+VEfRr/VjzGh2EoPfHvFA8eZPSBQrMndRDOMD6BazTXNrdMB
         XeEg==
X-Gm-Message-State: AOAM533BnMchgieFqYFBn5TEcxNmcGF821xO0B2ZywZj23Zi45TM2UcJ
        LNCxcr9qDKU64bguT1+qjA==
X-Google-Smtp-Source: ABdhPJxTQMDcAVUJtuWxOiFDEOTvOyxEsGOfb0YMDTG/HlvUeVbiyINIs4BEhRPMAergrBzosF8RKw==
X-Received: by 2002:a17:907:37b:: with SMTP id rs27mr9151356ejb.287.1622207175489;
        Fri, 28 May 2021 06:06:15 -0700 (PDT)
Received: from localhost.localdomain (ip4d17b4b8.dynamic.kabel-deutschland.de. [77.23.180.184])
        by smtp.googlemail.com with ESMTPSA id u21sm2322778ejg.50.2021.05.28.06.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:06:15 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 2/5] drm: rockchip: add missing registers for RK3188
Date:   Fri, 28 May 2021 15:05:51 +0200
Message-Id: <20210528130554.72191-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528130554.72191-1-knaerzche@gmail.com>
References: <20210528130554.72191-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dither_up, dsp_lut_en and data_blank registers to enable their
respective functionality for RK3188's VOP.
While at that also fix .dsp_blank register which is (only) set with
BIT24 (same as RK3066)

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

 Changes in v2:
 - drop the not yet upstreamed dsp_data_swap and rephrase the commit
   message according

 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index b046910129fb..2aa6d937a078 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -511,7 +511,10 @@ static const struct vop_common rk3188_common = {
 	.dither_down_sel = VOP_REG(RK3188_DSP_CTRL0, 0x1, 27),
 	.dither_down_en = VOP_REG(RK3188_DSP_CTRL0, 0x1, 11),
 	.dither_down_mode = VOP_REG(RK3188_DSP_CTRL0, 0x1, 10),
-	.dsp_blank = VOP_REG(RK3188_DSP_CTRL1, 0x3, 24),
+	.dsp_blank = VOP_REG(RK3188_DSP_CTRL1, 0x1, 24),
+	.dither_up = VOP_REG(RK3188_DSP_CTRL0, 0x1, 9),
+	.dsp_lut_en = VOP_REG(RK3188_SYS_CTRL, 0x1, 28),
+	.data_blank = VOP_REG(RK3188_DSP_CTRL1, 0x1, 25),
 };
 
 static const struct vop_win_data rk3188_vop_win_data[] = {
-- 
2.27.0

