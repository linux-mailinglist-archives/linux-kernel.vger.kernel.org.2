Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E333E2A6F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 14:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbhHFMPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 08:15:43 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59656 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343589AbhHFMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 08:15:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui8W5Kx_1628252123;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Ui8W5Kx_1628252123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Aug 2021 20:15:24 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] mailbox: fix a UAF bug in msg_submit()
Date:   Fri,  6 Aug 2021 20:15:21 +0800
Message-Id: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We met a UAF issue during our mailbox testing.

In synchronous mailbox, we use mbox_send_message() to send a message
and wait for completion. mbox_send_message() calls msg_submit() to
send the message for the first time, if timeout, it will send the
message in tx_tick() for the second time.

We assume message sending failed for both two times,  then the message
will be still in the internal buffer of a chan(chan->msg_data[idx]).
It will be send again in the same way when mbox_send_message() is
called next time. But, at this time this message (chan->msg_data[idx])
may be a UAF pointer, as the message is passed to mailbox core by user.
User may free it after last calling of mbox_send_message() returned
or not. Who knows!!!

In this patch, if the first time sending timeout, we pass timeout
info(-ETIME) to msg_submit() when do the second time sending by
tx_tick(). If it still send failed (chan->mbox->ops->send_data()
returned non-zero value) in the second time, we will give up this
message(chan->msg_count--) sending. It doesn't matter, user can chose
to send it again.

Actually, the issue I described above doesn't exist if
'chan->mbox->ops->send_data()' always return 0. Because if it always
returns 0, we will always do 'chan->msg_count—' regardless of message
sending success or failure. We have such mailbox driver, for example,
hi6220_mbox_send_data() always return 0. But we still have mailbox
drivers, which don't always return 0, for example, flexrm_send_data()
of drivers/mailbox/bcm-flexrm-mailbox.c.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/mailbox/mailbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 3e7d4b20a..3e010aafa 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -50,7 +50,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 	return idx;
 }
 
-static void msg_submit(struct mbox_chan *chan)
+static void msg_submit(struct mbox_chan *chan, int last_submit)
 {
 	unsigned count, idx;
 	unsigned long flags;
@@ -75,7 +75,7 @@ static void msg_submit(struct mbox_chan *chan)
 		chan->cl->tx_prepare(chan->cl, data);
 	/* Try to submit a message to the MBOX controller */
 	err = chan->mbox->ops->send_data(chan, data);
-	if (!err) {
+	if (!err || last_submit == -ETIME) {
 		chan->active_req = data;
 		chan->msg_count--;
 	}
@@ -101,7 +101,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	/* Submit next message */
-	msg_submit(chan);
+	msg_submit(chan, r);
 
 	if (!mssg)
 		return;
@@ -260,7 +260,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		return t;
 	}
 
-	msg_submit(chan);
+	msg_submit(chan, 0);
 
 	if (chan->cl->tx_block) {
 		unsigned long wait;
-- 
2.17.1

