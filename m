Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D895842C3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhJMOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhJMOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:52:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F972C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:50:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r18so11179104edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2/yYz+f+Cxm/Qvyz1YFZG6fJQEBjaALZ5meLk1rFxY=;
        b=hZQB9q6l9OGC1iRlDk89+5btbb4d1jn9U/nla5hzI8nIqEDEQCk6aqk0wIldYSfk4z
         Pnk2CP5yOYMLZm5gA8+VZlHepvyf4FO29++z3kFU7uNOZbqQLgB/fIdzKF6LPIWayOVi
         QMz8cOX5+J0g3PZm4KskKVxOUwgpjjIlas88U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2/yYz+f+Cxm/Qvyz1YFZG6fJQEBjaALZ5meLk1rFxY=;
        b=SohnH9HXCgqW7dtfORRYhM/6WzVk9rjc+wP5SnvZRTXE0MjBiRPLQGbt2RTO1/eu03
         DkZawSTz9PjIaBKE3FvGxgJGal3UBiJbtptWgDiK5eRsGNvpvSP14NdloFsQ2au80ZIS
         kKEjo8olaaumtr5T5Px4+T/rjJuj1BrT+qpl8PeaUtIsOXD+s0b14+WdznTSmhsjdtNK
         lvIDzY5zNvFPska2n6lfXMnwZwPAVPg99bb4nA9gwa/mBqSYyGJnTt0m8l8fR1lv5+H/
         I+4qU29MIFvkgF0JnTBQMEIwrvmgjxvjpVb2Pc5+779fedGVM5nN1yAXsRn2x7h/qQ5m
         1diA==
X-Gm-Message-State: AOAM53156GIWMT5qYtcaSnSWMjUWcU6HA6Fie7K26vL72cfI/NM09pH+
        cbjcfRs6RFiIdQZauyeiFFDp+g==
X-Google-Smtp-Source: ABdhPJxE/u4BgR6OxOjO+FNC6DvQ/ANW5hEzgEmNGkEXhOAD0EvRzymAflW42HN0f5VzYNvSjGYy9A==
X-Received: by 2002:a05:6402:19ba:: with SMTP id o26mr10333807edz.1.1634136645925;
        Wed, 13 Oct 2021 07:50:45 -0700 (PDT)
Received: from capella.. (27-reverse.bang-olufsen.dk. [193.89.194.27])
        by smtp.gmail.com with ESMTPSA id nd22sm7535098ejc.98.2021.10.13.07.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 07:50:45 -0700 (PDT)
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
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 0/6] net: dsa: add support for RTL8365MB-VC
Date:   Wed, 13 Oct 2021 16:50:32 +0200
Message-Id: <20211013145040.886956-1-alvin@pqrs.dk>
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

This version of the driver is relatively slim, implementing only the
standalone port functionality and no offload capabilities. It is based
on a previous RFC series [1] from August, and the main difference is the
removal of some spurious VLAN operations. Otherwise I have simply
addressed most of the feedback. Please see the respective patches for
more detail.

In parallel I am working on offloading the bridge layer capabilities,
but I would like to get the basic stuff upstreamed as soon as possible.

v1 -> v2:
  - drop DSA port type checks during MAC configuration
  - use OF properties to configure RGMII TX/RX delay
  - don't set default fwd_offload_mark if packet is trapped to CPU
  - remove port mapping macros
  - update device tree bindings documentation with an example
  - cosmetic changes to the tagging driver using FIELD_* macros

[1] https://lore.kernel.org/netdev/20210822193145.1312668-1-alvin@pqrs.dk/

Alvin Šipraga (6):
  ether: add EtherType for proprietary Realtek protocols
  net: dsa: move NET_DSA_TAG_RTL4_A to right place in Kconfig/Makefile
  dt-bindings: net: dsa: realtek-smi: document new compatible rtl8365mb
  net: dsa: tag_rtl8_4: add realtek 8 byte protocol 4 tag
  net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC
  net: phy: realtek: add support for RTL8365MB-VC internal PHYs

 .../bindings/net/dsa/realtek-smi.txt          |   87 +
 drivers/net/dsa/Kconfig                       |    1 +
 drivers/net/dsa/Makefile                      |    2 +-
 drivers/net/dsa/realtek-smi-core.c            |    4 +
 drivers/net/dsa/realtek-smi-core.h            |    1 +
 drivers/net/dsa/rtl8365mb.c                   | 1533 +++++++++++++++++
 drivers/net/phy/realtek.c                     |    8 +
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   20 +-
 net/dsa/Makefile                              |    3 +-
 net/dsa/tag_rtl8_4.c                          |  184 ++
 12 files changed, 1837 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/dsa/rtl8365mb.c
 create mode 100644 net/dsa/tag_rtl8_4.c

-- 
2.32.0

