Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5812361371
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhDOUZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhDOUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:25:44 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8ABC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:25:20 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id x16so25552114iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olbuZ/mNJfDWZdGKBFNMZr0U0A3cz9Cq6tnv1KxE8ZQ=;
        b=U2o1zir6cWC/gUvJMIzysxsi1RHpyOWNV33sZRt0cR6oKbqe9RFQ1w2sN8E27CvYeP
         E+8yKaYclrlZORYN8O06PLW9TsNcut21OGQpmOUn21FxUaWMAQobTMWDeHU7vYR77n6s
         QZjw7Akf3rOol62Brs0jtlXoGTYy3jEnxA+TVbA3uA68/ANFd0ak1TKtiwdJIP+JPsky
         g9uO3ZvPLTzyr675+tsXEb1OVGYuTpzl6tRFDjDhxV/0+lUKalkOU3Y3Zcol5oeKswKQ
         Yzy2Edk5uD4Pr+umrlmPZ6Ny5M6mDivqNN0V1Pk8dXQjSUts5Kh9hwIj7/Q1bGv5fME8
         Cggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olbuZ/mNJfDWZdGKBFNMZr0U0A3cz9Cq6tnv1KxE8ZQ=;
        b=W54zsz52/Q7wMpBO4BefYMFgsnvXQidGCYb/jYXl9aVOFiigdJepXUIY5s3uMVHuOh
         8Z2A1ISVGjgH4pAyQTb6DuZvW0S9vPKDYcy/6eeA0XRXKu5jMVERY+d71/wgF2Tu5E7O
         EVT+V6/k5INYj7/pBadEeq0FQdmtufNeqvQ2rURq4aT1VkPM4AY0aWjQpwhZTzzV1voe
         k8zU6eocv2mWsjTrWqyTQM/i5kNMBjbmUDAcI/DLmDCQVTTQVYNcUol+8sDc8y0FYcEC
         Bk1RUsLj+2CkdQIi/B9WUc/DHNbxCHWrz4amvpKK/xqIdNXckTw0nIALNpDl/Oy4cvGZ
         MXAQ==
X-Gm-Message-State: AOAM531DTsIEaIuifelOsEkSEsdktI8tvSRMho239KX5kEQ8WVyfe2L9
        r7KB2F54mkMeZj+IAS3+kYDNJlm8VcRbfyi2DZt0WUm2rkJshQ==
X-Google-Smtp-Source: ABdhPJyY9hB5ONCGcbYe/7y+BPiYKbtx/tUIt9FiM4SvOyVinpKvV9NQ3k8xglasd0Xkry5pXqJfIY2BCtkkPpuaAec=
X-Received: by 2002:a5d:9c03:: with SMTP id 3mr802184ioe.32.1618518319512;
 Thu, 15 Apr 2021 13:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183219.DC1928FA@viggo.jf.intel.com>
 <CAAPL-u8Jk-i-9-iSnU7_nb-k2ZMqdRk5c88d-M6Bi1rfv4kSLQ@mail.gmail.com>
 <20210414080849.GA20886@linux> <CAAPL-u-w_WShb0RyXhs8koihTOPvFK_dCwB22RhzA=f9kRyqqQ@mail.gmail.com>
 <6215a690-d14a-de7e-72cb-1aa4e2822f2e@intel.com>
In-Reply-To: <6215a690-d14a-de7e-72cb-1aa4e2822f2e@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 15 Apr 2021 13:25:08 -0700
Message-ID: <CAAPL-u87JKZWzHLigh4KiGAocR8ZDzbi8MPU2WNm9e_h+F1yHw@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration order
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 8:35 AM Dave Hansen <dave.hansen@intel.com> wrote:
> > This can help enable more flexible demotion policies to be
> > configured, such as to allow a cgroup to allocate from all fast tier
> > nodes, but only demote to a local slow tier node.  Such a policy can
> > reduce memory stranding at the fast tier (compared to if memory
> > hardwall is used) and still allow demotion from all fast tier nodes
> > without incurring the expensive random accesses to the demoted pages
> > if they were demoted to remote slow tier nodes.
>
> Could you explain this stranding effect in a bit more detail?  I'm not
> quite following.

By memory stranding, I mean that memory on a machine (or a NUMA node)
cannot be utilized even under extremely high work loads.  Memory
stranding happens usually due to mismatches between job/machine
shapes as well as resource fragmentation resulted from bin-packing
scheduling.  It is an important problem for cloud resource efficiency.

If NUMA hardwalling is used, we effectively split a single machine
into multiple smaller machines based on NUMA nodes.  This changes the
machine shapes and also makes memory more fragmented, which can lead
to more memory being stranded.

Here is a simple example:  Suppose that each machine has 2 NUMA nodes,
each with 4 cores and 5GB RAM, and all the jobs have the shape of
2 CPUs and 3GB memory.  Without NUMA memory hardwalling, we can pack
3 jobs onto each machine, which leaves 1GB memory and 2 cores in
stranding.  However, with NUMA memory hardwalling enabled, we can then
only pack 2 jobs onto each machine (one job on each NUMA node), which
increases the resource stranding to 4GB memory and 4 cores.
