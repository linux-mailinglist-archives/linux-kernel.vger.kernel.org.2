Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD20355215
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245592AbhDFL2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:28:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16354 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245512AbhDFL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:27:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF4vP6Fpgz93L8;
        Tue,  6 Apr 2021 19:25:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:27:26 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 10/10] tty: tty_ldisc: Remove the repeated word 'the'
Date:   Tue, 6 Apr 2021 19:24:48 +0800
Message-ID: <1617708288-14847-11-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
References: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word 'the' following advice of checkpatch.pl

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_ldisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 56e67f7..fdc4fa3 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -147,7 +147,7 @@ static int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
  *	Returns: -EINVAL if the discipline index is not [N_TTY..NR_LDISCS] or
  *			 if the discipline is not registered
  *		 -EAGAIN if request_module() failed to load or register the
- *			 the discipline
+ *			 discipline
  *		 -ENOMEM if allocation failure
  *
  *		 Otherwise, returns a pointer to the discipline and bumps the
-- 
2.8.1

