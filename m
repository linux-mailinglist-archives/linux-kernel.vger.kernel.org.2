Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4323C350D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhGJPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhGJPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 11:13:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F95C0613DD;
        Sat, 10 Jul 2021 08:11:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x24so9919789qts.11;
        Sat, 10 Jul 2021 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KndYjn/Dras9oVIQu2++er4oTGHdDL9wFnaryusxvs=;
        b=B6WoR/v9T7cQNrzS57RnEcalDQ2xAUCVfH8AHia78qYmqJcnyTrzeJvYnUmMAGKbrh
         L6lym41qO2VC+Zzi+b/1uoAMP8CMWXTOV/De66tzKyrdtIKDafc6526ll/7Om2FT7+dQ
         IwviBoG7qWow5kxW1F/o1NfkclkhBolm+oyxy9/Fvs0Dv5/GYD70BJHAmzDUbabEHDpR
         wm8Q0X2hRsA5C9Q3RESepneBX+abTr3GZBI5C9p7mGizrj8ZU5wh8S6s/yPf7ijSoFV2
         CZlKWppIoOUOcLCRG4KlEfQovUaj7tjOhxHqJejWZuxmKtEK2Da8LNqj/jiiDGC2PKZr
         J9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KndYjn/Dras9oVIQu2++er4oTGHdDL9wFnaryusxvs=;
        b=sNY/vK45F30MCE//8ePdxbyOnuEFNvzxQpfeEucxcjZ5uzRWjwB4zS/gQdW0a8m1Zb
         f7PV/kb8mHnY4vY95/ye9/ygyRa+xExkDz/8Xq+E9gsY+mLFrRIak//Iw+0BqmP8zuYv
         J3/KTKFriLn51PzvJAwo1SmL/dN87JNhhu/w0V42E/Wk9Nca9wc5iWFnngc8l4gvwK35
         hPx5XGgyihz883eDCPDVuAI6F/wqKTC0Gt0GeUQFp5gzTyS9L9oQ8yAc/yUe6y6+0A3J
         gkHjK1gyK6cNAR4zBRgTUwmohl9tGegheVsQTptPeZ4gkwN7MooxZjVnWBK7NkX9SvjC
         N/pw==
X-Gm-Message-State: AOAM53196nU9k7ZM104XHR5s6PHMQ/HI5nraxz4Q+AO52J3bX7rVqwX9
        AP3BzxwSF+TV3frv2uzLhdIc3JguC2z1xP+6
X-Google-Smtp-Source: ABdhPJz21VqzR4nb52cDDOeFHg0qPp4Qsl+zwsPTGvKAX58JL6UuNxo6EjbCCPKhk86LIDOel9MF0A==
X-Received: by 2002:ac8:ece:: with SMTP id w14mr39481837qti.5.1625929869827;
        Sat, 10 Jul 2021 08:11:09 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:ecc6:5233:6153:7b36])
        by smtp.gmail.com with ESMTPSA id w14sm3445482qtc.55.2021.07.10.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 08:11:09 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 0/4] split rk3568 and rk3566 device trees
Date:   Sat, 10 Jul 2021 11:10:30 -0400
Message-Id: <20210710151034.32857-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an example patch set that addresses the split of the rk3568 and
rk3566 soc device trees.
This method attempts to avoid deleting and modifing nodes by maintaining
a common dtsi for all common items and adding in the differences in
separate dtsi files.
It also includes a basic dts for the Pine64 Quartz64 Model A board
as an example of a rk3566 device.

This series has the following prerequisite:
arm64: dts: rockchip: add pmu and qos nodes for rk3568
https://patchwork.kernel.org/project/linux-rockchip/patch/20210624114719.1685-4-cl@rock-chips.com/

Peter Geis (4):
  arm64: dts: rockchip: move rk3568 dtsi to rk356x dtsi
  arm64: dts: rockchip: split rk3568 device tree
  arm64: dts: rockchip: add rk3566 dtsi
  arm64: dts: rockchip: add basic dts for Pine64 Quartz64-A

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 321 +++++++
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      |  20 +
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 814 +-----------------
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 786 +++++++++++++++++
 6 files changed, 1153 insertions(+), 794 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk356x.dtsi

-- 
2.25.1

