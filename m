Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B87457BE1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 06:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhKTFau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 00:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhKTFat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 00:30:49 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 21:27:47 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id j7so4980783ilk.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 21:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAiOoSz2aR+nU4nAvKB3E4IjIBIAvYPcM3p77o3YLH0=;
        b=oy0azkKwn4dwoV3Er9arlhJg9eUMCuNmoZRgSiSzCRP7kxbiWKrxPVDpRhQzQ962oc
         kgM1lDDdza4+bSYnmj4afPPKJdgGSAQ4h8AwRzQ13eTNYyHJ/zlcWKxJNtiX8KpS4Nm+
         IkWtFWulBUR14O60JjlU00wLAs3PZwZ9Z/JHPr6/HIBf2AWqgs1rDEc1vMMkl758qjTs
         rIgsapGRmn0e+yjMnezZMYa7i4G33yYaIpfjTgvRDZYgaXx+AR9S+xeHUmW9NARqI6Kd
         WAutsxJT/ikfNfJI5sEJI8e4l3BVBgGpBBVK8ORWN9OqGoselXVKqLVQIGiBLZvT4xTj
         lH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAiOoSz2aR+nU4nAvKB3E4IjIBIAvYPcM3p77o3YLH0=;
        b=yZTR9rMV2B4I4WpsK32UQBgQK+si3+58qnASa9JdJe/u4dlOFsjYRELnhkgUOLCZ8O
         7rFNGb0tD8eW+93ogQ39NnreU4pFOLuutm62dNuBLOJpQ8X0a7Z202bTx+FYvl5Z1cGe
         nQF/65YgaV9Ql6KkKIjMQvDCah33cVvfYOdtFGFJRAdXa+AC0Y8gi980A2GsrLkUGJAn
         XA9HCiLtDaS1/jH/xofCQfEGChzfsdAHPlOALA0XNEz7xE7ZZiDL+EsyhfUkDV1/WvPO
         s2u1WaTIeRihYAh1XmvK/cp1ZLAHdQ4qtJI1hzaYDhKVUmxANZPRsSQKWzX2nxtuTVi2
         XZnQ==
X-Gm-Message-State: AOAM530nB0S4R11ujf4R9qIyqSz3DNxcVcRgw7uEXjbkey1zBJVvkzC+
        ZgroNcVm4JlRaYc1lXmnXZpC2+l1xQajzV//Xfs6lg==
X-Google-Smtp-Source: ABdhPJzPJjBBL+Y+HgRcyAByQC7OhenxnmUpLB684dVA4hTC4HT+3IC2ky5zTXr9Y6GPGe1O1ZR9kvKqeUv9fPh/R38=
X-Received: by 2002:a92:6b0b:: with SMTP id g11mr8778285ilc.146.1637386066340;
 Fri, 19 Nov 2021 21:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com> <YZiBH6GxlkFFuyqa@casper.infradead.org>
In-Reply-To: <YZiBH6GxlkFFuyqa@casper.infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 19 Nov 2021 21:27:34 -0800
Message-ID: <CAHS8izM-DpKs1=-F04-8Qp55VFYC57zERpKkFBk4_QNsOmnOoQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 9:01 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Nov 19, 2021 at 08:50:06PM -0800, Mina Almasry wrote:
> > 1. One complication to address is the behavior when the target memcg
> > hits its memory.max limit because of remote charging. In this case the
> > oom-killer will be invoked, but the oom-killer may not find anything
> > to kill in the target memcg being charged. Thera are a number of considerations
> > in this case:
> >
> > 1. It's not great to kill the allocating process since the allocating process
> >    is not running in the memcg under oom, and killing it will not free memory
> >    in the memcg under oom.
> > 2. Pagefaults may hit the memcg limit, and we need to handle the pagefault
> >    somehow. If not, the process will forever loop the pagefault in the upstream
> >    kernel.
> >
> > In this case, I propose simply failing the remote charge and returning an ENOSPC
> > to the caller. This will cause will cause the process executing the remote
> > charge to get an ENOSPC in non-pagefault paths, and get a SIGBUS on the pagefault
> > path.  This will be documented behavior of remote charging, and this feature is
> > opt-in. Users can:
> > - Not opt-into the feature if they want.
> > - Opt-into the feature and accept the risk of received ENOSPC or SIGBUS and
> >   abort if they desire.
> > - Gracefully handle any resulting ENOSPC or SIGBUS errors and continue their
> >   operation without executing the remote charge if possible.
>
> Why is ENOSPC the right error instead of ENOMEM?

Returning ENOMEM from mem_cgroup_charge_mapping() will cause the
application to get ENOMEM from non-pagefault paths (which is perfectly
fine), and get stuck in a loop trying to resolve the pagefault in the
pagefault path (less fine). The logic is here:
https://elixir.bootlin.com/linux/latest/source/arch/x86/mm/fault.c#L1432

ENOMEM gets bubbled up here as VM_FAULT_OOM and on remote charges the
behavior I see is that the kernel loops the pagefault forever until
memory is freed in the remote memcg, and it may never will.

ENOSPC gets bubbled up here as a VM_FAULT_SIGBUS and and sends a
SIGBUS to the allocating process. The conjecture here is that it's
preferred to send a SIGBUS to the allocating process rather than have
it be stuck in a loop trying to resolve a pagefault.
