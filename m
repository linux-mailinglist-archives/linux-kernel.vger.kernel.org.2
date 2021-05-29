Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB01394BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhE2K3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 06:29:32 -0400
Received: from phobos.denx.de ([85.214.62.61]:59562 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhE2K3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 06:29:31 -0400
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E801881ECA
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 12:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1622284073;
        bh=0K5fa1pym+uYrWwUk5lMIEsPkX2k9QBt+qQSNfxfW38=;
        h=From:To:Cc:Subject:Date:From;
        b=DAA2sQ/oPk60qUa600SZlWYTjfJ/5wIWZQBlMIKeCSraXqk00lsKSYVTMdKkFOVN9
         Fc11JB7ZrnReBDE8JmRDTyYi6AllspFOuHyXs4DY7aGbxrzGL+gQ/Bf2XN8NR8SDqz
         qXDkJMeVKtqNOo7lqQlb3EsB4LYimxdAhV8fByxGbeAaT+jfOwRL9EwCnroo1sm181
         MTKTH7Hm+Esp2jchFBjzSQ3mlAsfYyp1BTU7M5qY/HbuHeEJZIGBR/jjZzj1v+idNE
         S7XfgI06+NQzNp4BKviPA1POhYBBvTl6UB0+sreQ7u+LvoamOSr5VdfdwP0r+bvIC7
         PmdjQXmePDgzw==
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 91283182BA2;
        Sat, 29 May 2021 12:27:46 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 6B0D31A8BC4; Sat, 29 May 2021 12:27:46 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-mtd@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mtd: devices: add support for microchip 48l640 EERAM
Date:   Sat, 29 May 2021 12:27:42 +0200
Message-Id: <20210529102744.1251220-1-hs@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


add support for microchip 48l640 eeram connected via
SPI. Patch 1 introduces devicetree documentation
and patch 2 the driver.


Changes in v2:
as Rob helped, fix warnings from running command
'make DT_CHECKER_FLAGS=-m dt_binding_check'
- fix build warnings
- add Fabios Tested-by

Heiko Schocher (2):
  mtd: devices: add devicetree documentation for microchip 48l640
  mtd: devices: add support for microchip 48l640 EERAM

 .../bindings/mtd/microchip,mchp48l640.yaml    |  45 +++
 drivers/mtd/devices/Kconfig                   |   6 +
 drivers/mtd/devices/Makefile                  |   1 +
 drivers/mtd/devices/mchp48l640.c              | 374 ++++++++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
 create mode 100644 drivers/mtd/devices/mchp48l640.c

-- 
2.30.2

