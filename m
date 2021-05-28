Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97D23942B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhE1Mnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhE1Mnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:43:35 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934B1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a15so2595979qta.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=38syo+ldw1QudlXVlbps0ms54ePB01IrTOpMTCdiin4=;
        b=ooF8ERF7a6r8xrauEEaMoj9ZArPxs7jrtDMzGogESnc6KzPvWLjnBC9jgTJwLBUQD1
         aNE2iNZk/Chaw98DRWKEdePQJjP/Ivx3zY012Uum3Yhb/wB8Uq0QTR4jLQZp1gN3NyP9
         ++fTyQp/S+1xDCAiqMxSCWCEpis+FxB+OWQ2C6fQIwpczi94QMxIlwBcfmBOiwypkM0W
         Pyv1gXsOR2r2LhJCWb+UHhYX10JuBloy857iZzB94ofuZSGXss0S1tND0AqzpftWef8J
         40Q6gvrX/T/0QHvz9OUFpjHSEgd01GqomC5vy33/7M+LtsNfvhQljuc0KFiYOhYHsdFF
         q30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=38syo+ldw1QudlXVlbps0ms54ePB01IrTOpMTCdiin4=;
        b=CC/IYU9QK8A5ZWfcq4R7YVlNpjeR3UQk2lTiWtW0oHyyUjY26rs0VUhMgAz6sOESIc
         s7035PjWPBxe1rZRadx6f2bQKntrlCvj4LjmB1s20Jw2N++AE0QmqtMMFECVI8cEJxlF
         4GhPE2hhCy6XlqtKHugbDYeoTZ0X20rYyFiCGsLB3HA2mJRGhgmLGLyi8mldW7Z7y47j
         9y8ta7obbsDK8B9b5FaVAfJ03Vy+n6Sg0eBo52aF/GXG5/9Aq1F/YffprMTBO8hlp/Qz
         rG/HvjFg7AnEPwmIUKbvExTU+65eof55+aSwuqBpC3pVlGgXQc4CUnNyWRo6t/9gcCS+
         4sCA==
X-Gm-Message-State: AOAM533o/rOa/vSAj6GCYDsGhYSdVGm/nV9woCTLXNDk09Cqisg933dO
        ePBggntMlLAdzPWzQxaKEw9EN4X00eOcWg==
X-Google-Smtp-Source: ABdhPJx0XdIKvgVkkQdcEeX3hjpMCqmMQ8Ir8T1hCTh8diPdnphWR3PsUsIgV6qkehzFoZMWRUdLow==
X-Received: by 2002:aed:210f:: with SMTP id 15mr3247806qtc.149.1622205719777;
        Fri, 28 May 2021 05:41:59 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id v8sm3319707qkg.102.2021.05.28.05.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:41:59 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     ksummit-discuss@lists.linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [TECH TOPIC] Writing a fine-grained access pattern oriented lightweight kernel module using DAMON/DAMOS in 10 minutes
Date:   Fri, 28 May 2021 12:41:25 +0000
Message-Id: <20210528124125.9051-1-sjpark@amazon.de>
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

In this talk, I will briefly introduce DAMON/DAMOS and present how you can
write a fine-grained data access pattern oriented lightweight kernel module on
top of DAMON/DAMOS.  With the talk, I will write an example module and evaluate
its performance on live.  A data access-aware proactive reclamation kernel
module for production use will also introduced as a use case.  After that, I
will discuss my future plans for improving DAMON and improving other kernel
subsystems using DAMON/DAMOS.

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
