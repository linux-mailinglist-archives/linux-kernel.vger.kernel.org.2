Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C1344E58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhCVSUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:20:21 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:39321 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhCVSUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:20:07 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3347122235;
        Mon, 22 Mar 2021 19:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616437203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SxpId9qwMWCyRo+nBXdhG1wstwEIVslF9/SHxhhLN5s=;
        b=KWo0c2fipzhzAxOznyiMV3nndYf9T5pqY15N4oPf5BKWqv3AUM9i/+/bQ2PfJirbqak137
        gxfK2iQ8CBKDA/w81/XJ6cDmO94ifsGuZ2Ip7eEc8AzZ7qqYTE9aRL1A3jscTjRU+4WaNV
        ZNot83yCr9OMiYMJcJ0LgiQg9tW9vsQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 0/4] mtd: core: OTP nvmem provider support
Date:   Mon, 22 Mar 2021 19:19:45 +0100
Message-Id: <20210322181949.2805-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal is to fetch a (base) MAC address from the OTP region of a SPI NOR
flash.

This is the first part, where I try to add the nvmem provider support to
the MTD core.

I'm not sure about the device tree bindings. Consider the following two
variants:

(1)
    flash@0 {
        ..

        otp {
            compatible = "mtd-user-otp";
            #address-cells = <1>;
            #size-cells = <1>;

            serial-number@0 {
                reg = <0x0 0x8>;
            };
        };
    };

(2)
    flash@0 {
        ..

        otp {
            compatible = "mtd-user-otp";
            #address-cells = <1>;
            #size-cells = <1>;

			some-useful-name {
                compatible = "nvmem-cells";

                serial-number@0 {
                    reg = <0x0 0x8>;
                };
			};
        };
    };

Both bindings use a subnode "opt[-N]". We cannot have the nvmem cells as
children to the flash node because of the legacy partition binding.

(1) seems to be the form which is used almost everywhere in the kernel.
That is, the nvmem cells are just children of the parent node.

(2) seem to be more natural, because there might also be other properties
inside the otp subnode and might be more future-proof.

At the moment this patch implements (1).

Michael Walle (4):
  nvmem: core: allow specifying of_node
  dt-bindings: mtd: add YAML schema for the generic MTD bindings
  dt-bindings: mtd: add OTP bindings
  mtd: core: add OTP nvmem provider support

 .../devicetree/bindings/mtd/common.txt        |  16 +-
 .../devicetree/bindings/mtd/mtd.yaml          | 110 +++++++++++++
 drivers/mtd/mtdcore.c                         | 149 ++++++++++++++++++
 drivers/nvmem/core.c                          |   4 +-
 include/linux/mtd/mtd.h                       |   2 +
 include/linux/nvmem-provider.h                |   2 +
 6 files changed, 267 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd.yaml

-- 
2.20.1

