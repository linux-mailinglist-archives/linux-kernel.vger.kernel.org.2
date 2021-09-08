Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22B403751
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351359AbhIHJyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:54:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44890 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347816AbhIHJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:54:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1889rHBS105320;
        Wed, 8 Sep 2021 04:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631094797;
        bh=ISfEfl208qPnX3zBAZ771efreeior4HFL+FyGS0J0eM=;
        h=From:To:CC:Subject:Date;
        b=ucW60v/uxhPMeb/pHd7kS8Cv6XAUDwhqsDRQqUmIBF/fi9FpMwZW92ey2wGRwkpda
         cQAzx5pHwyMUzPYHg17sw7jc+6XUurTMMXyOfChuVogm39l8CgIZiXDpTsIXIFjX5p
         RhlY1xCBeD59H4wa3low29VwFR7nhGT0TJUZ87NE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1889rHxs118366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Sep 2021 04:53:17 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Sep 2021 04:53:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Sep 2021 04:53:16 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1889rC4B019690;
        Wed, 8 Sep 2021 04:53:13 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH v3 0/3] Fix cold plugged USB device on certain PCIe USB cards
Date:   Wed, 8 Sep 2021 15:23:09 +0530
Message-ID: <20210908095312.985-1-kishon@ti.com>
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
second hcd for xhci.

RFC Patch series can be found at [1]
v1 Patch series can be found at [3]
v2 Patch series can be found at [4]

Changes from RFC:
1) Mathias identified potential issues with the RFC patch [2] and suggested
   the solution to use HCD flags. This series implements it.

Changes from v1:
1) Fixed code comments pointed out by Alan Stern
2) Renamed the HCD flag variable to "HCD_FLAG_DEFER_RH_REGISTER" from
   "HCD_FLAG_DEFER_PRI_RH_REGISTER"

Changes from v2:
1) Fixed issue in error path handling pointed by Alan

[1] -> https://lore.kernel.org/linux-usb/20210824105302.25382-1-kishon@ti.com/
[2] -> https://lore.kernel.org/linux-usb/06693934-28f2-d59e-b004-62cabd3f9e8e@linux.intel.com
[3] -> https://lore.kernel.org/r/20210825105132.10420-1-kishon@ti.com
[4] -> https://lore.kernel.org/r/20210826111426.751-1-kishon@ti.com

Kishon Vijay Abraham I (3):
  usb: core: hcd: Add support for deferring roothub registration
  xhci: Set HCD flag to defer primary roothub registration
  usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()

 drivers/usb/core/hcd.c  | 69 +++++++++++++++++++++++++++--------------
 drivers/usb/host/xhci.c |  1 +
 include/linux/usb/hcd.h |  2 ++
 3 files changed, 49 insertions(+), 23 deletions(-)

-- 
2.17.1

