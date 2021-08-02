Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275C23DD0A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhHBGgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:36:31 -0400
Received: from smtpbg127.qq.com ([109.244.180.96]:28809 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229734AbhHBGg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:36:26 -0400
X-QQ-mid: bizesmtp54t1627886151tn328rmd
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:35:50 +0800 (CST)
X-QQ-SSF: 01100000002000208000D00A0000000
X-QQ-FEAT: DoD8xN2rKozcOGDwtQmNGfBMZ4UEoqYYCItVoT8BP0ehgIcHrcwy8XO/zICNf
        hezuQEncJJkzXRt2FRLGqaRd0iyduY8fQM7gA8qOspLjf29L5ww2Y8t0/5CYFXDb9ng9bzJ
        Er1jDbcUUdDN6NJRFQg0ftZ72JOnZwzT1IZjZ4759YAg4VC/GKqaAL4KxMCsIx1gHij8gCs
        UMQMcL2pDeqo0H83vO1lDw1EzdD1SuVPKKT+zncroCdYeo4DpXEaUxWAXuUQtqirxaYLsoo
        B9J23bSdkIjdXRqHssRb0X+BFsk3o2Ko7jkQYQ9esTORcMtCLNR5gFrgfummGdgj1Zr5i8b
        cGa+qKLkpZSstC3fmk=
X-QQ-GoodBg: 0
From:   Icenowy Zheng <icenowy@sipeed.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 0/4] Add simple-dbi tinydrm driver
Date:   Mon,  2 Aug 2021 14:35:34 +0800
Message-Id: <20210802063538.75583-1-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a tinydrm driver called simple-dbi, which is a driver
that utilizes only standardized commands in MIPI DCS to activate a MIPI
DBI panel that requires no extra configuration, usually because the
configuration is pre-programmed into the OTP of the LCD controller.

Icenowy Zheng (4):
  dt-bindings: vendor-prefixes: add Zhishengxin
  dt-bindings: display: add binding for simple-dbi panels
  drm/tiny: add simple-dbi driver
  MAINTAINERS: add simple-dbi driver

 .../bindings/display/simple-dbi.yaml          |  72 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/tiny/Kconfig                  |  12 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/simple-dbi.c             | 244 ++++++++++++++++++
 6 files changed, 338 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/simple-dbi.yaml
 create mode 100644 drivers/gpu/drm/tiny/simple-dbi.c

-- 
2.30.2

