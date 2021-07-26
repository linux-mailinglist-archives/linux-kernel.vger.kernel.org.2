Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082423D5B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhGZNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhGZNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:49:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40090C061757;
        Mon, 26 Jul 2021 07:30:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso3438135wmq.0;
        Mon, 26 Jul 2021 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9mdNRBSE2nmfxCbbmaZ9R6rroSXfEMN6m1UvIoQOmnA=;
        b=FvGcWdwUnbNIaL8TDYLS+ennc5MxRzahTD0sk6YtW/+HZ/J8J/rjbuMQxWmgdmDfEg
         2p9hi46+a0robjaEQeyha30xz6ePBtSNXRpfk8ErgNOcYRJJgEyfsfyLaoJgzSx2EdwU
         3kapaskTNYgHKFKr/dpceVLhe+IlR4o4OQv2P7TH8wC1+kvm/DzXQsGGjVixwiZzxVIu
         GzAQ3aMG/eJ+QYV6Zm5X1/zJdTlmfQha/vU/rx7sn+0LPV4AMrdZ785JTP4xdtbhKLMn
         9q6aqqISpDSz5jpgXknQXlZWUKKZVtvzJZfdkQN2WL1TrNiQlHnHUWy+GnKG+MW3diM/
         ZVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9mdNRBSE2nmfxCbbmaZ9R6rroSXfEMN6m1UvIoQOmnA=;
        b=lW/3n0wnaQ5zNLwkVBoJphH6YbKmx3ItWXVyDK2r7G7RgHQ/eqKupFfuoNVVHWEce/
         bvJGZ2nRO+xviyKmPmllONk9TlMsTszqZS+CCirtI9QIX8ccga84c5syPbyvtT4pYDaW
         8ZtDETBd995gQPlHh/qwsey8CKWSuYTpk2IdbPt4Wx8CD5VLx3e1YGLhjhREZqI+o2f+
         Cp9wD3snxvNa1Eu4bKGXXgww/nebzMrv3YQ6Nif1W6zPtpiO++DpW4H9Xovz09naxoZq
         UUZ6CH9iGnIsL1VEsYhV9SRHfwPGhwlIVwDZVexnPXavzcZ42HqU0+DWNSQOx7toBnZZ
         JSKw==
X-Gm-Message-State: AOAM532IVyO0yl3iZmJRwSjXYTx+4SIAFctOq5lVnG0iDqNMFQROfhXq
        TfiXx6Mv1kGcUnLU7PTuSr0=
X-Google-Smtp-Source: ABdhPJwrDP7dV/kPfzS6fK85h8yfuXepeByOIw3g5Enpqlzx7y+lyubC2602mYUwKPSS6mC6ZbkNIA==
X-Received: by 2002:a7b:c939:: with SMTP id h25mr8950355wml.13.1627309807846;
        Mon, 26 Jul 2021 07:30:07 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id o17sm9176609wmp.31.2021.07.26.07.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:30:07 -0700 (PDT)
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
Subject: [PATCH v3 1/8] MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
Date:   Mon, 26 Jul 2021 16:29:36 +0200
Message-Id: <20210726142943.27008-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 836863a08c99 ("MAINTAINERS: Add information for Toshiba Visconti ARM
SoCs") refers to the non-existing file toshiba,tmpv7700-pinctrl.yaml in
./Documentation/devicetree/bindings/pinctrl/. Commit 1825c1fe0057
("pinctrl: Add DT bindings for Toshiba Visconti TMPV7700 SoC") originating
from the same patch series however adds the file
toshiba,visconti-pinctrl.yaml in that directory instead.

So, refer to toshiba,visconti-pinctrl.yaml in the ARM/TOSHIBA VISCONTI
ARCHITECTURE section instead.

Fixes: 836863a08c99 ("MAINTAINERS: Add information for Toshiba Visconti ARM SoCs")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d69b2d4646be..615c3e41cf92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2712,7 +2712,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
-F:	Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
-- 
2.17.1

