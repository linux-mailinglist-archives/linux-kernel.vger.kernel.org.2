Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674C0431A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhJRNTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:19:01 -0400
Received: from mx24.baidu.com ([111.206.215.185]:59988 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231847AbhJRNS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:18:59 -0400
Received: from BJHW-Mail-Ex08.internal.baidu.com (unknown [10.127.64.18])
        by Forcepoint Email with ESMTPS id 03141209666CBD90F7B3;
        Mon, 18 Oct 2021 21:16:47 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex08.internal.baidu.com (10.127.64.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 18 Oct 2021 21:16:46 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 18 Oct 2021 21:16:46 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: host: ehci: Make use of dma_pool_zalloc() instead of dma_pool_alloc/memset()
Date:   Mon, 18 Oct 2021 21:16:44 +0800
Message-ID: <20211018131645.434-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex08_2021-10-18 21:16:47:005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing dma_pool_alloc/memset() with dma_pool_zalloc()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/usb/host/ehci-mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index 21307d862af6..4c6c08b675b5 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -73,10 +73,9 @@ static struct ehci_qh *ehci_qh_alloc (struct ehci_hcd *ehci, gfp_t flags)
 	if (!qh)
 		goto done;
 	qh->hw = (struct ehci_qh_hw *)
-		dma_pool_alloc(ehci->qh_pool, flags, &dma);
+		dma_pool_zalloc(ehci->qh_pool, flags, &dma);
 	if (!qh->hw)
 		goto fail;
-	memset(qh->hw, 0, sizeof *qh->hw);
 	qh->qh_dma = dma;
 	// INIT_LIST_HEAD (&qh->qh_list);
 	INIT_LIST_HEAD (&qh->qtd_list);
-- 
2.25.1

