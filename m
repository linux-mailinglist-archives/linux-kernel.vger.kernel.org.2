Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA323D5BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhGZNt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhGZNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:49:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EB7C061757;
        Mon, 26 Jul 2021 07:30:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z7so11283098wrn.11;
        Mon, 26 Jul 2021 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oumxn3Jn2LEwYl2kpiE/EJBXX/yFRwINl4qx8VBODL0=;
        b=K4+wFedezV5J0UzC4/E9yAtzTQjnjhqAM0snYrDJz2iL5gaHNBA0014wnXOXFLO+ki
         GYdy0DYQZS6w/2f2pfBWPoCxSGvKxxK3LmBAfUVfFKqrAbooKcFm3x29Xo0LWkBz3eTd
         VzhYYVxL4lHKTSKx9UO/l0h1pL2VFWENOzO+DFJpsfvMN31mjPahzeYTVC44pYMBCPBV
         UlRJwuTxzw+NXI9aQU07JpknMFDdcahFwSLrB3/NaEFbbT+sOuCINdipb789x/HVMfuq
         tnaqEId8KB+cZCDn2pv4qVzy2KUPniDL2AV9puLRAtfsi79hV1oAfHa9hDdXc/O7V23A
         IFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oumxn3Jn2LEwYl2kpiE/EJBXX/yFRwINl4qx8VBODL0=;
        b=ZdHcwcafHpqfzjSgUWNbNQrCCPUbc4k3jqR9Aj4jTCulUUbpOPZJkmFI2sDgzDMxkg
         e+jtp5f4C7RbDbTqUflIp8hbxMgf7Rm2/XVQdEDIhRCDY1SnycKxACjdxm0WReufJkUi
         +BXcJJHLFTGBBvWyadPtMNi+s+XbVRC1LMdv8HFTwDDCpvhmO433FmJKW34EVm+NXQQ1
         nPKZgzDFDCJPG90ozu9QB6nxfj5PMNjjCaJ1j7rti29ANkHE0F0Ue6+MiCUXi3vHqVXb
         RUiDlmG3qJ7X9NpTvOwUbt+SCUmg5aWGr/mUtyqU1v22mGdHSKILNJlDzLnxAK4PgFjx
         5dZQ==
X-Gm-Message-State: AOAM532dJI5SFTEcM77H+KK3rdpZz2gkBeQ2rglFRDWBnbi0B3XHhHM9
        fLGnYr5rBpmXFU2AdvgGuQo=
X-Google-Smtp-Source: ABdhPJzxvlnWE/i1TCbpQ9g6l84AGKONpJKeCIzQLk5TstMmN96u1M7rV9aWses627pD4/tx7sElMQ==
X-Received: by 2002:adf:de84:: with SMTP id w4mr19679707wrl.104.1627309817625;
        Mon, 26 Jul 2021 07:30:17 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id o17sm9176609wmp.31.2021.07.26.07.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:30:17 -0700 (PDT)
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
Subject: [PATCH v3 6/8] MAINTAINERS: rectify entries to mtd-physmap.yaml
Date:   Mon, 26 Jul 2021 16:29:41 +0200
Message-Id: <20210726142943.27008-7-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
aggregated, amongst others, arm-versatile.txt and cypress,hyperflash.txt,
into mtd-physmap.yaml in ./Documentation/devicetree/bindings/mtd/.

The two .txt files are however mentioned in MAINTAINERS; hence,
./scripts/get_maintainer.pl --self-test=patterns complains about broken
references.

Refer to mtd-physmap.yaml, so that the maintainers and reviewers of
ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT and HYPERBUS SUPPORT are
informed on any changes in the yaml file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f36b6763073..07810c3211df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1386,7 +1386,7 @@ F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
 F:	Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-versatile.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
-F:	Documentation/devicetree/bindings/mtd/arm-versatile.txt
+F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 F:	arch/arm/boot/dts/arm-realview-*
 F:	arch/arm/boot/dts/integrator*
 F:	arch/arm/boot/dts/versatile*
@@ -8632,7 +8632,7 @@ S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next
-F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
+F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
-- 
2.17.1

