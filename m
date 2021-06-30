Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB43B7FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhF3JKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbhF3JKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:10:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6BCC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 02:07:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x22so1076796pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EunOHRF208NjwWFsRkZviCh5B7g+6zWrlmDRgMb1Q4=;
        b=ZQB3E9S6hmK9/GgfjKj9UFvOaFVFfbm7rL4iHToD4A8Q2J0ixPZw+maAkbB3K9m3/B
         mYM8NaoGUBEBSOUuecPXzDNP7JkF5nL1157O15TL3aaDujkhMWt1zbKDbF6mjXtilvBY
         cQ1PrD0AKhtuEWL6Mow1RUGK3ihTFjKUaxq+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EunOHRF208NjwWFsRkZviCh5B7g+6zWrlmDRgMb1Q4=;
        b=ui14bSCB8/BUBMrssj5IOr8RLCQoLRF7JXvAi68Q22My8ka5pT0WgfmQaQ+fIKvs0b
         kZ4LHI2g2kleXZg5J/2CDSRJ0D4rb9TH3Q1vTok/MvqQRoQIMvvuCBE5BNLf2v/FsMqh
         OOSKEtM/ZI0qmoCgMtTgqusvzyjG6z2ZXv1X8U6Gx84dywg0TzQwn+Ei7E7BnyRjlOV3
         ypMVG7DWYCy+EYJhIQYa3WbCqZJ/MOPOyH/tccwnoY8WUve5UvjYbUCF0XdM0BSIA1ko
         0dOSN55s8jqZ4G3v4KVD/WZKzyT7TFwGc3E6yIoEw2DVaNHuPtPhYlGZO3UJLih2lO2N
         fmdw==
X-Gm-Message-State: AOAM53039AZ/Y7QPROecwhASWwlOWUJ0ej7LyLqjc/7UJTMn+sxQpkJo
        O3yUIAwAsnb47DEa26KPtgSS+Q==
X-Google-Smtp-Source: ABdhPJwe5ressv6mI3pXKPXhPGqwlZTuAVhYAEKlP5foJIHcRuI9yUKHuKbiVGpA7ebHw0HeRReGtw==
X-Received: by 2002:a17:90b:230a:: with SMTP id mt10mr3399134pjb.236.1625044063075;
        Wed, 30 Jun 2021 02:07:43 -0700 (PDT)
Received: from kansho.tok.corp.google.com ([2401:fa00:8f:203:fc06:b3f6:f016:8299])
        by smtp.gmail.com with ESMTPSA id 73sm20822239pfy.83.2021.06.30.02.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 02:07:42 -0700 (PDT)
From:   Kansho Nishida <kansho@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Shunli Wang <shunli.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Kansho Nishida <kansho@chromium.org>
Subject: [PATCH 0/2] arm64: dts: mt8183: Add kukui platform audio node to the device tree
Date:   Wed, 30 Jun 2021 18:07:08 +0900
Message-Id: <20210630090710.1873559-1-kansho@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matthias,

The patch set adds audio node to kukui(mt8183) device tree.
By this change, the soundcards for each boards will be probed.

Thanks
Kansho



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

