Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDD3873AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbhERIAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbhERIAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:00:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9169CC061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:58:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d11so9073726wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DkFAJ7cUM9Paz3T90sR+cBtykdhQ8PjkYKNHuPU6o5M=;
        b=ITrtzVzPkLnjWtjElFMH31l+nVtM/TcQlGdY97yww8azEW2GuW+ptPOqD0j+2epwO9
         50UTGFcMift4HCK21eiIrSxXUQIvNO0nGh0OzgfSoIJOMsxH15mZQ1ywa/XCDxXSqP4g
         aVzknNUvQ/m+BmertAk6N2SBmNb94V0915egTGL6g5cNMcU57HotyPGxk31uX+nV6/kE
         ydXh2Ztmk30ZOmZY7hXbJBHDpFNWg1AUvudIzoRRXUwjryjRhdF0ofHGLsVjC/tiYyZB
         yZiZ1zCmii3IUIbvc2DvtTSIAL2Z7Msl8oqtqrgHTgdiRFej5r1Wc3o6tLv/1blwpyuc
         L2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DkFAJ7cUM9Paz3T90sR+cBtykdhQ8PjkYKNHuPU6o5M=;
        b=WaJ/PtE5INl0GJMkGeiCxAgbBxNVSUKI/xiK8aTFsGC8TAbA3SOj0w/C4vdXyyCWPG
         rDATxlLpWuTMc1D/DUs2CWvNnLjOw/Kt5Q+Q02T5J4CjzAjZSP3kAWUiTvLbxix5FF7h
         i2k5MFtFBFyTQqYAfGs4O9duG5AtJfc9jIVyTpNpdW3rqwBfy3VKb+ZkVtJNQvXGQ4kj
         a7bZ8o+RaV8CKvPopRQHZ/GJ/WAkOkGOT60x3w/gwOv+tx/KURT0KKtYP70xaqf/knlU
         1eeNsvXDgMFd1Y7j9E7QdK2rOwFlAzbUjv6C44FJ+8m/dj0NQoTIbBjt1ENH/HBGToDO
         heMw==
X-Gm-Message-State: AOAM530FY7x9wtobeBw7/sHAiBkGFgKAnkC7V00Y28jqD8LeRPjPSg0X
        AHYrbrPzgmrXxcem/O16WPW0Z6nSh1D2mdvE
X-Google-Smtp-Source: ABdhPJyKfFz0SKbNMOc+Ey51iyEMF4nI1arx0EzIXE/uR/jMy6HmULXM7jsFhK6o1WZ0X4tTPNMlvw==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr5256142wrr.218.1621324721170;
        Tue, 18 May 2021 00:58:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:842:2d82:a1ae:1a91])
        by smtp.gmail.com with ESMTPSA id v16sm735448wml.6.2021.05.18.00.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:58:40 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] tty: serial: meson: add amlogic,uart-fifosize property
Date:   Tue, 18 May 2021 09:58:30 +0200
Message-Id: <20210518075833.3736038-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
a different FIFO size from the other ports (64bytes).

This adds a property in the bindings, reads the property from the driver and updates
the DT with the new property.

Changes since v2:
- removed spurious blank line from bindings

Changes since v1:
- switched to a more generic "fifo-size"

Neil Armstrong (3):
  dt-bindings: serial: amlogic,meson-uart: add fifo-size property
  tty: serial: meson: retrieve port FIFO size from DT
  arm64: dts: meson: set 128bytes FIFO size on uart A

 .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi            | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 1 +
 drivers/tty/serial/meson_uart.c                              | 5 ++++-
 5 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.25.1

