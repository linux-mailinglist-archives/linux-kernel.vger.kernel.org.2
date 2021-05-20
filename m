Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4575389C43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 06:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhETEB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 00:01:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3616 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhETEB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 00:01:56 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FlwvF3z2nzmXKr;
        Thu, 20 May 2021 11:58:17 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 12:00:31 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 12:00:31 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     Jes Sorensen <jes@trained-monkey.org>
CC:     <linux-hippi@sunsite.dk>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>
Subject: [PATCH net-next] net: hippi: remove leading spaces before tabs
Date:   Thu, 20 May 2021 11:57:27 +0800
Message-ID: <1621483047-32583-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few leading spaces before tabs and remove it by running
the following commard:

    $ find . -name '*.[ch]' | xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/net/hippi/rrunner.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index 2201038..ab6ec90 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -623,11 +623,11 @@ static int rr_init1(struct net_device *dev)
 	writel(0x5000, &regs->ConRetry);
 	writel(0x100, &regs->ConRetryTmr);
 	writel(0x500000, &regs->ConTmout);
- 	writel(0x60, &regs->IntrTmr);
+	writel(0x60, &regs->IntrTmr);
 	writel(0x500000, &regs->TxDataMvTimeout);
 	writel(0x200000, &regs->RxDataMvTimeout);
- 	writel(0x80, &regs->WriteDmaThresh);
- 	writel(0x80, &regs->ReadDmaThresh);
+	writel(0x80, &regs->WriteDmaThresh);
+	writel(0x80, &regs->ReadDmaThresh);
 
 	rrpriv->fw_running = 0;
 	wmb();
-- 
2.8.1

