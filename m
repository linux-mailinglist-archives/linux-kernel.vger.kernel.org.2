Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82BC4331DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhJSJMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJSJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:12:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F837C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:09:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s136so15530937pgs.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWnbQ8jU1PuImQqBMv0ymywpDSXRWIX4TYs4htudQvU=;
        b=T+qGMFI1Iki8b/Y+kZzqOqZraGT2XFyr4W6PlZ1/AfRn3y9xSqmhpBEwtqJMGold+z
         rnHdGjDoHRYTSIA44vssYy6OHST8h8ARi/BvWAJ3AeX6rFmD/YO5v4p5xWgQwjO9iox1
         EEl0QSwFXw1D2t2zyTyKtf6eyR47zAJ+U2DN9el/UUGQhTMeG/sydPQT+7TPonuYa0Rf
         a+E51oQdw8ZnnP1r7JEKaulvSNcEmGNDzvV1EZYKpQaeTzNQKvVGLK1Tz77CLOEKctH3
         h9Ljolm7uOjZ4cmp/UbgEcGm/RVz1rF8QDPvfcKcEO7lMOYoAsrf9XpUJicBwQIEnR3J
         0rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWnbQ8jU1PuImQqBMv0ymywpDSXRWIX4TYs4htudQvU=;
        b=7c8L6GHsbfj/Bt58pH3M2u/8uV02yOwrLQj04raFo/KzEAL4mWvFE0ZIdVyvPr2ymR
         fM95Ux7zU/FaoS8MPLA3GB4tpE9oRffTJoKAQXoWoEoLPc3fsQHpVxIKxhMiw4WKe73D
         cuqleJWP8HScU3EcC8+nYzXxmJ34ytC3LskiwGs/SbMLiJcOy+doaJJkeMs1rI0bshxD
         PgFd00O14qBxYZsYp522vhNP9crkO/tD8mq4yYd24y8Pb53hPyUa+Y5xXz0Xo3yfeDSI
         RzHdqaLD8vJ9TxE3ruwH9m3nisuzDozOjxIPaJxQ8lEqTmqvnjoMsgLsk2zZQXvC1RKX
         xLhQ==
X-Gm-Message-State: AOAM533EqM8Yc/GyOrB3GIMf2kNZKo3iI1d3nLUUxv6/hUDGLRjJ13L2
        ApMrzk2fOkHnKJ2e2sAByDM=
X-Google-Smtp-Source: ABdhPJyj4NHbAw6lgwjnvbqwCFC137XbpGUbmoictCNKRA5/xKzV8TGBtI4cQiSXyifrWKEmLEpixw==
X-Received: by 2002:a05:6a00:1398:b0:44d:3234:dc31 with SMTP id t24-20020a056a00139800b0044d3234dc31mr33841668pfg.7.1634634597954;
        Tue, 19 Oct 2021 02:09:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v22sm15934057pff.93.2021.10.19.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:09:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     bskeggs@redhat.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH mm] remove duplicate include in nouveau_dmem.c
Date:   Tue, 19 Oct 2021 09:09:51 +0000
Message-Id: <20211019090951.1004859-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Jianping <ran.jianping@zte.com.cn>

'nvif/if000c.h' included in 'drivers/gpu/drm/nouveau/nouveau_dmem.c'
 is duplicated.It is also included on the 36 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 1 -
 1 file changed, 1 deletion(-)

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
 
-- 
2.25.1

