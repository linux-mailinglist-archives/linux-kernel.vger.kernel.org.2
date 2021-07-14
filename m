Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260333C826D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhGNKK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbhGNKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:10:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B50C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sAxjfTG2GJC/s5nT5UCMc4SIWzoYq07R90S/8qWy2PI=; b=LAixe5+dGQCMmTBzBHw1iovQm6
        FNR61J94zQSXeCpdQ2ou6USqJsgJlaH/D/CxDiIYHsrvGaDo4eMzIdJVYZVNhBv6nShJVAaHeQ58y
        Nbsxbr2nFRK+nFp1jHwApFpmsbMwTUSmQUVHgbIVIuuLQoXOX5uXC8XDM8SWWBJ51niOsqTD9pun8
        ad8NTwUu8YeDvS4eNFd/hLEXieK7ZF1YhDIeLfHCePNmfq4u25fBzJWtsphY37DYpJ/BjLPlz+NyK
        mAJNBbBzAEam1hzDLCkzYfCxxS85zNEhDDgHeyYDp2dzMn2oDhiIdedZ7zNBfhvkfvnF+3fIm0Z23
        tJA3rvMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3bnT-00HS2j-S5; Wed, 14 Jul 2021 10:07:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F1F298689D; Wed, 14 Jul 2021 12:07:19 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:07:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>, mchehab+huawei@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] media/atomisp: Use lockdep instead of *mutex_is_locked()
Message-ID: <20210714100719.GA11408@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160748.288862984@linutronix.de>
 <20210714095458.GF2725@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714095458.GF2725@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 11:54:58AM +0200, Peter Zijlstra wrote:
> @@ -67,17 +71,6 @@ do { \
>  #define DEFINE_RT_MUTEX(mutexname) \
>  	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
>  
> -/**
> - * rt_mutex_is_locked - is the mutex locked
> - * @lock: the mutex to be queried
> - *
> - * Returns 1 if the mutex is locked, 0 if unlocked.
> - */
> -static inline int rt_mutex_is_locked(struct rt_mutex *lock)
> -{
> -	return lock->owner != NULL;
> -}
> -

---
Subject: media/atomisp: Use lockdep instead of *mutex_is_locked()

The only user of rt_mutex_is_locked() is an anti-pattern, remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index 6f5fe5092154..c8a625667e81 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1904,8 +1904,8 @@ int __atomisp_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	dev_dbg(isp->dev, "Stop stream on pad %d for asd%d\n",
 		atomisp_subdev_source_pad(vdev), asd->index);
 
-	BUG_ON(!rt_mutex_is_locked(&isp->mutex));
-	BUG_ON(!mutex_is_locked(&isp->streamoff_mutex));
+	lockdep_assert_held(&isp->mutex);
+	lockdep_assert_held(&isp->streamoff_mutex);
 
 	if (type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		dev_dbg(isp->dev, "unsupported v4l2 buf type\n");
