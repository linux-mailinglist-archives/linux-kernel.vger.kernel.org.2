Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781D032F594
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCEVyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhCEVyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:54:08 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D8C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 13:54:08 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h4so4702938ljl.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsmMJABHzjW2imdiPFuBeArH9DaQyKHwBF7blWrk06o=;
        b=VYmZTqRzqRfXYYbPq4vU9UkIKIyFebUXF+fHNRjhr3iifCoNKRu+HHXLMeqm3xZDYH
         i/gCvMdtE+8hqyPAwuxNSjW68kzaprBvJIaGcDgPw+YIXsLC3xeJezFFtsAEpTKdOx/l
         E56fv7ugEoJKKG17KZJjvavpZVmn3wZVN2pFQitux0AKhBjP0+5b9tL5zUPEgg1DYfvp
         kqViuMiNWrI04N0ARC+2m8FUediMH3GRg0Otv+JUML8gKufh33kbXSd/Y/kxBGPAOsJl
         uYraYW1I5R8fGG6MeY5DxqeGmVMhAFur0jBoZOhgMofoB1vh/obnYN37d7XtUsZlSAn6
         WBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsmMJABHzjW2imdiPFuBeArH9DaQyKHwBF7blWrk06o=;
        b=i9WzrPsYUeRyTu7XHoiNBTgrrRpBqvF1pkgeN9DqkhV4g9XMtWivDhY4IO9gfFIC0u
         4+oelJuICV8/OOn5rHJJykhoZH7jT2A4EdxnlBg3sNOVpC6bU8sC6z8XYIAXrXjMFQZ+
         zSdAHQe8cj4kPrX5TpZRy22iV2eY1VDyHYELTP164PmHEH+erbG97mYgm0slEy63oJVn
         Hw/IY9DmGk8R5R9t2fwkwV6aa91bqR87BRaL3Eo43SsfikT3LeUjYQdJt2Gex+DO5H3f
         0cP3mkRGkDiVdTjDrU+g6cF+gXEPyZwrhcvNkB8eLKgDHjg5iuXQQ5g0hNm9632CmPCL
         W4Uw==
X-Gm-Message-State: AOAM5306qy3aBBnBJBxowm0ZevtHtf+MwnfNRcyeN2DfkRJ0dc3lIzhN
        DdGYIVvt0e0uT3/40SGbq2PLji9vqU2iskTuXHWszA==
X-Google-Smtp-Source: ABdhPJwOIepxZeN1ajeIR8EKiu0p/vlD2aPti7IKeBUrk0Xh0mg0RU2cYdzMCTqxs3DSJnhfPhO1OiTwxhYIVXVSTY0=
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr6555699ljj.34.1614981246415;
 Fri, 05 Mar 2021 13:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20210305212639.775498-1-shakeelb@google.com>
In-Reply-To: <20210305212639.775498-1-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 5 Mar 2021 13:53:54 -0800
Message-ID: <CALvZod5oPTj8r6vKXVGgtKoXVaRWbRX9S2mLVtSnyysqtzr_ng@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: charge before adding to swapcache on swapin
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 1:26 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> Currently the kernel adds the page, allocated for swapin, to the
> swapcache before charging the page. This is fine but now we want a
> per-memcg swapcache stat which is essential for folks who wants to
> transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> swap counters. In addition charging a page before exposing it to other
> parts of the kernel is a step in the right direction.
>
> To correctly maintain the per-memcg swapcache stat, this patch has
> adopted to charge the page before adding it to swapcache. One
> challenge in this option is the failure case of add_to_swap_cache() on
> which we need to undo the mem_cgroup_charge(). Specifically undoing
> mem_cgroup_uncharge_swap() is not simple.
>
> To resolve the issue, this patch introduces transaction like interface
> to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
> initiates the charging of the page and mem_cgroup_finish_swapin_page()
> completes the charging process. So, the kernel starts the charging
> process of the page for swapin with mem_cgroup_charge_swapin_page(),
> adds the page to the swapcache and on success completes the charging
> process with mem_cgroup_finish_swapin_page().

And of course I forgot to update the commit message.

Andrew, please replace the third paragraph with the following para:

To resolve the issue, this patch decouples the charging for swapin pages from
mem_cgroup_charge(). Two new functions are introduced,
mem_cgroup_swapin_charge_page() for just charging the swapin page and
mem_cgroup_swapin_uncharge_swap() for uncharging the swap slot once the
page has been successfully added to the swapcache.
