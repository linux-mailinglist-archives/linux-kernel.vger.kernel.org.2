Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2973F6BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbhHXWTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhHXWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:19:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E29C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:18:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fz10so3837131pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I29PRDdkFO6DfCb1a8J3sNnkifDHvzcssrN6abY8/Uc=;
        b=jNr4P6pJTiy4S8ANh5NEBDQ/AUgZNSXcGTDQX4h8HXy2DvhWl9FnotcZZdAPCc1Ax2
         yjnO73wJilmK6RAqPOcmo6UyBLHPkwoPqIbcWfPywXPKmt92AgCXprDkQDLT2LGLl8hy
         KAo9vkIQ4q6zZdPneh3X+/idHtC2qozqLGEq4G9drJQVFE2bpdj2bP9lcF5KHC1m/yGh
         qhGtDSh+S2M6wjgFhds/DvF8NGpwckw16lLGJgQMq7le8Ip0Kd/9hyRWEuf/+6w5le+L
         wpsaf2AF/6HUaxKc88JS74RI9duCFJSH5WvJHdKMpy61h5t2SVtg4oQkPwkyjxvXta7H
         nLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I29PRDdkFO6DfCb1a8J3sNnkifDHvzcssrN6abY8/Uc=;
        b=fsCWyZJGRiBR9/+iHgZiho9V5FUQx0mmNiGG1wdC2Uk8YWzUZtLMk8avOSP2/f2oDc
         2MAUyysERlIxMyg0oe0n+edgGANd6mNMU1cxO/DrnjSV6tNwqIU0Nn3gG4D+nXvFsPsT
         l5o9U6o2Nk+LkEC4hHQEg03qtySNocVfEgwMvA1GSWSQX6USuRuFvh8/8WWXa2Mzn81o
         wQ/jpknZ+bUCzlVAW3X1qejEwsw6bHpe8iJVCmkWrlMURA0qItVbGLV7fj8PNdMzHNIz
         txR546Mufr/6WkYEFLVq56rGJDqqEDKPh0o39pOCHQdTbYsjFg3hNRsLApoF7TBTGv0f
         a+kw==
X-Gm-Message-State: AOAM5335O0c0RwBEWLmf2KxrN3JnYi1CfWNvQlK2FiJK1pu/FALpzhwe
        Mr3FMFFF1Zvy8ceCu8mbdEdquf8NZH97T6GBALKr3Q==
X-Google-Smtp-Source: ABdhPJwHL4MBQfn67NKc1fqZnTexiXm4dZHsyxHgKKd4j1oHv/yeVYq5RUD2nvBwzKDpYdFvwL7qKGe933cREOvwRAo=
X-Received: by 2002:a17:902:ba90:b0:135:6709:705 with SMTP id
 k16-20020a170902ba9000b0013567090705mr7838088pls.79.1629843516441; Tue, 24
 Aug 2021 15:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <1629632949-14749-1-git-send-email-sumiyawang@tencent.com>
In-Reply-To: <1629632949-14749-1-git-send-email-sumiyawang@tencent.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 24 Aug 2021 15:18:24 -0700
Message-ID: <CAPcyv4ii8ajOk-dfC3ak03Ugg8C3DdOXCPY_h8WYKm4vn6KDHg@mail.gmail.com>
Subject: Re: [PATCH] pmem: fix the crash when unbind namespaces
To:     sumiyawang@gmail.com
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lidongchen@tencent.com, sumiyawang <sumiyawang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 4:49 AM <sumiyawang@gmail.com> wrote:
>
> From: sumiyawang <sumiyawang@tencent.com>
>
> kernel will crash when use after free the ioremap space,
> which is triggered by ndctl destroy-namespace while some IO operations
> exist.
> The sequence of pmem driver release chain should be changed:
> freeze the queue and wait io finished first, then iounmap.
>
> [47202.018374] BUG: unable to handle page fault for address: ffffc90080200000
> [47202.018822] CPU: 36 PID: 9606 Comm: systemd-udevd
> [47202.020921] Call Trace:
> [47202.020969]  ? pmem_do_bvec+0xf9/0x3a0
> [47202.021036]  ? xas_alloc+0x55/0xd0
> [47202.021094]  pmem_rw_page+0x4b/0x80
> [47202.021159]  bdev_read_page+0x86/0xb0
> [47202.021222]  do_mpage_readpage+0x5d4/0x7a0
> [47202.021297]  ? lru_cache_add+0xe/0x10
> [47202.021359]  mpage_readpages+0xf9/0x1c0
> [47202.021428]  ? bd_link_disk_holder+0x1a0/0x1a0
> [47202.021506]  blkdev_readpages+0x1d/0x20
> [47202.021574]  read_pages+0x67/0x1a0
>
> ndctl Call Trace in vmcore:
> PID: 23473  TASK: ffff88c4fbbe8000  CPU: 1   COMMAND: "ndctl"
> __schedule
> schedule
> blk_mq_freeze_queue_wait
> blk_freeze_queue
> blk_cleanup_queue
> pmem_release_queue
> devm_action_release
> release_nodes
> devres_release_all
> device_release_driver_internal
> device_driver_detach
> unbind_store
>
> At that time, the ioremap space is released

Thanks, looks good. I reworded the changelog a bit and added a "Cc:
stable" as well as a "Fixes: 50f44ee7248a ("mm/devm_memremap_pages:
fix final page put race")" tag. I'll send this up during the v5.15
merge window.

https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?h=libnvdimm-fixes&id=32b2397c
