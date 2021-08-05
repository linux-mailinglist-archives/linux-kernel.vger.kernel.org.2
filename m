Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB3A3E1853
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbhHEPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43638 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242282AbhHEPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:30 -0400
Message-ID: <20210805153953.270134895@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vwehnuXDeImKsjZ4mWbe7dd6/xJMgVJeOod7/h8jtVk=;
        b=FH0lcR52zm00cQUlVtw5uiMudmSlV3BZa1waFw8+VfLJWRiwE3ug9b4uPKS3RbGuYPy6yO
        SwZIcoZxhbvbZ5iUP46qYvNhrEKPx6EYiXqe9J50ICorWJ/zFTscKyFRT36LSiU4Oxaq9B
        pDILQwA3xSFZEDXWFyR88g2DOjx90pFZJBFojues2oRRennM3HjTk4SdF+fhy2x/ST1ryo
        Rvb4hBP+sm3jThIvOEzwnwe46S09KqecQQf0ZMshuttKqCJAt6oPYRNBV7fHZGGYVFr5N6
        UdrSzjvwAvegzQ4QTt67B1ChyXfqowCIJX+F2FTvpB6ErdmFmZ5p+U9VS96flQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vwehnuXDeImKsjZ4mWbe7dd6/xJMgVJeOod7/h8jtVk=;
        b=irP8A54u4LP0RupLpeos2RXmR+EYNSYcONaOSOU+hsgK4BDtsyXqYujENj5VyJzfe3O0gK
        KJRqGejLUbGehwDQ==
Date:   Thu, 05 Aug 2021 17:13:08 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V3 08/64] media/atomisp: Use lockdep instead of *mutex_is_locked()
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Subject: [patch V3 08/64] media/atomisp: Use lockdep instead of *mutex_is_locked()

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

