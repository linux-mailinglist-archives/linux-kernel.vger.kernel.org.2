Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1936CDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbhD0VSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhD0VSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:18:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1717C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:17:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t21so506253plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=XbRRcvWtbGF+CXX7u5Y0A9sQh6iONvsr9rd1ZAKg3XY=;
        b=UtILF44U19VkaoEiGDi9OShFkD7bzH4fJN1MkP5DYN9zhH4WHrPwMevEvR6cDn3Oga
         9kCh7jd4IIHZkbsjX8ZM3P1Qa+PDdQTl+NyOHxuY7UWjw044vyXpevDXg7mOD07tJOnB
         tK0VGTI9YBYXjao0f6/hiLhL/xKnPLeGlb1eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=XbRRcvWtbGF+CXX7u5Y0A9sQh6iONvsr9rd1ZAKg3XY=;
        b=GCsCe9XHGWgjomDMkehAtIvPH2AENMQbxM4WLu6cc1QgszYu7m6gnitzxYEpRt1UY3
         Nu5AiJVE+oSmpJe8baqhmc2Cg2QoZOAjzuCDXbGi+UzkqefT5GTDN8m0DnPq1NQQemeJ
         w2ZbLcKTdlJ4vUZPHJrdLFsHGq0babNS9PrsIim6NzCZPatrlqfrTT37KKkN25DWqK8j
         MWiOXr6t2I6uwxTicc1VR/w1IJzc/o0CQwuBrNqzuZ+mMPsAmDhd9HiDBwx2azxxT6bv
         JXcxn3O6gKZdacCzHiruK08TO1ub4szVRy98e1NzSlZ6oumE7zQf1BcuGEyYJ1NDtOTy
         5BKg==
X-Gm-Message-State: AOAM533cloT0it79IiYGksVtNlodiHQGzisQkOE6bwKeE629Tsu6nNgv
        DytRE+JBUW1BjO2Z0kfosbr8iOtqlYknKHR7suAPtvH3CS8v3TZJqg3xpekmdJ/xVTR1jyjm16F
        Aag9pWVSeB8If9l/F9+iUqMTlyduJMxqM3G3eFIdYb2V4MEtNmU+Ej/h8/UsgKTg47wQn0/WDAX
        IgjIY=
X-Google-Smtp-Source: ABdhPJzUUjmUDa213znjd+f8UAm8nhL+UqNmb0iztAu/bvvHnfeemYa+VEqOxSmrsE4qR9Nmj3TEWA==
X-Received: by 2002:a17:90a:cb0e:: with SMTP id z14mr308571pjt.128.1619558241876;
        Tue, 27 Apr 2021 14:17:21 -0700 (PDT)
Received: from cork (c-73-93-175-39.hsd1.ca.comcast.net. [73.93.175.39])
        by smtp.gmail.com with ESMTPSA id r1sm3194263pjo.26.2021.04.27.14.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 14:17:21 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:16:50 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: sched: wakeup setting TIF_NEED_RESCHED too frequently
Message-ID: <YIh/QubidJcE5IIv@cork>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I came across something that looks wrong and is certainly inefficient.
Here is a trace of what happened.  Kernel was 5.4, so not too ancient.

 + nanoseconds before present
 |       + 0 for voluntary (going to sleep), 1 for involuntary (TASK_RUNNING)
 |       |    + PID of prev task
 |       |    |      + PID of next task
 |       |    |      |    + RT priority
 |       |    |      |    |  + comm
 v       v    v      v    v  v
8729751  0   6893   6894  0 one
8723802  0   6894 106051  0 one
8718671  1 106051   6899  0 other
8711411  0   6899   6900  0 one
8705643  0   6900   6902  0 one
8699444  0   6902   6903  0 one
8693987  0   6903   6906  0 one
8687832  0   6906   6904  0 one
8681188  0   6904   6901  0 one
8674083  0   6901 106051  0 one
8639249  1 106051   6893  0 other
8631961  0   6893   6894  0 one
8626684  0   6894 106051  0 one
8623375  1 106051   6899  0 other
8617434  0   6899   6900  0 one
8612341  0   6900   6901  0 one
8607215  0   6901   6902  0 one
8600824  0   6902   6903  0 one
8595214  0   6903   6906  0 one
8590161  0   6906   6904  0 one
8584825  0   6904 106051  0 one
8465395  1 106051   6893  0 other
8358696  0   6893   6903  0 one

The "one" process seems to frequently wake a bunch of threads that
do very little work before going back to sleep.  Clearly inefficient,
but we are not interested in userspace problems here.  The "other"
process has a thread that would like to continue running, but only gets
to run for very short periods, 3.3µs in one case.  That also seems
inefficient and looks like either a scheduler or debatable policy.

My rule of thumb for task switch overhead is 1-3µs.  Probably 1µs for
the raw switch, plus another 2µs for cold cache effects.  If we want to
amortize that overhead a bit, time slices should be in the region of
1ms, give or take.  I would also be happy if the "one" process would
have to wait 1ms before the woken threads actually get to run.  So in my
book the observed behaviour is wrong, but opinions may differ.

Anyway, trying to find a cause, I noticed the following call chain:
	set_nr_if_polling()
	ttwu_queue_remote()
	ttwu_queue()
	try_to_wake_up()
	default_wake_function()
	curr->func()
	__wake_up_common()
	__wake_up_common_lock()
	__wake_up()
	wake_up()

Call chain above is manually created from source code.  Closest sample I
caught with instrumentation is missing the leaf calls after
try_to_wake_up():
	_raw_spin_unlock_irqrestore+0x1f/0x40
	try_to_wake_up+0x425/0x5e0
	wake_up_q+0x3f/0x80
	futex_wake+0x159/0x180
	do_futex+0xcd/0xba0

Afaics, the result is us setting TIF_NEED_RESCHED on any wakeup, unless
wake_list is already populated.  Is that actually intentional?  And is
that useful for performance of latency?  I think it isn't, but I am
probably missing something here.

Jörn

--
With a PC, I always felt limited by the software available. On Unix,
I am limited only by my knowledge.
-- Peter J. Schoenster
