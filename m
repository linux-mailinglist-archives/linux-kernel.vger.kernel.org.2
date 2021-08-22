Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4743F413B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhHVTdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 15:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHVTdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:33:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409EDC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 12:32:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d11so32161034eja.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DmrWrvyIHW/izeB1HmQaq15NlKbvEv6PvoGXABD0FYg=;
        b=UPGrIlZbooDfgQQZcQSPVe7VDiWM2uW5gX6HrlUEtWx2ylAqLvODE7/QKHxZnLxNqx
         eANDBCqEOyhRIeV0ruOInU5HIoRHkFZWl3cEhYRwyJ9C7Iu77mMvR2tTlOw3LnnqfGJ5
         0FoPiQL3CbuDUpHGhCuRngfynETTaNqTBr1T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DmrWrvyIHW/izeB1HmQaq15NlKbvEv6PvoGXABD0FYg=;
        b=JJOc9ejxy1uAMs98oHsteEydhwXYLslGJUo+J2sCcdLD3sgO3PhzE1IGbP3tuNeRjh
         acJKDYd0LaVEdrbKcLpjvmENL1G0ysgIVmAqR52sWKhC3fgbDB/IDpAIcKrc56F+1ghH
         6HWHbesvUn2IISSsORHbLv+x6Gfv+AKY9mDR1SR6Vo2/IzoyUBXeMXbNfoR/YKoISF0K
         DQfYTKSK5TQaXkZ8fC/tEWLe57X226ox3nZQrHMijZxaDX1WrfMa11H7Gj1oU5zEybEr
         whLO39uy39I/5GsWAP7k+Avo/2tqX2oaUcf9BeG9dJlPfjAqdHwzZBZHCHFYiAMixe96
         wgmQ==
X-Gm-Message-State: AOAM533SEJ0bUewaelG8AqAj6bgTY0/WgBOuPYIC0qDqQFmt+A/DOkmu
        sSp2jxjAVg9rxOvWEurXb+OgEA==
X-Google-Smtp-Source: ABdhPJzJMko7+irpdeI9GclqERGTcpjtciS3jmauwbgSK8PT7+h6Bqr+f1ifRCjQSPchYa7UpUPiKg==
X-Received: by 2002:a17:906:1913:: with SMTP id a19mr1266028eje.390.1629660758771;
        Sun, 22 Aug 2021 12:32:38 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id cn16sm7780053edb.9.2021.08.22.12.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 12:32:38 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     mir@bang-olufsen.dk, alvin@pqrs.dk,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 0/5] net: dsa: add support for RTL8365MB-VC
Date:   Sun, 22 Aug 2021 21:31:38 +0200
Message-Id: <20210822193145.1312668-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

This series adds support for Realtek's RTL8365MB-VC, a 4+1 port
10/100/1000M Ethernet switch. The driver - rtl8365mb - was developed by
Michael Ramussen and myself.

Summary of patches:

  - The first patch in the series is a bugfix in realtek-smi which I
    found when writing the new rtl8365mb subdriver and building
    realtek-smi as a module. If desired, I can spin it off into a
    separate patch and target it for net (not net-next).

  - The second patch updates the dt-bindings for the new compatible
    string.

  - The third patch adds the 8 byte tag protocol driver.

  - The fourth patch adds the rtl8365mb subdriver - the main feature of
    this patch series.

  - The fifth patch adds a PHY driver for the internal PHYs found in the
    RTL8365MB-VC. This is not strictly necessary for the rtl8365mb
    driver to work, but it avoids using the poll-only Generic PHY driver
    directly by hooking into the IRQs made available by the switch
    driver.

This is my first time in the DSA subsystem, so I am submitting this as
an RFC patch series for now. Apologies if I have made some terrible
mistakes along the way. All feedback - no matter how minor - is thus
very welcome.

There is a lot more work that can be done on this driver, particularly
when it comes to offloading certain DSA features to the hardware. I
intend to revisit this later when I have more time. In the mean time,
the driver seems to be in a good enough state for upstream submission.

Finally, there is an outstanding issue in probing the PHY driver when
fw_devlink=on. This seems to be a generic problem with DSA drivers which
create a dependency between an internal interrupt-controller and child
PHY nodes, realtek-smi being one of them. See [1] for an ongoing
discussion about that. Since this seems to be an existing problem and
not unique to this new driver, I hope that it will not impede the
upstreaming of this patch series.

[1] https://lore.kernel.org/netdev/cd0d9c40-d07b-e2ab-b068-d0bcb4685d09@bang-olufsen.dk/

Alvin Šipraga (5):
  net: dsa: realtek-smi: fix mdio_free bug on module unload
  dt-bindings: net: dsa: realtek-smi: document new compatible rtl8365mb
  net: dsa: tag_rtl8_4: add realtek 8 byte protocol 4 tag
  net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC
  net: phy: realtek: add support for RTL8365MB-VC internal PHYs

 .../bindings/net/dsa/realtek-smi.txt          |    1 +
 drivers/net/dsa/Kconfig                       |    1 +
 drivers/net/dsa/Makefile                      |    2 +-
 drivers/net/dsa/realtek-smi-core.c            |   10 +
 drivers/net/dsa/realtek-smi-core.h            |    2 +
 drivers/net/dsa/rtl8365mb.c                   | 2124 +++++++++++++++++
 drivers/net/dsa/rtl8366rb.c                   |    8 +
 drivers/net/phy/realtek.c                     |    8 +
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_rtl8_4.c                          |  178 ++
 12 files changed, 2342 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/rtl8365mb.c
 create mode 100644 net/dsa/tag_rtl8_4.c

-- 
2.32.0

