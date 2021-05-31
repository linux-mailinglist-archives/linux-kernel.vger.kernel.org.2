Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6488539662B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhEaQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233964AbhEaPPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:15:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EADE0611CA
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622474052;
        bh=APqh+mpty7VmfQtfJkHwTGmT6zlLWbDer8Q0cDH9f90=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JSKmX4KWkAP+VdafmMnZ0YHJ8aKY6nqjciDRP5G3FX7fwXgDUzpIIWEM6TysMHBEz
         stBqIzoQAsrCtCgtyjWeCNxOXkDbF+AE+c7kWDcM47kXtvmbQj7F7YrDIhBt6Ltk20
         gM8pN44BlN2xRzSolGWbhHycAyPKpx36caes/Imhx3gegYl5L/GUu6Aoc9DAzq/a5H
         cBJtww7qBsr9CwmkPtp9o10tFw28tTPLHy/jLDZBrh33sURIJRrn0J2iWEVFz7RG28
         YWFJH0JCd1z1Iwe4hFQp7W9eMEj7SLbPgunjWZQjr9dmySWsp7csCf0Wazm6goaSgN
         pp3lEeaTeglwg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] habanalabs: prefer ASYNC device probing
Date:   Mon, 31 May 2021 18:14:01 +0300
Message-Id: <20210531151403.12494-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531151403.12494-1-ogabbay@kernel.org>
References: <20210531151403.12494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no dependency when probing multiple devices so indicate to the
kernel that it can probe our devices in ASYNC fashion.

This shortens insmod of the driver from ~2 minutes to 20 seconds on
a system with 8 devices.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index bd67d4ceab56..137e7dc63d3b 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -574,7 +574,11 @@ static struct pci_driver hl_pci_driver = {
 	.probe = hl_pci_probe,
 	.remove = hl_pci_remove,
 	.shutdown = hl_pci_remove,
-	.driver.pm = &hl_pm_ops,
+	.driver = {
+		.name = HL_NAME,
+		.pm = &hl_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 	.err_handler = &hl_pci_err_handler,
 };
 
-- 
2.25.1

