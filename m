Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B231D5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhBQHgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 02:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhBQHet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:34:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7111C061788
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:33:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f3so16889898ybg.15
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6qKo0RCKzfkUdg1aVv7+GSGl79l43/TBLx7+DoXXi8I=;
        b=NUUqAKSm5fJlcLA3lidIGQhpQA/w5v7l+bo4P6DdSbGbL5iJcXCaTumT3ekzXeuYm2
         j88vcVcLoobDoICWGa15GihF/y1dgXsRseyicIt+l9Opiv6ItwHRz3x2d2bh5cKoc2sk
         IvjP7C68JNAGmVZ7uIkwBw1MVEtum9X/6Z+b+YKkzjBDoDISGqYSJD4QixrRpPhlDdRG
         YoW6419SqKu5s2fXzWtk9Dd3wQ4XNRIiBw+1E666y0yJ2ImPYnulWg6YA191KGT3yK5W
         qMB7JTCZFSeHpZTqrasQSE+rdXKhamMmIx8id2kAN3t3NN7rXDZxMZ0JRFnDwrmBd/kr
         U/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6qKo0RCKzfkUdg1aVv7+GSGl79l43/TBLx7+DoXXi8I=;
        b=sa1wqzRT3zUwBPvf0VSNmD32gDhoVyd2c6RP7hihQwK0PMplLSRd4J20yBuo7Y3GRp
         ysL6bkSR5vjqFgHlntcRzj3d/sz3QcnaPL4TVCOVwWlEIbEDZ/X6RApCO3jyjGQNiEfS
         CA1PwJ8DRjXtf3aX9CG+dNjPeXMwLTAgfnSe/va37TiovpgRxUMlUKzHrhcm4eqM6Yak
         lc45DPBHpr11aXafq3m20uY+1FP6Ta0KL7JZraI6SNuFaejTMsYSq63TvYMw0TmAVKEQ
         WoZRCrX6EHUbYWXTsIFOU0Uttfsdjh6AbQJ8O8gcH053I7GV9/DoImLT2vB59SkKKFat
         f2eg==
X-Gm-Message-State: AOAM530NdpFhxHei5fl0utTrKXwEB/uwqWG2MEC2kesFFTTQbEeddm51
        w5HfaUpKOjuK4dNyi2rXkT6BEpY=
X-Google-Smtp-Source: ABdhPJyCbvWIcimi/8Dd3oa4K5QbAuJxaLHILVFxNfFetvLayltZYdOWETxjv17kQsAqFtTDvQt5VGQ=
Sender: "wak via sendgmr" <wak@wak-linux.svl.corp.google.com>
X-Received: from wak-linux.svl.corp.google.com ([2620:15c:2c5:3:e984:b7fc:110a:274a])
 (user=wak job=sendgmr) by 2002:a25:830e:: with SMTP id s14mr36705171ybk.42.1613547228953;
 Tue, 16 Feb 2021 23:33:48 -0800 (PST)
Date:   Tue, 16 Feb 2021 23:33:18 -0800
In-Reply-To: <20210217073318.540369-1-wak@google.com>
Message-Id: <20210217073318.540369-5-wak@google.com>
Mime-Version: 1.0
References: <20210217073318.540369-1-wak@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 4/4] ipmi: kcs_bmc: Simplify state machine
From:   "William A. Kennington III" <wak@google.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "William A. Kennington III" <wak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes a few changes, notably:

  - Removes the mutex primitive as it is not needed in the file
    operation path. The read path had multiple spinlock acquisitions
    with state changes that don't appear safe to reordering,
    specifically around forced aborts.

  - Removes multiple per-channel allocated data buffers, opting to only
    store the necessary data for the currently in flight transaction.
    Since only 1 data buffer can really be used at a given time, we
    don't need the previous 2-3.

  - Reduces the number of states in the KCS state machine. There are
    some states, like the second abort state, that effectively duplicate
    others.

  - Cleans up the initialization and register setting logic to include
    bits that were missed previously.

