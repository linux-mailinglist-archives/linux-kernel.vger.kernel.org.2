Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0541A5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbhI1C76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 22:59:58 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:57302 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbhI1C7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:59:55 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18S2aTCb072684;
        Tue, 28 Sep 2021 10:36:29 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Sep 2021 10:57:10 +0800
From:   tommy-huang <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/6] *** Add AST2600 GFX node ***
Date:   Tue, 28 Sep 2021 10:56:57 +0800
Message-ID: <20210928025703.10909-1-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18S2aTCb072684
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AST2600 GFX support first.

Joel Stanley (5):
  ARM: dts: aspeed: Add GFX node to AST2600
  ARM: dts: aspeed: ast2600-evb: Enable GFX device
  drm/aspeed: Add AST2600 support
  HACK: drm/aspeed: INTR_STS hadndling
  HACK: drm/aspeed: Paramterise modes

tommy-huang (1):
  dt-bindings: gpu: Add ASPEED GFX bindings document

 .../devicetree/bindings/gpu/aspeed-gfx.txt     |  1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts       | 13 +++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi               | 11 +++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c        | 18 +++++++++++++-----
 4 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.17.1

