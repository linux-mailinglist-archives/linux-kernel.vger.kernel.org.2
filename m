Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E55324514
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhBXUQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:16:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:7357 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235605AbhBXUMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:12:44 -0500
IronPort-SDR: gv6AbQYvGAKiqubHclKpiNViOx0hb+rkMZF7aFteD1HhpgaUD5cXf1Ll94+pi4b/kH8kBaMUGl
 LoTWRV/okSnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="165162186"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="165162186"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 12:10:55 -0800
IronPort-SDR: GnkWRUM9MVOWcyCXKaQbxOOe9sQjawPljt1KyH6E4NxKDODyVKntO9NfBQuPX1eKcAUcGMMCw1
 cj/ApTkB1tiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="404080289"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2021 12:10:55 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 3DCA15804A9;
        Wed, 24 Feb 2021 12:10:55 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH V2 1/2] MFD: intel_pmt: Fix nuisance messages and handling of disabled capabilities
Date:   Wed, 24 Feb 2021 12:10:04 -0800
Message-Id: <20210224201005.1034005-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128172846.99352-1-david.e.box@linux.intel.com>
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some products will be available that have PMT capabilities that are not
supported. Remove the warnings in this instance to avoid nuisance messages
and confusion.

Also return an error code for capabilities that are disabled by quirk to
prevent them from keeping the driver loaded if only disabled capabilities
are found.

Fixes: 4f8217d5b0ca ("mfd: Intel Platform Monitoring Technology support")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
For merge in platform-drivers-x86

Based on 5.11-rc1 review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Changes from V1:

	- None. Patch 2 added.

 drivers/mfd/intel_pmt.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
index 744b230cdcca..65da2b17a204 100644
--- a/drivers/mfd/intel_pmt.c
+++ b/drivers/mfd/intel_pmt.c
@@ -79,19 +79,18 @@ static int pmt_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
 	case DVSEC_INTEL_ID_WATCHER:
 		if (quirks & PMT_QUIRK_NO_WATCHER) {
 			dev_info(dev, "Watcher not supported\n");
-			return 0;
+			return -EINVAL;
 		}
 		name = "pmt_watcher";
 		break;
 	case DVSEC_INTEL_ID_CRASHLOG:
 		if (quirks & PMT_QUIRK_NO_CRASHLOG) {
 			dev_info(dev, "Crashlog not supported\n");
-			return 0;
+			return -EINVAL;
 		}
 		name = "pmt_crashlog";
 		break;
 	default:
-		dev_err(dev, "Unrecognized PMT capability: %d\n", id);
 		return -EINVAL;
 	}
 
@@ -174,12 +173,8 @@ static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
 
 		ret = pmt_add_dev(pdev, &header, quirks);
-		if (ret) {
-			dev_warn(&pdev->dev,
-				 "Failed to add device for DVSEC id %d\n",
-				 header.id);
+		if (ret)
 			continue;
-		}
 
 		found_devices = true;
 	} while (true);

base-commit: a7d53dbbc70a81d5781da7fc905b656f41ad2381
-- 
2.25.1