Signed-off-by: William A. Kennington III <wak@google.com>
---
 drivers/char/ipmi/kcs_bmc.c | 301 ++++++++++++++----------------------
 drivers/char/ipmi/kcs_bmc.h |  49 ++----
 2 files changed, 132 insertions(+), 218 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 16a378d79db9..f2fa43a516da 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -11,21 +11,14 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
 
 #include "kcs_bmc.h"
 
 #define DEVICE_NAME "ipmi-kcs"
 
-#define KCS_MSG_BUFSIZ    1000
-
-#define KCS_ZERO_DATA     0
-
-
 /* IPMI 2.0 - Table 9-1, KCS Interface Status Register Bits */
 #define KCS_STATUS_STATE(state) (state << 6)
-#define KCS_STATUS_STATE_MASK   GENMASK(7, 6)
+#define KCS_STATUS_STATE_MASK   GENMASK(7, 4)
 #define KCS_STATUS_CMD_DAT      BIT(3)
 #define KCS_STATUS_SMS_ATN      BIT(2)
 #define KCS_STATUS_IBF          BIT(1)
@@ -33,19 +26,19 @@
 
 /* IPMI 2.0 - Table 9-2, KCS Interface State Bits */
 enum kcs_states {
-	IDLE_STATE  = 0,
-	READ_STATE  = 1,
-	WRITE_STATE = 2,
-	ERROR_STATE = 3,
+	KCS_STATE_IDLE  = 0,
+	KCS_STATE_READ  = 1,
+	KCS_STATE_WRITE = 2,
+	KCS_STATE_ERROR = 3,
 };
 
 /* IPMI 2.0 - Table 9-3, KCS Interface Control Codes */
 #define KCS_CMD_GET_STATUS_ABORT  0x60
 #define KCS_CMD_WRITE_START       0x61
 #define KCS_CMD_WRITE_END         0x62
-#define KCS_CMD_READ_BYTE         0x68
+#define KCS_DATA_READ_BYTE        0x68
 
