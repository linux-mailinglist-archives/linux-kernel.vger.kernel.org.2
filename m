Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23BB35286F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhDBJSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:18:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16332 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbhDBJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:18:06 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBZCx16Bgz9vtc;
        Fri,  2 Apr 2021 17:15:57 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 17:18:01 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <speakup@linux-speakup.org>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next] staging/speakup: Switch to kmemdup_nul()
Date:   Fri, 2 Apr 2021 17:21:11 +0800
Message-ID: <20210402092111.2443601-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup_nul() helper instead of open-coding to
simplify the code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/accessibility/speakup/i18n.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/accessibility/speakup/i18n.c b/drivers/accessibility/speakup/i18n.c
index ee240d36f947..46bd50f3c3a4 100644
--- a/drivers/accessibility/speakup/i18n.c
+++ b/drivers/accessibility/speakup/i18n.c
@@ -548,12 +548,10 @@ ssize_t spk_msg_set(enum msg_index_t index, char *text, size_t length)
 	if ((index < MSG_FIRST_INDEX) || (index >= MSG_LAST_INDEX))
 		return -EINVAL;
 
-	newstr = kmalloc(length + 1, GFP_KERNEL);
+	newstr = kmemdup_nul(text, length, GFP_KERNEL);
 	if (!newstr)
 		return -ENOMEM;
 
-	memcpy(newstr, text, length);
-	newstr[length] = '\0';
 	if (index >= MSG_FORMATTED_START &&
 	    index <= MSG_FORMATTED_END &&
 	    !fmt_validate(speakup_default_msgs[index], newstr)) {
-- 
2.25.1

