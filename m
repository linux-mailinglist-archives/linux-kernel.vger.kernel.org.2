Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FBD3C9B06
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbhGOJLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:13 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44298 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234002AbhGOJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:08 -0400
X-UUID: 74007920824a4c989aa500bc29d99f6a-20210715
X-UUID: 74007920824a4c989aa500bc29d99f6a-20210715
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 80373001; Thu, 15 Jul 2021 17:08:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:10 +0800
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
Subject: [PATCH v3 00/13] Add support mtu3 gadget (runtime) PM
Date:   Thu, 15 Jul 2021 17:07:45 +0800
Message-ID: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly adds support for mtu3 gadget suspend/resume when
the controller works at device only mode or dual role mode, and also
adds support runtime PM.

v3:
  add Acked-by Rob
  fix use-after-free issue when probe failed
v2:
  Change the comment of cover letter and its title.

  In order to help review, v2 drops the patches about role-switch
  rebuilding which are applied, and the left ones are identical.


Chunfeng Yun (13):
  dt-bindings: usb: mtu3: remove support VBUS detection of extcon
  dt-bindings: usb: mtu3: add optional property to disable usb2 ports
  dt-bindings: usb: mtu3: add support property role-switch-default-mode
  dt-bindings: usb: mtu3: add wakeup interrupt
  usb: common: add helper to get role-switch-default-mode
  usb: dwc3: drd: use helper to get role-switch-default-mode
  usb: mtu3: support property role-switch-default-mode
  usb: mtu3: support option to disable usb2 ports
  usb: mtu3: add new helpers for host suspend/resume
  usb: mtu3: support runtime PM for host mode
  usb: mtu3: add helper to power on/down device
  usb: mtu3: support suspend/resume for device mode
  usb: mtu3: support suspend/resume for dual-role mode

 .../bindings/usb/mediatek,mtu3.yaml           |  47 ++++-
 drivers/usb/common/common.c                   |  20 +++
 drivers/usb/dwc3/drd.c                        |   8 +-
 drivers/usb/mtu3/mtu3.h                       |   8 +
 drivers/usb/mtu3/mtu3_core.c                  | 115 ++++++++++--
 drivers/usb/mtu3/mtu3_dr.c                    |  26 ++-
 drivers/usb/mtu3/mtu3_dr.h                    |  30 +++-
 drivers/usb/mtu3/mtu3_gadget.c                |   5 +
 drivers/usb/mtu3/mtu3_host.c                  | 106 +++++++++--
 drivers/usb/mtu3/mtu3_plat.c                  | 166 +++++++++++++++---
 include/linux/usb/otg.h                       |   1 +
 11 files changed, 457 insertions(+), 75 deletions(-)

-- 
2.18.0

