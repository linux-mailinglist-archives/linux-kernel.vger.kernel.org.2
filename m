Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F53133ADA5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhCOIfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCOIfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:35:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8145CC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:35:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so15958281wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0LQpqn1sp2gKQ3mxss2v0MtbNQBB0Oge5rskRFXry8=;
        b=mf0X2squuN88Q++1zVaRbHGdHRdk3lTEgBdvpHWKawpFl9gkcyhB9lxEqGPXqDEKB3
         U5cPricaGv0BQdvagmtoYE+lY5Y8/CirkRwowKmsgU100hcT88/Pwx7hinYq/tYTQ7Zv
         daQAXFI+FMsLWslVOhvSizjfkwfNMRwVxNzG6t3gc5kTm1D0Ho+3PXi5qLapQzDxuAuU
         d4tXIE8CcfBPxalFFryeM/W3vbXTRoO9o3JOojFaocc9117Ym6D2tMVMJLwjvLgpZNoS
         9PTtgP6ib8QfgE20jExO7jeti3Xv4/s+uprCC0R9FJamWjrh38W+MfHmshnrH02O0sVq
         8MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0LQpqn1sp2gKQ3mxss2v0MtbNQBB0Oge5rskRFXry8=;
        b=KNQjI1JLvvH4tYBZG5grzOSzphFzXwlmWbsYroH/yyvWdPvfDuaZ2iLe1XpMmYu3Ak
         R+uybcmaC0h3YqGfwKFIGDY0XVUYwWDeTxt3TS6nLqgwinc/wtjMu1BOCGuuqU8uLCsV
         k6hIARKdb0OIMBoSE7mgQtNVidrdUHDQs9u0MrmuuaEhT3R5gIR/RuMRZmaaQ+VFtIlI
         oEd16SDGaD7981+j5yrxyFOcpaNp7m/npO/LN8jqP+IXmu6dknYQGcpBkaN3Cz/JumSy
         hcD0VHY3x0jtyZK2dwWiNACJtrBc4bb8ETJ5juDSnHK4SmpHRlRv15tWsOql8LPTjonF
         u60w==
X-Gm-Message-State: AOAM530lYXxemk6MwJe9k49PM6nuwxlEhRGSfWlWFu8fVY6F6LhemYtm
        YInQl1smtCgmDmrXXDE/38WVgQ==
X-Google-Smtp-Source: ABdhPJyuSFJ7w+LBE8QbGv2YrAgzrRTewd+TSsCmAC0t3U6NZO7rWWq9kbxRNygSBIk41pxdEObIVA==
X-Received: by 2002:a7b:cb99:: with SMTP id m25mr25428082wmi.64.1615797300081;
        Mon, 15 Mar 2021 01:35:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:708f:15aa:638c:22b7])
        by smtp.gmail.com with ESMTPSA id o2sm8372028wmc.23.2021.03.15.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 01:34:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] tty: serial: meson: add amlogic,uart-fifosize property
Date:   Mon, 15 Mar 2021 09:34:56 +0100
Message-Id: <20210315083459.359773-1-narmstrong@baylibre.com>
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

Neil Armstrong (3):
  dt-bindings: serial: amlogic,meson-uart: add amlogic,uart-fifosize
    property
  tty: serial: meson: retrieve port FIFO size from DT
  arm64: dts: meson: set 128bytes FIFO size on uart A

 .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                  | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi           | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                   | 1 +
 drivers/tty/serial/meson_uart.c                             | 5 ++++-
 5 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.25.1

