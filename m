Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E3738AED0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbhETMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241715AbhETMn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7024DC05649B
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d11so17359381wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RiZqS9+1VsUhQi4zCxRm7Qw/CQ+SCMejCROZ7vBDCII=;
        b=LeaXNvmDhLUKi4BpNVSHVz+CuQI0q/bnPzQUee6sPiX5zlHptWrRN5TnlO/9eMmO3d
         RGyObjyUw2hvL4jVWFP4RlE1K8EJBpiwCVh/smcZB4ORsXMIqkXNyj8uczuQitGuKpUB
         O3p1wIPaBo1bMpEqD4d4dUsMjy5nfPwOQK/cxGLjSwb0Wz8xA8F9z7vlGzuZ+Gva+5TY
         TnXjJCpxlD+w5dkect5TfTUzDdZPuSx7aS7Ao4r801uP97zZSNfdf3DjpugBhJ9+GSHT
         W5kWvP2N271CNZ3lHnoSg7bM25HzaEzuWdI/q5c+IPdKq6MHCj0ivH65XU2V5JsV2PG0
         SfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiZqS9+1VsUhQi4zCxRm7Qw/CQ+SCMejCROZ7vBDCII=;
        b=i78kTzcBtMhlWvf222yfaxKXjWKrHwO7g1SzO+ziESwOyqCSVKVJnDDELnoyBvI6ii
         nAUqGV7/Y4SZOVNEv4pLH7s/8xUZlcMRjeNyRow8KHkuRQlfNUBH5dN31hYoJqh3IKth
         hm6u3ZY465Ewub7dGiRBsW7u+Y00ETmub3DQmj8RS1JXRv1f4bbm2410/9XOKbnzmM3G
         iK4I1LXoeJAmybD2jJjoy/XGlABCf4KbkA9CmQwdcdIqZxhZyWbxvF76W5d+X3bifa/W
         J+LlBNteavYtAN4+Lf+3D9liSj7GB/FXOQ05JY+vh7nvZoTasmx4SEPeSYk+lnUWNeVJ
         /jzA==
X-Gm-Message-State: AOAM530ONcXjhKfy2TFU9hNTO56FZScPEb61WHXoCr2PtlfK+/s1mrPs
        Q02XVU6LIEM+FLeO92FGObECIw==
X-Google-Smtp-Source: ABdhPJwNbytM3HbZfJrhsQBc/jh4ZR3fXPG/OAOnPVHn358PMshvhBLhygc8EHr8vcYofNRgWWb9Ww==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr3803164wrx.226.1621512193588;
        Thu, 20 May 2021 05:03:13 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 21/38] drm/amd/include/aldebaran_ip_offset: Mark top-level IP_BASE as __maybe_unused
Date:   Thu, 20 May 2021 13:02:31 +0100
Message-Id: <20210520120248.3464013-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:259:29: warning: ‘XGMI2_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:252:29: warning: ‘XGMI1_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:245:29: warning: ‘XGMI0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:238:29: warning: ‘WAFL1_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:231:29: warning: ‘WAFL0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:161:29: warning: ‘PCIE0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:119:29: warning: ‘L2IMU0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:112:29: warning: ‘L1IMUPCIE0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:105:29: warning: ‘L1IMUIOAGR0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:98:29: warning: ‘IOHC0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:91:29: warning: ‘IOAPIC0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:84:29: warning: ‘IOAGR0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:63:29: warning: ‘FUSE_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:49:29: warning: ‘DBGU_IO0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:42:29: warning: ‘CLK_BASE’ defined but not used [-Wunused-const-variable=]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/aldebaran_ip_offset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h b/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h
index 644ffec2b0ce8..cdd426b41c20e 100644
--- a/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h
@@ -30,7 +30,7 @@ struct IP_BASE_INSTANCE {
 
 struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C20, 0x02408C00, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
-- 
2.31.1

