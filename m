Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2898E3FCBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbhHaQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbhHaQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:51:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E69C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:50:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l3so1952968pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tJ0ix3j4c9U+HeBLwmo3wyixuMJaDINEWtURTPXaQio=;
        b=HrgB0XYNR5eMaLvUAeBPUesNtrfnIuRQSqB0hjYfrNZwMtiddh3PbWr7YgHdIfih1g
         nybfsLqhDD88P74B0c1Zn6I0G69XNJPCx7A/K/qDol7erxamUg2oSoxoGbOBbE6cFRWg
         2STbAnMVwFZKdgg8XjWfWrfLeam29mKhb7QSnAYL3nSEeECG73Ahsz8EA1KR6o1KdnyC
         iL+4vHhGrm/KfKdIJAS46W963+eFOuodKpzaVqlni0dmfihpzZ7acBaLQRf0cC2X1gV1
         hNX82SLVFw39JYc2nZbEbgylL32u51jIRzhSRBTyVYkCE3Vsn86H27pBcrzU49WFgbTF
         UpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=tJ0ix3j4c9U+HeBLwmo3wyixuMJaDINEWtURTPXaQio=;
        b=SDVnoGlhK1c4qOFg9bFiy8GSkjtpU2u9iEt/p6+0q5AA5+TAaeEVCCtyho/YKZ/wmy
         c+njkx//L9rmljhYznaLwQqnjzy6Sffa0+Bb7f/eyxHZ7Dufguxwy37OX44pn8tbfAPH
         M7dDquPJT+bkuTi3Xrto230jVvKnEqhxnY58Gsovg2b3YrIf/ypQ5xxJuN9gHCzuTQAv
         S6/fTrRmAZOLLL0FJ/Nt8XEzbL7Zy/50EK7/u877SaFqbKYy0HzD+uTCtnqMkc4aDvF7
         u4hn2iVhLxpCItydj2yBA03fT25T+ljXNec5pd0Lb8UFKVMix09ZZAaUTj+BLwlDRZCl
         GbKg==
X-Gm-Message-State: AOAM531vk4c1yf9xguWeu8lPXzBnI8yRCA4TdVt+K6scOCvhJ15js/Gr
        wHrOt4XwoOwkf6eAFWGh4bcCDP5KlQ40QQ==
X-Google-Smtp-Source: ABdhPJxIjWqvTvNfKzFei9Frr20wCcEJsG8TfYTqn13vwetvShbUYM8bxAuwYJzRFhSKhzPfrMvBkw==
X-Received: by 2002:a17:902:7584:b0:12d:8cb5:c7b8 with SMTP id j4-20020a170902758400b0012d8cb5c7b8mr5568094pll.84.1630428658284;
        Tue, 31 Aug 2021 09:50:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id n185sm19620635pfn.171.2021.08.31.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:50:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 31 Aug 2021 06:50:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue changes for v5.15-rc1
Message-ID: <YS5d75CpAWb4aUOP@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

There is a long-standing subtle destroy_workqueue() bug where a workqueue
can be destroyed while internal work items used for flushing are still in
flight. Lai fixed it by assigning a flush color to the internal work items
so that they are correctly waited for during destruction.

Other than that, all are minor cleanups.

Thanks.

The following changes since commit 7e96bf476270aecea66740a083e51b38c1371cd2:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2021-07-29 09:42:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.15

for you to fetch changes up to bdb0a6548d2233dada752109a71bcf4c9b8ae6d6:

  workqueue: Remove unused WORK_NO_COLOR (2021-08-17 07:49:10 -1000)

----------------------------------------------------------------
Cai Huoqing (1):
      workqueue: Fix typo in comments

Lai Jiangshan (6):
      workqueue: Rename "delayed" (delayed by active management) to "inactive"
      workqueue: Change arguement of pwq_dec_nr_in_flight()
      workqueue: Change the code of calculating work_flags in insert_wq_barrier()
      workqueue: Mark barrier work with WORK_STRUCT_INACTIVE
      workqueue: Assign a color to barrier work items
      workqueue: Remove unused WORK_NO_COLOR

Sebastian Andrzej Siewior (1):
      workqueue: Replace deprecated CPU-hotplug functions.

Zhen Lei (2):
      workqueue: Fix possible memory leaks in wq_numa_init()
      workqueue: Replace deprecated ida_simple_*() with ida_alloc()/ida_free()

 include/linux/workqueue.h   |  15 ++--
 kernel/workqueue.c          | 186 ++++++++++++++++++++++++++------------------
 kernel/workqueue_internal.h |   3 +-
 3 files changed, 116 insertions(+), 88 deletions(-)

-- 
tejun
