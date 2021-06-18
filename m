Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2323AC773
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhFRJbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:31:55 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:28305 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232691AbhFRJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:31:54 -0400
X-UUID: 82c1d2694efe41b3a6c05af464e5c586-20210618
X-UUID: 82c1d2694efe41b3a6c05af464e5c586-20210618
Received: from mtkmrs31.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 775335094; Fri, 18 Jun 2021 17:29:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 17:29:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 17:29:19 +0800
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
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/13] Add support mtu3 gadget (runtime) PM
Date:   Fri, 18 Jun 2021 17:29:05 +0800
Message-ID: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 26C31FCAC5283B28118C0F50593B1879843ACA62262EFAA58B5F54223CBFBE622000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly adds support for mtu3 gadget suspend/resume when
the controller works at device only mode or dual role mode, and also
adds support runtime PM.

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
 drivers/usb/mtu3/mtu3_plat.c                  | 164 +++++++++++++++---
 include/linux/usb/otg.h                       |   1 +
 11 files changed, 456 insertions(+), 74 deletions(-)

-- 
2.18.0

