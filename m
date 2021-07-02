Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599823BA174
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhGBNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhGBNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:45:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A55C061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:43:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i8so12609121wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5PNOf2fBG33kkTj2T2akXL4UB6vTV7M6Cj6RMxXF9w=;
        b=wRrP5oTN1YQ5BNIwj11/8cQ8IM/n0VL5oAJq3eOB5KcwKKR2jEyg+UJ+pwFGyYVS8R
         i5xLcqReDthulFqtaWuV6Bk1f9a9XMiZ84dglshI2mGWY6w18g/zSX/rD7RAeE+mNb1Y
         vkY0OUR66iYLLzaum3IRtNdFXIZrmd+vur0AtgTZSjP5Bp/ZAU+/C5LmOHtlfGyGsljf
         6pmRnKT4Lf0TDpTJf7f5lsFtSieme6Zs/oz4vYpX6ybDjR8nhwBfN2ZxlL2ed+NZvl+N
         KaVaHvjABY/Ct0vMetzChCCNHStcHe6IENQgiVOtdEbvCT41jcPVi+gZIBmvIp16NqW7
         IWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5PNOf2fBG33kkTj2T2akXL4UB6vTV7M6Cj6RMxXF9w=;
        b=prJz4YjeYj+BUHOmXOXgfPqC++AcWUQ1dbWG0K9Qbaaus974eVYAMLcFTvem6s9rSn
         T5X76FMFbMiiPBYig/Q53Cwf/BTvBO7s+o+LjOO7bEfBvaVoJ6ZA233CQaHiETaM0gJz
         9XttQVaLBvZdWApPhDP1l1ufsISd/f5mHkP89fEUcLWDdoqpo8b2dM56FydEolOiT6Xy
         VDCCbwQew+7W1iHm8TNByQL0ezZutTYYbAW+Sz8dDIQTOchWAPsm71pPGLH/ZK1U4Jtn
         RB3XTlq7+iitpZa+cJYxSc0eI/g6kLNj16f4Dv0Ma24s57lv10WrvlC+t4IqO9dqlIAf
         x85w==
X-Gm-Message-State: AOAM531YBp5ImTTkX1r1aIjIV+KZsw5tCXMghFt9709vQbkP1OX4r13c
        qpZe0S122XHRdOtdzTzb1ODyIg==
X-Google-Smtp-Source: ABdhPJw/Yjf+4q1c9i/Cuv+UlNuFg9DhSWnMI7cHOdXk4qMTpxztNFvOYbwAX2D4uqkPydJpaDNbuw==
X-Received: by 2002:adf:eccf:: with SMTP id s15mr5880911wro.176.1625233403059;
        Fri, 02 Jul 2021 06:43:23 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:c5f3:6ae:eaf:87a2])
        by smtp.gmail.com with ESMTPSA id s1sm12595512wmj.8.2021.07.02.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:43:22 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 0/4] input: MT6358 PMIC button support
Date:   Fri,  2 Jul 2021 15:43:06 +0200
Message-Id: <20210702134310.3451560-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek MT6358 PMIC has support for two buttons: PWR and HOME.

The interrupt logic is a little different than other PMICs from the
same family:
for MT6323 and MT6397, we have one interrupt source per button
* for MT6358, we have two interrupts lines per button: the press and
* release interrupts are distinct sources.

Changes since original v2 at [1]:
* added 4th patch with device tree enable
* cover letter title prefixed with 'input'

This series depends on [2]

[1] https://lore.kernel.org/r/20210512152648.39961-1-mkorpershoek@baylibre.com
[2] https://lore.kernel.org/r/20210506094116.638527-1-mkorpershoek@baylibre.com

This has been tested with evtest on mt8183-pumpkin
using for-mfd-next as base tree.

Mattijs Korpershoek (4):
  Input: mtk-pmic-keys - use get_irq_byname() instead of index
  dt-bindings: input: mtk-pmic-keys: add MT6358 binding definition
  Input: mtk-pmic-keys - add support for MT6358
  arm64: dts: mt6358: add mt6358-keys node

 .../bindings/input/mtk-pmic-keys.txt          |  5 +-
 arch/arm64/boot/dts/mediatek/mt6358.dtsi      | 12 ++++
 drivers/input/keyboard/mtk-pmic-keys.c        | 56 +++++++++++++++++--
 3 files changed, 68 insertions(+), 5 deletions(-)


base-commit: 495fb48dbd9bcbe15859e086edd24519a6bd2961
-- 
2.27.0

