Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE43D8DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhG1M0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhG1M0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6AAC061757;
        Wed, 28 Jul 2021 05:26:18 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h27so1150693qtu.9;
        Wed, 28 Jul 2021 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cpOBZXZl+X9zh9reb80OTm+Y4W8Zt/c3AvDZt4KISo=;
        b=vJXvb2Jmlbm70+yCmjiFIleraKYYYJ+oFk0cRA5lKzzVnAChhB3QFlFl0bUDpkHvfX
         53r0RALch+rrgQJM1zkvkguosuCN/W1V2Q9uHeVBjXZD8xK0bO93xihBguGNVexr/Jeh
         QTCxKj50OMfwF3ak0WF9eXh8Q7RRqC5N+p1zhgGbNU9Bp2WaYBeBsv2EkpyLvdBRsH0W
         JYino0wZ7Or+Qfw8WYdAnX3tfOVHpjl3rLktWochoOAQovvHx8piGe1m2ESF0ZhDd6gH
         iMAX7E8FC2NVR9lIfLnEZCboTWg9yatSJoNW85DnzbmYxzlBIKxqtasQKSy/WYXjaFj1
         huIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cpOBZXZl+X9zh9reb80OTm+Y4W8Zt/c3AvDZt4KISo=;
        b=ES+ymiLpVH57Mk9eWDbjsulV7zk4yc9XV48ZDXAtCVO6lfKBHwbMHqkFdGQZHsDIOy
         Hm41AszwujHB2GPUrtgopV/6kRNucD5m3fcJqNUcs2nAzRVraaUDNJ8x9NONMGRXp6+t
         Q2OxrZb7BRs5xzFEzewURrockoujcv/tOGmw94wJfVO4fFFc5XWip7F0KuMItSDu6Dh7
         w7XNFZucDXmkJJv12+gbNc2z+GgqejEPdeOJGfikFYW4hxcOab8HY3kHaIhp9+y1m1Kr
         xa6/WmspGLDlMeGMkZESmJgud+IDSw1GfGrD/9ZcDA6jvGIq9FTSRQlty2aI0rVeiIHN
         VtIw==
X-Gm-Message-State: AOAM530ab0jISQ7AOId6LdvA0s+kfSVuCyQP9mK3epUp4353b+uZbkY8
        /UyfyWJZ/YBK/QJgIQ6p0FA=
X-Google-Smtp-Source: ABdhPJxZ0V3Jp5j7jIzfzpXOPbo0SByMp8ZIPkpmvH3SLHeS+IK/TXItGd/fCc0GPVXtnhnIL5OTRw==
X-Received: by 2002:a05:622a:1828:: with SMTP id t40mr23729089qtc.276.1627475177902;
        Wed, 28 Jul 2021 05:26:17 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id z9sm2842972qtn.54.2021.07.28.05.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:26:17 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 0/9] phy-rockchip-inno-usb2: support rk356x usb2phy
Date:   Wed, 28 Jul 2021 08:25:57 -0400
Message-Id: <20210728122606.697619-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

This is my series to support the usb2 phy devices on the rk356x.
The rk356x phy has a single muxed interrupt and has moved the usb2phy
nodes out of the grf and into their own nodes.
The phy needs to tie back into the grf for register control, similar to
the rv1108.
By moving the phys into their own nodes, they now have full
#address_cells = 2 register addresses, but they still reside below the 32bit
mmio range.

This driver series only supports the host configuration for the rk356x.
I have have tested it on the following:
rk3566 - Pine64 Quartz64 Model A
rk3399 - Pine64 Rockpro64

Please provide feedback and comments as you see fit.

Peter Geis (9):
  dt-bindings: soc: rockchip: add rk3568-usb2phy-grf
  dt-bindings: phy: phy-rockchip-inno-usb2: add rk3568 documentation
  dt-bindings: usb: generic-ohci: increase maximum clocks
  phy: phy-rockchip-inno-usb2: support #address_cells = 2
  phy: phy-rockchip-inno-usb2: support standalone phy nodes
  phy: phy-rockchip-inno-usb2: support muxed interrupts
  phy: phy-rockchip-inno-usb2: add rk3568 support
  arm64: dts: rockchip: add usb2 nodes to rk3568 device tree
  arm64: dts: rockchip: add Quartz64-A usb2 support

 .../bindings/phy/phy-rockchip-inno-usb2.yaml  |   8 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml |   1 +
 .../devicetree/bindings/usb/generic-ohci.yaml |   2 +-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  52 ++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  97 +++++++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 259 ++++++++++++++----
 6 files changed, 360 insertions(+), 59 deletions(-)

-- 
2.25.1

