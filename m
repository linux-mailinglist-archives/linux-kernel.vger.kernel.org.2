Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC00437039
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhJVC6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:58:55 -0400
Received: from ssh248.corpemail.net ([210.51.61.248]:9354 "EHLO
        ssh248.corpemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbhJVC6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:58:52 -0400
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((LNX1044)) with ASMTP (SSL) id PCA00130;
        Fri, 22 Oct 2021 10:56:30 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2308.14; Fri, 22 Oct 2021 10:55:57 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <gregkh@linuxfoundation.org>
CC:     <Larry.Finger@lwfinger.net>, <phil@philpotter.co.uk>,
        <straube.linux@gmail.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Kai Song <songkai01@inspur.com>
Subject: [PATCH] staging: r8188eu: Use memdup_user instead of kmalloc/copy_from_user
Date:   Fri, 22 Oct 2021 10:55:55 +0800
Message-ID: <20211022025555.6612-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   20211022105630129e2bae6274888de4809c42d710a487
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memdup_user helper instead of open-coding to simplify
the code.

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 0201f6fbeb25..96a08cc5a1ed 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1984,14 +1984,10 @@ static int rtw_wx_read32(struct net_device *dev,
 	padapter = (struct adapter *)rtw_netdev_priv(dev);
 	p = &wrqu->data;
 	len = p->length;
-	ptmp = kmalloc(len, GFP_KERNEL);
-	if (!ptmp)
-		return -ENOMEM;
 
-	if (copy_from_user(ptmp, p->pointer, len)) {
-		kfree(ptmp);
-		return -EFAULT;
-	}
+	ptmp = memdup_user(p->pointer, len);
+	if (IS_ERR(ptmp))
+		return PTR_ERR(ptmp);
 
 	bytes = 0;
 	addr = 0;
-- 
2.27.0

