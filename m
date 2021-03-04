Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0FC32CB7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhCDEnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:43:01 -0500
Received: from mail.windriver.com ([147.11.1.11]:34872 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhCDEmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:42:33 -0500
X-Greylist: delayed 5164 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 23:42:33 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 1243EnVH016543
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 19:14:54 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Mar 2021 19:14:49 -0800
Received: from pek-lwang1-u1404.wrs.com (128.224.155.118) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Wed, 3 Mar 2021 19:14:47 -0800
From:   Li Wang <li.wang@windriver.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <li.wang@windriver.com>
Subject: [V2][PATCH] vt: keyboard, fix uninitialized variables warning
Date:   Thu, 4 Mar 2021 11:10:48 +0800
Message-ID: <1614827448-1594-1-git-send-email-li.wang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <2973260e-2405-5a70-f9bd-398d3d45346e@windriver.com>
References: <2973260e-2405-5a70-f9bd-398d3d45346e@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
  return ret;
         ^~~
drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
  kfree(kbs);
  ^~~~~~~~~~

Signed-off-by: Li Wang <li.wang@windriver.com>
---
 drivers/tty/vt/keyboard.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 7763862..62f1ecb 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2090,6 +2090,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 
 		ret = 0;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	kfree(kbs);
-- 
2.7.4

