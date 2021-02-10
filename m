Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15C316844
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBJNrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhBJNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:47:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B457C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:47:06 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j19so2912615lfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7AQuIHqlGeDKdDmQaoPxTGljXqoMuKxFCh/+vT0i5k=;
        b=nOGKWwErjCXi0YFKi585FYnDqp7VZktLvttuvqdhK0nRwzl46aW1e6ZK2y4GhoJ9i8
         KpIxBAdYnb+08xigU5i30VZuFTrxH9hEDGhvwYEsy/vXJ20y3z8qmZGxB570y+8nwDXr
         KqRlvpUxKhal/kP45OJ60gFtDUeeffZe8T1LC5rRY+O2Fx+sJ5NgQqI1K5vhBdjd2A6B
         qJw8QKEDXZMZlFJvt+pc5moGlNUZkY9BSRYZmVwipRgXbnYqLGFJEc+CMn2+gVC3m7gE
         4OfOhMBxuIem8mVWHVp+YR/xI5Pyv3MgEexPFS4XvAKqbFwqVEoJy6zxsM+1KZMJkXNM
         BJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7AQuIHqlGeDKdDmQaoPxTGljXqoMuKxFCh/+vT0i5k=;
        b=OAUNVMlyKKVG/id7So51+D3siZSp8TmZ7lgzDV477xTHnxDqtdd37a0Ue2rtkj/vQk
         ttDeE36RmjRdv8U/C7t4f5x3FxO9goBwsDeHbLEixvxgH2mCnc/wAyDoin/uBd5a41Ku
         1Laqvl/O4lHMkgPEXW5gIOX5hCFDMpz5wMGHhR6qQlVecNIR5eveoNFB8Y9yjtWV6HqU
         mjm4eDaWCX5e2QPPiu4Pl/OZmT/uvs952U+mpvtGuTAJEG1VNzpr35QqJXFhHQd7/EKV
         SL927Y7ZVPCwyJYDbJ2V6QECM1DsrPCA+XQCuyJfhsG2/QLkyT9e9C1u2AFC4ijec3Rs
         hcRA==
X-Gm-Message-State: AOAM530b7J30+vItUYjzMuv7R+5bT4oAqoJ3cjayQsbmRChXY+sa1qWP
        eorp+y7d56FgvlxonNH8kim8CfN8rsTIoaFG0/Tb/A==
X-Google-Smtp-Source: ABdhPJz841Cfn+4sq64Q5uE+gYJv38/kovaen61M8ii6Y201iSug/qJh/kkiv/4ACj5E6wmRFUhiWf/OXsFV7bvBq+s=
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr1722867lff.347.1612964822071;
 Wed, 10 Feb 2021 05:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20210209214543.112655-1-hannes@cmpxchg.org>
In-Reply-To: <20210209214543.112655-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Feb 2021 05:46:51 -0800
Message-ID: <CALvZod7Tf+KBhT=3WCQ_uWa7_mZad6-L8wQJghxPRL_tVyQ8Cw@mail.gmail.com>
Subject: Re: [PATCH] mm: page-writeback: simplify memcg handling in test_clear_page_writeback()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 1:45 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Page writeback doesn't hold a page reference, which allows truncate to
> free a page the second PageWriteback is cleared. This used to require
> special attention in test_clear_page_writeback(), where we had to be
> careful not to rely on the unstable page->memcg binding and look up
> all the necessary information before clearing the writeback flag.
>
> Since commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
> BUG_ON(PageWriteback)") test_clear_page_writeback() is called with an
> explicit reference on the page, and this dance is no longer needed.
>
> Use unlock_page_memcg() and dec_lruvec_page_stat() directly.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
