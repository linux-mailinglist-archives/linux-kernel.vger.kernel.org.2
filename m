Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5543D09F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhGUHBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhGUHA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:00:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE37C061574;
        Wed, 21 Jul 2021 00:41:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d1so568228plg.0;
        Wed, 21 Jul 2021 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BQot9UItgo6XN+5GjiuK2SpVANWGwz3AoSdzswtxo6U=;
        b=cauIKMH8zc6qx5eC0HA5pKkcJgsEJwskQoocWc6fYrwYD8Yv5uaINCHnaL+FsPoVVg
         FnBIn+54FOCtYfRZfGeMmKuJ1IS7/iZpR44xinqi62wma2K/IMKKZ3ObqW0Ki+nIBoeb
         Ivw43SYUT1MMha6XbeYB3IWtXjfOHD1/LD3awEP6RSfpOTDCgB30Frx7ZOvInVsVD6pY
         obBRiov76RwnQBbNdeuLgvNodYEBw1qylzHLc489yJkW/XBs4VUMQgzBrM2KIRU5gi++
         s/A+zn0JEoZKfaa8fPHCydAKUFtHwoY/T1WUdtTzro+A5pouRPRu54VlEYTRrik9nCJc
         tb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BQot9UItgo6XN+5GjiuK2SpVANWGwz3AoSdzswtxo6U=;
        b=Xr+ahS1Cu8YmfLXwoP5KjSrqCWRIQdDnpwtuzUIqu9yyZIVahdTcGQh9vLDcYP6HK2
         OdMdtraagbAxEsMbiCGpCFK1imqNnNwzSdFCeMj4SFciiGewD5EQGz0bDcubavcwoIbL
         mkNOd1iVimkWPqDCE54Zvle5lBKrW+ayoJ7i+7RBLi6Zf6NJo+j56pEVD2x1c6YcIq97
         qvRJte4iV7z/4y24e6JFRyMD+qzc2Q1WFTSMhbOLFGhanFzoFNzHerhEyLT+9wum8406
         jTvJyoHEqZ/6Qt/R97NAJ6gzSumrCtk61pozKEQOyczgoBjz8cPJXIXJR9olA1QBcewC
         /XNQ==
X-Gm-Message-State: AOAM531PEmlVn/LidMATdztClMPArIbouWNb6q11k4FDTMpZKH8xoHYf
        mqxfTqdEtYZPWN7hZJegA1Q=
X-Google-Smtp-Source: ABdhPJwhNk3YO74f6uSp+4Dh/cuvO4Pe1uHMBx6hL82AB/WyBUffaXaWt4dXRDMjdeEKIlTsxOmukQ==
X-Received: by 2002:a17:902:e8ce:b029:12b:3d80:a028 with SMTP id v14-20020a170902e8ceb029012b3d80a028mr26666684plg.47.1626853295180;
        Wed, 21 Jul 2021 00:41:35 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id i8sm4841867pjh.36.2021.07.21.00.41.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jul 2021 00:41:34 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, linus.walleij@linaro.org,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com
Cc:     noralf@tronnes.org, dianders@chromium.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH v2 0/3] Add ilitek ili9341 panel driver
Date:   Wed, 21 Jul 2021 15:41:25 +0800
Message-Id: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
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

 .../bindings/display/panel/ilitek,ili9341.yaml     |  78 +++
 arch/arm/boot/dts/stm32f429-disco.dts              |   2 +-
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 778 +++++++++++++++++++++
 5 files changed, 870 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c

-- 
2.7.4

