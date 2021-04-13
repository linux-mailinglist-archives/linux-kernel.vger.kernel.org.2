Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6735E2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbhDMPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:34:17 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43387 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhDMPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:34:16 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 073CC2224D;
        Tue, 13 Apr 2021 17:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618328035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wlpXTeIgB0wwyJ+A27ebON2mk4B+HvdTc8AUtUC3MYE=;
        b=qvHSU1wmGxmdmctGWJmjwwR8IGN0XM1oCKnLOG3IFfHA9/XodlVpB6iPzImQUI5CIdwmF3
        lquNWCvikV0oLb1aYGbkBo8gnF1FLUQum+S1jcS6XVxMw5kKZjv50H/7RQjMy92IloOp7z
        Qjqcwmg5Vog4CYpbgbny4yp7pX2OgGI=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/2] arm64: dts: freescale: sl28: fix RGMII
Date:   Tue, 13 Apr 2021 17:33:47 +0200
Message-Id: <20210413153349.29119-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the RGMII on the sl28 boards. While the network port was
actually working it is still out-of-spec.

Please note, that this is split into two patches because each one fixes
a different commit.

Michael Walle (2):
  arm64: dts: freescale: sl28: fix RGMII clock and voltage
  arm64: dts: freescale: sl28: fix RGMII clock and voltage

 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts     | 3 ++-
 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts     | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1

