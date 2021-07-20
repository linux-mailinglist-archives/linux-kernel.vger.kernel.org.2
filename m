Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0733D0214
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhGTSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbhGTSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:35:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A37C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 12:15:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c23so3538812ljr.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07bx4NkLdn3YQo/4PUJkMzmndAbRZde3u9NpVjJE6Xo=;
        b=jH4ofDKiNAS6wninS1QG7BNfZTXGP6Tjxgvi8PtuyJ6A+fotRAxZpfxIuSyfOhDioS
         YlVz47P5bm5noadpORW7KP+FGm+QeNQJgSNXvF0keEyMaWzBtmnREHD5qMKGleIBjg2f
         gxySo7z5fJG5Y19umoVFApZQYQ0XlZNnfRMjz74qsbN0pvxhzG/iDg0+/IljYPmeY2ZY
         jjC8QCa0cP2aigYvOhYGzms8xO0zLIJfbJkRM2U84pKDUB3UZRbXq5uP0qoUsDpC6WAk
         n0hQ1Z54IU4MX/hy7VDhOw5UE6Wy7zhHbvxC6KcS/l2UPpwR42Hl1ZTnw8ZMi2wpwYUl
         AKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07bx4NkLdn3YQo/4PUJkMzmndAbRZde3u9NpVjJE6Xo=;
        b=ORVJOeqV+ir0MQb49SEgRksh/0t5H7XhQu6kC/1Ih6QuDRpndw74C24FGFvxwUI/SC
         ggol4nZYFue9YTFsiwVj6hHPBjzNQqPmOXibNbP6x0m2+pKeVoPJni8i8URHrkMji1Of
         LB4ugm1g+zJNQRTWives1ckPfdLMBEup8qlMZTOQxiwibsFGY7z/Q9FnsqHcsuZ5WXKj
         Mzxa4QdTJF11JMJZqAgdghZaKx3860qEz6UQbgUFYxm2UGzq7pWYUK6N7hLLD4pRaj+z
         JB0CDIkwEE0VzNqmb6BweNoHK8C2gGmlwKBCJ8K5dXhnx43Z1oAOWP/em7IgEvIu2Avt
         TsNw==
X-Gm-Message-State: AOAM531CmeGLZHwvAh3/7qFpP+n3JVfTVfdsYAMHREGoWO9h4Mfe/u2C
        Q9iqFDbS57V7HCW/cMo1jeJIJzlwXMNsCThzMJtByQ==
X-Google-Smtp-Source: ABdhPJzBfmIwchbylotTFNtN8B08j+3I3Jymmh9NtMuOkfmAVde5yClE76+HUsTtpljHe+5C8OuVzrFC7S2Z00Izk5o=
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr22595466lja.81.1626808548122;
 Tue, 20 Jul 2021 12:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod66KF-8xKB1dyY2twizDE=svE8iXT_nqvsrfWg1a92f4A@mail.gmail.com>
 <cover.1626688654.git.vvs@virtuozzo.com> <b19f065e-f3c9-2b20-2798-b60f0fc6b05f@virtuozzo.com>
In-Reply-To: <b19f065e-f3c9-2b20-2798-b60f0fc6b05f@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Jul 2021 12:15:37 -0700
Message-ID: <CALvZod7-S6=qzKgcnMh_=pK5HRVR6PdGkVXdNNrv9EJLcYW_aw@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] memcg: enable accounting for signals
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 3:46 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> When a user send a signal to any another processes it forces the kernel
> to allocate memory for 'struct sigqueue' objects. The number of signals
> is limited by RLIMIT_SIGPENDING resource limit, but even the default
> settings allow each user to consume up to several megabytes of memory.
> Moreover, an untrusted admin inside container can increase the limit or
> create new fake users and force them to sent signals.
>
> It makes sense to account for these allocations to restrict the host's
> memory consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

It seems like there is an agreement on this patch with the updated
commit message. In next version you can add:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
