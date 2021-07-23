Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE93D3B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhGWNPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:15:24 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48395 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhGWNPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:15:23 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 4D9B11BF209;
        Fri, 23 Jul 2021 13:55:53 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/3] add SMC based regmap driver for secure syscon access
Date:   Fri, 23 Jul 2021 15:52:36 +0200
Message-Id: <20210723135239.388325-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running under a secure monitor, some peripherals are setup as accessible
by secure world only. When those peripherals are system controllers, they might
need to be accessed by the normal world for some peripheral configuration.

In order to keep the existing code working for such devices (which usually uses
the regmap from a syscon), this series adds support for a regmap that uses SMCs
(Secure Monitor Call) to request access to registers. The secure monitor will
then catch these accesses and decide whether or not the normal world is allowed
to access the requested register.

As said, most drivers that needs access to registers that are shared in a system
controller often uses syscon. Currently, syscon uses a regmap_mmio which allows
to read and write registers using MMIO accesses. Support is added in this series
to also support "syscon-smc" compatible which will use a SMC regmap instead of a 
MMIO one.

Clément Léger (3):
  regmap: add regmap using ARM SMCCC
  syscon: add support for "syscon-smc" compatible
  dt-bindings: mfd: add "syscon-smc" YAML description

 .../devicetree/bindings/mfd/syscon-smc.yaml   |  57 ++++++
 drivers/base/regmap/Kconfig                   |   7 +-
 drivers/base/regmap/Makefile                  |   1 +
 drivers/base/regmap/regmap-smccc.c            | 131 ++++++++++++++
 drivers/mfd/syscon.c                          | 170 +++++++++++++++---
 include/linux/regmap.h                        |  38 ++++
 6 files changed, 378 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/syscon-smc.yaml
 create mode 100644 drivers/base/regmap/regmap-smccc.c

-- 
2.32.0

