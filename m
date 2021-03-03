Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A132BBCD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhCCMtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:49:09 -0500
Received: from mail1.windriver.com ([147.11.146.13]:34500 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842582AbhCCIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:07:51 -0500
X-Greylist: delayed 10944 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 03:07:46 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 12353WJx016360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Mar 2021 21:03:33 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Mar 2021 21:03:32 -0800
Received: from pek-lwang1-u1404.wrs.com (128.224.155.118) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 2 Mar 2021 21:03:31 -0800
From:   Li Wang <li.wang@windriver.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <li.wang@windriver.com>
Subject: [PATCH] vt: keyboard, fix uninitialized variables warning
Date:   Wed, 3 Mar 2021 12:59:32 +0800
Message-ID: <1614747572-3295-1-git-send-email-li.wang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
  return ret;
         ^~~
kernel-source/drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
  kfree(kbs);
  ^~~~~~~~~~

Signed-off-by: Li Wang <li.wang@windriver.com>
---
 drivers/tty/vt/keyboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 7763862..3e73d55 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2049,8 +2049,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
 	unsigned char kb_func;
 	unsigned long flags;
-	char *kbs;
-	int ret;
+	char *kbs = NULL;
+	int ret = -EINVAL;
 
 	if (get_user(kb_func, &user_kdgkb->kb_func))
 		return -EFAULT;
-- 
2.7.4

