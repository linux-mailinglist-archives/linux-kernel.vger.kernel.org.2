Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF854393DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhE1HZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbhE1HZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:25:40 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46884C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 00:24:06 -0700 (PDT)
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F3DC782CFA
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 09:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1622186645;
        bh=NfjgOcSAiOExjKOX7ld2ADzJG7qdNwxiZWM1VBqYt9E=;
        h=From:To:Cc:Subject:Date:From;
        b=kFzv0fy8p8ksC78E9ns5f/x7S7pQsaIKAF3iaGiK9XjW2IvlNusm+bVs5+3kxkFAF
         7+/bVKvY0UgCl5rZkRw6IHIYvRRZd+UW5M68iF32GEwkj98XpxvFaKaodgu5/g3Q5y
         VkdntFr3s51VgVqWGcpQ/pC4RJcWMgTACcfZhYWML7R8wn+ECuip1goVJafiews0RK
         XoH+bSedIeH834PzfjkiN8PoqzcZlEJVIlovZ8nUn8+hmfBq2PSbHT7olk3GaTSzvQ
         uahevn5rTvc5grVgiSLePjn8Quf4YJ0WmqjpbztQm3g0fhEBaeIGmIUeGdXCwHT6Mh
         corLQqxhXiDCA==
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 8CB1F182B99;
        Fri, 28 May 2021 09:23:53 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 63FAC1A8BC5; Fri, 28 May 2021 09:23:53 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-mtd@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] mtd: devices: add support for microchip 48l640 EERAM
Date:   Fri, 28 May 2021 09:23:49 +0200
Message-Id: <20210528072351.1639575-1-hs@denx.de>
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



Heiko Schocher (2):
  mtd: devices: add devicetree documentation for microchip 48l640
  mtd: devices: add support for microchip 48l640 EERAM

 .../bindings/mtd/microchip,mchp48l640.yaml    |  40 ++
 drivers/mtd/devices/Kconfig                   |   6 +
 drivers/mtd/devices/Makefile                  |   1 +
 drivers/mtd/devices/mchp48l640.c              | 379 ++++++++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
 create mode 100644 drivers/mtd/devices/mchp48l640.c

-- 
2.30.2

