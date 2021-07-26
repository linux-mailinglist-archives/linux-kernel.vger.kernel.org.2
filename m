Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F91D3D5BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhGZNuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbhGZNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:49:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1FDC061799;
        Mon, 26 Jul 2021 07:30:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k14-20020a05600c1c8eb02901f13dd1672aso117435wms.0;
        Mon, 26 Jul 2021 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zmEnUninoDDVw6qOk4K+IxgHAla5sREvr231jQJ9B0I=;
        b=eHpAfXjWNyt5wEuObsyvgqyo/sdjJa66t3ti+AkrFWIxkSqIOEMwfGuVpXZDY9cATW
         dyO3SC117JeiNXe8V1JmHvD6YRUCjvOQi5Bj/SO8Pip4dOBDbnIXyPxUBSfbSNR2icAL
         Rd3my0wKQGeea6Lii1vlOCt6hEVW5KLLBwn8MVJ4TX2B6L5djN1TqvtFdMz0rlhGV5Zw
         jAXftFC16bxD3PkwqkoPIV5oo/LnE/JYLVbqqWynSJLa2bfjXmqoghwDfoagdSDEaHtx
         UYHs4A6e1uJmYHMlKk7rfx0xfa85CqoWh0Eutpz+Tk7044iTdZuYYCXvfJwz1ogICVii
         4epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zmEnUninoDDVw6qOk4K+IxgHAla5sREvr231jQJ9B0I=;
        b=Qo0vN02g5l4qFc1wz6FKsFMU6xnBid2aS3s5DEOdzEKcVYXZCWVsfQyhp3HGc4cWh1
         niO191YFUwYqp5RUaijRSVVNCqyaTI7gbTBAN9PuMzkaGPcbKNnfh6ADjbiLq3sRj5tv
         L+OltZQsw78D/NYSl3dV8yNiqdPcdTBurZiE83lrXR2Ag3D//mL0MMZRIt6yHNvZAuAx
         OrvCcs6wSQ/gYEfz8y8f9WpGsExlyGABxHk3RKPmbwlbcFeaooYCknWV2XIw2RIOzaK7
         pGblClTqcZthYsRJv0sKDSv/dx8jp1/wjt7I4w9kUCdRsWJz0PCKW00w90SDBPORBlqu
         YUFQ==
X-Gm-Message-State: AOAM5310aeEYmx3Txj4FTJishruUOVgy7runG2W0OZRIjWiFF8umfqLQ
        kRO0V9/8zaQQ4yh4rOUqxl8=
X-Google-Smtp-Source: ABdhPJxGTJM0zz6F/vsL6XdmIWYJioSRVoob3A+gGjhpcQv21j1pkZcYYWtPDuJAutBRZVkAVPv+mg==
X-Received: by 2002:a1c:3505:: with SMTP id c5mr26528052wma.53.1627309821219;
        Mon, 26 Jul 2021 07:30:21 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id o17sm9176609wmp.31.2021.07.26.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:30:20 -0700 (PDT)
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
Subject: [PATCH v3 8/8] MAINTAINERS: rectify entry for FREESCALE IMX / MXC FEC DRIVER
Date:   Mon, 26 Jul 2021 16:29:43 +0200
Message-Id: <20210726142943.27008-9-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 96e4781b3d93 ("dt-bindings: net: fec: convert fsl,*fec bindings to
yaml") converts fsl-fec.txt to fsl,fec.yaml,  but missed to adjust its
reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
a broken reference.

Repair this file reference in FREESCALE IMX / MXC FEC DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe43695b58c..187c76bb42d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7365,7 +7365,7 @@ FREESCALE IMX / MXC FEC DRIVER
 M:	Joakim Zhang <qiangqing.zhang@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/fsl-fec.txt
+F:	Documentation/devicetree/bindings/net/fsl,fec.yaml
 F:	drivers/net/ethernet/freescale/fec.h
 F:	drivers/net/ethernet/freescale/fec_main.c
 F:	drivers/net/ethernet/freescale/fec_ptp.c
-- 
2.17.1

