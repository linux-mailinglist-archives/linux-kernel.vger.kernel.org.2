Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8F3444FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhCVNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:10:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:17818 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhCVM4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:56:10 -0400
IronPort-SDR: VapSbbOnKLg/WeI6u23M4V5B8qRWVLKPze/puWqrRK/hx0xaOLgaYXppRgtGlXsdWHFyu4+pNF
 1k638i+vt9Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="186943321"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="186943321"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 05:52:38 -0700
IronPort-SDR: pZpZ5F0M4u2h/9rJopkx8BI7odvlhNR8hrZsaH6NAieTY9AI9QLQBXgPZEk89vDueoVAcBbMsr
 ZS+ZZHF7CPSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="390466797"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2021 05:52:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DD28714A; Mon, 22 Mar 2021 14:52:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v1 1/1] usb: dwc3: pci: Enable dis_uX_susphy_quirk for Intel Merrifield
Date:   Mon, 22 Mar 2021 14:52:44 +0200
Message-Id: <20210322125244.79407-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that on Intel Merrifield platform the USB PHY shouldn't be suspended.
Otherwise it can't be enabled by simply change the cable in the connector.

Enable corresponding quirk for the platform in question.

Fixes: e5f4ca3fce90 ("usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression")
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 3d3918a8d5fb..4c5c6972124a 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -120,6 +120,8 @@ static const struct property_entry dwc3_pci_intel_properties[] = {
 static const struct property_entry dwc3_pci_mrfld_properties[] = {
 	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
+	PROPERTY_ENTRY_BOOL("snps,dis_u3_susphy_quirk"),
+	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{}
 };
-- 
2.30.2

