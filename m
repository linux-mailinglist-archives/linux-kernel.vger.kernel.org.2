Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F73F73AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhHYKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:52:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45278 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhHYKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:52:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17PApb3L003133;
        Wed, 25 Aug 2021 05:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629888697;
        bh=ohwW3unW5jCvC6uKqinVsEJ5ctT/OYLeiTK7Sp7kdy0=;
        h=From:To:CC:Subject:Date;
        b=GWmhQqVYMOAU6Iml4yM86rwfdtPVaStREPzPK7Ez7DANMvk8ydXW3ZcEqEc8RmzPx
         5/NfRVTHKGMGk1NjrTilX4HUFJDYql2zL3ooiNWUh0CRvD95yYmh9HmEEXUrms8hQI
         fxwk9xDfwT3G5o/1aC4luFh4YG52b9x82lhjoRTo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17PApbpC070866
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Aug 2021 05:51:37 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 25
 Aug 2021 05:51:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 25 Aug 2021 05:51:36 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17PApW85129194;
        Wed, 25 Aug 2021 05:51:33 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 0/3] Fix cold plugged USB device on certain PCIe USB cards
Date:   Wed, 25 Aug 2021 16:21:29 +0530
Message-ID: <20210825105132.10420-1-kishon@ti.com>
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

Changes from RFC:
1) Mathias identified potential issues with the RFC patch [2] and suggested
   the solution to use HCD flags. This series implements it.

[1] -> https://lore.kernel.org/linux-usb/20210824105302.25382-1-kishon@ti.com/ 
[2] -> https://lore.kernel.org/linux-usb/06693934-28f2-d59e-b004-62cabd3f9e8e@linux.intel.com

Kishon Vijay Abraham I (3):
  usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()
  usb: core: hcd: Add support for deferring roothub registration
  xhci: Set HCD flag to defer primary roothub registration

 drivers/usb/core/hcd.c  | 67 +++++++++++++++++++++++++++--------------
 drivers/usb/host/xhci.c |  2 +-
 include/linux/usb/hcd.h |  2 ++
 3 files changed, 48 insertions(+), 23 deletions(-)

-- 
2.17.1

