Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DEA3BE791
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhGGMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:06:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhGGMGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:06:18 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:c375:7561:3857:648])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 668781F43266;
        Wed,  7 Jul 2021 13:03:36 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, algea.cao@rock-chips.com,
        andy.yan@rock-chips.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 0/2] Add support of HDMI for rk3568
Date:   Wed,  7 Jul 2021 14:03:21 +0200
Message-Id: <20210707120323.401785-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible and platform datas to support HDMI for rk3568 SoC.

version 2:
- Add the clocks needed for the phy.
 
Benjamin Gaignard (2):
  dt-bindings: display: rockchip: Add compatible for rk3568 HDMI
  drm/rockchip: dw_hdmi: add rk3568 support

 .../display/rockchip/rockchip,dw-hdmi.yaml    |  6 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   | 68 +++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

-- 
2.25.1

