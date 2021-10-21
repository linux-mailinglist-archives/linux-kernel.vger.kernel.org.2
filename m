Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C01435D09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJUIlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:41:25 -0400
Received: from mx22.baidu.com ([220.181.50.185]:43076 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231473AbhJUIlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:41:21 -0400
Received: from BJHW-Mail-Ex12.internal.baidu.com (unknown [10.127.64.35])
        by Forcepoint Email with ESMTPS id 7B66FF519D69360D465D;
        Thu, 21 Oct 2021 16:39:04 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:39:04 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:39:03 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dm crypt: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 16:39:01 +0800
Message-ID: <20211021083902.1918-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-MAIL-EX04.internal.baidu.com (10.127.64.14) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex12_2021-10-21 16:39:04:526
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/md/dm-crypt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 1ee3da2bfd0b..d4ae31558826 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3363,14 +3363,13 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	spin_lock_init(&cc->write_thread_lock);
 	cc->write_tree = RB_ROOT;
 
-	cc->write_thread = kthread_create(dmcrypt_write, cc, "dmcrypt_write/%s", devname);
+	cc->write_thread = kthread_run(dmcrypt_write, cc, "dmcrypt_write/%s", devname);
 	if (IS_ERR(cc->write_thread)) {
 		ret = PTR_ERR(cc->write_thread);
 		cc->write_thread = NULL;
 		ti->error = "Couldn't spawn write thread";
 		goto bad;
 	}
-	wake_up_process(cc->write_thread);
 
 	ti->num_flush_bios = 1;
 	ti->limit_swap_bios = true;
-- 
2.25.1

