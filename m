Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802183D5BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhGZNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbhGZNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:49:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376AFC061757;
        Mon, 26 Jul 2021 07:30:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r2so11386875wrl.1;
        Mon, 26 Jul 2021 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NY7Jdh2vcheUL99l0C73MV3p43fEH4XJRH7qeoF2aTI=;
        b=gCFNSiEC30xuSpN2JSI9gUbQNQsoSRF4SNfG/ZVjSBGbX8UmBngJiL+VV0cZHitV3I
         mEwPLthVkHQE8UJ1wfORPQ9H9dRNzCUIOLsH/ANi3U8Oo1xAVrno/Yw9rWBxzd8f2ydc
         xbvmHPP27KEy/NRCP1/qaqBQs+R295/KXI5xG4cBD8kvQ6tdpmbK3c6jXkYRxjvvuuHI
         u5b3fitOn0P5hwE66INrnBBWkGqsO19JNlJYUGgqeuxYaJR1QPMuVPiMI4OTN0SkB2gT
         GQ0mZ7vBgw5tEvrfgP5F94yO5JPbkPaiWGS7u5v5BvpImYvpm/p8G6CSw+XMTHNS4vwS
         jPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NY7Jdh2vcheUL99l0C73MV3p43fEH4XJRH7qeoF2aTI=;
        b=W/n3r24X6Xp5vA3laL5431SSWvQP2ujzL4/xpF8QYOs93oReTYUwLojMDfeUYkBuCV
         P+mY0+d0SU8HdpK8K/pFNJj5h3wiK0bzbQIZTTq8FufjSFd2mgtUism84RXxSbhTvlS4
         R/YvdPFx2O04Uchw68QO+h9KhrfFthRv5DWq2dfBRVxQ7c7tHIWmGOlXDm7okLPz7wQR
         zxuJHgdjo1HHTow34Nh3H36w7RDcImEELNhQbAG3fApS5zsxTAjQEen/PeROG4PB8xyr
         oRc7MUYo+XjIK8NBhhs8cLAof8fZ6MxeiB9s2qCwsuUO0Ai0VooOXjU3Z99yfVCsdBxE
         AEDg==
X-Gm-Message-State: AOAM532pYwcRQS9KwggGNUlbcTAm6C4FV/4dCrP84ftkqpCjlFRIArKc
        jmFOOc9enNDQ36Ul4NTATqlZSPFrgxsTLg==
X-Google-Smtp-Source: ABdhPJyWJ/8phK7/a+ThRet54JSgfi6uCitr4oFwrmlf6VZNhusFq4vxr83ufULEWSMeRLEfUOPMrA==
X-Received: by 2002:adf:f710:: with SMTP id r16mr19660076wrp.124.1627309811808;
        Mon, 26 Jul 2021 07:30:11 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id o17sm9176609wmp.31.2021.07.26.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:30:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3 3/8] MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
Date:   Mon, 26 Jul 2021 16:29:38 +0200
Message-Id: <20210726142943.27008-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed794057b052 ("drm/kmb: Build files for KeemBay Display driver")
refers to the non-existing file intel,kmb_display.yaml in
./Documentation/devicetree/bindings/display/.

Commit 5a76b1ed73b9 ("dt-bindings: display: Add support for Intel KeemBay
Display") originating from the same patch series however adds the file
intel,keembay-display.yaml in that directory instead.

So, refer to intel,keembay-display.yaml in the INTEL KEEM BAY DRM DRIVER
section instead.

Fixes: ed794057b052 ("drm/kmb: Build files for KeemBay Display driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a568d83096a..bd943be7375c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9417,7 +9417,7 @@ INTEL KEEM BAY DRM DRIVER
 M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
 M:	Edmund Dea <edmund.j.dea@intel.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,kmb_display.yaml
+F:	Documentation/devicetree/bindings/display/intel,keembay-display.yaml
 F:	drivers/gpu/drm/kmb/
 
 INTEL KEEM BAY OCS AES/SM4 CRYPTO DRIVER
-- 
2.17.1

