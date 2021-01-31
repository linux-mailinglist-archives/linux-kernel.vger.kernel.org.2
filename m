Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78997309DBA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhAaPkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhAaMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:52:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C90C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 04:51:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j13so15761372edp.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 04:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fjrhs7HTb3KAOHD/Z4OsRiZR3fTTDer1xRtVh5uEzQQ=;
        b=mggdTO+OzSrMYTeeVpTG18ltZSkuUAgNUjWRpyNavueifr3EL59jk3fHyG9b5MsMze
         ad8BHI0O2eNoZY97JPbZ1QHjYDxOXDfc0Jt239VSK3FX5ZnmaZZHpHOJmFQjSbsxjrcM
         EQFgUhi6D24LVeGlH2+65JujeTPiJ2tO6u+UKnOGCjociHuocF6Jg1lQZlju6V4Y4hKQ
         Qj3D8U930n43hN2SaK/S6T8jBrHsWPs4uSNHaL9ZTNbjR6NZP+NvO9qB64aQnZMESzb+
         W9RI+8p/GXntTFwJV6saoi+FK5gCYRPq3E2th+r2C8lO1DbiXVrfzBGlFvGyH/92YwYV
         84aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fjrhs7HTb3KAOHD/Z4OsRiZR3fTTDer1xRtVh5uEzQQ=;
        b=Ie8EgbPQq4GNCiaCRqmJYc1lDd5OmpwGX4/SXy0hf3pH+H1apM4HDLdBLMuCeoYHNG
         W8SeQjCVFyXixjnTt/0rXDePTdLsIwDfwZZUUUi+qXAKX9XW3VjnYcHb0JwlWxKxQfro
         lMV+F1fYF0DRnXySYxB11jKkdQVq9nBqsY/ZkN1nIJ1K/trjJ/3z/rullS0p42AOsKTV
         NRzSmQrD5t64LlQZ98GbNE96HTpEQi9+SBSz9q1rd0RZTXyv8w2r2nVMUVjsmJlM5FSB
         4v5w1f3hUYGwo4NHGGFcGFnQQlSSsXUxDlgwxXyhjyLaa4QVpFRo0TYGwjR9pbmH1awk
         dlsw==
X-Gm-Message-State: AOAM531Lm0vltFoKOzCs4E1Ixuto+zDwBSuypGPBINvMgRjGpTskqZfv
        hyodQm248Xu9Tmc9L55MkFY=
X-Google-Smtp-Source: ABdhPJyIMzfAVupXZdw07J+8FbSpRt9OxCqtZKCXvj20Dih48GzJhmB94RAfPNXYaiSCctESwwkr0w==
X-Received: by 2002:a05:6402:1b11:: with SMTP id by17mr13753486edb.373.1612097481028;
        Sun, 31 Jan 2021 04:51:21 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i15sm6552820ejj.28.2021.01.31.04.51.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 04:51:20 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/rockchip: vop_reg: add rk3036 hdmi support
Date:   Sun, 31 Jan 2021 13:51:14 +0100
Message-Id: <20210131125114.10885-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Rockchip Inno HDMI driver was added, but the rk3036
VOP regs with HDMI support in the manufacturer tree never
made it to the mainline kernel.
This patch adds only hdmi_en and hdmi_dclk_pol.
The inno hdmi driver must set hdmi_pin_pol in
GRF_SOC_CON2.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Not tested with hardware
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 0697057e7..c164690a1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -147,6 +147,8 @@ static const struct vop_modeset rk3036_modeset = {
 
 static const struct vop_output rk3036_output = {
 	.pin_pol = VOP_REG(RK3036_DSP_CTRL0, 0xf, 4),
+	.hdmi_en = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 22),
+	.hdmi_dclk_pol = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 23),
 };
 
 static const struct vop_common rk3036_common = {
-- 
2.11.0

