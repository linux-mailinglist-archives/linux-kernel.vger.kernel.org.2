Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1F3A6AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhFNPqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:46:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50476 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhFNPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:46:13 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:1f5e:e45f:238:7e73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6F44E1F42B13;
        Mon, 14 Jun 2021 16:44:08 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, pgwipeout@gmail.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 0/4] Add USB2 support for rk3568
Date:   Mon, 14 Jun 2021 17:43:55 +0200
Message-Id: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original pacth from Peter Geis is here:
https://gitlab.com/pine64-org/quartz-bsp/linux-next/-/commit/cda136f853628259198d6f70c3e14c9e5c8e097f

I have split the driver part of this patch in two:
 - one to update reg usage
 - one to add USB2 support for rk3568
I have added patches for the bindings:
 - some clean up
 - add compatible for rk3568

Benjamin

Benjamin Gaignard (4):
  dt-bindings: phy: rockchip: USB2: remove useless #phy-cells property
  dt-bindings: phy: rockchip: USB2: Add compatible for rk3568
  PHY: rockchip: USB2: Allow 64 bits reg property
  phy: rockchip: USB2: Add support for rk3568

 .../bindings/phy/phy-rockchip-inno-usb2.yaml  |  3 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 85 +++++++++++++++++--
 2 files changed, 78 insertions(+), 10 deletions(-)

-- 
2.25.1

