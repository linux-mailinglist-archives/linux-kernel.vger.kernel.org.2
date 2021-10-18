Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852F0431A90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhJRNTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:19:32 -0400
Received: from mx24.baidu.com ([111.206.215.185]:60416 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231872AbhJRNTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:19:23 -0400
Received: from BJHW-Mail-Ex02.internal.baidu.com (unknown [10.127.64.12])
        by Forcepoint Email with ESMTPS id 8F45D95DA2A668E8EAE4;
        Mon, 18 Oct 2021 21:17:10 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex02.internal.baidu.com (10.127.64.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 18 Oct 2021 21:17:10 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 18 Oct 2021 21:17:10 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: host: fotg210: Make use of dma_pool_zalloc() instead of dma_pool_alloc/memset()
Date:   Mon, 18 Oct 2021 21:17:08 +0800
Message-ID: <20211018131709.487-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing dma_pool_alloc/memset() with dma_pool_zalloc()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/usb/host/fotg210-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 296452625488..b590995a6b3e 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -1859,10 +1859,9 @@ static struct fotg210_qh *fotg210_qh_alloc(struct fotg210_hcd *fotg210,
 	if (!qh)
 		goto done;
 	qh->hw = (struct fotg210_qh_hw *)
-		dma_pool_alloc(fotg210->qh_pool, flags, &dma);
+		dma_pool_zalloc(fotg210->qh_pool, flags, &dma);
 	if (!qh->hw)
 		goto fail;
-	memset(qh->hw, 0, sizeof(*qh->hw));
 	qh->qh_dma = dma;
 	INIT_LIST_HEAD(&qh->qtd_list);
 
-- 
2.25.1

