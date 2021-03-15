Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB033CA37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 01:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhCOX7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhCOX7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:59:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20468C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 16:59:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 184so18371974ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 16:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiWLaJ6JfRY7D2fjAEheSS/CI6En0Tfjr7NfpaLRaUg=;
        b=el1U4yM7KpXL5g8A1suug3kzC4jqMxihYzAe6idzQvWFnWS91NbuSI/u+c6mo6cRnV
         SPei+MME4J69H5g9v4345POnj6DndSypgXQdfUHFQYb7eJNzCDNSvw/2JxkV/MfzWtOC
         kf4IBHDbVcqItf9trvNPu1tywIQIXWuoKwXmyEvHMidR1r5dkG0r+DYt+noifqymr/al
         NOpBuSOhXUfkxXzujUrmtj6SfPf704YxzLSaRzU5iJInw3d/wh8k5iOLjeOO/M+5KmEi
         LJh2OEaMvZRv9JdvA6or3g3XBQ1bnr8Uu6YnH5VpChJ/5QuJgx7O/g/j1G2ONUuw4djx
         N5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiWLaJ6JfRY7D2fjAEheSS/CI6En0Tfjr7NfpaLRaUg=;
        b=WKFqhgzeRsMRZK3NZZgnxpzCl9i85Y6cjLwU3Ru5sEMs1S86wZmApFcJ6F9rPyjmkd
         mlth+x52xEGzQ9eNYvaMzFUTcQ+RmCVkM1XJQCmq+0adL6W9r7PgBMMBekIAYJzG4PRo
         QoOWEzQkddlhEL2cTIvYMfhV0DSKVYz/U33RI+MfyezPkpUp7wINeHgckYN27k3A/XYE
         lRsnQffJJEYyEszecxxlGS2bzzaLuYFyrzjnulQIMZd5p+qMK0v2Ey0f74dJOjvcv2Eb
         Ukme/GQorDfBGErZelzhH2fVQSfJGTWH7aKX2RgJAixWrY5fF1wltTqQ7X3PHAaF1Yve
         rM/Q==
X-Gm-Message-State: AOAM5329rNJj2HqT6970fY3/9AoMXVYYKM/xzkU5ONTF11WltDJ1BvqD
        yZlk8MImQVzWXzsbkb6lnnswQHmDX8b5yUqSNktsOg==
X-Google-Smtp-Source: ABdhPJzCFWkbAbfU5FZc7r0w/lfxsElxEMPSYg1g37oXUD304ZYfPSKaUF3yhqQGKYWlRE3P3zrkIX0Ht1rL3aPfSaI=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr922776ljc.0.1615852741307;
 Mon, 15 Mar 2021 16:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210315234100.64307-1-hannes@cmpxchg.org>
In-Reply-To: <20210315234100.64307-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Mar 2021 16:58:49 -0700
Message-ID: <CALvZod7VzxYc4Kz0WPHWt74YMopi9XrCu4CKtEGTRKxXPSP=8w@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: switch to rstat fix
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 4:41 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Fix a sleep in atomic section problem: wb_writeback() takes a spinlock
> and calls wb_over_bg_thresh() -> mem_cgroup_wb_stats, but the regular
> rstat flushing function called from in there does lockbreaking and may
> sleep. Switch to the atomic variant, cgroup_rstat_irqsafe().
>
> To be consistent with other memcg flush calls, but without adding
> another memcg wrapper, inline and drop memcg_flush_vmstats() instead.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
