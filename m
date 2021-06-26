Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B093B4FA9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhFZQyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 12:54:43 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:44926 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhFZQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 12:54:30 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Jun 2021 09:52:07 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Jun 2021 09:52:05 -0700
X-QCInternal: smtphost
Received: from rajeevny-linux.qualcomm.com ([10.204.66.121])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 Jun 2021 22:21:15 +0530
Received: by rajeevny-linux.qualcomm.com (Postfix, from userid 2363605)
        id 9423D21478; Sat, 26 Jun 2021 22:21:13 +0530 (IST)
From:   Rajeev Nandan <rajeevny@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        sam@ravnborg.org, robdclark@gmail.com, dianders@chromium.org,
        lyude@redhat.com, jani.nikula@intel.com, robh@kernel.org,
        laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        daniel.thompson@linaro.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, mkrishn@codeaurora.org,
        lee.jones@linaro.org, jingoohan1@gmail.com,
        linux-fbdev@vger.kernel.org
Subject: [v8 0/6] drm: Support basic DPCD backlight in panel-simple and add a new panel ATNA33XC20
Date:   Sat, 26 Jun 2021 22:21:02 +0530
Message-Id: <1624726268-14869-1-git-send-email-rajeevny@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the support for the eDP panel that needs the backlight
controlling over the DP AUX channel using DPCD registers of the panel
as per the VESA's standard.

This series also adds support for the Samsung eDP AMOLED panel that
needs DP AUX to control the backlight, and introduces new delays in the
@panel_desc.delay to support this panel.

This patch series depends on the following two series:
- Doug's series [1], exposed the DP AUX channel to the panel-simple.
- Lyude's series [2], introduced new drm helper functions for DPCD
  backlight.

This series is the logical successor to the series [3].

Changes in v1:
- Created dpcd backlight helper with very basic functionality, added
  backlight registration in the ti-sn65dsi86 bridge driver.

Changes in v2:
- Created a new DisplayPort aux backlight driver and moved the code from
  drm_dp_aux_backlight.c (v1) to the new driver.

Changes in v3:
- Fixed module compilation (kernel test bot).

Changes in v4:
- Added basic DPCD backlight support in panel-simple.
- Added support for a new Samsung panel ATNA33XC20 that needs DPCD
  backlight controlling and has a requirement of delays between enable
  GPIO and regulator.

Changes in v5:
Addressed review suggestions from Douglas:
- Created a new API drm_panel_dp_aux_backlight() in drm_panel.c
- Moved DP AUX backlight functions from panel-simple.c to drm_panel.c
- panel-simple probe() calls drm_panel_dp_aux_backlight() to create
  backlight when the backlight phandle is not specified in panel DT
  and DP AUX channel is present.
- Added check for drm_edp_backlight_supported() before registering.
- Removed the @uses_dpcd_backlight flag from panel_desc as this
  should be auto-detected.
- Updated comments/descriptions.

Changes in v6:
- Rebased
- Updated wanrning messages, fixed word wrapping in comments.
- Fixed ordering of memory allocation

Changes in v7:
- Updated the disable_to_power_off and power_to_enable panel delays
as discovered at <https://crrev.com/c/2966167> (Douglas)

Changes in v8:
- Now using backlight_is_blank() to get the backlight blank status (Sam Ravnborg)
- Added a new patch #4 to fix the warnings for eDP panel description (Sam Ravnborg)

[1] https://lore.kernel.org/dri-devel/20210525000159.3384921-1-dianders@chromium.org/
[2] https://lore.kernel.org/dri-devel/20210514181504.565252-1-lyude@redhat.com/
[3] https://lore.kernel.org/dri-devel/1619416756-3533-1-git-send-email-rajeevny@codeaurora.org/

Rajeev Nandan (6):
  drm/panel: add basic DP AUX backlight support
  drm/panel-simple: Support DP AUX backlight
  drm/panel-simple: Support for delays between GPIO & regulator
  drm/panel-simple: Update validation warnings for eDP panel description
  dt-bindings: display: simple: Add Samsung ATNA33XC20
  drm/panel-simple: Add Samsung ATNA33XC20

 .../bindings/display/panel/panel-simple.yaml       |   2 +
 drivers/gpu/drm/drm_panel.c                        | 108 +++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               |  73 +++++++++++++-
 include/drm/drm_panel.h                            |  15 ++-
 4 files changed, 190 insertions(+), 8 deletions(-)

-- 
2.7.4

