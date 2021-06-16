Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1F3A9B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhFPM4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:56:09 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:53060 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhFPM4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:56:06 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id CE363CD8BD;
        Wed, 16 Jun 2021 20:53:40 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.207.172.18])
        by smtp.263.net (postfix) whith ESMTP id P4789T140158491260672S1623848013965153_;
        Wed, 16 Jun 2021 20:53:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <97f3434abaad5f566b0711ee2b3c6bfd>
X-RL-SENDER: maqianga@uniontech.com
X-SENDER: maqianga@uniontech.com
X-LOGIN-NAME: maqianga@uniontech.com
X-FST-TO: larry.finger@lwfinger.net
X-RCPT-COUNT: 8
X-SENDER-IP: 111.207.172.18
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Qiang Ma <maqianga@uniontech.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        insafonov@gmail.com, yepeilin.cs@gmail.com, ffclaire1224@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] staging: r8188eu/core: remove the check for NULL pointer in _rtw_enqueue_cmd()
Date:   Wed, 16 Jun 2021 20:53:32 +0800
Message-Id: <20210616125332.31674-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the check for _rtw_enqueue_cmd(), because
rtw_enqueue_cmd() already has a check of NULL pointer,
so this condition is not possible.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 1724dfd7edbc..513c0f95b4bf 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -39,17 +39,12 @@ static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 {
 	unsigned long irqL;
 
-	if (!obj)
-		goto exit;
-
 	spin_lock_irqsave(&queue->lock, irqL);
 
 	list_add_tail(&obj->list, &queue->queue);
 
 	spin_unlock_irqrestore(&queue->lock, irqL);
 
-exit:
-
 	return _SUCCESS;
 }
 
-- 
2.20.1



