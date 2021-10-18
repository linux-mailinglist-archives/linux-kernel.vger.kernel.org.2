Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0343139F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhJRJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhJRJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:42:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E76EC061768
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:40:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i20so67618650edj.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v684pXQvnkH726GvM19gurGAI9+/mguWyz76aeI12nQ=;
        b=enVdtu4Ng/rJMl7F33WtKZfyqHpGPpmGgMQGLTZKITVoVCD7Y15MqRZOCUwOfeW2mj
         MjVbzYu1CZdT29ZoNL9c1Rqb8GsQmKTPBmER1hMPQ/wvbEVBOlZ7Vl3HJcahDqGiBGUO
         nLrbjfDy7hUI5SPcyxM7pit16ZJ4r+Sfh5DaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v684pXQvnkH726GvM19gurGAI9+/mguWyz76aeI12nQ=;
        b=mqJcTqrgnz4gjbx5HkF911fhNHUo6YyUZJvxB90sTwsbt1ADA0tAZJDDz2/9ru7PL8
         7NnWwQFlKl8E4VbwDHZcW1VljZLMMbkcxM9JBhnjMXvEwi400r8OaSEL8JDdVcc/iwaF
         pfVoKshsdsnm+VQDJRudSgK+LEkt5tTapJrVBong/2Pu5kHw3bwzPnCZwVslVbpWCldq
         Hw4HnJk6+SNaaPFJxewpdhjnQs/0h3wqr/Dez8bgL4/pHr3bAjTzpHrZrogdQ6Pnjtsf
         XkU3m1r6dIh9WU+Dj6OPIv3lxWqYTbh6O2eRn51D2me+mvhljBxWesNwHf/IJE6MPLQH
         aTNg==
X-Gm-Message-State: AOAM53118nKEBAyTsvEx9mEnRC5qK8xiAKR1TZQ7sAKFcCP3GBZzXMM5
        EMwq/fysJbvju4eR0K0i7U9zT8RKfteRI/Kh
X-Google-Smtp-Source: ABdhPJzBB7YTB7MrW7/tBR4KxKM1u3tyU8HcGiYpIx1tkRTMJYOxp+6V+RvgKeVFF8OJ5VlgNytE2Q==
X-Received: by 2002:a50:e1c3:: with SMTP id m3mr43306642edl.28.1634550023234;
        Mon, 18 Oct 2021 02:40:23 -0700 (PDT)
Received: from capella.. ([80.208.66.147])
        by smtp.gmail.com with ESMTPSA id z1sm10134566edc.68.2021.10.18.02.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 02:40:22 -0700 (PDT)
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
Cc:     arinc.unal@arinc9.com,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next 0/7] net: dsa: add support for RTL8365MB-VC
Date:   Mon, 18 Oct 2021 11:37:55 +0200
Message-Id: <20211018093804.3115191-1-alvin@pqrs.dk>
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

v3 -> v4:
  - get irq before setting virq parents (fixes kernel test robot
    warning)
  - remove pad-to-72-bytes logic in tagger xmit (fixes DENG Qingfang's
    suggestion); no longer needed as we set CPU minimum RX size to 64
    bytes
  - use mutex to protect MIB counter access instead of a spinlock (fixes
    Jakub's feedback on v3 statistics refactoring)

v2 -> v3:
  - move IRQ setup earlier in probe per Florian's suggestion
  - fix compilation error on some archs due to FIELD_PREP use in v1
  - follow Jakub's suggestion and use the standard ethtool stats API;
    NOTE: new patch in the series for relevant DSA plumbing
  - following the stats change, it became apparent that the rtl8366
    helper library is no longer that helpful; scrap it and implement
    the ethtool ops specifically for this chip

v1 -> v2:
  - drop DSA port type checks during MAC configuration
  - use OF properties to configure RGMII TX/RX delay
  - don't set default fwd_offload_mark if packet is trapped to CPU
  - remove port mapping macros
  - update device tree bindings documentation with an example
  - cosmetic changes to the tagging driver using FIELD_* macros

[1] https://lore.kernel.org/netdev/20210822193145.1312668-1-alvin@pqrs.dk/

Alvin Šipraga (7):
  ether: add EtherType for proprietary Realtek protocols
  net: dsa: allow reporting of standard ethtool stats for slave devices
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
 drivers/net/dsa/rtl8365mb.c                   | 1982 +++++++++++++++++
 drivers/net/phy/realtek.c                     |    8 +
 include/net/dsa.h                             |    8 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   20 +-
 net/dsa/Makefile                              |    3 +-
 net/dsa/slave.c                               |   34 +
 net/dsa/tag_rtl8_4.c                          |  178 ++
 13 files changed, 2320 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/dsa/rtl8365mb.c
 create mode 100644 net/dsa/tag_rtl8_4.c

-- 
2.32.0

