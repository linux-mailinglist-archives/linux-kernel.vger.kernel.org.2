Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E63F69FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhHXTli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:41:38 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:44742 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhHXTlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:41:37 -0400
Received: by mail-lf1-f41.google.com with SMTP id o10so47813032lfr.11;
        Tue, 24 Aug 2021 12:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfEPuan/zCIEg+H/ClhRQP2hu3myJiA0etgVi2UQg2A=;
        b=QPervYaYegUocV0f39v4PtEqHuqB5WKhzL/K//mEdG56wgOzBuFSwaIMDk6/PjWf7a
         /rf84Q1GwnaMHp3O234UbQOYKz5vvQwtHkwlPCMKZ/lvInNM0mVhh7us82HlLeKclsB7
         esvyfZB5NAxlIWn4DL+aKciOU9Xp9WFV0oExYspbUZG5JLsoBzqf3Rf+QOgvxwzp4w9I
         M33SBfAOIYlmWDWStYORbnkpboNexAkaxBRjAEUm8A2ZHnZmd7HRCVBrLbIp+d71xDVc
         ZWs3uLufrC29z879BkvXgbBwgjLZOltFSPSDjQdXf2iuWw0W7z3kHtdGGBEuiJLXJNbk
         VWeQ==
X-Gm-Message-State: AOAM530aULFkJ9qbURP7WBB7OZ1gDGNXiESy+3uBobsxxZbtRKJY5te3
        z2LUUEgiAOnrxpeL3NtrwAXBWK9T3/+YCAWuFJw=
X-Google-Smtp-Source: ABdhPJyY6Kq0QFIxOUEodaPp97AYu4Z0bqd1l4JiIFefiXeXzoPuLNXQ0o1IgWN9NHIAWuL9vRLvCZDw8OsyLSvcytY=
X-Received: by 2002:a05:6512:158e:: with SMTP id bp14mr22128013lfb.509.1629834051824;
 Tue, 24 Aug 2021 12:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629454773.git.rickyman7@gmail.com> <f9100c6e428eafe1b9761f947550e45ccc9e8849.1629454773.git.rickyman7@gmail.com>
In-Reply-To: <f9100c6e428eafe1b9761f947550e45ccc9e8849.1629454773.git.rickyman7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Aug 2021 12:40:40 -0700
Message-ID: <CAM9d7ch4RM5rKrYLKrny3yt3ciK87aqzJ8Wt3ze87u9KBHjyXg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/15] perf workqueue: add queue_work and
 flush_workqueue functions
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 3:54 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> This patch adds functions to queue and wait work_structs, and
> related tests.
>
> When a new work item is added, the workqueue first checks if there
> are threads to wake up. If so, it wakes it up with the given work item,
> otherwise it will pick the next round-robin thread and queue the work
> item to its queue. A thread which completes its queue will go to sleep.
>
> The round-robin mechanism is implemented through the next_worker
> attibute which will point to the next worker to be chosen for queueing.
> When work is assigned to that worker or when the worker goes to sleep,
> the pointer is moved to the next worker in the busy_list, if any.
> When a worker is woken up, it is added in the busy list just before the
> next_worker, so that it will be chosen as last (it's just been assigned
> a work item).

Do we really need this?  I think some of the complexity comes
because of this.  Can we simply put the works in a list in wq
and workers take it out with a lock?  Then the kernel will
distribute the works among the threads for us.

Maybe we can get rid of worker->lock too..

Thanks,
Namhyung
