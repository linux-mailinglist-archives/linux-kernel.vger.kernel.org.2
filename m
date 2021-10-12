Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87BB42A49E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhJLMjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhJLMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:39:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5070FC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:37:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a25so64669867edx.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Oo+boBE+eAlZd6IuqDEtqKvRJtwbHtewLQoxfaOhls=;
        b=kfT7unhmvoilGV6/AHKo7A+myzo7Y74AbsTelhnnuMoPgx/+7LGeMEqk01wfguHzED
         HSTDVH6ck0ZHzyEF01fgdd9zMllTnqQobRb2Vmzect38QkOUsX3CYa68z0cvU0/J4HQY
         zfotXFbZyYWseR0Ts5M2T5jWxO2foaGtGAfLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Oo+boBE+eAlZd6IuqDEtqKvRJtwbHtewLQoxfaOhls=;
        b=iZON/jeK3kxEzadcAvV4L6LJivfoiP3RVo2RCRRZ7iIF0GqNDBV3u0E7W6PCueho8D
         z47qYnksbeeetN9z7w99CkHm0OnOZXKnEadcSkhnOrcuR7ir3O5aNnAab5mzg3cbSrGa
         UroCHjc9UtnXF0RU4u84chQ3ANTB/cpkLypf8KAyC3T4gak2kHtDAtowrB8Dw/xX3d29
         n8H+AbHM8cpUGuArLFd48GqC0L04Tcr6NzJIXdg0e5ent1dDgv7BZ8Y3PUo1vAhkpx5H
         9xlwiV9hQGAb0VDxkxK0p9Z8q/etVDgYHB7prQ1ckPN+ez3TkiYvwJw9Cz0FKVaM+mQY
         rYZw==
X-Gm-Message-State: AOAM531rUWfMfqP+4q3AuY4OPZma5w8YlYIageey2J90ACXKTRndAVE2
        b1kQgeIgMpu3ylbM3DhEtQCSLg==
X-Google-Smtp-Source: ABdhPJwnXMOGGn+nFu0moDIaL9BzwsDFS640vDAAKjNXXWeI35G8Kc1Dwg+JzeKQjhinRg9NuFseQw==
X-Received: by 2002:a17:907:7388:: with SMTP id er8mr33437254ejc.324.1634042219554;
        Tue, 12 Oct 2021 05:36:59 -0700 (PDT)
Received: from capella.. (27-reverse.bang-olufsen.dk. [193.89.194.27])
        by smtp.gmail.com with ESMTPSA id b5sm5763629edu.13.2021.10.12.05.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 05:36:59 -0700 (PDT)
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
Subject: [PATCH net-next 0/6] net: dsa: add support for RTL8365MB-VC
Date:   Tue, 12 Oct 2021 14:35:49 +0200
Message-Id: <20211012123557.3547280-1-alvin@pqrs.dk>
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

[1] https://lore.kernel.org/netdev/20210822193145.1312668-1-alvin@pqrs.dk/

Alvin Šipraga (6):
  ether: add EtherType for proprietary Realtek protocols
  net: dsa: move NET_DSA_TAG_RTL4_A to right place in Kconfig/Makefile
  dt-bindings: net: dsa: realtek-smi: document new compatible rtl8365mb
  net: dsa: tag_rtl8_4: add realtek 8 byte protocol 4 tag
  net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC
  net: phy: realtek: add support for RTL8365MB-VC internal PHYs

 .../bindings/net/dsa/realtek-smi.txt          |    1 +
 drivers/net/dsa/Kconfig                       |    1 +
 drivers/net/dsa/Makefile                      |    2 +-
 drivers/net/dsa/realtek-smi-core.c            |    4 +
 drivers/net/dsa/realtek-smi-core.h            |    1 +
 drivers/net/dsa/rtl8365mb.c                   | 1610 +++++++++++++++++
 drivers/net/phy/realtek.c                     |    8 +
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   20 +-
 net/dsa/Makefile                              |    3 +-
 net/dsa/tag_rtl8_4.c                          |  166 ++
 12 files changed, 1810 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/dsa/rtl8365mb.c
 create mode 100644 net/dsa/tag_rtl8_4.c

-- 
2.32.0

