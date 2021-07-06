Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F133BC8EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhGFKEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhGFKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:04:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1397C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 03:01:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s18so5807903pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uliIU2m17ulU3tWZdvwBwlJdH1ELovSXyv/0ht1xq+E=;
        b=KpDXFN2TB9LCytImhRbUZP2d+IBfn13+vuF79l5n94yQG2rFYRnlTXzm0KhkQ5olSl
         aYJGpLzzoEc9LvndZgFz5TJtMQeqWFSZaEUgX4qKjcK4iSmu9CYiPFzDMzmvO8aZIz+3
         OztLGz5EOMNfSfACHa5E63GQgOrCHXqi4ut9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uliIU2m17ulU3tWZdvwBwlJdH1ELovSXyv/0ht1xq+E=;
        b=nmcHVG9kxP44vjIod3W+pDorie8+KtUrrCO9GfjyAVvJXuP6xxajfCjyDlkRpFvesQ
         OO25Itxcy7j8vkr0hc1c9RXw7/Rlqr8GJQn27gbisMbWZSRpiq2ipR0Y8mWTzqeT+jnf
         7urTxVfHmnA6kVWIiF6FTXLQ2bODDOHi+/0H8pyldiTDp3QobxdZfHy7dQAGQtDheROj
         fESHIfm5mVAZ2F8NTW5XkYLvVnSfIcxuWhLOhXdvlIFGTc6s6KOwpbH4ku2qBtCUMJrw
         MPnYxsMuC+s+AolEsTBuWBZnGU2F1lH9t101wWH4uDq3+sR1OUYcUGSEzemzNPmMqGY4
         FGdA==
X-Gm-Message-State: AOAM532r2s1OjjOw2i7G1J+//CRzMn7mZSJe471NCKrh88FoDrp42f9f
        VlQzQrhhifT3pBmpprXrpz/Jkw==
X-Google-Smtp-Source: ABdhPJx+Ir/qwXQ68CxJH4FAZ/envqizD1shhTEclBQijaU/eCQH5OPZfyru4yGvuoxtIPqBcuTPvQ==
X-Received: by 2002:aa7:87c2:0:b029:320:d13:d8a7 with SMTP id i2-20020aa787c20000b02903200d13d8a7mr8761493pfo.44.1625565702530;
        Tue, 06 Jul 2021 03:01:42 -0700 (PDT)
Received: from kansho.tok.corp.google.com ([2401:fa00:8f:203:39c:c8d0:5422:cb9c])
        by smtp.gmail.com with ESMTPSA id y4sm4446642pfa.14.2021.07.06.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 03:01:42 -0700 (PDT)
From:   Kansho Nishida <kansho@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Shunli Wang <shunli.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Kansho Nishida <kansho@chromium.org>
Subject: [PATCH v3 0/2] arm64: dts: mt8183: Add kukui platform audio node to the device tree
Date:   Tue,  6 Jul 2021 19:01:34 +0900
Message-Id: <20210706100136.1205047-1-kansho@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matthias,

This patchset is the v3 patch!

Regards,
Kansho


Changes in v3:
- Use audio-controller as the audio node instead.

Changes in v2:
- Changed to the dual license GPL + MIT.

Kansho Nishida (2):
  arm64: dts: mt8183: add audio node
  arm64: dts: mt8183: add kukui platform audio node

 arch/arm64/boot/dts/mediatek/mt6358.dtsi      |  1 +
 .../mt8183-kukui-audio-da7219-max98357a.dtsi  | 13 +++
 .../mt8183-kukui-audio-da7219-rt1015p.dtsi    | 13 +++
 .../mediatek/mt8183-kukui-audio-da7219.dtsi   | 54 +++++++++++
 .../mt8183-kukui-audio-max98357a.dtsi         | 13 +++
 .../mediatek/mt8183-kukui-audio-rt1015p.dtsi  | 13 +++
 ...mt8183-kukui-audio-ts3a227e-max98357a.dtsi | 13 +++
 .../mt8183-kukui-audio-ts3a227e-rt1015p.dtsi  | 13 +++
 .../mediatek/mt8183-kukui-audio-ts3a227e.dtsi | 32 +++++++
 .../mediatek/mt8183-kukui-jacuzzi-burnet.dts  |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-damu.dts    |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  1 +
 .../mt8183-kukui-jacuzzi-juniper-sku16.dts    |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-kappa.dts   |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-kenzo.dts   |  1 +
 .../mt8183-kukui-jacuzzi-willow-sku0.dts      |  1 +
 .../mt8183-kukui-jacuzzi-willow-sku1.dts      |  1 +
 .../boot/dts/mediatek/mt8183-kukui-kakadu.dts |  1 +
 .../dts/mediatek/mt8183-kukui-kodama.dtsi     |  1 +
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi |  5 +
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 67 ++++++++++++-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 94 ++++++++++++++++++-
 22 files changed, 336 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi

-- 
2.32.0.93.g670b81a890-goog

