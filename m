Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985F1398291
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhFBHGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhFBHGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:06:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78228C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 00:04:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r13so546424wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 00:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mtcJF4D20naeNnEs0Zx/Q0Y+XC41jEFEF4kHOZDgNa0=;
        b=IDyBDoZbFzb7qwT31jzph7Ztl4UCpqBDTFYzg/bjN/q+1kcY8cHQPIh3BDWYwIRAAW
         y9E5QNyO32djUBRk4fYmEi08EArjk0+Wqriz4zcK9iraNhNOFutWm8oRtrogFCNMfSPC
         ttxHH1L4LgtDrUUkDrUzoMvS0RhFCStE858bpb3pTwTWtpALlMA2tS8phNDe6W1yNr3U
         yisV5bWn1XX+hSc6Uplrd0GN+M5FYZ+FmDxifREO8octqi2u5Mfjg0wWyv4bA54EkoTq
         7e/icvfdd5NPWYlHznYU96MSoXIUKbcpX990YLISjO6Lo2Sljsxa59k7l7h4OdjgfF+S
         m9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mtcJF4D20naeNnEs0Zx/Q0Y+XC41jEFEF4kHOZDgNa0=;
        b=ReHFdf21AHZLEvPBSlr/KLiO73X+nFJ00IJBGCgFhNDDN+iegKB/tn9ixiqcn+lt/t
         7/gQSoVLRPkT60wPOmPeFERb6AUAmwikXyOgdmrZDhkbRx7sePNVM6aPg1H4HVupQLLF
         SVUdLIOclKaYWWtedYdDB6aE+vL6h1/E373FaVoqJyKXXxKubLzWs/Gsp8jJl8kAzdb1
         vFTrRWlK7o/znUe2s0GfBpSKQYVdxO5Nx30q9zsqmX2mBHgWBtM6j3zp/HB65sRE1R7w
         cbQU6I0Eb64uQJiknGsKUBnn0NAmI0RrJsfLH1GX3AYoQo0uOsJz2/Lv4wJr+Zmsc5ia
         HJ9w==
X-Gm-Message-State: AOAM532HQrZXAEKSoctok6IAMpJX1/FDUdRF500eDN60NCd5zcokGxj1
        +e7MjmB4BjlgqPbBdC9mRFA7Hw==
X-Google-Smtp-Source: ABdhPJxX/9WU/SgxzH+ZyQgQR6B/ZRBTBVIOZNRce8o7bxoTkEzw37IgWFtvOv6OCmH2YZ7iNUDm7Q==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr3635505wmj.188.1622617455114;
        Wed, 02 Jun 2021 00:04:15 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id y9sm1853276wrh.11.2021.06.02.00.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 00:04:14 -0700 (PDT)
Date:   Wed, 2 Jun 2021 08:04:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fei Shao <fshao@chromium.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Yuchen Huang <yuchen.huang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: [GIT PULL] Immutable branch between MFD, Regulator and RTC due for
 the v5.14 merge window
Message-ID: <20210602070412.GD2173308@dell>
References: <1622011927-359-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1622011927-359-1-git-send-email-hsin-hsiung.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tb-mfd-regulator-rtc-v5.14

for you to fetch changes up to 4cfc965475124c4eed2b7b5d8b6fc5048a21ecfd:

  regulator: mt6359: Add support for MT6359P regulator (2021-06-01 16:44:36 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Regulator and RTC due for the v5.14 merge window

----------------------------------------------------------------
Hsin-Hsiung Wang (6):
      mfd: mt6358: Refine interrupt code
      rtc: mt6397: refine RTC_TC_MTH
      dt-bindings: mfd: Add compatible for the MediaTek MT6359 PMIC
      dt-bindings: regulator: Add document for MT6359 regulator
      mfd: Add support for the MediaTek MT6359 PMIC
      regulator: mt6359: Add support for MT6359P regulator

Wen Su (1):
      regulator: mt6359: Add support for MT6359 regulator

 Documentation/devicetree/bindings/mfd/mt6397.txt   |    1 +
 .../bindings/regulator/mt6359-regulator.yaml       |  385 ++++++++
 drivers/mfd/mt6358-irq.c                           |   89 +-
 drivers/mfd/mt6397-core.c                          |   24 +
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/mt6359-regulator.c               | 1036 ++++++++++++++++++++
 drivers/rtc/rtc-mt6397.c                           |    2 +-
 include/linux/mfd/mt6358/core.h                    |    8 +-
 include/linux/mfd/mt6359/core.h                    |  133 +++
 include/linux/mfd/mt6359/registers.h               |  529 ++++++++++
 include/linux/mfd/mt6359p/registers.h              |  249 +++++
 include/linux/mfd/mt6397/core.h                    |    1 +
 include/linux/mfd/mt6397/rtc.h                     |    1 +
 include/linux/regulator/mt6359-regulator.h         |   59 ++
 15 files changed, 2494 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
 create mode 100644 drivers/regulator/mt6359-regulator.c
 create mode 100644 include/linux/mfd/mt6359/core.h
 create mode 100644 include/linux/mfd/mt6359/registers.h
 create mode 100644 include/linux/mfd/mt6359p/registers.h
 create mode 100644 include/linux/regulator/mt6359-regulator.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
