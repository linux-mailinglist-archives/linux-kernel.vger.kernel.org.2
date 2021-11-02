Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27D0442760
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBHEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:04:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:01:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u17so5411591plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 00:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQoPRk8ivYGfoPLY0uKKJcZTeIJDjKgCSjb0TdRpEts=;
        b=a4PkgHNAFD9tiKky1CA8bCU1tMMcEmSlOfw1LLmJ9Y+H7Y4klCH+G7ttV9k3ZzVWJS
         bwoigSRjS5hUNDnzflSNJDflJVufDavIQsH8P9sf+2RWlFZbqrsllWXKfuSFQzc0pc1O
         WvwJ9KDnPRGd+54acxO3tB6H3hfLJiZenHy21sAwc+FJMTGTlSEoBRrgkoxPpEKuGAsp
         +SHbwEWleQ2R2fVOo8+jSoBKzTLyKKNFiRqH+/kQ/bIDf284bEWZEm5R88zcGncsGvl3
         Z5xFpwZIhTBeulSnyZfQrFAaQ4YhiJduwUcMvWr+fnGob8+PGB56jYgxl26XNXXAcMx9
         N81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQoPRk8ivYGfoPLY0uKKJcZTeIJDjKgCSjb0TdRpEts=;
        b=rHde2dXKtHcbKCYoHX7y15Ugr6d7o7YDMMq5b3CTKNEQtFZrptAT5s6Dc/aiAdP2BB
         UV5HsUuQBBsVhtSaFaeFO4YloLQsfW3NgCGSnwed3p/wz6aP1eGUtqVILtCqJri097yg
         SRSO5l9rpXOcycxh+DBWfdtnI3/Cem+UEJw8bX1PTDeyBQ1tGFdGJxw/efyqvCC2W7vI
         5WzDTm4qaQkJ5X90/wYga/Jh+a1/9A2HjkhYli0fHeoHA5AkkI+I/1+tcfTKO6hZre3D
         hb+o87SQmMtWEp77ev+K72ZpsTAZFfUrmjKvTb6cQDGkm7HuTmMg1oXiHYzLbaodqM9u
         h7pw==
X-Gm-Message-State: AOAM533PafQZRoFPcU8XLZuk7un1tbNYiS/CClRc7BJLy8K7MzpTFXGb
        kJPBA40prMCVVpxgmbJpy57mT4+hT4o=
X-Google-Smtp-Source: ABdhPJwvd0T2hHcaD6+31RvPGMRiHpfwws6wPxEkTzrkBiAS+wxzFXvQR1utMLd7HTCdyJE0DGypBg==
X-Received: by 2002:a17:90a:4dcc:: with SMTP id r12mr4464805pjl.13.1635836500426;
        Tue, 02 Nov 2021 00:01:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e9sm13458381pfv.132.2021.11.02.00.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 00:01:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nicholas.kazlauskas@amd.com, qingqing.zhuo@amd.com,
        contact@emersion.fr, aurabindo.pillai@amd.com, Wayne.Lin@amd.com,
        shenshih@amd.com, nikola.cornij@amd.com, Roman.Li@amd.com,
        Anson.Jacob@amd.com, Aric.Cyr@amd.com,
        meenakshikumar.somasundaram@amd.com,
        jiapeng.chong@linux.alibaba.com, george.shen@amd.com,
        syed.hassan@amd.com, lee.jones@linaro.org, ye.guojin@zte.com.cn,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amd/display: remove unnecessary conditional operators
Date:   Tue,  2 Nov 2021 07:01:25 +0000
Message-Id: <20211102070125.4445-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

Since the variables named is_end_of_payload and hpd_status are already
bool type, the ?: conditional operator is unnecessary any more.

Clean them up here.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 43e983e42c0f..752a79724ce1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -784,8 +784,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 					plink = adev->dm.dc->links[notify.link_index];
 					if (plink) {
 						plink->hpd_status =
-							notify.hpd_status ==
-							DP_HPD_PLUG ? true : false;
+							notify.hpd_status == DP_HPD_PLUG;
 					}
 				}
 				queue_work(adev->dm.delayed_hpd_wq, &dmub_hpd_wrk->handle_hpd_work);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 60539b1f2a80..24dc662ec3e4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -626,7 +626,7 @@ bool dal_ddc_submit_aux_command(struct ddc_service *ddc,
 	do {
 		struct aux_payload current_payload;
 		bool is_end_of_payload = (retrieved + DEFAULT_AUX_MAX_DATA_SIZE) >=
-				payload->length ? true : false;
+				payload->length;
 		uint32_t payload_length = is_end_of_payload ?
 				payload->length - retrieved : DEFAULT_AUX_MAX_DATA_SIZE;
 
-- 
2.25.1

