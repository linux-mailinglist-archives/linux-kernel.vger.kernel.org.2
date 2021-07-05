Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80A3BB9FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGEJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhGEJSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:18:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C65C061760
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:15:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n11so11376447pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umJqdN/Kghanf87PrOW7ly3BAvBjzkV6eo4lUVI3NGE=;
        b=ZV2NSqe96CvOJzGYnnmqxN8ckY+rjz0Vq0upurDVUYC25uAZJRSyAI+EVqkJcXQ7cm
         vDYQqe+0eiKIRVYagfV7CLb9neTq5BVvwuQFZS9WAqE4T0UZqRgq91DjXk1t7JCIORDB
         3C3byV6yYUm9J3wbLWmkN9erWjjKLVVcnJbUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umJqdN/Kghanf87PrOW7ly3BAvBjzkV6eo4lUVI3NGE=;
        b=QchPBiuetuqXOAMr+vsbvvx+nDJ1MWbLvlZTFW9xrcsJMKh3VFNmEvG7ptD9q8kvYk
         TVVMnBRIdFahPHp134Rd0sJ4lRyxMnJ7TQttvFLHf4mQI7bjtYvlCJL+CrhnqK6l04NT
         O7Y5nXY9y4JY4S2MXfI5u16gG+djlMg8pAgJ7EFIt6NvSbuRBCFVeU0hNckYg1ed3DjN
         aRe6DjUS5SfMJJrAnW9ho20hQwJw0gW+xTLGYXbq4z6bg8Yxn/8urSK8bsCb8InsExOq
         Xw7pO8KHujVm8/vr+2BhBVfolubrcTVJ+ybmZg4O6zfjb7hcDmI/UGJSCsAbAVGmzPZp
         cO3g==
X-Gm-Message-State: AOAM532WrvZDRc0vAlmaWZ5AEaYPUzLIqvCTDkFqReK+ybBKwOXeZ8lp
        WuD1jrrOoPQztuAarfMDt3LV+g==
X-Google-Smtp-Source: ABdhPJzvsk3n7se/8QtiY+N021ieLTuJ8ebq64UibbjCe4HmDxTqZ34SFxfYvhwG0OPPQ27RVKh0wA==
X-Received: by 2002:a17:90a:fb8d:: with SMTP id cp13mr14382138pjb.21.1625476524343;
        Mon, 05 Jul 2021 02:15:24 -0700 (PDT)
Received: from kansho.tok.corp.google.com ([2401:fa00:8f:203:cdc4:4be8:5ce4:df43])
        by smtp.gmail.com with ESMTPSA id 9sm12245176pfv.42.2021.07.05.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 02:15:23 -0700 (PDT)
From:   Kansho Nishida <kansho@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Shunli Wang <shunli.wang@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Kansho Nishida <kansho@chromium.org>
Subject: [PATCH v2 0/2] arm64: dts: mt8183: Add kukui platform audio node to the device tree
Date:   Mon,  5 Jul 2021 18:15:12 +0900
Message-Id: <20210705091514.912355-1-kansho@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matthias,

This patchset is the v2 patch applying your comment.

Regards,
Kansho


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

