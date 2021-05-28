Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C8A39432F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhE1NHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbhE1NHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:07:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8584EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s6so4749175edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNFtWXNjGOhAnzhZIEB5pnyB38+rxkkPxxFke3J42dU=;
        b=Cp3x0F3HzKzYTPdjhti0qWsurFeZhEYI49cQWIWnZ3c7rexuYRJ4OYj/Y/mEjcYlxR
         yjaFAh2o8JR+p/Cca1aceicCfVU+q7IHag8HwBFzKW7y1WaOXpJu7g81ZwiuD+7awXml
         yZHAZq29gLBl8X2TtlZ7AauzoDl9DRTRkSfAQsHeJwcSyLuj0nOKG9gmEe0lI9pX3NjF
         bbvwaW1pSPJktRmFi1zeVAjTPxkBuU2dn+2furdeHDvaQSf9gXTUN3G2tfjjlVU5V2Zn
         V0b9JAitSJH6DuxUORNqqs4xBxI1HktvQfvKv/9+Coe4CyyTFliegMaaIw81qxY9uUA0
         sC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNFtWXNjGOhAnzhZIEB5pnyB38+rxkkPxxFke3J42dU=;
        b=JUiJw14KGJvFwLOfpLdW67gkDbWuIYdopz1IC8oKFqy4M6Dg0IEaeVshscVWQVHrtH
         sCep36gcBXZC+FgWbXWx5SbJNjxmBl4AUDtkLDAR1aEVcdiSO7DGxrj5xmFtnr802J8z
         3mUAwlyJqPYUxURi4Bu/JwMNx905oTMkPiimiz1/K9vK4SRmUTdulL2LmWzVP4FSaFJa
         ykwJaS9uR6vweqUHY5UjJikWErIWV5x9Dzr0igdgQlg35NXvOdwbBlqLskF5Nui10Rwv
         PTvYYYG5RSNgVRsanBpCCd6OeZhVxdPh/C6c/iodvaPL/TtsYLQiLtaaVyJ2bq2ze2N8
         3gEg==
X-Gm-Message-State: AOAM532zYwPTLkMrREMOh6LIN1USPNNf4EPWUotsqo1C6nE4WG9Y17BS
        vwOejUs95ce1L5vZdWLIJQ==
X-Google-Smtp-Source: ABdhPJxrk2zpxNArotZZCA4evEMOVPnLf5LCF7KZ8yY4PiSqXrjB0JYSxy1zVM4W6d0H6YcovlQiAg==
X-Received: by 2002:aa7:d61a:: with SMTP id c26mr9966117edr.351.1622207170190;
        Fri, 28 May 2021 06:06:10 -0700 (PDT)
Received: from localhost.localdomain (ip4d17b4b8.dynamic.kabel-deutschland.de. [77.23.180.184])
        by smtp.googlemail.com with ESMTPSA id u21sm2322778ejg.50.2021.05.28.06.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:06:09 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 0/5] drm: rockchip: various ports for older VOPs
Date:   Fri, 28 May 2021 15:05:49 +0200
Message-Id: <20210528130554.72191-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

this is v3 of a series I posted almost 1 year ago. I considered now all
feedback I got at that time.
It mainly ports existining functionality to older SoCs - most importantly
enables alpha blending for RK3036, RK3066, RK3126 and RK3188

Note some of the patches are required to let VOP correctly process the
data that comes from the video decoder - I recently posted a series that
adds support for those older SoCs at [1].

[1] https://lore.kernel.org/linux-media/20210525152225.154302-1-knaerzche@gmail.com/

Regards,
Alex

Changes in v2:
 - drop not yet upstreamed dsp_data_swap from RK3188 regs
 - rephrase most commit messages

Changes in v3:
 - add patch for RK3066
 - drop patch that converts overlay windows from
   DRM_PLANE_TYPE_CURSOR to DRM_PLANE_TYPE_OVERLAY

Alex Bee (5):
  drm: rockchip: add scaling for RK3036 win1
  drm: rockchip: add missing registers for RK3188
  drm: rockchip: add missing registers for RK3066
  drm: rockchip: add alpha support for RK3036, RK3066, RK3126 and RK3188
  drm: rockchip: set alpha_en to 0 if it is not used

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 52 +++++++++++++++++----
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  1 +
 3 files changed, 44 insertions(+), 10 deletions(-)


base-commit: 5d765451c2409e63563fa6a3e8005bd03ab9e82f
-- 
2.27.0

