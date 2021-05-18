Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB25B387106
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346438AbhERFDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 01:03:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2961 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhERFDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 01:03:22 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkkLX2JMtzCsJ7;
        Tue, 18 May 2021 12:59:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 13:02:01 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 13:02:01 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <zbr@ioremap.net>, <gregkh@linuxfoundation.org>
Subject: [PATCH -next] w1: w1_therm: fix build warning in w1_seq_show()
Date:   Tue, 18 May 2021 13:04:15 +0800
Message-ID: <20210518050415.615783-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build warning:

  drivers/w1/slaves/w1_therm.c: In function ‘w1_seq_show’:
  drivers/w1/slaves/w1_therm.c:2059:6: warning: variable ‘rv’ set but not used [-Wunused-but-set-variable]
    int rv;
        ^~

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/w1/slaves/w1_therm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index a284da567ff9..ca70c5f03206 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -2056,7 +2056,6 @@ static ssize_t w1_seq_show(struct device *device,
 {
 	struct w1_slave *sl = dev_to_w1_slave(device);
 	ssize_t c = PAGE_SIZE;
-	int rv;
 	int i;
 	u8 ack;
 	u64 rn;
@@ -2084,7 +2083,7 @@ static ssize_t w1_seq_show(struct device *device,
 			goto error;
 
 		w1_write_8(sl->master, W1_42_COND_READ);
-		rv = w1_read_block(sl->master, (u8 *)&rn, 8);
+		w1_read_block(sl->master, (u8 *)&rn, 8);
 		reg_num = (struct w1_reg_num *) &rn;
 		if (reg_num->family == W1_42_FINISHED_BYTE)
 			break;
-- 
2.25.1