-static void update_status_bits(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
+static void kcs_update_status_bits(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
 {
 	u8 tmp = kcs_bmc->read_status(kcs_bmc);
 	tmp &= ~mask;
@@ -53,95 +46,70 @@ static void update_status_bits(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
 	kcs_bmc->write_status(kcs_bmc, tmp);
 }
 
-static inline void set_state(struct kcs_bmc *kcs_bmc, u8 state)
+static void kcs_set_state(struct kcs_bmc *kcs_bmc, enum kcs_states state)
 {
-	update_status_bits(kcs_bmc, KCS_STATUS_STATE_MASK,
+	kcs_update_status_bits(kcs_bmc, KCS_STATUS_STATE_MASK,
 					KCS_STATUS_STATE(state));
 }
 
-static void kcs_force_abort(struct kcs_bmc *kcs_bmc)
+static void kcs_force_abort(struct kcs_bmc *kcs_bmc, enum kcs_errors error)
 {
-	set_state(kcs_bmc, ERROR_STATE);
+	kcs_bmc->phase = KCS_PHASE_ERROR;
+	kcs_bmc->error = error;
+	kcs_set_state(kcs_bmc, KCS_STATE_ERROR);
 	kcs_bmc->read_data_in(kcs_bmc);
-	kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
+	kcs_bmc->write_data_out(kcs_bmc, 0);
+}
 
-	kcs_bmc->phase = KCS_PHASE_ERROR;
-	kcs_bmc->data_in_avail = false;
-	kcs_bmc->data_in_idx = 0;
+static void kcs_pump_data_out(struct kcs_bmc *kcs_bmc)
+{
+	kcs_bmc->write_data_out(kcs_bmc,
+			kcs_bmc->data_idx >= kcs_bmc->data_len ?
+			0 : kcs_bmc->data[kcs_bmc->data_idx++]);
 }
 
 static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
 {
-	u8 data;
-
 	switch (kcs_bmc->phase) {
-	case KCS_PHASE_WRITE_START:
-		kcs_bmc->phase = KCS_PHASE_WRITE_DATA;
-		fallthrough;
-
 	case KCS_PHASE_WRITE_DATA:
-		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
-			set_state(kcs_bmc, WRITE_STATE);
-			kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
-			kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
-						kcs_bmc->read_data_in(kcs_bmc);
-		} else {
-			kcs_force_abort(kcs_bmc);
-			kcs_bmc->error = KCS_LENGTH_ERROR;
-		}
+		if (kcs_bmc->data_len >= KCS_MSG_BUFSIZ)
+			return kcs_force_abort(kcs_bmc, KCS_LENGTH_ERROR);
+		kcs_bmc->data[kcs_bmc->data_len++] =
+			kcs_bmc->read_data_in(kcs_bmc);
+		kcs_bmc->write_data_out(kcs_bmc, 0);
 		break;
 
-	case KCS_PHASE_WRITE_END_CMD:
-		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
-			set_state(kcs_bmc, READ_STATE);
-			kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
-						kcs_bmc->read_data_in(kcs_bmc);
-			kcs_bmc->phase = KCS_PHASE_WRITE_DONE;
-			kcs_bmc->data_in_avail = true;
-			wake_up_interruptible(&kcs_bmc->queue);
-		} else {
-			kcs_force_abort(kcs_bmc);
-			kcs_bmc->error = KCS_LENGTH_ERROR;
-		}
+	case KCS_PHASE_WRITE_END:
+		if (kcs_bmc->data_len < 1 && kcs_bmc->data_len >= KCS_MSG_BUFSIZ)
+			return kcs_force_abort(kcs_bmc, KCS_LENGTH_ERROR);
+		kcs_bmc->phase = KCS_PHASE_WRITE_DONE;
+		kcs_set_state(kcs_bmc, KCS_STATE_READ);
+		kcs_bmc->data[kcs_bmc->data_len++] =
+			kcs_bmc->read_data_in(kcs_bmc);
+		wake_up_interruptible(&kcs_bmc->read_ready);
 		break;
 
 	case KCS_PHASE_READ:
-		if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len)
-			set_state(kcs_bmc, IDLE_STATE);
-
-		data = kcs_bmc->read_data_in(kcs_bmc);
-		if (data != KCS_CMD_READ_BYTE) {
-			set_state(kcs_bmc, ERROR_STATE);
-			kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
-			break;
-		}
-
-		if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len) {
-			kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
+		if (kcs_bmc->data_idx >= kcs_bmc->data_len) {
 			kcs_bmc->phase = KCS_PHASE_IDLE;
-			break;
+			kcs_set_state(kcs_bmc, KCS_STATE_IDLE);
 		}
-
-		kcs_bmc->write_data_out(kcs_bmc,
-			kcs_bmc->data_out[kcs_bmc->data_out_idx++]);
+		if (kcs_bmc->read_data_in(kcs_bmc) != KCS_DATA_READ_BYTE)
+			return kcs_force_abort(kcs_bmc, KCS_UNSPECIFIED_ERROR);
+		kcs_pump_data_out(kcs_bmc);
 		break;
 
-	case KCS_PHASE_ABORT_ERROR1:
-		set_state(kcs_bmc, READ_STATE);
-		kcs_bmc->read_data_in(kcs_bmc);
+	case KCS_PHASE_ABORT:
+		kcs_set_state(kcs_bmc, KCS_STATE_READ);
+		if (kcs_bmc->read_data_in(kcs_bmc) != 0)
+			return kcs_force_abort(kcs_bmc, KCS_UNSPECIFIED_ERROR);
+		kcs_bmc->phase = KCS_PHASE_READ;
+		kcs_bmc->data_len = 0;
 		kcs_bmc->write_data_out(kcs_bmc, kcs_bmc->error);
-		kcs_bmc->phase = KCS_PHASE_ABORT_ERROR2;
-		break;
-
-	case KCS_PHASE_ABORT_ERROR2:
-		set_state(kcs_bmc, IDLE_STATE);
-		kcs_bmc->read_data_in(kcs_bmc);
-		kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
-		kcs_bmc->phase = KCS_PHASE_IDLE;
 		break;
 
 	default:
-		kcs_force_abort(kcs_bmc);
+		kcs_force_abort(kcs_bmc, KCS_UNSPECIFIED_ERROR);
 		break;
 	}
 }
@@ -150,40 +118,32 @@ static void kcs_bmc_handle_cmd(struct kcs_bmc *kcs_bmc)
 {
 	u8 cmd;
 
-	set_state(kcs_bmc, WRITE_STATE);
-	kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
-
+	kcs_set_state(kcs_bmc, KCS_STATE_WRITE);
 	cmd = kcs_bmc->read_data_in(kcs_bmc);
+	kcs_bmc->write_data_out(kcs_bmc, 0);
+
 	switch (cmd) {
 	case KCS_CMD_WRITE_START:
-		kcs_bmc->phase = KCS_PHASE_WRITE_START;
-		kcs_bmc->error = KCS_NO_ERROR;
-		kcs_bmc->data_in_avail = false;
-		kcs_bmc->data_in_idx = 0;
+		if (kcs_bmc->phase != KCS_PHASE_IDLE)
+			return kcs_force_abort(kcs_bmc, KCS_UNSPECIFIED_ERROR);
+		kcs_bmc->phase = KCS_PHASE_WRITE_DATA;
+		kcs_bmc->data_len = 0;
 		break;
 
 	case KCS_CMD_WRITE_END:
-		if (kcs_bmc->phase != KCS_PHASE_WRITE_DATA) {
-			kcs_force_abort(kcs_bmc);
-			break;
-		}
-
-		kcs_bmc->phase = KCS_PHASE_WRITE_END_CMD;
+		if (kcs_bmc->phase != KCS_PHASE_WRITE_DATA)
+			return kcs_force_abort(kcs_bmc, KCS_UNSPECIFIED_ERROR);
+		kcs_bmc->phase = KCS_PHASE_WRITE_END;
 		break;
 
 	case KCS_CMD_GET_STATUS_ABORT:
-		if (kcs_bmc->error == KCS_NO_ERROR)
+		if (kcs_bmc->phase != KCS_PHASE_ERROR)
 			kcs_bmc->error = KCS_ABORTED_BY_COMMAND;
-
-		kcs_bmc->phase = KCS_PHASE_ABORT_ERROR1;
-		kcs_bmc->data_in_avail = false;
-		kcs_bmc->data_in_idx = 0;
+		kcs_bmc->phase = KCS_PHASE_ABORT;
 		break;
 
 	default:
-		kcs_force_abort(kcs_bmc);
-		kcs_bmc->error = KCS_ILLEGAL_CONTROL_CODE;
-		break;
+		kcs_force_abort(kcs_bmc, KCS_ILLEGAL_CONTROL_CODE);
 	}
 }
 
@@ -198,8 +158,8 @@ irqreturn_t kcs_bmc_irq(int irq, void *arg)
 
 	status = kcs_bmc->read_status(kcs_bmc);
 	if (status & KCS_STATUS_IBF) {
-		if (!kcs_bmc->running)
-			kcs_force_abort(kcs_bmc);
+		if (!kcs_bmc->open)
+			kcs_force_abort(kcs_bmc, KCS_NO_ERROR);
 		else if (status & KCS_STATUS_CMD_DAT)
 			kcs_bmc_handle_cmd(kcs_bmc);
 		else
@@ -218,30 +178,15 @@ static inline struct kcs_bmc *to_kcs_bmc(struct file *filp)
 	return container_of(filp->private_data, struct kcs_bmc, miscdev);
 }
 
-static int kcs_bmc_open(struct inode *inode, struct file *filp)
-{
-	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
-	int ret = 0;
-
-	spin_lock_irq(&kcs_bmc->lock);
-	if (!kcs_bmc->running)
-		kcs_bmc->running = 1;
-	else
-		ret = -EBUSY;
-	spin_unlock_irq(&kcs_bmc->lock);
-
-	return ret;
-}
-
 static __poll_t kcs_bmc_poll(struct file *filp, poll_table *wait)
 {
 	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 	__poll_t mask = 0;
 
-	poll_wait(filp, &kcs_bmc->queue, wait);
+	poll_wait(filp, &kcs_bmc->read_ready, wait);
 
 	spin_lock_irq(&kcs_bmc->lock);
-	if (kcs_bmc->data_in_avail)
+	if (kcs_bmc->phase == KCS_PHASE_WRITE_DONE)
 		mask |= EPOLLIN;
 	spin_unlock_irq(&kcs_bmc->lock);
 
@@ -252,57 +197,36 @@ static ssize_t kcs_bmc_read(struct file *filp, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
-	bool data_avail;
-	size_t data_len;
+	u8 data_in[KCS_MSG_BUFSIZ];
 	ssize_t ret;
 
-	if (!(filp->f_flags & O_NONBLOCK))
-		wait_event_interruptible(kcs_bmc->queue,
-					 kcs_bmc->data_in_avail);
-
-	mutex_lock(&kcs_bmc->mutex);
-
 	spin_lock_irq(&kcs_bmc->lock);
-	data_avail = kcs_bmc->data_in_avail;
-	if (data_avail) {
-		data_len = kcs_bmc->data_in_idx;
-		memcpy(kcs_bmc->kbuffer, kcs_bmc->data_in, data_len);
-	}
-	spin_unlock_irq(&kcs_bmc->lock);
 
-	if (!data_avail) {
-		ret = -EAGAIN;
-		goto out_unlock;
+	while (kcs_bmc->phase != KCS_PHASE_WRITE_DONE) {
+		if (filp->f_flags & O_NONBLOCK) {
+			spin_unlock_irq(&kcs_bmc->lock);
+			return -EAGAIN;
+		}
+		ret = wait_event_interruptible_lock_irq(kcs_bmc->read_ready,
+					 kcs_bmc->phase == KCS_PHASE_WRITE_DONE, kcs_bmc->lock);
+		if (ret) {
+			spin_unlock_irq(&kcs_bmc->lock);
+			return ret;
+		}
 	}
 
-	if (count < data_len) {
-		spin_lock_irq(&kcs_bmc->lock);
-		kcs_force_abort(kcs_bmc);
+	if (kcs_bmc->data_len > count) {
 		spin_unlock_irq(&kcs_bmc->lock);
-
-		ret = -EOVERFLOW;
-		goto out_unlock;
+		return -EOVERFLOW;
 	}
 
-	if (copy_to_user(buf, kcs_bmc->kbuffer, data_len)) {
-		ret = -EFAULT;
-		goto out_unlock;
-	}
-
-	ret = data_len;
-
-	spin_lock_irq(&kcs_bmc->lock);
-	if (kcs_bmc->phase == KCS_PHASE_WRITE_DONE) {
-		kcs_bmc->phase = KCS_PHASE_WAIT_READ;
-		kcs_bmc->data_in_avail = false;
-		kcs_bmc->data_in_idx = 0;
-	} else {
-		ret = -EAGAIN;
-	}
+	ret = kcs_bmc->data_len;
+	memcpy(data_in, kcs_bmc->data, kcs_bmc->data_len);
+	kcs_bmc->phase = KCS_PHASE_WAIT_READ;
 	spin_unlock_irq(&kcs_bmc->lock);
 
-out_unlock:
-	mutex_unlock(&kcs_bmc->mutex);
+	if (copy_to_user(buf, data_in, ret))
+		return -EFAULT;
 
 	return ret;
 }
@@ -312,34 +236,28 @@ static ssize_t kcs_bmc_write(struct file *filp, const char __user *buf,
 {
 	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 	ssize_t ret;
+	u8 data_out[KCS_MSG_BUFSIZ];
 
 	/* a minimum response size '3' : netfn + cmd + ccode */
-	if (count < 3 || count > KCS_MSG_BUFSIZ)
+	if (count < 3 || count > sizeof(data_out))
 		return -EINVAL;
 
-	mutex_lock(&kcs_bmc->mutex);
-
-	if (copy_from_user(kcs_bmc->kbuffer, buf, count)) {
-		ret = -EFAULT;
-		goto out_unlock;
-	}
+	if (copy_from_user(data_out, buf, count))
+		return -EFAULT;
 
 	spin_lock_irq(&kcs_bmc->lock);
 	if (kcs_bmc->phase == KCS_PHASE_WAIT_READ) {
 		kcs_bmc->phase = KCS_PHASE_READ;
-		kcs_bmc->data_out_idx = 1;
-		kcs_bmc->data_out_len = count;
-		memcpy(kcs_bmc->data_out, kcs_bmc->kbuffer, count);
-		kcs_bmc->write_data_out(kcs_bmc, kcs_bmc->data_out[0]);
+		memcpy(kcs_bmc->data, data_out, count);
+		kcs_bmc->data_idx = 0;
+		kcs_bmc->data_len = count;
+		kcs_pump_data_out(kcs_bmc);
 		ret = count;
 	} else {
-		ret = -EINVAL;
+		ret = -EBUSY;
 	}
 	spin_unlock_irq(&kcs_bmc->lock);
 
-out_unlock:
-	mutex_unlock(&kcs_bmc->mutex);
-
 	return ret;
 }
 
@@ -350,27 +268,42 @@ static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
 	long ret = 0;
 
 	spin_lock_irq(&kcs_bmc->lock);
-
 	switch (cmd) {
 	case IPMI_BMC_IOCTL_SET_SMS_ATN:
-		update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN,
-				   KCS_STATUS_SMS_ATN);
+		kcs_update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN,
+				KCS_STATUS_SMS_ATN);
 		break;
 
 	case IPMI_BMC_IOCTL_CLEAR_SMS_ATN:
-		update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN,
-				   0);
+		kcs_update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN, 0);
 		break;
 
 	case IPMI_BMC_IOCTL_FORCE_ABORT:
-		kcs_force_abort(kcs_bmc);
+		kcs_force_abort(kcs_bmc, KCS_NO_ERROR);
 		break;
 
 	default:
 		ret = -EINVAL;
 		break;
 	}
+	spin_unlock_irq(&kcs_bmc->lock);
 
+	return ret;
+}
+
+static int kcs_bmc_open(struct inode *inode, struct file *filp)
+{
+	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
+	int ret = 0;
+
+	spin_lock_irq(&kcs_bmc->lock);
+	if (kcs_bmc->open) {
+		ret = -EBUSY;
+	} else {
+		kcs_bmc->open = true;
+		kcs_update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN, 0);
+		kcs_force_abort(kcs_bmc, KCS_NO_ERROR);
+	}
 	spin_unlock_irq(&kcs_bmc->lock);
 
 	return ret;
