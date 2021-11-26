Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6329B45EA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376433AbhKZJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376375AbhKZJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:42:09 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB50C0613F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:35:55 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso9557206pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YPCZQk3ldefrvQEF5kF6Pda8ed46AtY2WEwLZ32ZdQE=;
        b=WtOjZrJ8kWWA/IQ4NgDTdNnoPQvTwOGJEmFe7tzDF4AdX9q/wCXVktD6SA0o73hhhK
         Ages3FPYK+dSDrmrTCNCKS+r+kEUTvNJAMnLCgEYP+a5o1txJ1biFs2Bht1JkgeMlLFC
         c1F7hNnVJpYnfnRYsNgwKZaKiupTk6ASc0altLy6340h73qSJE9U3bNuUPHXow5nFRan
         k+mVFsaRRod9TJWK+P6SEMEiwaMe840mO6MHRPDc8aiNSMkeLaUBflqBYZ9t4E+76aN1
         jMYkyIXWYN4Fmr5Dh9pRfdvib69XCoPH1ShjXpqHFeBmdd/FFoGs8MyXewkcqd+eb/4w
         1PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YPCZQk3ldefrvQEF5kF6Pda8ed46AtY2WEwLZ32ZdQE=;
        b=J3Rs1jAwBwHdpVBrSCnS1GkWWwr+4aKHKsu2i0TXGYEmnD4Udiy7rEOVezOqTGXnvN
         lg71oILR8DZ92DoUOtxDUPBBjVHcZYJ1RZ5n9UAIxVYvOrFhU5xrAMnbD8WjBruhHneL
         KyyKsV4QZFobN8j8LpoSdY5betLjemUHFc/1G8YDn9z0IWeL4jDLEkbfXKF+EFLd/Uuk
         CWuMiq87Go2eN8xwPb8A9sh29vWJFiCO7H/jHvQU1zjLq45gmY0143cMOonxmGZzr1Y1
         ii3JDiVF4zt9G5y+Riiv0no7aXvxEqLWM2ZQvmjY0jmpaf1o0JJM8AfNSTzKXiqjOoes
         EdvA==
X-Gm-Message-State: AOAM532RgTlOVfXbe4L1cWLU9TcnJFW59wMCy9cPcVOnfmnWm+Evdm4Q
        CR0U/PH0ApUcsY/bM4CorpbZewb4R0CQ6w==
X-Google-Smtp-Source: ABdhPJwaIFkm5Ct+j9PxVOQBfts3QKBod1ClI7mOqt7mHRmi+bme6jGCvPJj762Z361zKL1GGNJsRw==
X-Received: by 2002:a17:902:da8d:b0:142:4fa:9147 with SMTP id j13-20020a170902da8d00b0014204fa9147mr35915452plx.72.1637919354703;
        Fri, 26 Nov 2021 01:35:54 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q11sm6079647pfk.192.2021.11.26.01.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 01:35:54 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/2] Add Qualcomm MPM irqchip driver support
Date:   Fri, 26 Nov 2021 17:35:27 +0800
Message-Id: <20211126093529.31661-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds DT binding and driver support for Qualcomm MPM (MSM Power Manager)
interrupt controller.

Changes for v2:

- Update both driver and binding for better alignment with qcom-pdc
  implementation.  Devices with wake-up capability via MPM_GIC pin
  will specify MPM pin rather than GIC interrupt number in DT.


Shawn Guo (2):
  dt-bindings: interrupt-controller: Add Qualcomm MPM support
  irqchip: Add Qualcomm MPM controller driver

 .../interrupt-controller/qcom,mpm.yaml        |  72 +++
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/qcom-mpm.c                    | 487 ++++++++++++++++++
 4 files changed, 568 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
 create mode 100644 drivers/irqchip/qcom-mpm.c

-- 
2.17.1

