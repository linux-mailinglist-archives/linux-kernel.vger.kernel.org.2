Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463BF3B4F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 17:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFZQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFZQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 12:01:03 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD2DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 08:58:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v12so6319318plo.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z2zRyBuCyuLZys6i1b2AqM0hkjmyNcoVBYJnGdBI8Pc=;
        b=lbMdk9t0iT2GxQb6+2WLD/lQAAjx1RelzUvkjlQ340vXxuAqa5KKSLsN5RPeMRDf1U
         QCmUO6p0AYN3sEmLH1hUljVV1npDjEmg5HerhV4wnugiIF/qWWrWIr/9kydAQ6eCTjk0
         oEeMcWHKcS3pAIyT6yKonCUCJRPdN0Yn+/D3tQHE19chSSlhgeQCpe9y98pxXrrOGQNB
         53PJ8GHUIXi3iAiTyE3HGCN2gLByCwaQtKfsS518EZd0OsI+ocPk4y7yau+Wzaf+d6wa
         +JJQBhUn4oRgc9nmp/TUAzRK5oKqR0aot7x1/SbNjA7rP0ozVpqyEOTr8IGBXRHPpYtm
         uZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z2zRyBuCyuLZys6i1b2AqM0hkjmyNcoVBYJnGdBI8Pc=;
        b=MlZ3/hTSBPgdYjtHanEkaKR7YYh4hOkXaKJiwxG4ND7oGnlFRxRA+nE/wpOPyBsNJx
         ZoNm9zfFU+vworlZXcvz3FXsfyCmsq4R0PK8xHCuDOfjVLdbyVftEg+KRlWdrGSaCwp0
         ruTX6EhivsJ8BV+MPO5KXeT/puR6elTZR73yWuF0EjXWkmXxDyLBGrARoWryWuS3CSIh
         30Yo8V46vTNTPUTdsnMMOdpJPjg0DNgDI256/2l4FwVz15nNveQ1Hpq9RGZlj64C8+WK
         glJLeKhGUoI7dsFs0BuxOEkCVOOQU4C/UjzZU5X/uOP2yqhhXauoH7dhuEw5bTzcdc4n
         OdAA==
X-Gm-Message-State: AOAM5324brzL4VfYsaHn5TW1fQA2H6j5aUaETaZQ4GEvlK0DqekqFxUC
        i2kHCkQaug+jmedhONqRZx0=
X-Google-Smtp-Source: ABdhPJzNdyJcHwtC+v/Kn/QiLyobYLLDxg4yOPLBi7N71HB0qxN/5P1ohMJEji6MJIIZyuQTdJQCOg==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr26923494pjj.165.1624723118208;
        Sat, 26 Jun 2021 08:58:38 -0700 (PDT)
Received: from localhost.localdomain (1-171-6-245.dynamic-ip.hinet.net. [1.171.6.245])
        by smtp.gmail.com with ESMTPSA id n59sm2164807pji.46.2021.06.26.08.58.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jun 2021 08:58:37 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     axel.lin@ingics.com, cy_huang@richtek.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: rtmv20: Fix wrong mask for strobe-polarity-high
Date:   Sat, 26 Jun 2021 23:58:32 +0800
Message-Id: <1624723112-26653-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix wrong mask for strobe-polarity-high.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
In-reply-to: <CAFRkauB=0KwrJW19nJTTagdHhBR=V2R8YFWG3R3oVXt=rBRsqw@mail.gmail.com>
---
Sorry, it's really the typo.
This mask must be bit 0 not 1.
---
 drivers/regulator/rtmv20-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rtmv20-regulator.c b/drivers/regulator/rtmv20-regulator.c
index 4bca64d..2ee3341 100644
--- a/drivers/regulator/rtmv20-regulator.c
+++ b/drivers/regulator/rtmv20-regulator.c
@@ -37,7 +37,7 @@
 #define RTMV20_WIDTH2_MASK	GENMASK(7, 0)
 #define RTMV20_LBPLVL_MASK	GENMASK(3, 0)
 #define RTMV20_LBPEN_MASK	BIT(7)
-#define RTMV20_STROBEPOL_MASK	BIT(1)
+#define RTMV20_STROBEPOL_MASK	BIT(0)
 #define RTMV20_VSYNPOL_MASK	BIT(1)
 #define RTMV20_FSINEN_MASK	BIT(7)
 #define RTMV20_ESEN_MASK	BIT(6)
-- 
2.7.4

