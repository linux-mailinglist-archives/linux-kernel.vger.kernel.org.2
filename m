Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCD3E8F84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhHKLgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhHKLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:36:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6FC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:35:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k2so2244931plk.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocNu8t+0vPe8xDuDrmXUgxK/R5Hfv7t0v2kfkL1QOgA=;
        b=B+dx6gtSem9LSUSvN8E6giOkQHucQX2rfdWvdRiGZVmSPgioJxHNzz96Wv/7YAzK/m
         JyrlpDgL5bOF6eMtXkydeAbLGqIVrhMrKIOcRV1PJmBbaTyLJ7prchjvpW3b/9EJ4Gcf
         ateFz6QnoBeY6tSGD7pStGh857XyHpTJPAPNYmXPvvaf8f6DMcrxqyD04zVorltoKP3z
         E9/BFvyIJiHW/R/cj3ZR88UE93OebnOpVaMGRh8SMPHgat07me51s6HqtWI7CNWbMEe0
         xEtnFJU2f52n+5cz37RdDZfaSwfAZp2z2D4FqRC4OCW3n6bDmRvJZFMhXfWD/Tci4rTh
         0rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocNu8t+0vPe8xDuDrmXUgxK/R5Hfv7t0v2kfkL1QOgA=;
        b=HmZbE1vaXClSQF4Jpfc7+vvWXaiaS3mK9Kb6xMIRciZ63AaUg2wv31lkbdRq+O7IYe
         UPaAwmJiv5kfv4wRBJY+Ot4tKN7hg+27InhU6TIDRMO1uyWar5hMKlm5TgWzRnxbd2B+
         1jzjB1yU3RtQO+jbLYAWjd3two96ER9BuQCF1fEU1CbMZ3OwsHA4eEl/JP++cqYurhlj
         EXbH/R6kOHY/Sj7VCpQLRMuccFTxJeOKh6qIAbPGYFvE0KezU05PkfhYeWnRgtkfDz/Y
         x838v68vaC7x18+dUHfMDT6gtEBma9Jp3D3w/L4PiB/BgwaiVOX3z6xyAe1TaXn/iROq
         HZXQ==
X-Gm-Message-State: AOAM532Cm1bOqS4xttGuCH5Xj/SZ4IgQEkry8wTIGRcZNlS1qsa18COW
        bD8socTKvbOBcHDWPV9AQQ4=
X-Google-Smtp-Source: ABdhPJz2SBVANXMZ07VbSSh4pznTgoL/y9wtPx7R4CwSyd5hF9Ctj75Fuud9mXAdwAvfcZj7S9//6A==
X-Received: by 2002:a17:902:8543:b029:12d:461f:a6a8 with SMTP id d3-20020a1709028543b029012d461fa6a8mr3905116plo.1.1628681743298;
        Wed, 11 Aug 2021 04:35:43 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.103])
        by smtp.gmail.com with ESMTPSA id c12sm26423669pfl.56.2021.08.11.04.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 04:35:42 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        luben.tuikov@amd.com, tzimmermann@suse.de, sam@ravnborg.org
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        Tuo Li <islituo@gmail.com>, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] gpu: drm: amd: amdgpu: amdgpu_i2c: fix possible uninitialized-variable access in amdgpu_i2c_router_select_ddc_port()
Date:   Wed, 11 Aug 2021 04:34:58 -0700
Message-Id: <20210811113458.6940-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable val is declared without initialization, and its address is 
passed to amdgpu_i2c_get_byte(). In this function, the value of val is 
accessed in:
  DRM_DEBUG("i2c 0x%02x 0x%02x read failed\n",
       addr, *val);

Also, when amdgpu_i2c_get_byte() returns, val may remain uninitialized, 
but it is accessed in:
  val &= ~amdgpu_connector->router.ddc_mux_control_pin;

To fix this possible uninitialized-variable access, initialize val to 0 in
amdgpu_i2c_router_select_ddc_port().

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index bca4dddd5a15..82608df43396 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -339,7 +339,7 @@ static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
 void
 amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connector)
 {
-	u8 val;
+	u8 val = 0;
 
 	if (!amdgpu_connector->router.ddc_valid)
 		return;
-- 
2.25.1

