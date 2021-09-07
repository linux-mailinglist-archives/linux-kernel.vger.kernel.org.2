Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1133A402B2C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhIGO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:56:33 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57459 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344256AbhIGO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:56:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 20BF9580E87;
        Tue,  7 Sep 2021 10:55:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Sep 2021 10:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=y8PXeVnFzrsl/
        cXDsgWmWZzL6RQvNo+H9tfhruaVO+U=; b=CJVhLaHjIvv39oj5hmIgfFph0tsWf
        jzoffG1Gq9uLrd1mlg5qU08WTS43II6E+PedvrJP8dZfEDFX8MzUOjY5j5pYz0t3
        X60XP7NEOK//kOB8W41tDMLd1swUwHCg2DMKS1HlD2XFDe9Ti2ELGFIGzyh0JU/y
        1TvFzliUs+0Oi/yQPZ9IGrp+PUacdkPiIfQfMy7eIQY5KzZYS1aJVYHFxYYUOZrO
        81r3BdukbIRrhaTJRYEWxkQgPnMqKA7/IsZp/s6K1Qs60b9z22mBZnJ6X4FNFeeY
        4YOlDcZWNo+6Fqksvkk1CmbttBrbNMN7Fbbxesp8Hcg7us2ztz1TFLxZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=y8PXeVnFzrsl/cXDsgWmWZzL6RQvNo+H9tfhruaVO+U=; b=IZI7grHk
        SQOCKYf7sDAum6+2HiDs+ZFdNt861sQYGOl1D+v/xPXRsamUxs5adghUTHqD/B1H
        m/yX+hlb1bLwtvEr7wKGJLkWbqetW1jmx2wniChnTD3YdF8QFcSVGjDavdIkWNdp
        T9cpd2WzBmEFIgDbzBEsOf5gQEnqL/wQdr58Wz3f8QWf12Ea9jeQZsX4+g+8syVZ
        ztYrL9lrZPdH9XXVLtpPtvRYJQNGDfDmZxC+BC67CfdLvoZbcFysY4+jpMmkOTph
        UbQ1aZka7BL2/WQNBBYmQK2l7cRIPJGwlyznCtS2DsSDxlvXWpWTe8uTY1gO53aj
        KSVLoONg6pzkag==
X-ME-Sender: <xms:Wn03YYkzTfzmFZESSpLZW2oi1YztF08LGzCZnq_wSwKWnEESlQSQ5g>
    <xme:Wn03YX0jbmEuxVE70zOxwtov12sWwYaaGHMqoQftFLp3BgHnOjqtvjThemxDHB_MZ
    ncllBrABuLQIw_UfYM>
X-ME-Received: <xmr:Wn03YWrCY4SeFy247ihUPEEtO78nWJdCUl3oZLEmK4y9wy4gjVxcjXM-tyO5Arf4gnxp8E8hTddP3OpMnQBOonm3gRCDhVRYI1gdgTfxRzY-V0l01LyGsTTOO_grzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefhedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Wn03YUlvwGmYM8JT_zUdLPPPRtuVf-8vSp1bw5yrcXeaoFLrFHFQ8Q>
    <xmx:Wn03YW28egzSwb9gsNRPRRcQ0U1EWpokvnTfBvVz5p_KYGQpPfogvQ>
    <xmx:Wn03YbvE7lCWLJoUlmLAluJpZvFwLNRfiBffcngc6_et51-sqFAhQw>
    <xmx:W303YUz040TUnZHI-XCmjvEsWRQHzdf1SqE5CwB26yx5PGPhl9O6Dg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 10:55:21 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mailbox: Add txdone_fifo
Date:   Tue,  7 Sep 2021 16:54:59 +0200
Message-Id: <20210907145501.69161-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210907145501.69161-1-sven@svenpeter.dev>
References: <20210907145501.69161-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mailbox controllers are backed by a hardware FIFO and only provide
a "FIFO not full" or "FIFO empty" interrupt. In the most common case
it is however not neccesarry to wait for this interrupt since there
is enough space in the FIFO and the message can be accepted directly.
txdone_fifo adds supports for such controllers. Messages are assumed
to have been transmitted as long as ops->send_data() returns success.
Only if the FIFO is full and ops->send_data() returns -EBUSY the
interrupt is enabled with ops->request_irq().

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/mailbox/mailbox.c          | 66 ++++++++++++++++++++++++++----
 drivers/mailbox/mailbox.h          |  1 +
 include/linux/mailbox_controller.h | 15 +++++++
 3 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 3e7d4b20ab34..cd628d98d211 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -50,6 +50,15 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 	return idx;
 }
 
