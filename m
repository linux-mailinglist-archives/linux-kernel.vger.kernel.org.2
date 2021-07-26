Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00DD3D5BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhGZNt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbhGZNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:49:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FF4C061757;
        Mon, 26 Jul 2021 07:30:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j2so11299944wrx.9;
        Mon, 26 Jul 2021 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OYJH8WVN7p/hRjDk7AHd6O2dIHni5gF45DfiSQQ1ZSk=;
        b=KzcK6c7Serdrruue33VewS2DrKQW4yc7H9fVtCRt0t475VVytYX1jtr8Z6ch4UQH9k
         1gahpAaM1vybQ2PjHm0jhiwP8Bwq2hR7RjdywkbZlj8LJPgx+h4fHRC2Y1OBR7X84lbm
         4D+XVioo+xAgdwRZphwDu5/pe3bTPXnMsMwDu6rhUv9lV+w1nP/wYcoomT0u8FJTPiba
         V3dXNUwpq9nXbmnF9yZZ4vMp1U8FPkXsq131OyjpdOQ20iVMQMPW7xCL2GmgWlOv8vci
         GCO8O1c9rBycj9Jh1Osx5FNY6CDAUNa0g4UOBmfpwGCclXbaZK7XStJty+RBjzYSeji1
         D0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OYJH8WVN7p/hRjDk7AHd6O2dIHni5gF45DfiSQQ1ZSk=;
        b=V0EaCI0l2ERQalKQGEOWdAGgZ7plgWoDPC0AwPQ+qyaw+k6RNRXvVt4ehuJnOruuZI
         CcHAtqJIC/ZCCFIosv727Ymu3Bcj154aAJ3DQQrMu3RRpM2APiNMT0ljq7y/30iEd+E0
         qFFbNz9rbtyT53kkyGr7MiJUXGYYGznmmL56eNmYXreVqcNC8HdfOsM5gRbMnyW+QHFE
         S0NB7BFqr/Q4d0CxCcv/vnh03Opbhbta66LnrSXg0ogr1vMSVMoMcY45i4HxlTf2wMoO
         o4w27JdMkvzGA+ZdVfQ343dph4htrPmrCRLm80ta50RGNt/VuoGIjIn0bkC2rL1uN6jv
         Cifg==
X-Gm-Message-State: AOAM530hW05Do+gajB5ZxRQ8ngv6M/sWS0pr9QT3SmVO2LqEeNXFVxFO
        cqYEruT2k1Dyp7Ag8zcv1cQ=
X-Google-Smtp-Source: ABdhPJx1971jZQpEYPn0Tg3fcJKdtG1MlFbID/ONtP3qNKfUtaUqX5jp35HjV8Y/+ZrsChTrRFixsA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr6109404wru.85.1627309815615;
        Mon, 26 Jul 2021 07:30:15 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id o17sm9176609wmp.31.2021.07.26.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:30:15 -0700 (PDT)
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
Subject: [PATCH v3 5/8] MAINTAINERS: rectify entry for ALLWINNER HARDWARE SPINLOCK SUPPORT
Date:   Mon, 26 Jul 2021 16:29:40 +0200
Message-Id: <20210726142943.27008-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock") adds
Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml,
but the related commit 3c881e05c814 ("hwspinlock: add sun6i hardware
spinlock support") adds a file reference to allwinner,sun6i-hwspinlock.yaml
instead.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches  F:  Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml

Rectify this file reference in ALLWINNER HARDWARE SPINLOCK SUPPORT.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c5a407015e2d..8f36b6763073 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -755,7 +755,7 @@ F:	drivers/crypto/allwinner/
 ALLWINNER HARDWARE SPINLOCK SUPPORT
 M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
 S:	Maintained
-F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml
+F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
 F:	drivers/hwspinlock/sun6i_hwspinlock.c
 
 ALLWINNER THERMAL DRIVER
-- 
2.17.1

