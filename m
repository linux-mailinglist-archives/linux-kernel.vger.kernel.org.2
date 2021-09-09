Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA774045B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350481AbhIIGnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:43:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37342 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbhIIGnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:43:17 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1896g5fq057002;
        Thu, 9 Sep 2021 01:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631169725;
        bh=w8ba3lprUH64+lF9MNZzR+xLhmjlZzEh1UyopCn96mQ=;
        h=From:To:CC:Subject:Date;
        b=w8LclNiwep/bp0TisxVbmw8FKOjkMBmEKsCkWQGujPi+2jAQ9aIlyYFRVzEJ06ESX
         zYg7nx6QvZHOJ2++bjuwdONyqLQnuOG5aUGNPmDNPOHmQtRcH+pT1zDqRHMIMLFJAz
         vOSQ2RvhnasibULUc25YKGlSd2tT06u4fpaENCEw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1896g4QN127481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Sep 2021 01:42:04 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 9
 Sep 2021 01:42:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 9 Sep 2021 01:42:04 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1896g04P062945;
        Thu, 9 Sep 2021 01:42:01 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH v4 0/3] Fix cold plugged USB device on certain PCIe USB cards
Date:   Thu, 9 Sep 2021 12:11:57 +0530
Message-ID: <20210909064200.16216-1-kishon@ti.com>
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
v3 Patch series can be found at [5]

Changes from RFC:
1) Mathias identified potential issues with the RFC patch [2] and suggested
   the solution to use HCD flags. This series implements it.

Changes from v1:
1) Fixed code comments pointed out by Alan Stern
2) Renamed the HCD flag variable to "HCD_FLAG_DEFER_RH_REGISTER" from
   "HCD_FLAG_DEFER_PRI_RH_REGISTER"

Changes from v2:
1) Fixed issue in error path handling pointed by Alan

Changes from v3:
1) Fix un-initialized variable usb_remove_hcd() and did some cleanup
suggested by Alan

[1] -> https://lore.kernel.org/linux-usb/20210824105302.25382-1-kishon@ti.com/
[2] -> https://lore.kernel.org/linux-usb/06693934-28f2-d59e-b004-62cabd3f9e8e@linux.intel.com
[3] -> https://lore.kernel.org/r/20210825105132.10420-1-kishon@ti.com
[4] -> https://lore.kernel.org/r/20210826111426.751-1-kishon@ti.com
[5] -> https://lore.kernel.org/r/20210908145146.GB603644@rowland.harvard.edu

Kishon Vijay Abraham I (3):
  usb: core: hcd: Add support for deferring roothub registration
  xhci: Set HCD flag to defer primary roothub registration
  usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()

 drivers/usb/core/hcd.c  | 68 +++++++++++++++++++++++++++--------------
 drivers/usb/host/xhci.c |  1 +
 include/linux/usb/hcd.h |  2 ++
 3 files changed, 48 insertions(+), 23 deletions(-)

-- 
2.17.1

