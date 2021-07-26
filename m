Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847C83D5B94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhGZNt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbhGZNt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:49:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590EC061757;
        Mon, 26 Jul 2021 07:29:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k4so5455816wms.3;
        Mon, 26 Jul 2021 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HDpUHKg/kY2KkYhHuvMxZt0YPwDDfMu+KZC12Q0UV78=;
        b=KovvZSSJQw087KUMruN0DHnK5cOUrEqWPatS3z3BljJM9aGUR6csD1w2X/jbgmO6qG
         uD4LlecQqQLcwFskhaNslSJPHjGE9l4kpnLz9D+yeOYZhAiJVwmfpkWog4KwPam1Rfwx
         XnEc9ZZsaY7NF4lJQOswQd8lYX5Wc5nno+JKBzqWecG5/y4GGrSh6/KbFkJ/vS2xNY1h
         PiYs7sx6ST+XYl4eGbdVhueKUH/JlmjDh0It1+lNv4BEl1MzyP4G3XA1XCy3QkJPdIBN
         FW/qet/88WOayIT7ZK3QMPR/paIb0Nq+2GFj+Pbo4Qd8wka6LoffKwoxtuUaexo12VAn
         GzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HDpUHKg/kY2KkYhHuvMxZt0YPwDDfMu+KZC12Q0UV78=;
        b=Wiq74JcFCgQqC990p1Y52uHD8gwtw2nya9jZukqNLx4avOVfE+LFRw2+4vapyRbBjo
         9Txr75prhsRQw3mvGwEpryOI88s+G+ysTA2jbUztDcwa6Ao0sZSNv+KTKVBAtX30gIhT
         h5AvqOecQr/JGzMIOnX/zy+GHf6ubjLRuOlWPwgkaGfQIP/TsuCoYAN0cNCx1EX5tS45
         ES5cQgAYjJvr7vP5iZUK71Y0Gwobndn5eP7PFSpACwBiBe5OP9EQD+prPpLggnf46UDC
         a6tfbzkRrG1bDRPlZnM0obFmyiUOu+mzuGGxqfkSTUHfb3IJSF5bALYlo39t86BGTW7j
         ZKmw==
X-Gm-Message-State: AOAM530Oqy4p9H6EtdWg3Ay/7gSAYtJk5xtLVERul6lSyXsxN5QDU0Y3
        KEhnFITymbqz1Z1aHIV/lRA=
X-Google-Smtp-Source: ABdhPJwhmylNNpZJlBcjxMjO69MVjFBeW1YKTTw/WbYW+DR6RSUIAM3jnCtGNkq6mNf/NeplTPn0lQ==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr17138782wmb.167.1627309793778;
        Mon, 26 Jul 2021 07:29:53 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id o17sm9176609wmp.31.2021.07.26.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:29:53 -0700 (PDT)
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
Subject: [PATCH v3 0/8]  Rectify file references for dt-bindings in MAINTAINERS
Date:   Mon, 26 Jul 2021 16:29:35 +0200
Message-Id: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

here is a patch series that cleans up some file references for dt-bindings
in MAINTAINERS. It applies cleanly on next-202106723.

This is a v3 of the still relevant patches from the first submission
of the patch series (see Links) send out 2021-03-15 and resent on 2021-04-19.

It now further includes more clean-up, see patches 4 to 8.

Could you pick this series for your devicetree bindings tree?

No functional change, just cleaning up MAINTAINERS.

Lukas

Link: https://lore.kernel.org/lkml/20210315160451.7469-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/lkml/20210419092609.3692-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/lkml/20210614112349.26108-1-lukas.bulwahn@gmail.com/

Adjustment from original to resend version:
  - drop subsumed patches

Adjustment to resend version:
  - add Fixes-tags as requested by Nobuhiro Iwamatsu

Adjustment to v2:
  - add more clean-up for file references on dt-bindings

Lukas Bulwahn (8):
  MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
  MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
  MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
  MAINTAINERS: rectify entries with documentation-file-ref check
  MAINTAINERS: rectify entry for ALLWINNER HARDWARE SPINLOCK SUPPORT
  MAINTAINERS: rectify entries to mtd-physmap.yaml
  MAINTAINERS: rectify entry for ARM/ASPEED I2C DRIVER
  MAINTAINERS: rectify entry for FREESCALE IMX / MXC FEC DRIVER

 MAINTAINERS | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

-- 
2.17.1

