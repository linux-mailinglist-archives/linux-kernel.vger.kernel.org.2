Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5E032BE6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574114AbhCCRV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444534AbhCCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7B0C061A2D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k66so6403203wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njsbuAXEhvSkC6YoNxprxAwF24DaUFg/QS4093pyPFU=;
        b=TgIkGyP9JIU32AbI5hfadU2xhCSdtLwfumK9mSGqfAJPwMDpJ6ZZqpcu4zeW8Td11Q
         lRM81CYzICCagh40F6VzmooVY7+P5gBzN26tOhDsZgvRp/hkh+GyB4AG4FYQnj65q2ji
         piYJQpj7qDS0dG5ivvzUopT+srl6Dh8w5NryTWR6YHsYwVSLrL1Vs3R5Ko/mkg7ezVPJ
         glNsEfOZLP7CZLkamEsNtZht3f8x66dFgrIzH8NvwaqkDyxMUl8AvkxgT/XYDi1Fop8D
         qynT7C6kiMsYtdGh2o7N2Hd9tL/S9YYSCTBL1nylThfIeAUktbqcBVs9FTkUXWMCxbgk
         hPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njsbuAXEhvSkC6YoNxprxAwF24DaUFg/QS4093pyPFU=;
        b=M4pd300FekcLQceSMjlYW1ZL/W0Od3+zE9/gsURlhjaDSrj6tHDXpmcrfYpz1fVS3n
         jAmyMRu5QbE8J6Xm8dTLd+T7hibeGENiuZW4zh7Y/X9sOiZTPEAaQBVl/eGDPxJuQGX9
         ZPPpZv8yGJGqK48i2xosArNfTbRyrDPTApAzmIGT8HeGVLfLtYOJv8K9jSjF4U38T3no
         RomKtNrqA/gehDqJOEId2+6QhCc30bP2sP9qy0G+RHTLU4vqTsMWkL2FEuLYq9COjhmi
         CAJYUxakOq9u8xFe/vV3Su5OtJwmwlTAsW5JMY/Gt7z8kdSU1UAJ+F9iTrRgl/IOm1JH
         +tpg==
X-Gm-Message-State: AOAM530bTGYlAf//MuGue/6CmfhtUTYg1PFdn3bd3JBb6PydGZqoCqlt
        JfJXStqxFNDtauqejEZ1+kJ7AQ==
X-Google-Smtp-Source: ABdhPJyqk61brH7edJ1UguviebdmPTyHiDQEdrRQQC/ORyoJAItYmzYPp0UF+z+6JKEAd119zC5iug==
X-Received: by 2002:a1c:a98a:: with SMTP id s132mr9569035wme.12.1614779036972;
        Wed, 03 Mar 2021 05:43:56 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 24/53] drm/vmwgfx/vmwgfx_kms: Remove unused variable 'ret' from 'vmw_du_primary_plane_atomic_check()'
Date:   Wed,  3 Mar 2021 13:42:50 +0000
Message-Id: <20210303134319.3160762-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c: In function ‘vmw_du_primary_plane_atomic_check’:
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:460:31: warning: variable ‘vcs’ set but not used [-Wunused-but-set-variable]

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-5-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 9a89f658e501c..9293dc19a7683 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -453,10 +453,9 @@ int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
 
 	if (!ret && new_fb) {
 		struct drm_crtc *crtc = state->crtc;
-		struct vmw_connector_state *vcs;
 		struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 
-		vcs = vmw_connector_state_to_vcs(du->connector.state);
+		vmw_connector_state_to_vcs(du->connector.state);
 	}
 
 
-- 
2.27.0

