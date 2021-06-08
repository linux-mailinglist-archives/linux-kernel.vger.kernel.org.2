Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67D839EC43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFHCl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:41:26 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4390 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhFHCl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:41:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzZ9B1G2rz6vTL;
        Tue,  8 Jun 2021 10:35:42 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:39:32 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 10:39:31 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] tty: tty_ldisc: fix doc warnings in tty_ldisc.c
Date:   Tue, 8 Jun 2021 10:48:43 +0800
Message-ID: <20210608024843.2756746-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_ldisc.c:63: warning: Excess function
  parameter 'disc' description in 'tty_register_ldisc'
 drivers/tty/tty_ldisc.c:90: warning: Function parameter or
  member 'ldisc' not described in 'tty_unregister_ldisc'
 drivers/tty/tty_ldisc.c:90: warning: Excess function
  parameter 'disc' description in 'tty_unregister_ldisc'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/tty/tty_ldisc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 8edd73ab9148..756a4bfa6a69 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -48,7 +48,6 @@ static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
 
 /**
  *	tty_register_ldisc	-	install a line discipline
- *	@disc: ldisc number
  *	@new_ldisc: pointer to the ldisc object
  *
  *	Installs a new line discipline into the kernel. The discipline
@@ -77,7 +76,7 @@ EXPORT_SYMBOL(tty_register_ldisc);
 
 /**
  *	tty_unregister_ldisc	-	unload a line discipline
- *	@disc: ldisc number
+ *	@ldisc: ldisc number
  *
  *	Remove a line discipline from the kernel providing it is not
  *	currently in use.
-- 
2.31.1

