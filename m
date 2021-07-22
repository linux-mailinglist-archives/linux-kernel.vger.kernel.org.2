Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50463D303A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 01:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhGVWvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 18:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGVWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 18:51:19 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B28EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 16:31:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h1so477862iol.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ah3hxIEkxG4Tfj2BhFU2Ycu/VLeQs8pazhZDcOSRuI=;
        b=L/jbABCG0hw5gPUITvGkMBLiNMiW1P2E9lQr8zCrJyrrAmkBZkoncrILNrhXpXV8/s
         B6TZiGk6/iEGHBPe2Ms4FDKZ7mr8Heh9xbs5Me1P+fUcBV3yU8W6Nawg0qszuz5ZHpsu
         OpPv1zmMkN/1oVxJvt6W4ghM0WswFxQM47ZyEpUpAjgUkeouihsQPL0iXjZxplzXsrJp
         6RS2Ul5ad0cGtFvMpASk5q74qpeb+JDBVZfGqn+5sdWemP2Kx43rG2nFJZS4Flc3EoAC
         Jh1Jw9+UX3Mn7Zc02rjGSXcO3EmjkvDqCZbUQNznlyqjPkP9qL/4mSlmpveMOSsUE2t0
         zXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ah3hxIEkxG4Tfj2BhFU2Ycu/VLeQs8pazhZDcOSRuI=;
        b=OuTI4zE5A3xfxs6F/8j80DrKXhihpLquv7WTttjoq5wSP7ljrDbaEZmLgvyAKUgGy0
         Pt6wrSbxjM/ZJ2th8emtpr+jRMlcdIemCwlZDEcatHO/LOkUjShSNUbxJJvQDat4no12
         55LkhAXF7vjwbY8NpRZXlEkhHyj0aMwdIKUTwxFeMhu4J1BIWQy+0JnXkMbL+AJVhyLD
         dYiSPX4El+bQNzu3ZDLhAC1XVYpbP3BLwwwasJBi7ja6TsfeAXgxzg7wnGvWRfmxJ6L8
         GKx1L9cU2FM3thpzzN73q38FqWDEpTDVZxI9GK8j5vQ/z4bhT5Dmy4b1R8A/LEQ9Xif+
         eQBQ==
X-Gm-Message-State: AOAM532qN8ymiwlXsh4FE6Wy7NOjqyJe2K/Ulxg4ZE8QfzZA/UKoPEaz
        hKf5ac4knanSrvGmjMVa5k9muoJCYLLIu1EeHwP/bQ==
X-Google-Smtp-Source: ABdhPJxQDTtZ1I9K905D80K8OFIlnniKJQhcYDu31zNPQKLJxskE8hli0iKE8HJVoeO2yxuZcT1y+DrjRYxA9WvxSBI=
X-Received: by 2002:a6b:4f16:: with SMTP id d22mr1644492iob.15.1626996712569;
 Thu, 22 Jul 2021 16:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626966805.git.rickyman7@gmail.com>
In-Reply-To: <cover.1626966805.git.rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jul 2021 16:31:40 -0700
Message-ID: <CAP-5=fWxuGkJdFPNt7B=t3bc81jP8YWOUdyvfFcntStGqUxuag@mail.gmail.com>
Subject: Re: [PATCH 0/3] tools: add gettid to libc_compat.h
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 8:34 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Hi Arnaldo,
>
> following our previous discussion on workqueue RFC patchset, I'm sending
> this patchet to add gettid to tools/include/tools/libc_compat.h.
> This new definition will replace existing uses and will be used by the
> workqueue code.
>
> Thanks,
> Riccardo
>
> Riccardo Mancini (3):
>   tools libc_compat: add gettid
>   perf jvmti: use gettid from libc_compat
>   perf test: mmap-thread-lookup: use gettid
>
>  tools/include/tools/libc_compat.h     | 7 +++++++
>  tools/perf/jvmti/jvmti_agent.c        | 9 +--------
>  tools/perf/tests/mmap-thread-lookup.c | 4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)

All 3 patches look like great cleanup, thanks!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
