Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5B539F006
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFHH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:59:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53161 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230223AbhFHH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:59:47 -0400
X-UUID: f33319f5c9144cc9bc476a6b7bd1d8a2-20210608
X-UUID: f33319f5c9144cc9bc476a6b7bd1d8a2-20210608
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2144466894; Tue, 08 Jun 2021 15:57:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:57:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:57:49 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yuwen Ng <yuwen.ng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 00/23] Add support gadget (runtime) PM
Date:   Tue, 8 Jun 2021 15:57:26 +0800
Message-ID: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly adds support for gadget suspend/resume when the controller
works at device only mode or dual role mode, and also adds support runtime PM,
in order to fix the sequence issue about resume and role switch event arised
by extcon or role-switch, rebuild and unify the flow of dual role switch for
all three supported ways.

Chunfeng Yun (23):
  dt-bindings: usb: mtu3: remove support VBUS detection of extcon
  dt-bindings: usb: mtu3: add optional property to disable usb2 ports
  dt-bindings: usb: mtu3: add support property role-switch-default-mode
  dt-bindings: usb: mtu3: add wakeup interrupt
  usb: mtu3: power down device IP by default
  usb: mtu3: power down port when power down device IP
  usb: mtu3: remove wakelock
  usb: mtu3: drop support vbus detection
  usb: mtu3: use enum usb_role instead of private defined ones
  usb: mtu3: rebuild role switch flow of extcon
  usb: mtu3: add helper to get pointer of ssusb_mtk struct
  usb: mtu3: use force mode for dual role switch
  usb: mtu3: rebuild role switch get/set hooks
  usb: common: add helper to get role-switch-default-mode
  usb: dwc3: drd: use helper to get role-switch-default-mode
  usb: mtu3: support property role-switch-default-mode
  usb: mtu3: support option to disable usb2 ports
  usb: mtu3: add new helpers for host suspend/resume
  usb: mtu3: support runtime PM for host mode
  usb: mtu3: add helper to power on/down device
  usb: mtu3: support suspend/resume for device mode
  usb: mtu3: support suspend/resume for dual-role mode
  usb: mtu3: use clock bulk to get clocks

 .../bindings/usb/mediatek,mtu3.yaml           |  47 +++-
 drivers/usb/common/common.c                   |  20 ++
 drivers/usb/dwc3/drd.c                        |   8 +-
 drivers/usb/mtu3/mtu3.h                       |  36 ++-
 drivers/usb/mtu3/mtu3_core.c                  | 117 +++++++-
 drivers/usb/mtu3/mtu3_dr.c                    | 193 +++++---------
 drivers/usb/mtu3/mtu3_dr.h                    |  30 ++-
 drivers/usb/mtu3/mtu3_gadget.c                |   5 +
 drivers/usb/mtu3/mtu3_host.c                  | 112 ++++++--
 drivers/usb/mtu3/mtu3_plat.c                  | 250 +++++++++++-------
 include/linux/usb/otg.h                       |   1 +
 11 files changed, 530 insertions(+), 289 deletions(-)

-- 
2.18.0

