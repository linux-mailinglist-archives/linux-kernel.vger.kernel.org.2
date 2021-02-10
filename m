Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEE31609E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhBJIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbhBJIIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:08:23 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6CFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:07:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f16so1004430wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivWcuWrIoBecqEGJhNfZ/cW2pH+vz74Zsw92krm7Qs8=;
        b=QtkVPl7c495rDGndC5yLmVckyz2TpgvvCtyFg4I9WJxdSNwn7i+cJym6chQS6q/zq2
         g0KCV00AtQtkuyqy2yXc/QZcOF0QECc+Kr1efheujIV8OwnIOxwyWTYCdpcP2dpw0CUI
         HNW++ANMqIDaIInbZ9kCqPF9rSH0mJly/38O7ICbjgeDeWOKCTtCY7iN1EohUbNsjLhc
         Kr+kzobvKoSB/MPWLjqYwzQOxuRiGNZaMIq8ow0CEloyv833/tON6fEqDH2Vqq4Xge3R
         AOptdMyQq9Odlzk/+x0CZhTbIrWZHFOyDfsmq9u4AUuNl263Zb97wTEyu6imuGsi8tt5
         hm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivWcuWrIoBecqEGJhNfZ/cW2pH+vz74Zsw92krm7Qs8=;
        b=MwSVj6dim7uhhnn968/l1yvvqS/lQgQtg1BTyEXRXr4m6EN+I5KY+jHDL4ycU/Wj1u
         l5+jjUSdO7K181MlW1HuingJA5+9nhOv+Fd34O+XNUX/45ZbqniET7z78dmRhmNgr/Aj
         zp96dSBoZeWeMH7nB6dxB4OhL7ldoJos27t0qJwff3Yl3HAeh/rZFsQUdaJW0U9TUWO5
         dl5KSeiIU2QxERKm2Jgu63CxM6isOj0xfp3OxW4STQpoWRn36W+9WRVTP4p4obrLSAtM
         kDOPmQ1Ns1i+4YqO3n71Es+yY1v5mlCM3jIWtj99iCkgcKQ0bJ9eBGFS5ZIbQvfzPVo8
         KZDg==
X-Gm-Message-State: AOAM532QqPSzGKbwrKih8CkvjxhNGpE/hD8EuYA2EOvkhAzstSz7hCD1
        4neUNDAzAQvb/Wq2SkNNcr4t3A==
X-Google-Smtp-Source: ABdhPJyupGp8Gp1Qh2vatwn96/hZaOKXsZ2emVoDl0b6Pjh8EaVBZlZO3bOLkxa/602emJ4HncLyLA==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr1772932wmk.130.1612944462091;
        Wed, 10 Feb 2021 00:07:42 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:d403:f5fa:8912:cba5])
        by smtp.gmail.com with ESMTPSA id c18sm12856597wmk.0.2021.02.10.00.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:07:41 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org, kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/2] phy: amlogic: Add support for the G12A Analog MIPI D-PHY
Date:   Wed, 10 Feb 2021 09:07:34 +0100
Message-Id: <20210210080736.771803-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
panels, this adds the bindings.
    
This Analog D-PHY works with a separate Digital MIPI D-PHY.

This serie adds the Bindings and the PHY driver.

Changes from v1 at [1]:
- Bindings fixes

[1] https://lore.kernel.org/r/20201123145157.300456-1-narmstrong@baylibre.com

Neil Armstrong (2):
  dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
  phy: amlogic: Add G12A Analog MIPI D-PHY driver

 .../phy/amlogic,g12a-mipi-dphy-analog.yaml    |  35 ++++
 drivers/phy/amlogic/Kconfig                   |  12 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 177 ++++++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c

-- 
2.25.1

