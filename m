Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA8361F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbhDPLuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDPLuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:50:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE27C061574;
        Fri, 16 Apr 2021 04:49:35 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 388732224A;
        Fri, 16 Apr 2021 13:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618573773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oB/Ab68gOO29EsC3+FTgow2Hyng5ZQUfAUylQq2Zats=;
        b=BmPdDcxQB1Eapv8iuzLFQUGQJMmkEWLN+iC1WMgLX9XgvYdC/LdpG1VQHmIoaQCbC19VmY
        NWGIbrbdzKftuXcqOst+rDVo+Mp3du3fr/lvnI1M54iPJFGVMbFvugME+g8iNlFrRHp6uG
        JPT8OMRC8O5Ao/yeO+TrCDZN0X5cwjs=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/5] mtd: core: OTP nvmem provider support
Date:   Fri, 16 Apr 2021 13:49:23 +0200
Message-Id: <20210416114928.27758-1-michael@walle.cc>
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

Michael Walle (5):
  nvmem: core: allow specifying of_node
  dt-bindings: mtd: add YAML schema for the generic MTD bindings
  dt-bindings: mtd: add OTP bindings
  dt-bindings: mtd: spi-nor: add otp property
  mtd: core: add OTP nvmem provider support

 .../devicetree/bindings/mtd/common.txt        |  16 +-
 .../bindings/mtd/jedec,spi-nor.yaml           |   6 +
 .../devicetree/bindings/mtd/mtd.yaml          |  89 +++++++++++
 drivers/mtd/mtdcore.c                         | 149 ++++++++++++++++++
 drivers/nvmem/core.c                          |   4 +-
 include/linux/mtd/mtd.h                       |   2 +
 include/linux/nvmem-provider.h                |   2 +
 7 files changed, 252 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd.yaml

-- 
2.20.1

