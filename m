Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1337F32F9AB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCFLSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhCFLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:17:59 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED1DC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 03:17:58 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so570294pjg.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 03:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xdaYIHbo42EzW4+tTrCCIBJZrl43XKwjfdhXKE79QkI=;
        b=OU8IkoIgBcGiyXFXs7IFjfZBTGGs0bWhDh2k3i2p+t5/sRh2gppxbcqpCrkBP/7Lne
         Dp0G+U77bTBi4eAhBRLbDSjcd6glcsaLr9G0ohROwCRG1diGuR7pp1U7UoQeaA2BE0zf
         x3zEuKMokoALIZ7dgB4wqajTb7GTVjLo+ocBnn6BeYOUqgNYlYxgSTv31GuDJ0kVQ6Lh
         go5XkMfJBomHLOvtZzTo1gDKE/iBCo9C78UGgbHxepzHYRDuEVr+W6DCwqgGaG12weBS
         uDDfYHxABSD2akfNtdqx15BmZcqQ2ezXQHhiYfIVTd+wZL66l3gQY191krzaNGOJsoyP
         3aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xdaYIHbo42EzW4+tTrCCIBJZrl43XKwjfdhXKE79QkI=;
        b=g24leTBGoncX4nrbhswcXfN1PWE2rkKtbH3ucqcBfkSNnMZxI1ObrgqzBkfRkSUeLZ
         Iue5/5pLpJCeLgGltrnwZoTlSMP7e9N3IZaoTMdZYpUartV1vBl2uAk+TcGl1kRhvVV5
         ezeKdo99YNuQXg6Pq7w625yA5KgDtvGb1Zs9pFr4PgWUDoRwS7Bw40WJdPufCVXYtJMp
         a47mFd9ZcMJhzGH3PyWQKZ9Ds2AX3ZSXPbrYfiQ+Gth29ecMjWt0QqtYna92nJwY/Jkr
         0fzVWb9TU6FgbA646+Wr8Xxge4RrwR/mL94arC1Gonk6Lk3ysJ1JNs8b7jSBPNGze0NE
         AKCA==
X-Gm-Message-State: AOAM533yqgJKcrMxgvLrU6mHhvCLqQYPn+PHcoTFsNUV8Fiv9dnp8jkm
        fTE948jRGMUUlDanIvGO9Os=
X-Google-Smtp-Source: ABdhPJx4gWaZVfPNcXcXFDwquU8hwFVxF7LWE6D2TVf8jy2qAw7j6kTV29gabrWD9ercYIzdRabKrg==
X-Received: by 2002:a17:90a:6286:: with SMTP id d6mr15012274pjj.234.1615029478197;
        Sat, 06 Mar 2021 03:17:58 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id u15sm4925194pfk.128.2021.03.06.03.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:17:57 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     bskeggs@redhat.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, lyude@redhat.com,
        zhang.yunkai@zte.com.cn, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: remove duplicate include in nouveau_dmem and base
Date:   Sat,  6 Mar 2021 03:17:51 -0800
Message-Id: <20210306111751.216932-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'if000c.h' included in 'nouveau_dmem.c' is duplicated.
'priv.h' included in 'base.c' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c           | 1 -
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 92987daa5e17..f5cc057b123b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -33,7 +33,6 @@
 #include <nvif/if000c.h>
 #include <nvif/if500b.h>
 #include <nvif/if900b.h>
-#include <nvif/if000c.h>
 
 #include <nvhw/class/cla0b5.h>
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
index c39e797dc7c9..09524168431c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
@@ -20,8 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 #include "priv.h"
-
-#include "priv.h"
 #include <core/firmware.h>
 
 static void *
-- 
2.25.1

