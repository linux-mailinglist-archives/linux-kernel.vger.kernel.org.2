Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457B443AC64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhJZGtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:49:00 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:31309 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234080AbhJZGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:48:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=cuibixuan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UtkOMwB_1635230785;
Received: from VM20210331-25.tbsite.net(mailfrom:cuibixuan@linux.alibaba.com fp:SMTPD_---0UtkOMwB_1635230785)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Oct 2021 14:46:33 +0800
From:   Bixuan Cui <cuibixuan@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.or, rafael@kernel.org,
        cuibixuan@linux.alibaba.com
Subject: [PATCH -next v2] platform-msi: Save the msg context to desc in platform_msi_write_msg()
Date:   Tue, 26 Oct 2021 14:46:25 +0800
Message-Id: <1635230785-57350-1-git-send-email-cuibixuan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the msg context to desc when the msi interrupt is requested.
So that the requesters can use it in special scenarios, such as
resume mode.

Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
---
Changes in v2:
* Modify the commit log and update my email address;

 drivers/base/platform-msi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 3d6c8f9..824a540 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -90,6 +90,10 @@ static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 
 	priv_data = desc->platform.msi_priv_data;
 
+	desc->msg.address_lo = msg->address_lo;
+	desc->msg.address_hi = msg->address_hi;
+	desc->msg.data = msg->data;
+
 	priv_data->write_msg(desc, msg);
 }
 
-- 
1.8.3.1

