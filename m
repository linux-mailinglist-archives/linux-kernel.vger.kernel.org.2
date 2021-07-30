Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F933DBA3B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbhG3OUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbhG3ORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA8EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:11 -0700 (PDT)
Message-ID: <20210730135205.550252060@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pPXtcbzBpx2WvpEzmNy/XF7HmoJ4t1PwQYsNJ8K7yPM=;
        b=16Umbro/HSG5sNFVfc2yM87JUXA2RdOTL2uvqymC3fBdCLyn+FBjvsRfjMQv3jZEoQ2frk
        TuclOLd77OrB/QBcWD/yKq3azVkB5qohctTBHAspnjMSZkh9nnLypIVOSSQB1xKcZGYcLt
        6fLfNvVwW8KaaXIdVQ7VNQTxn/zch8ZsvkMVIkTxx5yIz82FCWUisZSBFMU71qDeTJBVUr
        6rZJJ+qdaLUHh6vejLZ36kfwd00a1/kgrgaAvnrf1LviMV0zqBWMeSlKRtVfTIu/jfsXZh
        EW5T0w/NImwAYtligyfG7nRLnXHkcKsH+bryyOyTmMTwLkaPHtZWnvLSEnmO1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pPXtcbzBpx2WvpEzmNy/XF7HmoJ4t1PwQYsNJ8K7yPM=;
        b=CZXVe/xOyi+5BvMmNnp41in17OAx30hPsG/1WPollv/yOlHXOm+YaGKFRJ/CqxJNI9cWM6
        Oopuav6ntLf6CiCA==
Date:   Fri, 30 Jul 2021 15:50:14 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 07/63] media/atomisp: Use lockdep instead of *mutex_is_locked()
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Subject: [patch 07/63] media/atomisp: Use lockdep instead of *mutex_is_locked()

The only user of rt_mutex_is_locked() is an anti-pattern, remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210714100719.GA11408@worktop.programming.kicks-ass.net
---

---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1904,8 +1904,8 @@ int __atomisp_streamoff(struct file *fil
 	dev_dbg(isp->dev, "Stop stream on pad %d for asd%d\n",
 		atomisp_subdev_source_pad(vdev), asd->index);
 
-	BUG_ON(!rt_mutex_is_locked(&isp->mutex));
-	BUG_ON(!mutex_is_locked(&isp->streamoff_mutex));
+	lockdep_assert_held(&isp->mutex);
+	lockdep_assert_held(&isp->streamoff_mutex);
 
 	if (type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		dev_dbg(isp->dev, "unsupported v4l2 buf type\n");

