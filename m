Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A0426765
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbhJHKIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbhJHKIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:08:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84CC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 03:06:15 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s17so4888778ioa.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1xe7HVmwnAm2hY4m4BiIkGINzGUhNv9G0AmFY+7sdk=;
        b=gUfPViGAbhbk3pdt8KL592Lt6ClO0cTh0yyS3O8LnjcrhhnCae99bbNcIuCqRDvHfM
         7dbsD4iibYpsFNqam6Amqi9IEgiDe5yf5dwd23I6NhjwxCg6U/vfW2YHArSxFN9sKqo/
         nZEE7OgTMt+ttEzcIh9yj7gCNtyvhxXNFkyQuzgxufZ+dPGzhtK+PUVh/AukWSrThxLH
         z65hJv2xowWXBBOr8+QgKYdX9Ko4hKV0sWUnziw23Xj2u2XwTpAg+Kkx8s9XwuNNkou5
         75I5BY1sk1oyNQSmz6vdqL9B0SmD9dxeOrDjDPpLvBzTZfnhgHGksCBC+Bk5T3bvzR/o
         iWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1xe7HVmwnAm2hY4m4BiIkGINzGUhNv9G0AmFY+7sdk=;
        b=O5xI7VFBBp+VeXUN+jV4g3VUk1YJpjj3fAAw7OUDEZttdtsWfRGNSPkHQnIpTM0AOO
         Qcd3zPQYXLcvvm9FRd2jW/O/A/OoYB0IKlrZrEMCS36h/u6I0Zumwc4nZ8eCE+fBgolr
         xq3Z/LKd12hTF3PvYk63eV+yaDsKdRQGTYwFW5ahZxAVKkJJQOt7Yj551a0W08MdSF5w
         oT8dn0zoloaxU3yqbEnKncWxvZLavbJPYB2IhreFFD1LC5huW30NHWsymlaEWqLQANuI
         Lt+cjpvZ+kA5xYATdjEfDCsZK70xIBKNQAXYOuV6+LrimUftQ3kaqLk8ErAOxGHJP/Rj
         giYQ==
X-Gm-Message-State: AOAM530ih8/eZv4lKaca5xhSOaBioZyJbYzkMbB/3Mfz5XGxiAW+jeCv
        5MTKvbefG0bx5RRLARj1n90=
X-Google-Smtp-Source: ABdhPJyl1mGS2rwKZJRwm/wjcD2IPss6EFpSvzNkGu52+dvH70f4eIZ0molZZqSQmcYRlLhOyqJE4w==
X-Received: by 2002:a05:6602:3417:: with SMTP id n23mr6836333ioz.205.1633687574967;
        Fri, 08 Oct 2021 03:06:14 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w23sm779577iow.10.2021.10.08.03.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 03:06:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C410F27C0054;
        Fri,  8 Oct 2021 06:06:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 08 Oct 2021 06:06:10 -0400
X-ME-Sender: <xms:EhhgYSgMJ6U73VlcVkoU8FOXRtcBDPig6P7etp9zPx9H2R6dCnYcIg>
    <xme:EhhgYTA5YpNP3nNmLz64HMGz2OSt9tREOlq69G8IEoSBQxiXr8v2xuO7RPDbXCtR1
    R2r1feDVykLQLAK2w>
X-ME-Received: <xmr:EhhgYaHR008VN_pFMcbRFHHK4zMFSgCGVXqBLOskTaH6FZe_-GPYpxZq0XkROg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddttddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:EhhgYbRT1m6eqIWWeVuzS_Yd-lIrtsxbS9v4T8HLbGr8pgxS-0YRKQ>
    <xmx:EhhgYfwfqT66rDh3LDV8MC_cIB0BWDlYEkesu4IPba4Q38T09w1GqA>
    <xmx:EhhgYZ6i9SU0NzBGnMcM5SaLYkJGVpDwL4uRA8fwi43UQtGZe1Mkfw>
    <xmx:EhhgYWnLj2rCzyh848Q6gEIWLj_UK9DckyZnKajkXcMVEM0ULG8m4Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Oct 2021 06:06:10 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 2/2] workqueue: Fix work re-entrance when requeue to a different workqueue
Date:   Fri,  8 Oct 2021 18:04:54 +0800
Message-Id: <20211008100454.2802393-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211008100454.2802393-1-boqun.feng@gmail.com>
References: <20211008100454.2802393-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When requeuing a work to a different workqueue while it's still getting
processed, re-entrace as the follow can happen:

	{ both WQ1 and WQ2 are bounded workqueue, and a work W has been
	  queued on CPU0 for WQ1}

	CPU 0			CPU 1
	=====			====
	<In worker on CPU 0>
	process_one_work():
	  ...
	  // pick up W
	  worker->current_work = W;
	  worker->current_func = W->func;
	  ...
	  set_work_pool_and_clear_pending(...);
	  // W can be requeued afterwards
				queue_work_on(1, WQ2, W):
				  if (!test_and_set_bit(...)) {
				    // this branch is taken, as CPU 0
				    // just clears pending bit.
				    __queue_work(...):
				      pwq = <pool for CPU1 of WQ2>;
				      last_pool = <pool for CPU 0 of WQ1>;
				      if (last_pool != pwq->pool) { // true
				        if (.. && worker->current_pwq->wq == wq) {
					  // false, since @worker is a
					  // a worker of @last_pool (for
					  // WQ1), and @wq is WQ2.
					}
					...
					insert_work(pwq, W, ...);
				      }
				// W queued.
				<schedule to worker on CPU 1>
				process_one_work():
				  collision = find_worker_executing_work(..);
				  // NULL, because we're searching the
				  // worker pool of CPU 1, while W is
				  // the current work on worker pool of
				  // CPU 0.
				  worker->current_work = W;
				  worker->current_func = W->func;
	  worker->current_func(...);
	  			  ...
	  			  worker->current_func(...); // Re-entrance

This issue is already partially fixed because in queue_work_on(),
last_pool can be used to queue the work, as a result the requeued work
processing will find the collision and wait for the existing one to
finish. However, currently the last_pool is only used when two
workqueues are the same one, which causes the issue. Therefore extend
the behavior to allow last_pool to requeue the work W even if the
workqueues are different. It's safe to do this since the work W has been
proved safe to queue and run on the last_pool.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1418710bffcd..410141cc5f88 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1465,7 +1465,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 
 		worker = find_worker_executing_work(last_pool, work);
 
-		if (worker && worker->current_pwq->wq == wq) {
+		if (worker) {
 			pwq = worker->current_pwq;
 		} else {
 			/* meh... not running there, queue here */
-- 
2.32.0

