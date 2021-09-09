Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE0640485A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhIIKXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhIIKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:23:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F127AC061575;
        Thu,  9 Sep 2021 03:22:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i21so2570499ejd.2;
        Thu, 09 Sep 2021 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=TfW4psnv/zAnc1AOOFz+MTHAzd1Q3PArM+8GhLHC080=;
        b=emh2BPqu4FxGfim9EKDq5F8andHF12gF7t7SlqDrGH2EkIsiShSe2GJ/RxuFIxgYfK
         0Z9OtQLnZFCLQ2La+U/Hlie35xGe3ye9vsc9Dq2lxs6LDlCKttPZGfAWTfeinvBYDYiI
         fxbmmt2csuLCtlmKP+2Wk613wOpLQfx5Dwq/yp2wh0Zh/GDgVDdiaOBlgNsebIs18NSW
         Js1x5hhsJjG/n/QNx24mX2X8A98gMfGd8Q7/OKEh0XJ4Xg7S5AFMAiKFcShlV2MKLf0l
         XttdSvc7KWnHuxmNwTMBLU9zX82/ahEOvi/gbOsF6+I1k+WjYyRnWlrRga1A/q869xnQ
         2mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TfW4psnv/zAnc1AOOFz+MTHAzd1Q3PArM+8GhLHC080=;
        b=hEGs6r8SPmvmqufp74LN+r1Mf3/lgJ9Bo4AtcPf0sJaVRMpafRAlSFqCtzoQYesdsb
         5CPPSskJdl1uGFlkSdL7BtLMfg+xVwCqC3xzc4ZZWfQJcKdeili7wqqYHZr6ub90c41G
         k544KfMK1wjSlggEuaz87wjjJh5kYepRRzHeK5kuUATjrYKlQfu0HDvPXUuNvFu2PoKG
         fqNYz9bATVu451imI74gNSZ+eBEZPo/I1wwjKQuIpde8KqpuEfFECBFCKWFPaFeiROTJ
         HjaPANbbzKdwiEPrYAM2i0poryW32RBaPnYQ6JUzULW0NDMt2MnbZibKcYeix6KTAQDh
         BPbQ==
X-Gm-Message-State: AOAM531UrJFq+/aUsBRxZAgqPbU5svR4E2yo/ZHqRWGXHcdK/aLpxAWS
        YE2O4LRgcNFiMpv3a4P/XAc=
X-Google-Smtp-Source: ABdhPJxmXM6vb2apg0VG31QfN1pKa9V5PLO6ij3GvmAoDs2qT63d7kAKZ2TT660VeIPaPSELNeaK+A==
X-Received: by 2002:a17:906:2649:: with SMTP id i9mr2488275ejc.1.1631182919609;
        Thu, 09 Sep 2021 03:21:59 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id cn16sm808571edb.87.2021.09.09.03.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 03:21:58 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 0/2] arm64: dts: amlogic: add support for Radxa Zero
Date:   Thu,  9 Sep 2021 10:21:52 +0000
Message-Id: <20210909102154.22710-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Radxa Zero SBC. The device-tree is loosely
based upon existing support for SEI510 and U200 (also G12A boards)
and has been developed with the 4/32 board configuration.

Changes since v2:
- Add Rob's bindings ack
- Drop interrupts from wifi node

Changes since v1:
- Drop flash_1v8 and use vcc_1v8
- Rename dc_in to ao_5v
- Rename vcc_5v to hdmi_pw and drop GPIO control

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for Radxa Zero
  arm64: dts: amlogic: add support for Radxa Zero

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-g12a-radxa-zero.dts     | 405 ++++++++++++++++++
 3 files changed, 407 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts

-- 
2.17.1

