Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2CF325DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBZHE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhBZHEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:04:05 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F425C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:03:23 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id e3so1659087pfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+j5qJuOZSbQysXD/JvLKk0ZQswOeC5SGkz/d6BdcFcg=;
        b=N2XLogZuLsxAgBn8YmeZBrAP87b2Ul4RMTTf5CT3klEH9Un+lFYDL8t2qz4GlaWOFP
         TSBNgirKvPcQ0ttYcHMluSYqirsjgDJiPo7v4m6CL9Iwb4ZMp6l1I7QXGikpBenmvKvK
         fE3ugSlT+/xBqvULXQLNlvp2rpaa8dk3BIChc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+j5qJuOZSbQysXD/JvLKk0ZQswOeC5SGkz/d6BdcFcg=;
        b=INAU8+uPBC+1lf+gxrsUVyHutE3QHpAnTqtJHppnDS0Hr/2qc9cKc1qePev89oA8rR
         Oi/stwKBA2d6lZp9xUHJ7my5+GJcB/2fv9RsJ+cOJO7h7WZ335qfX16btnvnOv3jyk3W
         y/rpiM77NOP4xfHMxJ9GyrNJDTfxwSiqqJ7EjHh2c+sYdJ5tIArWEoyXqZuPIeZItSNq
         TVU3mVQzu+GgyYY0ijk+k63NoRHcxLKQ5WXWDBbbQezF0yChqpHsz1mFSZGi92HYs7RO
         0SygxrN7ShnIIBbzvvHvETCJnKyMsz1XJZr+30zkX2oSDQvTWgDGP5PAN/0cRTGZe2kb
         wqog==
X-Gm-Message-State: AOAM530QDETLNEszT6UynjeHpkJ57wS7c233MqbuwAaRTFnkGMgaYExf
        FS7MjrpXrJQHikSCBDoCN+fehA==
X-Google-Smtp-Source: ABdhPJwYBClGgFC8cYKGWzWdFhfQORrre5aTlESCiZ/M7eXTZMRntwBrV1DvM3urLS5FLfHk1E5oow==
X-Received: by 2002:a62:1e41:0:b029:1e6:fe13:b78e with SMTP id e62-20020a621e410000b02901e6fe13b78emr1911923pfe.26.1614323003138;
        Thu, 25 Feb 2021 23:03:23 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.220])
        by smtp.gmail.com with ESMTPSA id f7sm7592156pjh.45.2021.02.25.23.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 23:03:22 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 00/10] ARM: dts: stm32: Add Engicam STM32MP1 SoM
Date:   Fri, 26 Feb 2021 12:32:54 +0530
Message-Id: <20210226070304.8028-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial series to support Engicam MicroGEA STM32MP1 and
i.Core STM32MP1 SoM and it's associated carrier board dts(i) support.

Changes for v2:
- fixed v1 comments
- add i.Core STM32MP1 SoM 

Jagan Teki (10):
  dt-bindings: arm: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0
  ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 SoM
  ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 board
  dt-bindings: arm: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 7" OF
  ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 7" OF
  dt-bindings: arm: stm32: Add Engicam i.Core STM32MP1 C.TOUCH 2.0
  ARM: dts: stm32: Add Engicam i.Core STM32MP1 SoM
  ARM: dts: stm32: Add Engicam i.Core STM32MP1 C.TOUCH 2.0
  dt-bindings: arm: stm32: Add Engicam i.Core STM32MP1 EDIMM2.2 Starter Kit
  ARM: dts: stm32: Add Engicam i.Core STM32MP1 EDIMM2.2 Starter Kit

 .../devicetree/bindings/arm/stm32/stm32.yaml  |  17 ++
 arch/arm/boot/dts/Makefile                    |   4 +
 .../stm32mp157a-icore-stm32mp1-ctouch2.dts    |  47 +++++
 .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  47 +++++
 .../boot/dts/stm32mp157a-icore-stm32mp1.dtsi  | 195 ++++++++++++++++++
 ...157a-microgea-stm32mp1-microdev2.0-of7.dts | 154 ++++++++++++++
 ...32mp157a-microgea-stm32mp1-microdev2.0.dts |  55 +++++
 .../dts/stm32mp157a-microgea-stm32mp1.dtsi    | 147 +++++++++++++
 8 files changed, 666 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi

-- 
2.25.1

