Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2F3576A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhDGVVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbhDGVVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:21:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B522C061760;
        Wed,  7 Apr 2021 14:21:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a12so9668254wrq.13;
        Wed, 07 Apr 2021 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnRokraJNQQ3ziNTnfPQf4MZbYvKQk5ORT1VbxzhrPA=;
        b=IiJ+43ioz64XkpThdu2m/4wB/i7lHoRJ0qPsQEwkdY/UrOUaZLRaXFETG2HoIg7+Wi
         +565zWB4TSwpszDXc9EcKJzP4t+ysq9Vr/yNdklPamxdLjEpBeK53lRD+hxvZdbKZlck
         MVA65GJhKucxhNO4Duso+3uUCDFApF1QCN/KEAHrI/xstBNlBmhGTeRXMBZUW15NxMn7
         7NAoeW4b7dBhhfPsKwUHV6pn2hBRrbbjnrnnX2gjl5PjJ5HZ/vQb6HBxLtQ9MOxvDx7G
         s1Ht3lwLWEqoO5nyZhu1CG2Qu6gE/+2bCtBqJmcLOsluUQy8u9hw9cKya/NkgsFB6nlM
         hypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnRokraJNQQ3ziNTnfPQf4MZbYvKQk5ORT1VbxzhrPA=;
        b=Mj/4hYySbBg7wrrTzXZM/4RgJI71uqTbqpXeF3Ak6b4l+xmJWGFuXwqj0XxCaJ6dHy
         oR8KpOQN+xU6M/jxwkUxDcktVpgh1/BEDwLJtS5ALhLtk2NkzvYVlY1kUp4H3yiFiPtj
         8KMV44fxnkAkKJLJLlN/pVYzGCB5Kj3iq6u9Cp11Zwpa2vMOmMdE3nuM79fBh9wJ4Flw
         0pbI4mkiTLerLoxv4/28A/wZerd6zi8PDdxVwWmOWIIQ5VzK9O6ld5ihvKdmUNLR0iJC
         Cs6sS5iddS5LNdU9CnvRrbX9aega0P7F8EMiBPbUSJDNFXZhfvpsk2J0Le0vUG/99D+V
         BGng==
X-Gm-Message-State: AOAM530CTNRtU9VBBNq/maL3EIg+KsktiuiFLvvX1YPrYHoJOi47Omp7
        yXvURi8dnrOK4YBnMfSb2QO36tM6cOg=
X-Google-Smtp-Source: ABdhPJww8ubBqw30Y4BIOy12HAszw92cjE7X8pc4aWqn6oFMmF9f8hh1VX1IkDjbhgDfiEUvsaDlKQ==
X-Received: by 2002:a05:6000:1102:: with SMTP id z2mr2005190wrw.87.1617830487075;
        Wed, 07 Apr 2021 14:21:27 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270041a0a0f4308eafc0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:41a0:a0f4:308e:afc0])
        by smtp.gmail.com with ESMTPSA id l14sm17173952wrm.77.2021.04.07.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 14:21:26 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, Anson.Huang@nxp.com, krzk@kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 0/7] imx-gpcv2 improvements
Date:   Wed,  7 Apr 2021 23:21:15 +0200
Message-Id: <20210407212122.626137-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set aims is to add the support of the i.MX8 MM power domains
on the mainline kernel.

To achieve this, I do several patches
  - Check errors when reading or writing registers (concerns i.MX8M base
    implementation);
  - Fix power up/down sequence. Handshake was not checked and it was
    not called at the appropriate time (concerns i.MX8M base
implementaions);
  - Allow domains without power sequence control like the HSIOMIX of the
    i.MX8MM.
  - Add some i.MX8MM domains (HSIO and OTGS);
  - Introduce quirks. For example, i.MX8MM OTG domains should not be
    powered off (seen n the source code of th i.MX ATF). Quirks are
easily upgrable for other cases.
  - Finally I defined power domains into the imx8mm.dtb file.

I know that this kind of patch is rejected by NXP ut the other way
(callin ATF directly) was also rejected.

I also know that NXP is concerned abou adding hundred lines of codes for
each new SOC but it' the way it works on Linux. And the "added code"
mainly consist of adding structures, defines and generic methods for
regmap.

If it's a real problem, maybe we can introduc a new "gpcv3" driver for
i.MX8MM, i.MX8MN and i.MX8MP.

Thanks,  

Adrien Grassein (7):
  soc: imx: gpcv2: check for errors when r/w registers
  soc: imx: gpcv2: Fix power up/down sequence
  soc: imx: gpcv2: allow domains without power sequence control
  dt-bindings: power: fsl,imx-gpcv2: add definitions for i.MX8MM
  soc: imx: gpcv2: add HSIOMIX and USB domains for i.MX8MM
  soc: imx: gpcv2: add quirks to domains
  arm64: dts: imx8mm: add power-domains

 .../bindings/power/fsl,imx-gpcv2.yaml         |   7 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  35 ++
 drivers/soc/imx/gpcv2.c                       | 336 ++++++++++++++----
 include/dt-bindings/power/imx8mm-power.h      |  21 ++
 4 files changed, 333 insertions(+), 66 deletions(-)
 create mode 100644 include/dt-bindings/power/imx8mm-power.h

-- 
2.25.1

