Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA03C99C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbhGOHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:43:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15018 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhGOHno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:43:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQR6M2z5HzbcQD;
        Thu, 15 Jul 2021 15:37:31 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 15:40:42 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 15 Jul
 2021 15:40:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
Subject: [PATCH -next] platform/x86: amd-pmc: Fix missing unlock on error in amd_pmc_send_cmd()
Date:   Thu, 15 Jul 2021 15:43:27 +0800
Message-ID: <20210715074327.1966083-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from function amd_pmc_send_cmd()
in the error handling case.

Fixes: 95e1b60f8dc8 ("platform/x86: amd-pmc: Fix command completion code")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/platform/x86/amd-pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 680f94c7e075..663a4ca0580d 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -275,7 +275,7 @@ static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, bool set, u32 *data, u8 msg
 				PMC_MSG_DELAY_MIN_US * RESPONSE_REGISTER_LOOP_MAX);
 	if (rc) {
 		dev_err(dev->dev, "failed to talk to SMU\n");
-		return rc;
+		goto out_unlock;
 	}
 
 	/* Write zero to response register */
-- 
2.25.1

