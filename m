Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55D9443325
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhKBQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhKBQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:40:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF13C0432EF
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:36:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x64so1648800pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kzaasMMBTXjWCF2aP5KAdydXQMo8KpV1k3e0lAQIo44=;
        b=F7ISfMno8xtoB4Js7RP8rkONBvLUr9wt+CzoJTq12uwh2ehtnzzCsBAFArwhugCAW2
         zTLisHtU3YxHuUMGIb96EdsJTCCaNzt9KVxKUZ6fsz5RjRQf8jUDMO9MW29LbkAI8z+l
         tCTdUOlRUn4OjYKX8bu0x3VqAbvXrS4NziveV5tUOc546LoxNnQ5ouoq/0pybFybjwIz
         kbaDOt0dtw5dp5jBjmOp5qovElzsY7YNDUOvzxo1ScqrcbBE6e0bXX3+048AFjl9uFIi
         UsO2H6UM7bQ2YNSoqdsjD8a5KLTOAXKGNAOMmiXI++J3RBOOlaqqN8T3FdwM5Rc71sRu
         KNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=kzaasMMBTXjWCF2aP5KAdydXQMo8KpV1k3e0lAQIo44=;
        b=p4RKfn0bqpvXthbsJO58a8Nm3a2dQ4yPxdgVFPHgfR7A8rIDvNxrRNTc0imf2QUz6b
         5QMTZ2XiyBhI4uwc1miLNU5HHngTimngm9uqKqol0mR6WpyKEITNIyuyC0IQiJK/KVNu
         oJQ9spoiTCA1IJ8bZRsrLZFy6IOPRIQ9x1jmFOBYu8/EeJivgL4QNkVQBFN3T/6PCid+
         ogLP1ahfDk8jSAFEj/j/rcxufZ2xPhg0cBAL1PzAHPxe/A1JS4rL8R7N6WVrlrlDTNyP
         pPZWVHiukGcQ0UY6BWSC5VdDr+2Ajd6af74UV0AFaQVI6+eXtchT2UR658/CUanJbQpP
         e1kg==
X-Gm-Message-State: AOAM533ueAlUpKh6ElyHhA+iRpTiZCbPInPuOC+jCbc6UdSAVpJkZizn
        CYeyjRTO3y8nK/d+prYJN7x9TEUrcno8WA==
X-Google-Smtp-Source: ABdhPJxlxLSZSHAWHfrbfbQpeKE9/+xiaudmOsKqtl/0klqrojAFXfPafNFSZTosAqDN0Vw3wjj6Dg==
X-Received: by 2002:a63:f753:: with SMTP id f19mr16897970pgk.92.1635871012621;
        Tue, 02 Nov 2021 09:36:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id l3sm18558189pff.4.2021.11.02.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:36:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 2 Nov 2021 06:36:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue changes for v5.16-rc1
Message-ID: <YYFpIp/sa4Oiix71@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Nothing too interesting. An optimization to short-circuit noop cpumask
updates, debug dump code reorg, and doc update.

Thanks.

The following changes since commit d9abdee5fd5abffd0e763e52fbfa3116de167822:

  Merge branch 'akpm' (patches from Andrew) (2021-10-19 05:41:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.16

for you to fetch changes up to f9eaaa82b474350aa8436d15a7ae150a3c8b9d5c:

  workqueue: doc: Call out the non-reentrance conditions (2021-10-25 07:18:40 -1000)

----------------------------------------------------------------
Boqun Feng (1):
      workqueue: doc: Call out the non-reentrance conditions

Imran Khan (1):
      workqueue: Introduce show_one_worker_pool and show_one_workqueue.

Menglong Dong (1):
      workqueue: make sysfs of unbound kworker cpumask more clever

 Documentation/core-api/workqueue.rst |  21 +++-
 drivers/tty/sysrq.c                  |   2 +-
 include/linux/workqueue.h            |   3 +-
 kernel/power/process.c               |   2 +-
 kernel/workqueue.c                   | 187 ++++++++++++++++++++---------------
 5 files changed, 128 insertions(+), 87 deletions(-)

-- 
tejun
