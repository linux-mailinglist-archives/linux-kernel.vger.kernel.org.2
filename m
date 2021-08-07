Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579413E32F1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhHGDWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhHGDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:22:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EFDC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 20:22:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a20so9751303plm.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 20:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uh+LyNoJn+/C2qxN/x3CP3dUbi+uecXz/MsGDySkhoA=;
        b=ezLH8i5/yWdbUs21lSN0rKfxHZB7O7tAd5eQJQRyAobRiL66KcFjnL2ZBGXl8YWgv7
         PXBk6Ycu0WMVWrKYmXQ3nbaI5JuPCWaRNxpw69i4fCdhMW0oBaL0R3WJDDSbCesgT0MJ
         KoDluNQr2axDHrchi654p8etEwXWUkUQgWoGq4cV51KW9zz+3V3GgEtHVWVtCACj3R3N
         L0JsaoafAt2PKsHwkDfRSzOUbB068bK6Y692e7e/o/PFLfVoRMyHnyf/kqM/F7VuSkIj
         Hk+Q7p4qV+a2zyYHwUoIENDULn7l1DL8z10Pw2E7FbM8RtGv4+7VFlejmUa6ZqGVmW08
         vHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uh+LyNoJn+/C2qxN/x3CP3dUbi+uecXz/MsGDySkhoA=;
        b=XIrrULrCkOkOzOBoA4DLpF4fkFTEYCp4dffYD39EEvYJqmucGDZ/HE9XzpgOrgEdGF
         fYap1s5TIBGlEcx5014j9o2fNjv5KH9+eZaoWVzQL86Az9lVkl8Tud/kGtyRmaZVXid1
         liTlYbGnMckhOijZreek2LujmlcuT6cdpmz+pAvo4xxXlE6Kzb3xVG9lVU5YOJashVB4
         sp5n6nhtDXJfxWdnLtYHyWiTuLPfTyNhxhIPGKdnkbzoRw1D/7kpQELIGc9rLT/ArrQj
         dN2/jSQu3qoE7eQ3MgQtfrj9y76LtExo+D/cCrEHQCl7Us3ZQHXwkPUR5+YcfQH2C8Oe
         LHdQ==
X-Gm-Message-State: AOAM532D6UIU6xcKXVS8jXTe/q8zYnroPyq+9tUqCMoTSL1fwZTuFWAW
        Szl16/pxn3+3cwLB3/L/vyY=
X-Google-Smtp-Source: ABdhPJxYlV/B6KQ8XIFc8KckV2s869t7rvEHWhyHYWJ9BNBFNeTGgIQEAzTbbrEFuEuK4aEgh7D6Zg==
X-Received: by 2002:a63:62c7:: with SMTP id w190mr626970pgb.55.1628306539357;
        Fri, 06 Aug 2021 20:22:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t8sm13950866pgh.18.2021.08.06.20.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 20:22:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yong.yiran@zte.com.cn
To:     bskeggs@redhat.com
Cc:     yong.yiran@zte.com.cn, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/nouveau/nvenc: remove duplicate include in base.c
Date:   Fri,  6 Aug 2021 20:20:54 -0700
Message-Id: <20210807032054.642867-1-yong.yiran@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yong yiran <yong.yiran@zte.com.cn>

'priv.h' included in 'base.c' is duplicated.
Remove all but the first include of priv.h from base.c.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
---
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
index c39e797dc7c9..cf5dcfda7b25 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
@@ -21,7 +21,6 @@
  */
 #include "priv.h"
 
-#include "priv.h"
 #include <core/firmware.h>
 
 static void *
-- 
2.25.1

