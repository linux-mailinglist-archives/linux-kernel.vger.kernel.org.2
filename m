Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47738428AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhJKKpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhJKKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:45:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DABC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 03:43:01 -0700 (PDT)
Date:   Mon, 11 Oct 2021 12:42:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633948979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQZKyD/lIPAGKb60VxQ7ByQVmg9mZPtbvQcoBA6951U=;
        b=iYvcF+X3acZriOjfxO5mfJl4yge9Pl0lBW8efXT7OfZHJU4XjThpxAZ/HvTB4L3+t2qcB+
        K3ya/BgcuZPwjjky6NxzXozJXey9LVHQVTc4KQrdd3VQAfwucUTzE/3Z//T4ULgW7nwzNJ
        uK9L4Epi7nIBgtreAxzPp0+uO+XlAR5XJOwwuytaUA3Ye7m3UKfcJgEPtdaD5pVr9WBfvr
        inQi0qJ9KOgRNoV4hEW9o5AQ52z+x8f3WbUD8LteknEIigsEGiMoP+lNNHSuXL1UVUCqpe
        N6gTexQIb9ihW+tTffeEIvMuXV3/kUYqhTHpKGYleH3k7DteTbqHxJ5xkybsig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633948979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQZKyD/lIPAGKb60VxQ7ByQVmg9mZPtbvQcoBA6951U=;
        b=sReWmHb494X3TDOIg8+mrXBZWincIH2Ru6LthZS+k/VjRZXYZSOqjwispIApR/BqJB9pHH
        owG3Ww+64O1dCjAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rt-devel:linux-5.15.y-rt-rebase 85/155]
 drivers/md/raid5.c:2222:20: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <20211011104257.tyxo5pm4jln3a7ng@linutronix.de>
References: <202110092249.dDmDslZ6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202110092249.dDmDslZ6-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-09 22:20:57 [+0800], kernel test robot wrote:
> sparse warnings: (new ones prefixed by >>)
> >> drivers/md/raid5.c:2222:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __percpu * @@
>    drivers/md/raid5.c:2222:20: sparse:     expected struct spinlock [usertype] *lock
>    drivers/md/raid5.c:2222:20: sparse:     got struct spinlock [noderef] __percpu *
>    drivers/md/raid5.c:2281:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __percpu * @@
>    drivers/md/raid5.c:2281:22: sparse:     expected struct spinlock [usertype] *lock
>    drivers/md/raid5.c:2281:22: sparse:     got struct spinlock [noderef] __percpu *

I think the code itself is correct but sparse got confused by the
definition of the struct. Defining raid5_percpu on its own makes the
warning go away:

diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -559,6 +559,17 @@ struct r5pending_data {
 	struct bio_list bios;
 };
 
+/* per cpu variables */
+struct raid5_percpu {
+	spinlock_t	lock;		/* Protection for -RT */
+	struct page	*spare_page; /* Used when checking P/Q in raid6 */
+	void		*scribble;  /* space for constructing buffer
+				     * lists and performing address
+				     * conversions
+				     */
+	int scribble_obj_size;
+};
+
 struct r5conf {
 	struct hlist_head	*stripe_hashtbl;
 	/* only protect corresponding hash list and inactive_list */
@@ -634,15 +645,7 @@ struct r5conf {
 					    */
 	int			recovery_disabled;
 	/* per cpu variables */
-	struct raid5_percpu {
-		spinlock_t	lock;		/* Protection for -RT */
-		struct page	*spare_page; /* Used when checking P/Q in raid6 */
-		void		*scribble;  /* space for constructing buffer
-					     * lists and performing address
-					     * conversions
-					     */
-		int scribble_obj_size;
-	} __percpu *percpu;
+	struct raid5_percpu	__percpu *percpu;
 	int scribble_disks;
 	int scribble_sectors;
 	struct hlist_node node;

The RCU warnings look valid since there are __rcu annotations.

Sebastian
