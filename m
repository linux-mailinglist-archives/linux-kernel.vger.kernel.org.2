Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA93D5BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhGZNuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhGZNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:49:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE46C0613C1;
        Mon, 26 Jul 2021 07:30:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so117848wmd.3;
        Mon, 26 Jul 2021 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1qdjxYz3IXUJf5O0KYb5AZybd97sac2EulDbLZCJcM=;
        b=Vpf0/81ZRJmGHYfW3A35bPyDRQWmpoYAZ8RFAnwY7bKdfg8TRIqae9vA4XhUPxp6IR
         Y175ORlODbwkxKqHJ5JLLpyR4B6uTOANfIxaxxU/1JiBppjndCahSB5wVeQNhGBCUbDi
         mil1Yi0ILmw5EXMo5EWDYGT0XNOz/pHblJBcrDCWQ69trwoem/lIdjA93skD8FraZPUS
         Q2Hm4/57VzSYcBNR6L4rkiKPbTehnle3Fs/9/EDhhzblDiX9YKgcNx9bGnlgW+EAoYhd
         SY1isV8IVWEeA3BRkUAsmCvUjs8Cc832XCOmkY7UNRPR30lMFI4AvpQKjwToZ1OkGSs9
         QkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1qdjxYz3IXUJf5O0KYb5AZybd97sac2EulDbLZCJcM=;
        b=obv0nGWdQRCJGTecUikuy+F7FToZvGQ2jTC1RSSs7jGneqTt2bjfr2I+ZrXUf/e/Is
         S+eYXYF9nyKIDUjqf/xn6nD65Rf/DXH9g0B/MbRygLTgwNnNphIKLODlQbujh/c7svNG
         u1EDGaK62nq9ZJ0yf3YKUxiD+rmEIIKXsGsmtmsAGOi3Xmq3JMkrcZ2Sj4V6p0h5wIHO
         KKMqV7DjOxtewaZ4y36TZJgF/L9a3L2Q5E5SAiM3KJj8MjODsW1fMLqr7iWBu80nFvoJ
         1+JwP/4RBMLu7DjW27+gIE6vK3NyMXG4F4VFrltjapVRSP/itCAAaLCST5rndTsVgOGu
         LmSA==
X-Gm-Message-State: AOAM533qQx7dfNRbL2lwVNfWJfpoRETdtKvhu/SX+0AToX+Vi3+i5NtD
        9sY+qs5bhy6cv+VufbMz0qg=
X-Google-Smtp-Source: ABdhPJyrX6LvEfxzSe+NpYlIuwTn3KzuT3329Kv7ie00EYKhqQPa3J/pjLs082PKp1P7SzGoEcwbQQ==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr9269048wme.76.1627309819374;
        Mon, 26 Jul 2021 07:30:19 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id o17sm9176609wmp.31.2021.07.26.07.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:30:19 -0700 (PDT)
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
Subject: [PATCH v3 7/8] MAINTAINERS: rectify entry for ARM/ASPEED I2C DRIVER
Date:   Mon, 26 Jul 2021 16:29:42 +0200
Message-Id: <20210726142943.27008-8-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 810e4441946c ("dt-bindings: aspeed-i2c: Convert txt to yaml format")
converts i2c-aspeed.txt to aspeed,i2c.yaml, but missed to adjust its
reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
a broken reference.

Rectify this file reference in ARM/ASPEED I2C DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07810c3211df..0fe43695b58c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1720,7 +1720,7 @@ R:	Joel Stanley <joel@jms.id.au>
 L:	linux-i2c@vger.kernel.org
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+F:	Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
 F:	drivers/i2c/busses/i2c-aspeed.c
 F:	drivers/irqchip/irq-aspeed-i2c-ic.c
-- 
2.17.1