@@ -381,8 +314,9 @@ static int kcs_bmc_release(struct inode *inode, struct file *filp)
 	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 
 	spin_lock_irq(&kcs_bmc->lock);
-	kcs_bmc->running = 0;
-	kcs_force_abort(kcs_bmc);
+	kcs_bmc->open = false;
+	kcs_update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN, 0);
+	kcs_force_abort(kcs_bmc, KCS_NO_ERROR);
 	spin_unlock_irq(&kcs_bmc->lock);
 
 	return 0;
@@ -403,12 +337,9 @@ int kcs_bmc_init(struct kcs_bmc *kcs_bmc, struct device *dev, u32 channel)
 	int rc;
 
 	spin_lock_init(&kcs_bmc->lock);
-	mutex_init(&kcs_bmc->mutex);
-	init_waitqueue_head(&kcs_bmc->queue);
+	init_waitqueue_head(&kcs_bmc->read_ready);
 
-	kcs_bmc->data_in = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	kcs_bmc->data_out = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	kcs_bmc->kbuffer = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
+	kcs_bmc->open = false;
 
 	kcs_bmc->miscdev.fops = &kcs_bmc_fops;
 	kcs_bmc->miscdev.minor = MISC_DYNAMIC_MINOR;
diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
index d65ffd479e9b..48c4fa8772d7 100644
--- a/drivers/char/ipmi/kcs_bmc.h
+++ b/drivers/char/ipmi/kcs_bmc.h
@@ -8,42 +8,37 @@
 
 #include <linux/irqreturn.h>
 #include <linux/miscdevice.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
 
 /* Different phases of the KCS BMC module.
  *  KCS_PHASE_IDLE:
  *            BMC should not be expecting nor sending any data.
- *  KCS_PHASE_WRITE_START:
- *            BMC is receiving a WRITE_START command from system software.
  *  KCS_PHASE_WRITE_DATA:
  *            BMC is receiving a data byte from system software.
- *  KCS_PHASE_WRITE_END_CMD:
+ *  KCS_PHASE_WRITE_END:
  *            BMC is waiting a last data byte from system software.
  *  KCS_PHASE_WRITE_DONE:
- *            BMC has received the whole request from system software.
+ *            BMC is waiting to send request to the upper IPMI service.
  *  KCS_PHASE_WAIT_READ:
  *            BMC is waiting the response from the upper IPMI service.
  *  KCS_PHASE_READ:
  *            BMC is transferring the response to system software.
- *  KCS_PHASE_ABORT_ERROR1:
+ *  KCS_PHASE_ABORT:
  *            BMC is waiting error status request from system software.
- *  KCS_PHASE_ABORT_ERROR2:
- *            BMC is waiting for idle status afer error from system software.
  *  KCS_PHASE_ERROR:
  *            BMC has detected a protocol violation at the interface level.
  */
 enum kcs_phases {
 	KCS_PHASE_IDLE,
 
-	KCS_PHASE_WRITE_START,
 	KCS_PHASE_WRITE_DATA,
-	KCS_PHASE_WRITE_END_CMD,
+	KCS_PHASE_WRITE_END,
 	KCS_PHASE_WRITE_DONE,
-
 	KCS_PHASE_WAIT_READ,
 	KCS_PHASE_READ,
 
-	KCS_PHASE_ABORT_ERROR1,
-	KCS_PHASE_ABORT_ERROR2,
+	KCS_PHASE_ABORT,
 	KCS_PHASE_ERROR
 };
 
