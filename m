Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B685536A0C1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 13:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhDXLHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhDXLHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 07:07:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9657CC061574;
        Sat, 24 Apr 2021 04:06:18 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0643E22178;
        Sat, 24 Apr 2021 13:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619262374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rZ+I/irwn/OCLHsOVLfWBRlbXKmaiZIgFDgdHK7w49o=;
        b=L5cygG4pEtkeFYLpTrmrNvYR3aHBmh1s1LeMsNhWANf6DBnBI4oR2YjGXrIJbWGWoXEjS+
        sZsKhOulWcjWS0gjxcnaBJCxqB5qiHQ6p3efyTkiYzdT1phHLqTPaDCchGkqjWZx3xpyIO
        xjC7LgylUEOK/dzyZHg0Jgu8kYLGZWc=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/5] mtd: core: OTP nvmem provider support
Date:   Sat, 24 Apr 2021 13:06:03 +0200
Message-Id: <20210424110608.15748-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some flashes provide one (or more) OTP regions which can be used to
store MAC addresses or serial numbers. Implement a NVMEM provider for
this storage which then can be used by a network card to fetch the
MAC adress for example.

This is an example DT node:

flash@0 {
    otp {
        compatible = "user-otp";
        #address-cells = <1>;
        #size-cells = <1>;

        serial-number@0 {
            reg = <0x0 0x8>;
        };
    };
};

Michael Walle (5):
  nvmem: core: allow specifying of_node
  dt-bindings: mtd: add YAML schema for the generic MTD bindings
  dt-bindings: mtd: add OTP bindings
  dt-bindings: mtd: spi-nor: add otp property
  mtd: core: add OTP nvmem provider support

 .../devicetree/bindings/mtd/common.txt        |  16 +-
 .../bindings/mtd/jedec,spi-nor.yaml           |   6 +
 .../devicetree/bindings/mtd/mtd.yaml          |  89 +++++++++++
 drivers/mtd/mtdcore.c                         | 148 ++++++++++++++++++
 drivers/nvmem/core.c                          |   4 +-
 include/linux/mtd/mtd.h                       |   2 +
 include/linux/nvmem-provider.h                |   2 +
 7 files changed, 251 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd.yaml

-- 
2.20.1

