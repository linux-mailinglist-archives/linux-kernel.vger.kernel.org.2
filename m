Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AFD3752DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhEFLQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbhEFLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:16:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A603C061574;
        Thu,  6 May 2021 04:15:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x5so5165438wrv.13;
        Thu, 06 May 2021 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKPKjC32Qn6kjND+LenXIZJVBF0PVCvDa6k0IxhTJHs=;
        b=KgMOyS4KfgGxmnqr/4bT0Qf2amG8M8M6esBofLumfkPmpZZ3Wxy8zgDGma+ML/YhvS
         h0+zDu6rX6/rbRMsiUMdbmFYDKT14FGHCcMuVfLXHZ+H1vPYvgLfb3KqsXoA2zgsnZ0K
         o8n+TDX9+4biv2xszruxtiz+T0QFCm6CaxehPfwkDG3KjIUldnHufQjMNxCaTvLkfnHp
         Y3NwTejxApoCelJylntzNERXtdtwm5LZ1xY4s54p9fIW1z0nh+UaJhbyF6SeG73wGX2s
         8EGaK9/nc9kexFqwGUyq6JASLSTnBnARcgw5rUmmI+5+GgGp20BRwyHMcC4tqpanMx/w
         gaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKPKjC32Qn6kjND+LenXIZJVBF0PVCvDa6k0IxhTJHs=;
        b=Jtp4BfcbdKcnY7KxXcvtlHqapwD1XtSZ+v4j51x5sCZrC2/8Xuj+kexQQSEDEQV9A9
         nsKJiqJiJd/IsyC2OfC5AUFNUkUXBhjwwVHMHjoGP74aCGf0hy7QGOwuO9zssCH90DcH
         HyxK6EqghziLgjcLxyLx0xKBKwiDyK8Bhw/uXeytlxGcvLPylZmaCdbw3o2jRCVmBwEP
         Bscni72jnmiCxWjgvkVofsGrzerNX//rbz7n0Tlv0Ec5fuh+FQP/bkFtfo+6MC1Mob8n
         UPl0dB1i3SZBEE5/9xkmDwKvbFLqLFgRfWaf6zPDm0dMnl2NWs1CnDm3FExM2plUki1w
         stEg==
X-Gm-Message-State: AOAM530jaeoXu/YfDn4+NIAbypAFXnZ0CPohOLVL3IMjMxxh+EK3h/zI
        9qN1reLrEfo5pZdV4XFyzZY=
X-Google-Smtp-Source: ABdhPJyEP75X+AJ8yeboScGjjt1ct0gGgAHI0daEWAMuYw/MAXK8h11es+AAXrMrI+arA/e7CozvMw==
X-Received: by 2002:a05:6000:154e:: with SMTP id 14mr4473511wry.24.1620299734257;
        Thu, 06 May 2021 04:15:34 -0700 (PDT)
Received: from localhost.localdomain (231.red-83-51-243.dynamicip.rima-tde.net. [83.51.243.231])
        by smtp.gmail.com with ESMTPSA id u5sm3642433wrt.38.2021.05.06.04.15.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 04:15:33 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, kishon@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com
Subject: [PATCH 0/5] phy: ralink: mt7621-pci-phy: some improvements
Date:   Thu,  6 May 2021 13:15:26 +0200
Message-Id: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series contains some improvements in the pci phy driver
for MT7621 SoCs.

MT7621 SoC clock driver has already mainlined in
'commit 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")'

Because of this we can update schema documentation and device tree
to add related clock entries and avoid custom architecture code
in favour of using the clock kernel framework to retrieve clock 
frequency needed to properly configure the PCIe related Phys.

After this changes there is no problem to properly enable this
driver for COMPILE_TEST.

Configuration has also modified from 'tristate' to 'bool' depending
on PCI_MT7621 which seems to have more sense.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos


Sergio Paracuellos (5):
  staging: mt7621-dts: use clock in pci phy nodes
  dt-bindings: phy: mediatek,mt7621-pci-phy: add clock entries
  phy: ralink: phy-mt7621-pci: use kernel clock APIS
  phy: ralink: Kconfig: enable COMPILE_TEST on mt7621-pci-phy driver
  phy: ralink: Kconfig: convert mt7621-pci-phy into 'bool'

 .../bindings/phy/mediatek,mt7621-pci-phy.yaml | 12 +++++++
 drivers/phy/ralink/Kconfig                    |  4 +--
 drivers/phy/ralink/phy-mt7621-pci.c           | 33 +++++++++++--------
 drivers/staging/mt7621-dts/mt7621.dtsi        |  4 +++
 4 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.25.1

