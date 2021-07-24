Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88453D4490
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 05:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhGXDDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 23:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhGXDDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:03:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A54C061575;
        Fri, 23 Jul 2021 20:44:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so11718305pjb.0;
        Fri, 23 Jul 2021 20:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KzYdVSq+hzPkiy2rWNyAMfR6nXUf8PV4FMF6QSsanc0=;
        b=HwRIt5xmgKGu4CMhFNGPNx/cq8ZtKNiCaEeFzg23kvA2et/soaIIFDQOGRSFcLN3tf
         I5qJnEI08e203s/RTrO1hs4/7ZvfQz557bPfXnnSZvdUfNjD10vheWvfO3YHn7PK10hy
         854pE0hdmYJiAgNc22kAQGTphdhXNF0GgefDxV7twVAQ3+6VVXElg+d9hH0NAfBBOaBu
         Gz+nIijVPa1o5noz8726Y9K8g2T3zyPI28L+g5Rm3fswmQ4V4jP09I9cK2hqD/Br9o6C
         chz/uvb7Jrz5vWLE2B5vmMVpsqpJmRkXOPkqAi9EbkeM22CgdPczwAQ1whVECQxTIi9X
         D28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KzYdVSq+hzPkiy2rWNyAMfR6nXUf8PV4FMF6QSsanc0=;
        b=oqOYIW1xUvHH/1VASC3nSv2P1hGZO8CGzYQRsMRhvCLFWSJaFIbZzgOMkzR+qmtQv2
         bVpAwnUhePIDxpGZVnqBi+0u0Jj11CPY8ng8GboAnVG+TzzrNsROsj42UJmJuDlwCH6G
         fbfL4ZTkhvX6mwjZgB+IlMqsNNCf+T0hejZ1285XVAOKs+w3egSWZnSkG0r6ewjrVroU
         7bzKiUMqnpohDKyskiNq2+7aUoHAGYPD//Zs2wq9XpNwdhX+f6EAVR0GxGg/RoOGOnp1
         gnN8r4S0W8jqn/HYW0Xje0BdJvtJ3ep4GAjuAWn9aHt7NVm2pIMYXyF/i4Cee9/mhMi6
         sDqA==
X-Gm-Message-State: AOAM533potl8DlNXKyeRtfRzPHS0fun838WnYKfP4ReZROULqHVgCTtJ
        21p4AOO7posdAoKZAr8U5d8=
X-Google-Smtp-Source: ABdhPJzC1Psa2hNrHlE+tkGyXCvT4y61A7xVh6MTTBPBveXgeXdVcEj/D8j1GbgPAqFrEqzYq9ll/w==
X-Received: by 2002:a17:902:c60b:b029:12a:e53f:9f44 with SMTP id r11-20020a170902c60bb029012ae53f9f44mr6562714plr.28.1627098253167;
        Fri, 23 Jul 2021 20:44:13 -0700 (PDT)
Received: from localhost.localdomain ([23.228.102.68])
        by smtp.gmail.com with ESMTPSA id c17sm35118733pfv.68.2021.07.23.20.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jul 2021 20:44:12 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     laurent.pinchart@ideasonboard.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        noralf@tronnes.org
Cc:     kbuild-all@lists.01.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH v4 0/3] Add ilitek ili9341 panel driver
Date:   Sat, 24 Jul 2021 11:44:00 +0800
Message-Id: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dillon Min <dillon.minfei@gmail.com>

Since the st,sf-tc240t-9370-t dts binding already exist in stm32f429-disco.dts
but, the panel driver didn't get accepted from mainline. it's time to submit
patch fot it.

This driver can support two different interface by different dts bindings:
- spi+dpi, use spi to configure register, dpi for graphic data.
  st,sf-tc240t-9370-t
- only spi, just like tiny/ili9341.c (actually, this part is copy from tiny)
  adafruit,yx240qv29

I was submited the first patch last year, you can find it at [1].
this patch has one major difference from that one, which is replace the low
level communication way, from spi_sync() to mipi_dbi_{command,
command_stackbuf}() interface, referred from Linus's patch [2].

both the two dpi/dbi interface was tested on stm32f429-disco board, if anyone
want to verify this patch, you need apply the clk patch for this board first,
you can get it from [3].

[1] "drm/panel: Add ilitek ili9341 panel driver"
https://lore.kernel.org/lkml/1590378348-8115-7-git-send-email-dillon.minfei@gmail.com/

[2] "drm/panel: s6e63m0: Switch to DBI abstraction for SPI"
https://lore.kernel.org/dri-devel/20210611214243.669892-1-linus.walleij@linaro.org/

[3]
https://lore.kernel.org/lkml/1590378348-8115-6-git-send-email-dillon.minfei@gmail.com/

v4:
- fix m68k-allmodconfig build error which reported by lkp, thanks.
- add Copyright 2018 David Lechner <david@lechnology.com>.
v3 link:
https://lore.kernel.org/lkml/1627013203-23099-1-git-send-email-dillon.minfei@gmail.com/

v3:
- add Fixes tags.
- collect reviewed-by tags from linus and jagan.
- replace DRM_ERROR() with dev_err() or drm_err().
- remove kernel-doc markers from struct ili9341_config{}.
- reorder include headers.
- remove the struct device *dev from struct ili9341{}.
- restructure the ili9341_probe() function, add two ili9341_{dbi,dpi)_probe()
  to make it more readable according to jagan's suggestion, thanks.

for the full drm driver exist in drm/panel need Sam and Laurent's feedback.
so, not cover this part at this time, will be update later.

v2 link:
https://lore.kernel.org/lkml/1626853288-31223-1-git-send-email-dillon.minfei@gmail.com/

v2:
- replace vcc regulator to bulk regulators in driver, from linus suggestion.
- fix dtbs_check warnings on ili9341 dts binding check.
- add bulk regulation node in ilitek,ili9341.yaml.
v1 link:
https://lore.kernel.org/lkml/1626430843-23823-1-git-send-email-dillon.minfei@gmail.com/

Dillon Min (3):
  dt-bindings: display: panel: Add ilitek ili9341 panel bindings
  ARM: dts: stm32: fix dtbs_check warning on ili9341 dts binding
  drm/panel: Add ilitek ili9341 panel driver

 .../bindings/display/panel/ilitek,ili9341.yaml     |  78 ++
 arch/arm/boot/dts/stm32f429-disco.dts              |   2 +-
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 792 +++++++++++++++++++++
 5 files changed, 884 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c

-- 
1.9.1

