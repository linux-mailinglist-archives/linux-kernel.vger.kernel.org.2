Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6405739C01F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFDTGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:06:46 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39683 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:06:43 -0400
Received: by mail-wm1-f48.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso8496221wmh.4;
        Fri, 04 Jun 2021 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHU9r9qJ7f3y57BwW4Qkv4q6Btiso2T9prw5IOLS5+0=;
        b=awJgxzWxRYr+LdcAZSkviGJAdgq/iNEGo2VfwjyUqX4jhUfsImih8lTVTe4yKgS2ff
         tb/qWbJFaRY+V36MbIXsqH6zrD/pcFFtdpaamZG9hejKjWnfyKLAaTO2uI51fINYqduQ
         hRQFfBdMsTVijvJ3BrTanhfu9oK5CRvflEdcZn5BDHykVzIQ11m6CEzX7sNoDttwjBgv
         FzZQJhprNVpCShzBbM+sbc7xK49S/AGUDCFLwNbCQt0Z1l+XrKUzoUjCWQO7S+xjNeuI
         e6AYXboNnN9ZiH5Yn5ZpVHkInkmx8VKcKboNZAcWJt5mPnxW7HSQPcSXhFvQSCGKOXRO
         EVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHU9r9qJ7f3y57BwW4Qkv4q6Btiso2T9prw5IOLS5+0=;
        b=ESg5MKZviUYLey4OobCRclN46LP3h8DdbM4LgJbP/GpLd3HNjLwirvJz0N2EupkB8L
         A0chgFn+8iWiviPqmzw+ub/36p3h2VZV5oyeKqAvrdjsOU8itk1JS46KXN+hYZgphqBc
         vzxR9+f0lC7WeXh0dSdSg2/l0ybuFcRz4fVsJlaFqhe3ugSW1WAr6MHaS+0A89U67Hjy
         OWkrSuS/N7RCLar7dOYjz0vqT9RJBrnpG/DrxGS7oxKEENj99d7XeazdaKQuDqfrVHwK
         j5/JH6xLZ54yog6vAK8lU8gRApxDCKjHVE/yZYFVd3xMfLJ2gbrHwKqw57OlDM6FPJHo
         fKDQ==
X-Gm-Message-State: AOAM531GnN4+PVZIDYfshtePqDoOupRD5rtGOtcX2PjCXzkYQpDfTH1W
        4S/rCT4Ld9GkkV8arhYK90M=
X-Google-Smtp-Source: ABdhPJykGZ2XaAh+6nd5AWh78goWmo9NEO2GwWjbKCccA/e4aZpvDtr7jUVgMKUMCOXcYM5PtPeIbA==
X-Received: by 2002:a1c:6209:: with SMTP id w9mr4977091wmb.27.1622833435509;
        Fri, 04 Jun 2021 12:03:55 -0700 (PDT)
Received: from localhost.localdomain (p200300f137127c00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:3712:7c00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id x10sm7576200wrt.65.2021.06.04.12.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 12:03:55 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] phy: Add support for the HDMI TX PHY on Meson8/8b/8m2
Date:   Fri,  4 Jun 2021 21:03:36 +0200
Message-Id: <20210604190338.2248295-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson8/8b/8m2 SoCs embed a HDMI TX PHY. Unfortunately there is
no (public) documentation for this hardware. The best thing we have is
the 3.10 vendor kernel, which unfortunately doesn't document most
register bits (only a few are named there, the rest is all magic
numbers).
It is possible that this is a TranSwitch HDMI TX PHY based core, but
this is pure speculation.

Adding a driver for the HDMI TX PHY gets us one step closer to video
output on these older SoCs.


Martin Blumenstingl (2):
  dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY bindings
  phy: amlogic: Add a new driver for the HDMI TX PHY on Meson8/8b/8m2

 .../phy/amlogic,meson8-hdmi-tx-phy.yaml       |  51 ++++++
 drivers/phy/amlogic/Kconfig                   |  11 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c      | 150 ++++++++++++++++++
 4 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c

-- 
2.31.1

