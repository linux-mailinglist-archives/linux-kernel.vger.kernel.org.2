Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604FB3CB5E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbhGPKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhGPKXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:23:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7F0C06175F;
        Fri, 16 Jul 2021 03:20:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 21so8552827pfp.3;
        Fri, 16 Jul 2021 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YCyNWjhO4V+grwdhX/Rkj6AZtgSXulvvHbE6SHCabhc=;
        b=NvMTrO9AvBHK5PXr7Tq2AEdo5sCNQniw/lPvn4rNiQnQfO8GutVkkVt9Wn8swq8XVu
         jPQgA/zwLuuTlLLFo1vf4D65idV8ehQ1yinIrwaow8COmr8iyVERNdEA/JHs9irRRAq1
         aIvWu1iD2PLOnJ5B2kwFfOrD3qAJW+3h/2XEY/xWGwygw60BZxKbZCHSZNujuo6vkup4
         Gbmdb/gIo8GQv38AVpguvhSdtK3o8QodmbUuSkJDEtMg14zaDqGf8rWZ9oNaklO8RRp/
         Iy7QBq52gWiuIYXvfpw/cz6yJDO+I14mqy5ss8IvSUY9jICLRaAwKgC+kVtKkF+nl1G2
         YLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YCyNWjhO4V+grwdhX/Rkj6AZtgSXulvvHbE6SHCabhc=;
        b=ZkoPp/r7pP4IaIS9IQno0lyhwqWx3pQLzYYhbTGMDc0+qIyUS8cZnZ5y3KHjXKbRFE
         4eAfJDtcwAaK842AoAboVLsos2Ezxz/IxmxozaCnaW+w599q0QvcXkJmzsaIo11OEihr
         PXuEInItUuxudVOx3pkxtbFcibEP2kdgY6uT9HGI7kJlLhxjgz2f4IdVW/Rkr8H3j2Ru
         UJDkAGm+qIVwcwyQ6RKeSSsI6worIhdZBAZqBHMbvfHAyGpPEnZ2qJYMHTMwTutdT39Q
         /pbdZ3XR3DFOvpHND56DX461pC5DJGQuDbqBobF1ed4F9c0Cg37oZrutyNHlOIlYbLE6
         8g6A==
X-Gm-Message-State: AOAM531PXyZGf4b+qVUiEseDcfvyjM5b9x3r5hj9n+uZuT1DW8rFF40/
        wjFCCaaw3VKValwq7Z5vzfA=
X-Google-Smtp-Source: ABdhPJyV/WkPZ7cH7PDgBqZ26JunVbj8zu2wDGcXqX9ALU+XHA62RewLfxASyZnmk4Pi7OI6tBvAOg==
X-Received: by 2002:a62:3344:0:b029:28c:6f0f:cb90 with SMTP id z65-20020a6233440000b029028c6f0fcb90mr9497355pfz.58.1626430848877;
        Fri, 16 Jul 2021 03:20:48 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id f3sm8051285pjt.19.2021.07.16.03.20.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jul 2021 03:20:48 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     noralf@tronnes.org, dianders@chromium.org,
        alexandre.torgue@foss.st.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH 0/2] Add ilitek ili9341 panel driver
Date:   Fri, 16 Jul 2021 18:20:41 +0800
Message-Id: <1626430843-23823-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
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

I submited the first patch last year, you can find it at [1].
this patch has one major difference from that one, which is replace the low
level communication way, from spi_sync() to mipi_dbi_{command,
command_stackbuf}() interface, referred from Linus's patch [2].

both the two dpi/dbi interface was tested on stm32f429-disco board, if anyone
want to verify this patch, you need apply the clk patch for this board first,
you can get it from [3]

[1] "drm/panel: Add ilitek ili9341 panel driver"
https://lore.kernel.org/lkml/1590378348-8115-7-git-send-email-dillon.minfei@gmail.com/

[2] "drm/panel: s6e63m0: Switch to DBI abstraction for SPI"
https://lore.kernel.org/dri-devel/20210611214243.669892-1-linus.walleij@linaro.org/

[3]
https://lore.kernel.org/lkml/1590378348-8115-6-git-send-email-dillon.minfei@gmail.com/


Dillon Min (2):
  dt-bindings: display: panel: Add ilitek ili9341 panel bindings
  drm/panel: Add ilitek ili9341 panel driver

 .../bindings/display/panel/ilitek,ili9341.yaml     |  69 ++
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 778 +++++++++++++++++++++
 4 files changed, 860 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c

-- 
2.7.4

