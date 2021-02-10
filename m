Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECE031673D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhBJM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhBJM4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:56:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5EEC061788
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:55:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jj19so4010556ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHOlOhcQ+zRM08ThU13hzkWKzBwX1E8wDjj/X8CawAg=;
        b=1NJLJVasOsjg2D8QyTt6YfgsQSkcKVj6ahijVhKmG5dQ6UCBcMYGvYWDE5dpYlNSaz
         OT3p91d6FOX8k2qln/eIt1EMXmML2/1xSKmZVg6Rg3PM5lERdBBQeaMytNqvWVXbSIj0
         mr6Mbbs/z7/cyXq4vyf0PsFnisJNKuFAQHb0YvjWoPv9wWhcrILORBXXC8dkB8Y88c69
         9FMtUhflhwWTB9dSD/LHYZK4H7lwandVc6Re/f3DnJDmfXzx1iAEbOC5axjaHm1ZKpbS
         FxuxYyUVe7u32A34wJcd29v9f7Ap0w53MwfHbnTCyZckuRjBOATVM/3sdeS73rpA6nRO
         gt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHOlOhcQ+zRM08ThU13hzkWKzBwX1E8wDjj/X8CawAg=;
        b=e7QZBX3H2veMLlv0WKKDx5slYvzTd6NItfWQrLrg4hB1DKDdkk/RqcxEgZFCkDpx6B
         lM+H228HYfp5wSjzgATafQHFTLUrTyAfKh1kzpPWYMsoCoXus0scy0UlvQO/7ra96Shb
         h50oeELX0AruGu/oAoYUWnU99VuKjSFwllUSw9g0/LxWyCzOt3iXZpPpQyWMI/L4Wgq/
         muAul21AL7qdwXnyyduZGGQpvYR4MPKX9BB1qxmT2kBtTsvXR8K6HA8Aee1auRNbgauz
         zrvDO0GnCR9dbgIpfxR/pLIHUEyQTH/Ub8JPf1jVjqoMLUthx7QP0DqUWy0QyOaJCyUB
         U32g==
X-Gm-Message-State: AOAM533ZwhXi3h+xBlRB0qb1OoqyU5AgkYa1ZOZBQG2ea5snvDrMV4ba
        EpK5xzMZ0RypboHd/8P8AWAjwm8Sb+Sh+YMP
X-Google-Smtp-Source: ABdhPJz5myXkPhHhSvFomd4ohKnj3VSNl3FJWuFgcafxmK6wC/Ofubabk2glsJSKLT+eTLFeaMZkeQ==
X-Received: by 2002:a17:906:d922:: with SMTP id rn2mr2882148ejb.414.1612961729918;
        Wed, 10 Feb 2021 04:55:29 -0800 (PST)
Received: from localhost.localdomain (dh207-97-164.xnet.hr. [88.207.97.164])
        by smtp.googlemail.com with ESMTPSA id u5sm1084900edc.29.2021.02.10.04.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:55:29 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 net-next 0/4] Add support for Qualcomm QCA807x PHYs
Date:   Wed, 10 Feb 2021 13:55:19 +0100
Message-Id: <20210210125523.2146352-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Qualcomm QCA807x PHYs.

These are really common companion PHYs on boards featuring
Qualcomm IPQ40xx, IPQ60xx and IPQ807x SoCs.

They are 2 or 5 port IEEE 802.3 clause 22 compliant
10BASE-Te, 100BASE-TX and 1000BASE-T PHY-s.

They feature 2 SerDes, one for PSGMII or QSGMII connection with MAC,
while second one is SGMII for connection to MAC or fiber.

Both models have a combo port that supports 1000BASE-X and 100BASE-FX
fiber.

Each PHY inside of QCA807x series has 2 digitally controlled output only
pins that natively drive LED-s.
But some vendors used these to driver generic LED-s controlled by
user space, so lets enable registering each PHY as GPIO controller and
add driver for it.

Robert Marko (4):
  dt-bindings: net: Add QCA807x PHY
  dt-bindings: net: Add bindings for Qualcomm QCA807x
  net: phy: Add Qualcomm QCA807x driver
  MAINTAINERS: Add entry for Qualcomm QCA807x PHY driver

 .../devicetree/bindings/net/qcom,qca807x.yaml |  70 ++
 MAINTAINERS                                   |   9 +
 drivers/net/phy/Kconfig                       |  10 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/qca807x.c                     | 855 ++++++++++++++++++
 include/dt-bindings/net/qcom-qca807x.h        |  30 +
 6 files changed, 975 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
 create mode 100644 drivers/net/phy/qca807x.c
 create mode 100644 include/dt-bindings/net/qcom-qca807x.h

-- 
2.29.2

