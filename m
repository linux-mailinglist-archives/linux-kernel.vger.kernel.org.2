Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6357314FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhBINBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:01:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:41904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhBINBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:01:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07E60AF9C;
        Tue,  9 Feb 2021 13:00:39 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        eric@anholt.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [RFC/PATCH v2 00/16] Raspberry PI 4 V3D enablement
Date:   Tue,  9 Feb 2021 13:58:56 +0100
Message-Id: <20210209125912.3398-1-nsaenzjulienne@suse.de>
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

- Patch #10 I took as is from the downstream implementation, I can't really
  provide an exact explanation on what changed HW wise.

Ultimately, I need confirmation from the Broadcom folks that they are alright
with patch #12 (deleting pm ops in V3D).

With all this, I get a more or less stable experience using mesa 20.3.4 and
X11/Gnome.

Regards,
Nicolas

---

Changes since v1:
 - Use 'reg-names'
 - Correct ASB names
 - Add missing binding patch for V3D
 - Address Stefan's comments

Nicolas Saenz Julienne (16):
  dt-bindings: soc: bcm: bcm2835-pm: Convert bindings to DT schema
  dt-bindings: soc: bcm: bcm2835-pm: Introduce reg-names
  dt-bindings: soc: bcm: bcm2835-pm: Add support for bcm2711
  ARM: dts: bcm2835/bcm2711: Introduce reg-names in watchdog node
  ARM: dts: bcm2711: Use proper compatible in PM/Watchdog node
  mfd: bcm2835-pm: Rename asb to rpivid_asb
  mfd: bcm2835-pm: Use 'reg-names' to get resources
  mfd: bcm2835-pm: Add support for BCM2711
  soc: bcm: bcm2835-power: Add support for BCM2711's Argon ASB
  soc: bcm: bcm2835-power: Bypass power_on/off() calls
  dt-bindings: gpu: v3d: Add BCM2711's compatible
  drm/v3d: Get rid of pm code
  drm/v3d: Add support for bcm2711
  ARM: dts: bcm2711: Enable V3D
  ARM: configs: Enable DRM_V3D
  arm64: config: Enable DRM_V3D

 .../devicetree/bindings/gpu/brcm,bcm-v3d.yaml |  1 +
 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 46 ----------
 .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 88 +++++++++++++++++++
 arch/arm/boot/dts/bcm2711.dtsi                | 15 +++-
 arch/arm/boot/dts/bcm2835-common.dtsi         |  1 +
 arch/arm/configs/multi_v7_defconfig           |  1 +
 arch/arm64/configs/defconfig                  |  1 +
 drivers/gpu/drm/v3d/Kconfig                   |  2 +-
 drivers/gpu/drm/v3d/v3d_debugfs.c             | 18 +---
 drivers/gpu/drm/v3d/v3d_drv.c                 | 12 +--
 drivers/gpu/drm/v3d/v3d_gem.c                 |  9 --
 drivers/mfd/bcm2835-pm.c                      | 83 ++++++++++++-----
 drivers/soc/bcm/bcm2835-power.c               | 82 +++++++++++------
 include/linux/mfd/bcm2835-pm.h                |  3 +-
 14 files changed, 225 insertions(+), 137 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml

-- 
2.30.0

