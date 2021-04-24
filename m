Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0836A278
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhDXR6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 13:58:44 -0400
Received: from mailfilter03-out40.webhostingserver.nl ([195.211.72.99]:13018
        "EHLO mailfilter03-out40.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232546AbhDXR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 13:58:42 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Apr 2021 13:58:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=uWGEYY57hk1ulJd0jL768OUeNIB3byX25zDF+F7sAG0=;
        b=dN7PTLh4Tbu6oSrP+lvn1igyHP/3NHtNeheeK63/34UMVIotL9obwDWzCuhW6kmfLRrNKE5+7IwET
         P9ztkcry9++hZBdNhLuZupgbhO53mQj5i4TmLPLY5gWBCkvLGpDA5wEv539/YfMlifVOHVVKyyFoNe
         RekJu7U7d2RjER64qDi+tX0AVGLadGK0Br/s+cYSmzMh8pxcksSU/liCzJfs3yLPB3JMI7uRneAQt2
         lbmuAUwJsRRNulygQsjRVhLQRkCjRV/iwMYTqc2MxcdLY/gWnYQnsD3AMUkhMJSax3dmnUBBUEF0Se
         YUJUlzwtGg4d6DEyJjsKnP0PPRBJi2Q==
X-Halon-ID: 5f029fb1-a524-11eb-b7ff-001a4a4cb9a5
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter03.webhostingserver.nl (Halon) with ESMTPSA
        id 5f029fb1-a524-11eb-b7ff-001a4a4cb9a5;
        Sat, 24 Apr 2021 19:41:59 +0200 (CEST)
Received: from [2001:981:6fec:1:f5b4:4723:a50d:fb65] (helo=localhost.localdomain)
        by s198.webhostingserver.nl with esmtpa (Exim 4.94)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1laMI3-00AjY6-GY; Sat, 24 Apr 2021 19:41:59 +0200
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] extcon-intel-mrfld: initialize mrfld_extcon status
Date:   Sat, 24 Apr 2021 19:41:38 +0200
Message-Id: <20210424174138.175889-1-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

extcon driver for Basin Cove PMIC shadows the switch status used for dwc3
DRD to detect a change in the switch position. This change initializes the
status at probe time.

Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
Fixes: 492929c54791 ("extcon: mrfld: Introduce extcon driver for Basin Cove PMIC")
---
 drivers/extcon/extcon-intel-mrfld.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
index f47016fb28a8..cd1a5f230077 100644
--- a/drivers/extcon/extcon-intel-mrfld.c
+++ b/drivers/extcon/extcon-intel-mrfld.c
@@ -197,6 +197,7 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
 	struct regmap *regmap = pmic->regmap;
 	struct mrfld_extcon_data *data;
+	unsigned int status;
 	unsigned int id;
 	int irq, ret;
 
@@ -244,6 +245,14 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
 	/* Get initial state */
 	mrfld_extcon_role_detect(data);
 
+	/*
+	 * Cached status value is used for cable detection, see comments
+	 * in mrfld_extcon_cable_detect(), we need to sync cached value
+	 * with a real state of the hardware.
+	 */
+	regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
+	data->status = status;
+
 	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
 	mrfld_extcon_clear(data, BCOVE_MCHGRIRQ1, BCOVE_CHGRIRQ_ALL);
 
-- 
2.27.0