@@ -56,36 +51,24 @@ enum kcs_errors {
 	KCS_UNSPECIFIED_ERROR       = 0xFF
 };
 
-/* IPMI 2.0 - 9.5, KCS Interface Registers
- * @idr: Input Data Register
- * @odr: Output Data Register
- * @str: Status Register
- */
-struct kcs_bmc {
-	spinlock_t lock;
-
-	int running;
+#define KCS_MSG_BUFSIZ    960
 
+struct kcs_bmc {
 	/* Setup by BMC KCS controller driver */
 	u8 (*read_status)(struct kcs_bmc *kcs_bmc);
 	void (*write_status)(struct kcs_bmc *kcs_bmc, u8 b);
 	u8 (*read_data_in)(struct kcs_bmc *kcs_bmc);
 	void (*write_data_out)(struct kcs_bmc *kcs_bmc, u8 b);
 
+	spinlock_t lock;
+	wait_queue_head_t read_ready;
+
+	bool open;
 	enum kcs_phases phase;
 	enum kcs_errors error;
-
-	wait_queue_head_t queue;
-	bool data_in_avail;
-	int  data_in_idx;
-	u8  *data_in;
-
-	int  data_out_idx;
-	int  data_out_len;
-	u8  *data_out;
-
-	struct mutex mutex;
-	u8 *kbuffer;
+	u8 data[KCS_MSG_BUFSIZ];
+	size_t data_idx;
+	size_t data_len;
 
 	struct miscdevice miscdev;
 };
-- 
2.30.0.478.g8a0d178c01-goog

