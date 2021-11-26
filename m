Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C743245F122
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378305AbhKZP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352017AbhKZPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:55:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7342CC06179B;
        Fri, 26 Nov 2021 07:44:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d24so19606780wra.0;
        Fri, 26 Nov 2021 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLkyoLUKpRjZnUdDc279znKmoge1lvnkGD50/gVexkQ=;
        b=OqVKngMbKLP1DHv9TsYenjFQef9cX6K7kJey9mSlOp6MZOzu3usOtwBL0qb2SNi4EK
         ffP1HlR1pHpOe7MCNiKzCLNi/xllzf8RTz6nNXz4Ujt3LAOaN6OLa7vnaZb7XvQFGXPF
         btNKgwianGoMtkWVm7adowHH4JIvmWOGvnzXBPija5qvt9p8cdv12LiLl3M1Lmfvi+cg
         tEM5Svnk6RyH9iHSCwTb8TWGt1YCB9XSU78W7pamTXnBNDyEkCt3x3+QevXjCso/2Wpi
         ydRzASYt1K/q3legxeFrgeQYmFHYGCJIjFyNqC8DckkEMt1RMRrNhrU1Ib2hJR3i/uDO
         W26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLkyoLUKpRjZnUdDc279znKmoge1lvnkGD50/gVexkQ=;
        b=M5jpD0/p4wu/GwrS3a/tJDS5oDp68a6Fe/lbrvMtbMDQXQNsyQRwfed6DNH00IQB6X
         EQ33xvevXYEsb52NzCNwIEKUjIdEqAlTLWTQS65VjSHQRIQY7AKzSy/8sTot29iwvlvw
         JJ3j+F2roZ6n7QDO+IIW169UTMIFTcy0fA0wdnVaC5GExRfsBRB7PHujfxZcH0fSTI0W
         AoJSJH63p6mZG0uDf9gowNmtaoeq22t8G3P+g3Lxh6SyqQ8CQxV9BJ50CFlqxYJx29PP
         ViMlnoZyJVYBF3xga4miiM626lK7qcbRJZTSLKBwwqII/ZYSWu9Hhl/2zBvYOCuPn1mn
         Ch4A==
X-Gm-Message-State: AOAM532lmQ5FooTvGo/YgJBFKbdes4xK34s4oAk1xENxfxnD4OYJ7TXl
        bUsjRG9KbFOEetzEdhaDA0Y=
X-Google-Smtp-Source: ABdhPJz32axiOIaYWuL5xgqmPKeOpKTpr4MPYCFIT4SmwfpsM90/cnVDf90UkxFLZUgJBM6pUasxug==
X-Received: by 2002:adf:fa4b:: with SMTP id y11mr15142087wrr.460.1637941439074;
        Fri, 26 Nov 2021 07:43:59 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id p13sm11372400wmi.0.2021.11.26.07.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:43:58 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] RK356x/Quartz64 Model A SPI
Date:   Fri, 26 Nov 2021 16:43:41 +0100
Message-Id: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch of this series adds a compatible for rk3568-spi
to the DT bindings.

The second adds the SPI nodes for RK3566 and RK3568 SoCs. The nodes
were lifted from the downstream vendor kernel's devicetree, and were
double-checked for correctness.

The third patch sets up the broken-out SPI pins on the Quartz64
Model A; they use the "m1" set of the pins, not the "m0" set. I
assume the "m" stands for "mux".

I've tested both patches by connecting an MCP2515 SPI CAN bus
controller to the spi pins, which initialised fine.

Regards,
Nicolas Frattaroli

Nicolas Frattaroli (3):
  dt-bindings: spi: spi-rockchip: Add rk3568-spi compatible
  arm64: dts: rockchip: Add spi nodes on rk356x
  arm64: dts: rockchip: Add spi1 pins on Quartz64 A

 .../devicetree/bindings/spi/spi-rockchip.yaml |  1 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  5 ++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 68 +++++++++++++++++++
 3 files changed, 74 insertions(+)

-- 
2.34.0

