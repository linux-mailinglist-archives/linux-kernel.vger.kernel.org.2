Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E153DDDC1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhHBQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:33:38 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:43742 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhHBQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:33:37 -0400
Received: by mail-lf1-f49.google.com with SMTP id b6so11975149lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 09:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmBOQh62T1UV9eRoKSnknXI5E7fc6g51r7kEChZ41/A=;
        b=P9klfYdbU+OVdE9AXz84+gzNfpAD+G9pdyd9//47WeUutANhwp5lzXTxNyTXiKIB3y
         7JGHHneahawtmMq2lLLlT0OdNqkX4sCUMGZipGoBzCNxakT3tQe0HmJDyQOYZUsPPPUF
         xfuUXa37EJjq2as9ne47d//dehFAP0PyqHcnjGpg3Pegj4lplSd01AJF3+cvXcwKxLVp
         fXj6MjvyaoJHhZKchrGTu9M2C/Q6/q35Dc7J9WbbnD7XU2zrV2Zbf4xYA273h/jNmjDQ
         cOyYA0H4tUyu81OwzsgolNJ8FXSVjQgLf9BwhtKMGKzS76zAlmdnFNbb6dnecaYfcpT/
         E/Cw==
X-Gm-Message-State: AOAM532ahon9Ra5or6ZvwGatemkITwFkPcAREdXg3TUQxU/P52YJqUQ1
        W26fqlDlSvWc0o2CyOUubMXK57XzNQ0OrHq9N5s=
X-Google-Smtp-Source: ABdhPJwW5SOPwKA2YKJQcOU+M2dfVX+1FdDYZvHWRRQQmFlmjP1c81ZSMLZQW4iewN13hIiwuN7206awhNSbktdjmD0=
X-Received: by 2002:a05:6512:3ba7:: with SMTP id g39mr13948336lfv.494.1627922005673;
 Mon, 02 Aug 2021 09:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210719223153.1618812-1-namhyung@kernel.org> <YPaQ94VCtYWSXYnh@krava>
 <YQfwLP4Ebsc3Wzb2@kernel.org>
In-Reply-To: <YQfwLP4Ebsc3Wzb2@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 Aug 2021 09:33:14 -0700
Message-ID: <CAM9d7cijTT9DFec1LRHM0PFwRe6zZ7qE-n9Yw2Qu1hDhLdTfDQ@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] perf inject: Fix broken data with mixed input/output
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Aug 2, 2021 at 6:16 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Tue, Jul 20, 2021 at 11:01:43AM +0200, Jiri Olsa escreveu:
> > On Mon, Jul 19, 2021 at 03:31:48PM -0700, Namhyung Kim wrote:
> > > The perf inject processes the input data and produces an output with
> > > injected data according to the given options.  During the work, it
> > > assumes the input and output files have the same format - either a
> > > regular file or a pipe.  This works for the obvious cases, but
> > > sometimes makes a trouble when input and output have different
> > > formats (like for debugging).
>
> > >  * changes in v3
> > >   - use task-clock:u in the pipe-test.sh
>
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> Thanks, applied.
>
> Had to do some adjustments due to minor conflicts, can you please check
> tmp.perf/core?

Thanks, it looks good to me!
Namhyung
