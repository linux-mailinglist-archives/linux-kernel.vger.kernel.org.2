Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDF8307CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhA1Rhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:37:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:63532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233074AbhA1Rdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:33:39 -0500
IronPort-SDR: Q4zsTg/xg44IoCj0/eLcLvnVJx4IiqjmB7toazXySFdvVKRHxwinKjjFyzWEkW+HZyUd563ekb
 ycfE4ffIx6fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="160048712"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="160048712"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 09:30:12 -0800
IronPort-SDR: LCEsI5E5q1CgdGYlGyNz65s5dbrwIYLnhEQhrERIu+mcVZlZE6itgG0hPHeK84Oq6Qi2TfXecS
 vJNRyFYL126Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="505389607"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2021 09:30:12 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id E4EB1580565;
        Thu, 28 Jan 2021 09:30:11 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MFD: intel_pmt: Fix nuisance messages and handling of disabled capabilities
Date:   Thu, 28 Jan 2021 09:28:46 -0800
Message-Id: <20210128172846.99352-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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
---
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
-- 
2.25.1

