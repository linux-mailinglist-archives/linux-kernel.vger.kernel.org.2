Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15B2311789
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBFAAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:00:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:56214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231566AbhBENxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:53:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9F6CACB7;
        Fri,  5 Feb 2021 13:52:56 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     phil@raspberrypi.com, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [RFC/PATCH 00/11] Raspberry PI 4 V3D enablement
Date:   Fri,  5 Feb 2021 14:52:36 +0100
Message-Id: <20210205135249.2924-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to enable V3D on BCM2711, the SoC available on the
Raspberry Pi 4 family of boards.

Due to the lack of documentation some things are taken as it from
testing/downstream implementation[1], which I'm hilighting here:

- It's not clear that the following is 100% true, maybe someone can confirm:

	"In BCM2711 the new ARGON ASB took over V3D. The old ASB is still
	present with the ISP and H264 bits, and V3D is in the same place in the
	new ASB as the old one."

- Patch #6 I took as is from the downstream implementation, I can't really
  provide an exact explanation on what changed HW wise.

Ultimately, I need confirmation from the Broadcom folks that they are alright
with patch #7.

With all this, I get a more or less stable experience using mesa 20.3.4 and
X11/Gnome.

Regards,
Nicolas

---

Nicolas Saenz Julienne (11):
  dt-bindings: soc: bcm: bcm2835-pm: Convert bindings to DT schema
  dt-bindings: soc: bcm: brcm,bcm2835-pm: Add support for bcm2711
  ARM: dts: bcm2711: Use proper compatible in PM/Watchdog node
  mfd: bcm2835-pm: Add support for BCM2711
  soc: bcm: bcm2835-power: Add support for BCM2711's ARSAN ASB
  soc: bcm: bcm2835-power: Bypass power_on/off() calls
  drm/v3d: Get rid of pm code
  drm/v3d: Add support for bcm2711
  ARM: dts: bcm2711: Enable V3D
  ARM: configs: Enable DRM_V3D
  arm64: config: Enable DRM_V3D

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 46 -----------
 .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 80 +++++++++++++++++++
 arch/arm/boot/dts/bcm2711.dtsi                | 14 +++-
 arch/arm/configs/multi_v7_defconfig           |  1 +
 arch/arm64/configs/defconfig                  |  1 +
 drivers/gpu/drm/v3d/Kconfig                   |  2 +-
 drivers/gpu/drm/v3d/v3d_debugfs.c             | 18 +----
 drivers/gpu/drm/v3d/v3d_drv.c                 | 12 +--
 drivers/gpu/drm/v3d/v3d_gem.c                 |  9 ---
 drivers/mfd/bcm2835-pm.c                      | 55 ++++++++++---
 drivers/soc/bcm/bcm2835-power.c               | 74 +++++++++++------
 include/linux/mfd/bcm2835-pm.h                |  1 +
 12 files changed, 190 insertions(+), 123 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml

-- 
2.30.0

