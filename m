Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241E741EFD2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhJAOnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhJAOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:43:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E3AC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:41:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y23so387453lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0qXtkCtWUxN7VB9S0jNEMSWx7lvs4OCRR8Io1oFKYA=;
        b=URDjUNh9j4DDqU2Z3tr9x4ltkoZ9INlGbBwu71DV8OO7AAhYkjG3TUqZnOyRddg9PP
         zPtfVJw7uvlSUZgsvswISTf0N16HXjYU+xwI1sFNebNN9S6smOjxzHhU/7MGfpFra1OL
         USdlDMgtqYUBvDatB2FWFtOjgwiSWwjv6DtPbS0MFEKLyUoqvDnqn1tl+qLZvsjCSUUZ
         mQUMLDenlLUvnYM7lidTbFlEUB0ETZKwLjt7if0p/oK6919aVezLO6ADFcFHiMmEMfMO
         86Rsjc7d1NE9rsWTcEixzX8JdBYrh4nVIfDLiHESs6X6Z39sp83Kbkq2X2Bx/vvFOJt4
         RdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0qXtkCtWUxN7VB9S0jNEMSWx7lvs4OCRR8Io1oFKYA=;
        b=n2scwrA0jInd0YFoR0D/0sYiVpQMPg4sxMLr5BDhuj9srYPwb6oOK+rQSFGFXcgxZe
         eBhRlpxhmN6w5VvzkHwCevKk+EThzfue5ivTmAOZrPUGR+GQC0YWI/mP7bU10XvdkrVX
         J5iwgk4ZqzlKCVF6gcCudINnXyFAVrnD4qcZ5v/VMMXF/iexN+pjUvhn4MDEh6Vky/Hd
         bs0A3xhHJtdrAocYglID11YTpCWh1R+h/yPQZn6l57Pt7O0Fc9Sur3wanomGQbB6rRHk
         UbPGdOp0kRyVxg1bXfKAWPBN0msX/QSm+NHr5QyWssS2QZFluvtw/GS9TNWFikf5hw85
         Z0WA==
X-Gm-Message-State: AOAM532XdTTR3HPiCdbQ2HLdrBOe4icbVzhN4At6sVQR3yRUwkEChXhA
        LSqiuQK8inuugF1cvxMGffItQyhuZndmFMAf4It8qw==
X-Google-Smtp-Source: ABdhPJxKP6QTO5y9VXM6rpR6ji3szjZqKCXY4+dcY9D4qucO+bf1uQWULNaqKNEqhjZC2K/+FFjIDq/Xx5ZSiQ8Dp5I=
X-Received: by 2002:a05:6512:12c8:: with SMTP id p8mr5599821lfg.40.1633099314880;
 Fri, 01 Oct 2021 07:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210930044711.2892660-1-shakeelb@google.com> <YVca+jJnjDn5RLsq@cmpxchg.org>
In-Reply-To: <YVca+jJnjDn5RLsq@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 1 Oct 2021 07:41:43 -0700
Message-ID: <CALvZod7TENAMsmf6swD40RxGFFKOSUtSg9SvgaqE6pdRHy8nrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] memcg: flush stats only if updated
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 7:26 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Sep 29, 2021 at 09:47:10PM -0700, Shakeel Butt wrote:
> > At the moment, the kernel flushes the memcg stats on every refault and
> > also on every reclaim iteration. Although rstat maintains per-cpu update
> > tree but on the flush the kernel still has to go through all the cpu
> > rstat update tree to check if there is anything to flush. This patch
> > adds the tracking on the stats update side to make flush side more
> > clever by skipping the flush if there is no update.
> >
> > The stats update codepath is very sensitive performance wise for many
> > workloads and benchmarks. So, we can not follow what the commit
> > aa48e47e3906 ("memcg: infrastructure to flush memcg stats") did which
> > was triggering async flush through queue_work() and caused a lot
> > performance regression reports. That got reverted by the commit
> > 1f828223b799 ("memcg: flush lruvec stats in the refault").
> >
> > In this patch we kept the stats update codepath very minimal and let the
> > stats reader side to flush the stats only when the updates are over a
> > specific threshold. For now the threshold is (nr_cpus * CHARGE_BATCH).
> >
> > To evaluate the impact of this patch, an 8 GiB tmpfs file is created on
> > a system with swap-on-zram and the file was pushed to swap through
> > memory.force_empty interface. On reading the whole file, the memcg stat
> > flush in the refault code path is triggered. With this patch, we
> > bserved 63% reduction in the read time of 8 GiB file.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> This is a great idea.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks.

>
> One minor nit:
>
[...]
>
> Because of the way the updates and the flush interact through these
> variables now, it might be better to move these up and together.
>
> It'd also be good to have a small explanation of the optimization in
> the code as well - that we accept (limited) percpu fuzz in lieu of not
> having to check all percpus for every flush.

I will move the code and add the comment on the optimization in the
next version.