+static void complete_msg(struct mbox_chan *chan, void *msg, int r)
+{
+	if (chan->cl->tx_done)
+		chan->cl->tx_done(chan->cl, msg, r);
+
+	if (r != -ETIME && chan->cl->tx_block)
+		complete(&chan->tx_complete);
+}
+
 static void msg_submit(struct mbox_chan *chan)
 {
 	unsigned count, idx;
@@ -59,7 +68,7 @@ static void msg_submit(struct mbox_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flags);
 
-	if (!chan->msg_count || chan->active_req)
+	if (!chan->msg_count || chan->active_req || chan->irq_pending)
 		goto exit;
 
 	count = chan->msg_count;
@@ -75,15 +84,30 @@ static void msg_submit(struct mbox_chan *chan)
 		chan->cl->tx_prepare(chan->cl, data);
 	/* Try to submit a message to the MBOX controller */
 	err = chan->mbox->ops->send_data(chan, data);
-	if (!err) {
-		chan->active_req = data;
+	if (err) {
+		/* HW FIFO is full and we need to wait for an irq to continue */
+		if (chan->txdone_method & TXDONE_BY_FIFO) {
+			chan->irq_pending = true;
+			chan->mbox->ops->request_irq(chan);
+		}
+	} else {
+		/* controllers with a FIFO have already accepted the message */
+		if (!(chan->txdone_method & TXDONE_BY_FIFO))
+			chan->active_req = data;
 		chan->msg_count--;
 	}
 exit:
 	spin_unlock_irqrestore(&chan->lock, flags);
 
+	if (err)
+		return;
+
+	/* controllers with a FIFO have already accepted the message */
+	if (chan->txdone_method & TXDONE_BY_FIFO)
+		complete_msg(chan, data, 0);
+
 	/* kick start the timer immediately to avoid delays */
-	if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
+	if (chan->txdone_method & TXDONE_BY_POLL) {
 		/* but only if not already active */
 		if (!hrtimer_active(&chan->mbox->poll_hrt))
 			hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
@@ -107,11 +131,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
 		return;
 
 	/* Notify the client */
-	if (chan->cl->tx_done)
-		chan->cl->tx_done(chan->cl, mssg, r);
-
-	if (r != -ETIME && chan->cl->tx_block)
-		complete(&chan->tx_complete);
+	complete_msg(chan, mssg, r);
 }
 
 static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
@@ -179,6 +199,31 @@ void mbox_chan_txdone(struct mbox_chan *chan, int r)
 }
 EXPORT_SYMBOL_GPL(mbox_chan_txdone);
 
+/**
+ * mbox_chan_txfifo_ready - A way for controller driver to notify the
+ *			    framework that there is space in the FIFO
+ *			    to accept messages again.
+ * @chan: Pointer to the mailbox chan on which there is FIFO space available
+ *
+ * The controller that has IRQ for TX ACK calls this atomic API
+ * to notify that there is space in the hardware FIFO again.
+ * It works only if txdone_fifo is set by the controller.
+ * This must be called from within the IRQ handler.
+ */
+void mbox_chan_txfifo_ready(struct mbox_chan *chan)
+{
+	if (unlikely(!(chan->txdone_method & TXDONE_BY_FIFO))) {
+		dev_err(chan->mbox->dev,
+		       "Controller can't run the TX FIFO ticker\n");
+		return;
+	}
+
+	WRITE_ONCE(chan->irq_pending, false);
+	while (!READ_ONCE(chan->irq_pending) && READ_ONCE(chan->msg_count))
+		msg_submit(chan);
+}
+EXPORT_SYMBOL_GPL(mbox_chan_txfifo_ready);
+
 /**
  * mbox_client_txdone - The way for a client to run the TX state machine.
  * @chan: Mailbox channel assigned to this client.
@@ -376,6 +421,7 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 	chan->msg_free = 0;
 	chan->msg_count = 0;
 	chan->active_req = NULL;
+	chan->irq_pending = false;
 	chan->cl = cl;
 	init_completion(&chan->tx_complete);
 
@@ -485,6 +531,8 @@ int mbox_controller_register(struct mbox_controller *mbox)
 
 	if (mbox->txdone_irq)
 		txdone = TXDONE_BY_IRQ;
+	else if (mbox->txdone_fifo)
+		txdone = TXDONE_BY_FIFO;
 	else if (mbox->txdone_poll)
 		txdone = TXDONE_BY_POLL;
 	else /* It has to be ACK then */
diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
index 046d6d258b32..710525341df6 100644
--- a/drivers/mailbox/mailbox.h
+++ b/drivers/mailbox/mailbox.h
@@ -6,5 +6,6 @@
 #define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
 #define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
 #define TXDONE_BY_ACK	BIT(2) /* S/W ACK received by Client ticks the TX */
+#define TXDONE_BY_FIFO	BIT(3) /* controller has HW FIFO with not-empty irq */
 
 #endif /* __MAILBOX_H */
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 36d6ce673503..638cc20b9ebc 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -42,6 +42,11 @@ struct mbox_chan;
  *		  Used only if txdone_poll:=true && txdone_irq:=false
  * @peek_data: Atomic check for any received data. Return true if controller
  *		  has some data to push to the client. False otherwise.
+ * @request_irq: If the controller sets 'txdone_fifo', the API calls this
+ *		 to enable the 'ready to submit' interrupt whenever a previous
+ *		 call to send_data was not successful. This interrupt must fire
+ *		 only once and must call mbox_chan_txfifo_ready when new
+ *		 messages can be accepted into the hardware FIFO again.
  */
 struct mbox_chan_ops {
 	int (*send_data)(struct mbox_chan *chan, void *data);
@@ -50,6 +55,7 @@ struct mbox_chan_ops {
 	void (*shutdown)(struct mbox_chan *chan);
 	bool (*last_tx_done)(struct mbox_chan *chan);
 	bool (*peek_data)(struct mbox_chan *chan);
+	void (*request_irq)(struct mbox_chan *chan);
 };
 
 /**
@@ -61,6 +67,11 @@ struct mbox_chan_ops {
  * @txdone_irq:		Indicates if the controller can report to API when
  *			the last transmitted data was read by the remote.
  *			Eg, if it has some TX ACK irq.
+ * @txdone_fifo:	Indicates if the controller has a hardware FIFO which
+ *			can directly accept multiple messages without delay.
+ *			In case the FIFO cannot accept a message ops->send_data
+ *			returns -EBUSY and ops->request_irq is used to request
+ *			an interrupt once the FIFO has space for new messages.
  * @txdone_poll:	If the controller can read but not report the TX
  *			done. Ex, some register shows the TX status but
  *			no interrupt rises. Ignored if 'txdone_irq' is set.
@@ -77,6 +88,7 @@ struct mbox_controller {
 	struct mbox_chan *chans;
 	int num_chans;
 	bool txdone_irq;
+	bool txdone_fifo;
 	bool txdone_poll;
 	unsigned txpoll_period;
 	struct mbox_chan *(*of_xlate)(struct mbox_controller *mbox,
@@ -108,6 +120,7 @@ struct mbox_controller {
  * @cl:			Pointer to the current owner of this channel
  * @tx_complete:	Transmission completion
  * @active_req:		Currently active request hook
+ * @irq_pending:	Set if the API is waiting for an interrupt to continue
  * @msg_count:		No. of mssg currently queued
  * @msg_free:		Index of next available mssg slot
  * @msg_data:		Hook for data packet
@@ -120,6 +133,7 @@ struct mbox_chan {
 	struct mbox_client *cl;
 	struct completion tx_complete;
 	void *active_req;
+	bool irq_pending;
 	unsigned msg_count, msg_free;
 	void *msg_data[MBOX_TX_QUEUE_LEN];
 	spinlock_t lock; /* Serialise access to the channel */
@@ -130,6 +144,7 @@ int mbox_controller_register(struct mbox_controller *mbox); /* can sleep */
 void mbox_controller_unregister(struct mbox_controller *mbox); /* can sleep */
 void mbox_chan_received_data(struct mbox_chan *chan, void *data); /* atomic */
 void mbox_chan_txdone(struct mbox_chan *chan, int r); /* atomic */
+void mbox_chan_txfifo_ready(struct mbox_chan *chan); /* atomic */
 
 int devm_mbox_controller_register(struct device *dev,
 				  struct mbox_controller *mbox);
-- 
2.25.1

