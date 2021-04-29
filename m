Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076A136F1C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhD2VRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhD2VRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:17:30 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB397C06138C;
        Thu, 29 Apr 2021 14:16:41 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e14so229781ils.12;
        Thu, 29 Apr 2021 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLmAbaiqDgXsfehVsfQxBE/NoaMPlbdkvn0mL6TiaaY=;
        b=OHVHpOiLo43hskM9fq3HHxoZHN+xbU9C8D828PXJlGscbjMGCamVk99WegqVrFZbLh
         QkE1XXNoiHmM0KCsJSHARrBQTPWxsBZJfTCTa+2vi4UGh+T+Pvqn4I/F8dinjJYVhagA
         ryi3N2iULkIKHyE2iVMZTE5J/6LCw3cbyUalyBH01H/hRJrOtEASkp0si2jNrk2OFDY4
         bwzx2kbij5lkL1jMfmVxm/nvAqj1RCkcP6TAM/+UCSA/OxfOwO334vzuGP3rqS17wp81
         hT33q3w5ZYvKorfVWj517DW2ow1VqshyLqaitAA7BxZwP5XDqST/YSPZGsSG278PgWFj
         MW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLmAbaiqDgXsfehVsfQxBE/NoaMPlbdkvn0mL6TiaaY=;
        b=KuSGLXvNsKPBF4TQWcbsdfEGRBDSpghxKQX68vlKaH7PxFab0ZDQP/+BB5D7W9wuYf
         zwakUS+577eVbFwhUfxnbnJg7TZGIkOIegpKDP4bgwsdi3qDI1j19cBXTt1iOmEK7tc8
         bQV7DvzaaCvgNLLzMTMx40RL9s323SwlGTHNfvZmvh/LkxtsZRgGUT/RrdvxIuzyhlI1
         rKTq7V5X6ajjbPlWqbM2zFpGmzu4sMioOLTVgzhNSTpyMMNWu/a7JoTkNoRyarI35ssV
         sYebINcWAOW48Sd810aANYDFpOn323Gfn46TGrW+dTK7Bqw8k9XXFQBHMhWYvafFWNdZ
         bfnw==
X-Gm-Message-State: AOAM533tIAXvS8YuZ5VC/d1b6yCintZFi0IGIrC2zHOlQv5sYaXttMc/
        6dafaRh8fNLtLxVQhNBoF98=
X-Google-Smtp-Source: ABdhPJxIS4VXXNgUZgos9bwHUCZiCmUnqf8uTn94VwlVwYH++jwtzW4E/RkGLUSnKpYVtbbucwDpVg==
X-Received: by 2002:a05:6e02:1d0e:: with SMTP id i14mr1261188ila.230.1619731001114;
        Thu, 29 Apr 2021 14:16:41 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8a74:d2ad:27b:e619])
        by smtp.gmail.com with ESMTPSA id q11sm1808076ile.56.2021.04.29.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:16:40 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@oss.nxp.com, marex@denx.de, frieder.schrempf@kontron.de,
        tharvey@gateworks.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/5] soc: imx8mn:  Add gpcv2, USB and GPU 
Date:   Thu, 29 Apr 2021 16:16:19 -0500
Message-Id: <20210429211625.1835702-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the updates to the GPCv2 driver for i.MX8M Mini [1], much of this
can be applied to work with the i.MX8M Nano.  With the added
GPCv2 domains, additional functions like USB and GPU are available.
This series does not utilize any power domains requiring the blk-ctl.

[1] -  https://lkml.org/lkml/2021/4/29/72

Adam Ford (5):
  dt-bindings: add defines for i.MX8MN power domains
  soc: imx: gpcv2: add support for i.MX8MN power domains
  arm64: dts: imx8mn: add GPC node and power domains
  arm64: dts: imx8mn: Add power-domain reference in USB controller
  arm64: dts: imx8mn: Add GPU node

 .../bindings/power/fsl,imx-gpcv2.yaml         |  1 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 62 +++++++++++++
 drivers/soc/imx/gpcv2.c                       | 93 +++++++++++++++++++
 include/dt-bindings/power/imx8mn-power.h      | 15 +++
 4 files changed, 171 insertions(+)
 create mode 100644 include/dt-bindings/power/imx8mn-power.h

-- 
2.25.1

