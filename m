Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B646403F78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbhIHTJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhIHTJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:09:29 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB6C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 12:08:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bi4so4380392oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bw+JG+aQMrwPzIAhtsSSwIELKeZ1QyarX3T49Luud4c=;
        b=TbXlV3D9n7GMa1t1MJOGjHEwWpRdK7WxXe/JR06eo5TUDQYhiXt0NZpizFDnpJDQhZ
         4OaPfdJfCFEOtUdnhdH4O9DbKAxNnrIT7MiDfXdWYDJFrSW4YolXKDKnDwh0HkbjP6zD
         uoF4wqd49GJl9rA+GVBV6vbEd1CpVG9XxrjLb+2nZJI63KzMVpq1yWSiLjPHIZpPWbiY
         BtuFVFW4Ly6JdO42eRKB3VHvXVE8p4/M6CHeb7AyF/ZU+1wGPPp7tmpN2nZlzg8bhgXw
         2yWjaP5/icauhrhgp1eiD3BElRoFrWuSPQVKBfL0oSuJkiT4apceWJKzwRZZ5DajEiyQ
         Bb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bw+JG+aQMrwPzIAhtsSSwIELKeZ1QyarX3T49Luud4c=;
        b=EUF9r51ZJZnnzVpPG/zCyH1HODYnhHgc/L0mtNcVueNO/RKcoBjDYVDj2IKMK6CFlV
         QSHv6x+jmFW8CVEJSiR6gi2R4mTXf4Ivji2Z3INmvXLB4k0JZcqWn/w/xxgSr527uHS8
         TI8UCEPuwgn1+Re/1iFRKzlkV8zSjIF+YCH59gEFs/Kxkf3AluYB+zZum3Q+5Ld2PW2F
         LKoJXfi1CkF+0q220f4q29FjfFidzpIkHjN5pq+diqkXxy7pbUzwge67jQSzITp01L7t
         YpXwB15FI/2JDa2dDkM3k3YxlDDVlrp/lyyUrchS6ISwExigMd5i2Mfmf4jE1W3NeY8B
         j6pw==
X-Gm-Message-State: AOAM533lAaTDbOo11ytH29aZjSJAPT9sIMElueVwJKVMd8vWnS8blS6e
        lgqmn54e/sVMVm6XelDH1Ho=
X-Google-Smtp-Source: ABdhPJx5bURId7fRLqo29FhLyipAcn4Q2zfAltA/3QWnCbeeW+Tdz8wJYdLDdGu8vIjxCvPSnGob9Q==
X-Received: by 2002:aca:5f04:: with SMTP id t4mr3563120oib.53.1631128100985;
        Wed, 08 Sep 2021 12:08:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r7sm591936oog.48.2021.09.08.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:08:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] drm/nouveau/nvkm: Replace -ENOSYS with -ENODEV
Date:   Wed,  8 Sep 2021 12:08:17 -0700
Message-Id: <20210908190817.1213486-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvkm test builds fail with the following error.

drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c:
	In function 'nvkm_control_mthd_pstate_info':
drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c:60:35: error:
	overflow in conversion from 'int' to '__s8' {aka 'signed char'}
		changes value from '-251' to '5'

The code builds on most architectures, but fails on parisc where ENOSYS
is defined as 251. Replace the error code with -ENODEV (-19). The actual
error code does not really matter and is not passed to userspace - it
just has to be negative.

Fixes: 7238eca4cf18 ("drm/nouveau: expose pstate selection per-power source in sysfs")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
index b0ece71aefde..ce774579c89d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
@@ -57,7 +57,7 @@ nvkm_control_mthd_pstate_info(struct nvkm_control *ctrl, void *data, u32 size)
 		args->v0.count = 0;
 		args->v0.ustate_ac = NVIF_CONTROL_PSTATE_INFO_V0_USTATE_DISABLE;
 		args->v0.ustate_dc = NVIF_CONTROL_PSTATE_INFO_V0_USTATE_DISABLE;
-		args->v0.pwrsrc = -ENOSYS;
+		args->v0.pwrsrc = -ENODEV;
 		args->v0.pstate = NVIF_CONTROL_PSTATE_INFO_V0_PSTATE_UNKNOWN;
 	}
 
-- 
2.33.0

