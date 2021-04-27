Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6ED36C4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhD0LYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:24:04 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40301 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230270AbhD0LYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:24:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UX-4Cd8_1619522596;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UX-4Cd8_1619522596)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Apr 2021 19:23:17 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mporter@kernel.crashing.org
Cc:     alex.bou9@gmail.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] drivers/rapidio/rio-scan.c: drop unneeded assignment in rio_enum_peer()
Date:   Tue, 27 Apr 2021 19:23:15 +0800
Message-Id: <1619522595-105320-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making '<' operation with port->host_deviceid directly after
calling the function rio_get_host_deviceid_lock(() is more efficient,
so assignment to ‘tmp’ is redundant.

Eliminate the following clang_analyzer warning:
drivers/rapidio/rio-scan.c:561:10: warning: Although the value stored to
'tmp' is used in the enclosing expression, the value is never actually
read from 'tmp'

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/rapidio/rio-scan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 19b0c33..2bc4d1e 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -524,7 +524,6 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 {
 	struct rio_dev *rdev;
 	u32 regval;
-	int tmp;
 
 	if (rio_mport_chk_dev_access(port,
 			RIO_ANY_DESTID(port->sys_size), hopcount)) {
@@ -558,7 +557,7 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 	rio_mport_write_config_32(port, RIO_ANY_DESTID(port->sys_size),
 				  hopcount,
 				  RIO_HOST_DID_LOCK_CSR, port->host_deviceid);
-	while ((tmp = rio_get_host_deviceid_lock(port, hopcount))
+	while (rio_get_host_deviceid_lock(port, hopcount)
 	       < port->host_deviceid) {
 		/* Delay a bit */
 		mdelay(1);
-- 
1.8.3.1

