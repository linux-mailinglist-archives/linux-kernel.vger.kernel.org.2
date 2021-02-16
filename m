Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421FF31CEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhBPRKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhBPRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:10:16 -0500
Received: from pmg02-out3.zxcs.nl (pmg02-out3.zxcs.nl [IPv6:2a06:2ec0:1:b::ffea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F244C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:09:28 -0800 (PST)
Received: from pmg02.zxcs.nl (localhost.localdomain [127.0.0.1])
        by pmg02.zxcs.nl (ZXCS) with ESMTP id E010F82663;
        Tue, 16 Feb 2021 18:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CQp8a9bvhUdwKVBZ0N74gvncL9qmC+u/ZFHCgpEsS+o=; b=J50Nm06a0Q51h3t6vBefpAdhwE
        qUU6PnVO0ETMQZWrfbYifiMV+K3vdb93a/bgcoI8JZ3JS1n0EaFeqJHVZgqq1g44DdRGCSMiE3rEo
        EmY0rsoxnQslBiDKQlR25nZJCQPy++iz/NAbm0cHi3xHkDsnBDnUhGvQaEz4IHMw8YiAHnUk9ePCq
        aJDftDN39WtTpjUSLRFiivUGO/yTCe2xEM2sYqExeJzRAC0bDnpKMNajz9oMh6mwhwsOcw5szbp/4
        eUV4D77lwpxnlZuFEkxEtocsJrCNP6lKdnMQnTC1gu8qTY9gz1H3yTErRFzsgElA/tROBumk3Ovlm
        lPXF4nAQ==;
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Martin Cerveny <m.cerveny@computer.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [PATCH RESEND v3 0/2] Add support for Topwise A721 tablet
Date:   Tue, 16 Feb 2021 17:59:52 +0100
Message-Id: <20210216165954.43135-1-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: dev@pascalroeleven.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On request I'm resending the last two patches from the Topwise A721 tablet
series from a year ago as they weren't picked up. The other patches are
already merged, so I didn't resend them. They still apply as-is, so no changes
are made.

Changes from v2:
* Collected acked-by.

Original cover letter:

This series add support for the Topwise A721 tablet and it's display.
It is an old tablet (around 2012) but it might be useful as reference
as the devicetree is pretty complete.

Changes from v1:
* Split into multiple patches
* dt-binding: use yaml instead of txt
* dt-binding: add Topwise A721 to sunxi.yaml
* dt-binding: add Topwise to vendor-prefixes
* drm: Add bus_format, bus_flags and connector_type
* dts: Use SPDX license identifier instead of boilerplate license text
* dts: Remove pinctrl leftovers

Pascal Roeleven (2):
  dt-bindings: arm: Add Topwise A721
  ARM: dts: sun4i: Add support for Topwise A721 tablet

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/sun4i-a10-topwise-a721.dts  | 242 ++++++++++++++++++
 3 files changed, 249 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-topwise-a721.dts

-- 
2.27.0


