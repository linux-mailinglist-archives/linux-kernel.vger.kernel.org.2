Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078AF3E90AF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbhHKMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbhHKMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:04 -0400
Message-ID: <20210811121414.607674736@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Tm2qJv6M2HHUN5mTudc04ti4cTP5D1ZxP2EQ6uzJEys=;
        b=u6sVLa/+cO+x9Ol9HjALW4dnEIr0in7ytioPO0xlDf7g3BxzahHlwQUCxbmKz/O9pItrEH
        BDSLAk4ue7jwwu9uWRM33EcuBjd+FhvbdAKJt/iIu9HYpoAIeXcQ8Oik4vi0OyhzkFugt1
        N6FLJDeK6zkyMqm7KPffYN+Y7dFFAnhO4+uRx1P3e76OXE71u7t8H3HDv2qin76cYQYfkl
        2NLhoVJ2H+giq3m0YNAYMIRAXO/83VDNtJD66btmDrg4qwo9oBOo37Lv5mS9js/oFlmN1J
        9oVB0YJE76Z5AadHc2IhfCw+DydPZELI/PlIO9Co7598fZUeRjBY0vc/RjiNPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Tm2qJv6M2HHUN5mTudc04ti4cTP5D1ZxP2EQ6uzJEys=;
        b=Y9eL26/jJODVCkorH+3zdZz0Z+EoFZpi9sRfvc83+Y/RyovChY1MjopazThWf/Aji0GGJ4
        JYftyCFv1IGxJRCg==
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
Subject: [patch V4 08/68] media/atomisp: Use lockdep instead of *mutex_is_locked()
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:40 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Subject: [patch V4 08/68] media/atomisp: Use lockdep instead of *mutex_is_locked()

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

