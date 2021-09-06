Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FF640153F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 05:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhIFDg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 23:36:57 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15292 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhIFDg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 23:36:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H2vDV6C3cz8sqH;
        Mon,  6 Sep 2021 11:35:22 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 6 Sep 2021 11:35:50 +0800
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 6 Sep 2021 11:35:49 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <ville.syrjala@linux.intel.com>, <tiwai@suse.de>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
Subject: [PATCH] drm/i915: Free the returned object of acpi_evaluate_dsm()
Date:   Mon, 6 Sep 2021 11:35:41 +0800
Message-ID: <20210906033541.862-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the comment on top of acpi_evaluate_dsm():

| * Evaluate device's _DSM method with specified GUID, revision id and
| * function number. Caller needs to free the returned object.

We should free the returned object of acpi_evaluate_dsm() to avoid memory
leakage. Otherwise the kmemleak splat will be triggered at boot time (if we
compile kernel with CONFIG_DEBUG_TEST_DRIVER_REMOVE=y).

Fixes: 8e55f99c510f ("drm/i915: Invoke another _DSM to enable MUX on HP Workstation laptops")
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index 7cfe91fc05f2..68abeaf2d7d4 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -186,13 +186,16 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
 {
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	acpi_handle dhandle;
+	union acpi_object *obj;
 
 	dhandle = ACPI_HANDLE(&pdev->dev);
 	if (!dhandle)
 		return;
 
-	acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
-			  INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
+	obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
+				INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
+	if (obj)
+		ACPI_FREE(obj);
 }
 
 /*
-- 
2.19.1

