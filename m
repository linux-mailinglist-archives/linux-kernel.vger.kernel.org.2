Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4F3240C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbhBXPZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbhBXOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:48:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED87AC06121D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m1so2059074wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4kcaWc3A3e2JpDYvEG1HkJ7RHkTySsh0QGk3axijlk0=;
        b=zAWYfmcRa81N8ayfCtv7YISYLImGL3DtFIgXnH8YZ82jEbqtH8t1om/1yRzEU80h8S
         uv5Y98HkbEi/Mb/lBNbhpZa931kwWUymnps+vlG0AsrbjF4qB8d77f6R9s1pR14nfDy3
         NQBi6DnKQRCqNEna/JcrzS8YAdLVnkiThf/49nhLv7kTFLJzHt5Wh1rUpjp0caU4M5V3
         4C7hGu6Yfonujcxtycnfrka4VAEYXKUV+SFES403HdoKD50OPG5cUJeXOSqfx/bhKRG0
         eltMsneu9FwwFUEzgJv1vAOO/WprVJWcEe+lVtkdzDXQVUgU2GYyr/EAVOmYPx2mVJwW
         RQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4kcaWc3A3e2JpDYvEG1HkJ7RHkTySsh0QGk3axijlk0=;
        b=CxU9OQ7N8nqnRLtcOd5WQliUjL9queHekbFh7dt2bxne43tlinE/94/av8Ff3XoYYW
         9W/jfqdVR9R3Xzg7mq+lUt1gIFutmxpAgjQH5PTqE9eUuwSNOTz2AxJ0knU/yXClFirm
         oqZUsCGxCe5J/N8EvSbWCPU+v90LO0DuA1D5GI7bpXfcNA/P5stty5nNo0eLeTc5aTBh
         zNlGzW5eQoXgqbPgYBq9LMVfH9dR3hnFh3pw+FfuvXMJTzRBTzm1HxGJErXCmYIaYXQJ
         0HG86hMGVEXjqj5Kqn6G0Ur8kF+ppCIOK8k/y11CsUZzFaw/37SlywVprbH9zUOgnwc4
         g1kA==
X-Gm-Message-State: AOAM532LiCdiAYXV4bruBxrdOe/HrFesDo3lfVm6Nyv5Utw4/BNPSUVi
        xDp+2FigLnhZD3FTk4PwoivJoA==
X-Google-Smtp-Source: ABdhPJyZD7BW+LIu4wbjkLZsjSoMWfexoyGfPB8WVBh3k+PENCICivX461RCP92G6r8IrNnAdG9zrw==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr4037793wmb.88.1614177777616;
        Wed, 24 Feb 2021 06:42:57 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:57 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH v2 9/9] phy/drivers/stm32: Use HZ macros
Date:   Wed, 24 Feb 2021 15:42:19 +0100
Message-Id: <20210224144222.23762-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index a54317e96c41..02dd12bb4692 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -14,6 +14,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 
 #define STM32_USBPHYC_PLL	0x0
 #define STM32_USBPHYC_MISC	0x8
@@ -48,7 +49,6 @@ static const char * const supplies_names[] = {
 #define PLL_FVCO_MHZ		2880
 #define PLL_INFF_MIN_RATE_HZ	19200000
 #define PLL_INFF_MAX_RATE_HZ	38400000
-#define HZ_PER_MHZ		1000000L
 
 struct pll_params {
 	u8 ndiv;
-- 
2.17.1

