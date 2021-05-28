Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DB3942E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhE1MqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhE1MqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:46:11 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CDFC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:43:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j189so3908812qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aSGlQM/XH/4dqoGaUVEoegdMj3CQ0k2Q1uZIVms6JyE=;
        b=VmQ2B6FVflLQlxCG3jjQAirYKIoA6nnByBl5Llwnh+8UmYK7Syi/Ihl3BdwX/iPdRg
         QhFRDq/ZirOXC0DZSMux2f0d9wsGTp/V8jxPe8+tPQCHPXTy45odyZdZwiD6weUU4rL2
         Q31sbAmyRICsqPcsTFSaqvGEvtczyTQ7Uw+RNdD0nesUatPbRsTUupVOnyFT4wDimRQz
         1MabxnK2XemZm+BIyf0iMCKMKqzDZ74wBU/5SzhhIILVb0IN6iuvBynAyoQm9QSV8CDR
         fMY5iH9Acqe7eBCuthWDEV+RZ0jZaNCPVZLiMUNIFz6bEwraC+yHaoLHrmRSvrGnQVkY
         FEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aSGlQM/XH/4dqoGaUVEoegdMj3CQ0k2Q1uZIVms6JyE=;
        b=Zr0vJWOL3do5l9FhgALKVPi2pX/hkTH4q9/17j5ydObqrMlC/lvIuAja3+Oxc8V6KL
         DOmSBIpQDu+3OUpa0CLjPqpC2vLnN3i56LeBDN9FkgoYxL+dHOFnXjXuWGXrxJcPVZAh
         oWyKIbZ+beSPdFXVkoXaqfmd00xGQV1oT9EI//b3u6eRMybb+z3UtY1QGg8viVFPlvnI
         JYICPximc2W8/YEBaEf5ik79i5SpYUTI9pZ2I9qmP8XQWTi23QEvC0vGX1kPixcRRloo
         WVLhw0nAw8f96UChI0YL27ohHsvP7hjC0zVm2FgbpooOdFvyh3JTq9L8AMBDmPDbamhh
         eMMg==
X-Gm-Message-State: AOAM532XTuA/Hqr1PJcpDiZeQKMsVL9frxTSXxa1R/zToMzEKxjyXOUr
        8BxyI8GtF1HdBLGmBQxrXNZV25gd5G7scg==
X-Google-Smtp-Source: ABdhPJwD/P+zQDuakBQd4ilWxP4M27/YGz6pBQUtgSIzZLwsd5vhcahrXFyb/KrSDjAhnRIp+6xoWg==
X-Received: by 2002:a05:620a:42:: with SMTP id t2mr3710915qkt.423.1622205838412;
        Fri, 28 May 2021 05:43:58 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id z1sm3351959qki.47.2021.05.28.05.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:43:57 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     lsf-pc@lists.linux-foundation.org
Cc:     shakeelb@google.com, gthelen@google.com, rientjes@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [LSF/MM TOPIC] Fine-grained Data Access Pattern and Memory Management Optimizations
Date:   Fri, 28 May 2021 12:43:50 +0000
Message-Id: <20210528124350.9140-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON and DAMOS
---------------

DAMON[1] is a framework for general data access monitoring of kernel
subsystems.  It provides best-effort high quality monitoring results while
incurring only minimal and upper-bounded overhead, due to its practical
overhead-accuracy tradeoff mechanism.  On a production machine utilizing 70 GB
memory, it can repeatedly scan accesses to the whole memory for every 5ms,
while consuming only 1% single CPU time.

On top of it, a data access pattern-oriented memory management engine called
DAMON-based Operation Schemes (DAMOS) is implemented.  It allows clients to
implement their access pattern oriented memory management logic with very
simple scheme descriptions.  We implemented fine-grained access-aware THP and
proactive reclamation using this engine in three lines of scheme and achieved
remarkable improvements[2].

As of this writing (2021-05-28), the code is not in the mainline but available
at its development tree[3], and regularly posted to LKML as patchsets[4,5,6].
Nevertheless, the code has already merged in the public Amazon Linux kernel
trees[7,8], and all Amazon Linux users can use DAMON/DAMOS off the box. We are
also supporting the two latest upstream LTS stable kernels[9,10].

Agenda
------

Now we can improve Linux kernel's memory management using DAMON's fine-grained
access information.  We could do that by modifying existing subsystems to use
DAMON internally, or implementing new ones on top of DAMOS and let users
select.  The two ways would have their own pros and cons.

I am currently working for implementation of another practical and lightweight
proactive reclamation in the latter way, because this is a new subsystem.  I'd
like to further extend this work to other parts of the kernel including THP,
NUMA and tiered-memory balancing, LRU list arrangement, and KVM, though I don't
have concrete idea as of now but only shallow thought.

I'd like to briefly introduce DAMON/DAMOS, my progress and plans, and
discuss with people for
- thoughts on the programming interface of DAMON/DAMOS,
- pros and cons of the two approaches for this kind of work,
- how DAMON/DAMOS could collaborate with other similar works,
- concerns regarding my planned future works, and
- what additional DAMON/DAMOS-based optimizations would be possible.


[1] https://damonitor.github.io (https://damonitor.github.io/)
[2] https://damonitor.github.io/doc/html/latest/vm/damon/eval.html
[3] https://https://github.com/sjp38/linux/tree/damon/master (https://https//github.com/sjp38/linux/tree/damon/master)
[4] https://lore.kernel.org/linux-mm/20210520075629.4332-1-sj38.park@gmail.com/
[5] https://lore.kernel.org/linux-mm/20201216084404.23183-1-sjpark@amazon.com/
[6] https://lore.kernel.org/linux-mm/20201216094221.11898-1-sjpark@amazon.com/
[7] https://github.com/amazonlinux/linux/tree/amazon-5.4.y/master/mm/damon
[8] https://github.com/amazonlinux/linux/tree/amazon-5.10.y/master/mm/damon
[9] https://github.com/sjp38/linux/tree/damon/for-v5.4.y
[10] https://github.com/sjp38/linux/tree/damon/for-v5.10.y
