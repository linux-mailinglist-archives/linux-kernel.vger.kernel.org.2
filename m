Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414343F5C72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhHXKx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:53:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59742 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbhHXKx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:53:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17OAr6gj066435;
        Tue, 24 Aug 2021 05:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629802386;
        bh=S0OVBAatI84KIbShrBm5yBL8uU+nTOrTxMrx2mLEoHY=;
        h=From:To:CC:Subject:Date;
        b=aX/HRPTvjAxb+FkNeA4Vjx/p0oBkN4Tyr3fXoQ1OFGIatvCQQc770HGRmHBje3SJf
         S1v3FDud76qNGqh4TjyEM7RBuCp95Z6AB5w8CDFqeXpF5+E5G57l6R5dsXkh0VjYj7
         kCawd93aKUpwPxb8gYEWsS4ZImcqizr5G1rDRe0I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17OAr6rf072332
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Aug 2021 05:53:06 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 05:53:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 24 Aug 2021 05:53:06 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17OAr3Dc129176;
        Tue, 24 Aug 2021 05:53:04 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>
Subject: [RFC PATCH 0/5] Fix cold plugged USB device on certain PCIe USB cards
Date:   Tue, 24 Aug 2021 16:22:57 +0530
Message-ID: <20210824105302.25382-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cold plugged USB device was not detected on certain PCIe USB cards
(like Inateck card connected to AM64 EVM or connected to J7200 EVM).

Re-plugging the USB device always gets it enumerated.

This issue was discussed in
https://lore.kernel.org/r/772e4001-178e-4918-032c-6e625bdded24@ti.com
and
https://bugzilla.kernel.org/show_bug.cgi?id=214021

So the suggested solution is to register both root hubs along with the
second hcd for xhci. This series performs some cleanups and implements
the suggested solution.

Kishon Vijay Abraham I (5):
  usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()
  usb: core: hcd: Let usb_add_hcd() indicate if roothub has to be
    registered
  usb: core: hcd: Add support for registering secondary RH along with
    primary HCD
  usb: core: hcd-pci: Let usb_hcd_pci_probe() indicate if RH has to be
    registered
  xhci-pci: Use flag to not register roothub while adding primary HCD

 drivers/usb/core/hcd-pci.c  | 11 +++---
 drivers/usb/core/hcd.c      | 72 ++++++++++++++++++++++++-------------
 drivers/usb/host/xhci-pci.c |  2 +-
 include/linux/usb/hcd.h     | 16 ++++++---
 4 files changed, 65 insertions(+), 36 deletions(-)

-- 
2.17.1

