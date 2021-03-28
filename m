Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7129F34BC0D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 12:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhC1K3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhC1K2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 06:28:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AAFC061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 03:28:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o16so9972709wrn.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9C9o0jI1d0iLQkL79YD70gp+AFS7VFL+EskN1VJqDG0=;
        b=fYIF89zxs+oQtyeJUQxasTVn3VmpxnaABwQ3GvLeBtVGUqpe5PJteLOjM1pgKTZMBi
         tMw6IeIZ5KbhO8E07B6tVn0HWsvr8ltTxNOfuA++3O/9tkCeHpZCSgbR/iMQ+V6CuJeV
         +mymyf2KigkgCpcGZXfoEkk4SHeG3GsqRI/mKM27ZmoXSIQDDnataQk7IBKlbBFuZEei
         tMAtq+EX5ulBIinQriZXuTv09cPtZkczpmvwRjwFeAbX/mFC0GtStSJhr1neNn9b7mAn
         IGdyHHJ1EYhPPmhJ+ZRvALC5QDWlMs4+8KYsF+yqRX/GoWgYBikMojL0hyKnkoHeMXp2
         mJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=9C9o0jI1d0iLQkL79YD70gp+AFS7VFL+EskN1VJqDG0=;
        b=b9tiU77pCJnSO1r5n3R72YOqhS1QzKn+IZPGWk8/3NnlqkgxfGXh5ZBbwAMN0wK9cP
         hH+okxJNpES/mLjZ7ll4m5qUosUcI0dTKle560r7KluwQB3rJOONYqsTJVuIjTM1OREP
         7oFQoukDwvdoEM2J2urVcSfdyKbkKytFX0N1y7iuSxzueeKc1FM3R73d66tyVfyGYewh
         nvvs4kPWWioWVy5XfZcTvvXZumw6zpaqVhjDmyHGvQIz3rpKfJuVv8HJ0hC8M8AJeI/d
         HHQ8ng0cQh4Mz4yleYzIonv0lqMSjzeppJ5F7JJqlK7Hqi9K1i9zrEzb5We7ZA3fJTKO
         Fd+g==
X-Gm-Message-State: AOAM53367TqwnmZRwehsfcypYWXUEgRLBSu6Kr2QXm0vwPOWJYC36Kfa
        vbqiRazQ7Cx79Rm59a5aTQurRJY9uEc=
X-Google-Smtp-Source: ABdhPJyOZntSIiGc9AiYArBi9IKvtuarwH4GztQ/JdTN8e/Fg7VaRYtfe5XZiJGbPl42qs1Z2CC7XQ==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr23161008wrq.201.1616927326283;
        Sun, 28 Mar 2021 03:28:46 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id y8sm19608123wmi.46.2021.03.28.03.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 03:28:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 28 Mar 2021 12:28:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fix
Message-ID: <20210328102843.GA347473@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-03-28

   # HEAD: 291da9d4a9eb3a1cb0610b7f4480f5b52b1825e7 locking/mutex: Fix non debug version of mutex_lock_io_nested()

Fix the non-debug mutex_lock_io_nested() method to map to mutex_lock_io() instead of mutex_lock().

Right now nothing uses this API explicitly, but this is an accident waiting to happen.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      locking/mutex: Fix non debug version of mutex_lock_io_nested()


 include/linux/mutex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 0cd631a19727..515cff77a4f4 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -185,7 +185,7 @@ extern void mutex_lock_io(struct mutex *lock);
 # define mutex_lock_interruptible_nested(lock, subclass) mutex_lock_interruptible(lock)
 # define mutex_lock_killable_nested(lock, subclass) mutex_lock_killable(lock)
 # define mutex_lock_nest_lock(lock, nest_lock) mutex_lock(lock)
-# define mutex_lock_io_nested(lock, subclass) mutex_lock(lock)
+# define mutex_lock_io_nested(lock, subclass) mutex_lock_io(lock)
 #endif
 
 /*
