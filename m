Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B099240B8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhINUOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:14:08 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:45819 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhINUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:14:06 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 3102DCF35B;
        Tue, 14 Sep 2021 20:06:10 +0000 (UTC)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 930BEFF802;
        Tue, 14 Sep 2021 20:05:47 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v9 0/4] drm: LogiCVC display controller support
Date:   Tue, 14 Sep 2021 22:05:35 +0200
Message-Id: <20210914200539.732093-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for the LogiCVC display controller.
The controller is a bit unusual since it is usually loaded as
programmable logic on Xilinx FPGAs or Zynq-7000 SoCs.
More details are presented on the main commit for the driver.

More information about the controller is available on the dedicated
web page: https://www.logicbricks.com/Products/logiCVC-ML.aspx

Note that this driver has rather simple connector management, which was
not converted to drm_panel_bridge to keep the ability to enable the panel
at first vblank but also to support DVI.

Changes since v8:
- Rebased on top of the latest drm-misc-next;
- Dropped useless phandle-based syscon regmap support;
- Switched to a single-port graph description;
- Updated the device-tree schema to the port schema and added a
  description for the port.

Change since v7:
- Replaced DRM_INFO/DRM_ERROR/DRM_DEBUG_DRIVER with fashions using drm_device;
- Fixed yaml binding alignment issue;
- Renamed logicvc-display name to the generic "display" name;
- Added patternProperties match for display in the parent mfd binding;
- Used drm_atomic_get_new_crtc_state when needed;
- Checked mode in mode_valid instead of atomic_check;
- Switched to drmm_mode_config_init;
- Removed useless logicvc_connector_destroy wrapper;
- Removed useless drm_dev_put calls;
- Removed atomic_commit_tail that enables the panel and streamlined the logic;
- Reworked Makefile cosmetics;
- Fixed checkpatch issues.

Changes since v6:
- Updated to the latest DRM internal API changes; 
- Used an enum to index dt properties instead of the name string.

Changes since v5:
- Subclass DRM device and use devm_drm_dev_alloc for allocation;
- Removed call to drm_mode_config_cleanup (done automatically with devm);
- Some related code cleanups;
- Bring back not-for-merge patch adding colorkey support.

Changes since v4:
- Updated to internal DRM API changes (rebased on drm-misc-next);
- Added Kconfig dependency on OF;
- Added MAINTAINERS entry;
- Used drm_err and dev_err instead of DRM_ERROR where possible;
- Various cosmetic changes.

Changes since v3:
- Rebased on latest drm-misc;
- Improved event lock wrapping;
- Added collect tag;
- Added color-key support patch (not for merge, for reference only).

Changes since v2:
- Fixed and slightly improved dt schema.

Changes since v1:
- Switched dt bindings documentation to dt schema;
- Described more possible dt parameters;
- Added support for the lvds-3bit interface;
- Added support for grabbing syscon regmap from parent node;
- Removed layers count property and count layers child nodes instead.

Paul Kocialkowski (4):
  dt-bindings: display: Document the Xylon LogiCVC display controller
  dt-bindings: mfd: logicvc: Add patternProperties for the display
  drm: Add support for the LogiCVC display controller
  NOTFORMERGE: drm/logicvc: Add plane colorkey support

 .../display/xylon,logicvc-display.yaml        | 302 +++++++
 .../bindings/mfd/xylon,logicvc.yaml           |   3 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/logicvc/Kconfig               |   9 +
 drivers/gpu/drm/logicvc/Makefile              |   9 +
 drivers/gpu/drm/logicvc/logicvc_crtc.c        | 280 +++++++
 drivers/gpu/drm/logicvc/logicvc_crtc.h        |  21 +
 drivers/gpu/drm/logicvc/logicvc_drm.c         | 471 +++++++++++
 drivers/gpu/drm/logicvc/logicvc_drm.h         |  67 ++
 drivers/gpu/drm/logicvc/logicvc_interface.c   | 214 +++++
 drivers/gpu/drm/logicvc/logicvc_interface.h   |  28 +
 drivers/gpu/drm/logicvc/logicvc_layer.c       | 767 ++++++++++++++++++
 drivers/gpu/drm/logicvc/logicvc_layer.h       |  71 ++
 drivers/gpu/drm/logicvc/logicvc_mode.c        |  80 ++
 drivers/gpu/drm/logicvc/logicvc_mode.h        |  15 +
 drivers/gpu/drm/logicvc/logicvc_of.c          | 185 +++++
 drivers/gpu/drm/logicvc/logicvc_of.h          |  46 ++
 drivers/gpu/drm/logicvc/logicvc_regs.h        |  88 ++
 20 files changed, 2665 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
 create mode 100644 drivers/gpu/drm/logicvc/Kconfig
 create mode 100644 drivers/gpu/drm/logicvc/Makefile
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_regs.h

-- 
2.32.0

