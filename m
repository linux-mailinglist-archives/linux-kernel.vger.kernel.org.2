Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64C4292FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbhJKPTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:19:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22886 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233673AbhJKPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:19:20 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BEfQn5008672;
        Mon, 11 Oct 2021 15:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=5InFO/uS1I+/8Pc4FT2v1C41LT9aRMsVbjjSz4hf8+A=;
 b=vk26U9gW05EBuiT/VV+eAO1aMusIYa8i9M7iOlJp8AleP6nCitTEzdi0LPKjmlAKX1bI
 S9Bwl2gwaes6KvMT/6TP8AFkFyjZKjEsjerkiO7D0SlgvXWugr+dyjB89m1T/WwyWzwm
 q3gW8QdXa6fVYHmZUoX7gsr+c7z6VNHqrq/maebmkYDweTYUcz5YaaKnUVm1hO90CvgQ
 q+YxdRnMq5q5wn9h+XuELt4gF8y9ksePykMxctiuIMFa+gXEKb58s+aUPc93/QUzrFzl
 0HV+33bEEtUh8t7nXZlLXG/Yw28TQzT9DsZRYUDA6DD6VPbDHt/1B5BQ6aRlnr5E5I/X Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkxs5cyef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 15:17:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BFEgfr091664;
        Mon, 11 Oct 2021 15:17:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3bmadwdb91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 15:17:10 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 19BFGuIC099609;
        Mon, 11 Oct 2021 15:17:10 GMT
Received: from t460.home (dhcp-10-175-30-45.vpn.oracle.com [10.175.30.45])
        by aserp3020.oracle.com with ESMTP id 3bmadwdb6m-1;
        Mon, 11 Oct 2021 15:17:10 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH] habanalabs: select CRC32
Date:   Mon, 11 Oct 2021 17:14:43 +0200
Message-Id: <20211011151443.12040-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.23.0.718.g5ad94255a8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n_lmNP9buRaalInJaXNStv8erwpUaAu0
X-Proofpoint-ORIG-GUID: n_lmNP9buRaalInJaXNStv8erwpUaAu0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build/link error by adding a dependency on the CRC32
routines:

  ld: drivers/misc/habanalabs/common/firmware_if.o: in function `hl_fw_dynamic_request_descriptor':
  firmware_if.c:(.text.unlikely+0xc89): undefined reference to `crc32_le'

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/misc/habanalabs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/Kconfig b/drivers/misc/habanalabs/Kconfig
index 293d79811372c..0068ff9a34abb 100644
--- a/drivers/misc/habanalabs/Kconfig
+++ b/drivers/misc/habanalabs/Kconfig
@@ -8,6 +8,7 @@ config HABANA_AI
 	depends on PCI && HAS_IOMEM
 	select GENERIC_ALLOCATOR
 	select HWMON
+	select CRC32
 	help
 	  Enables PCIe card driver for Habana's AI Processors (AIP) that are
 	  designed to accelerate Deep Learning inference and training workloads.
-- 
2.23.0.718.g5ad94255a8

