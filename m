Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5351C3B09C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhFVQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFVQDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:03:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D93C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:00:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1827603wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOMZk1VKxvEsQe+425mKGnLA46HeEVTGsHHfQ5TUmdo=;
        b=qf/fz46NPHaWfKJ5ojds9u2NYgfXiZNcmgkC6EINZuigVXaowBRq1Dfsr1lBSTZt3U
         eTRLvyjvjY5NBjK22ij1enha6oBN4bnvaf+I+8mNNhaKmcHek0wFDkTGmVJN2fM/9nPg
         yLnit/yU1sLblVKOht0L0ue5wrmmskduEtGR1NJzGEmMOE2C1nlAE6I/KRvMXDLL5uop
         mb3fwBNpowalE9b+Ui5rp0f5CnEisk8vb9/tJq+oQX8sFoSS3xK3vgaJEGDTZEtE4ABo
         zAxAI2ERqMj2e7WP3M9btYT0qVrk6AFOWnft9hmXilMET2N+KDozNSLMzpCcjJJMOWrN
         8twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOMZk1VKxvEsQe+425mKGnLA46HeEVTGsHHfQ5TUmdo=;
        b=g4gm++iXckwbeyAZ+3lyghadcHVA11aoPnsZp8qHUIP6g1uyxbWUr1XcF+cYZmdSQ+
         /B7Mefk32Wpi3OEHwewwasTJsyfZ+8IdRsmdYqpIYIFGq6J5/tlNm4ZzB3P0kYdD621l
         vYRH9TqAm2SDiqbiF3h//jWGz0yzWZeY2TT6Jbn5f1hyRVCt37j3Bu2LWc1/vtwVIUrU
         OLM1B6J6I0/7tterOZtjzERy8E7SYr1Wb9dXUEPtuLJq0xkofFQoolEnu/rqlIq69CfS
         37AdwsQxsJDG8CsxxHHmct3/R/kg7qHj7ytSKgVJ1sVqILDDvzo7wjb0CKEw4+O8kbMi
         O7tQ==
X-Gm-Message-State: AOAM531NeuI11zl1BFij9WysNhKr5IdXWIf3Mr0vgCfOwxnx/SOqlxi+
        H/x7YdAgXpJanWy1xhSrEr8/iQYxIpMlPENOqVrBFA==
X-Google-Smtp-Source: ABdhPJzSoujWiRAvyGIwEgL3UvR+fnBtxVS+HiJRtZsgofK9RRT0hDyY9RXFGnx6uEwTGNXL5kYwR8bY6o4aPKWadd4=
X-Received: by 2002:a05:600c:2484:: with SMTP id 4mr5336575wms.76.1624377643601;
 Tue, 22 Jun 2021 09:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <ecd941b3-2fd5-61d8-93a1-76a3a3ee4138@huawei.com>
 <CAP-5=fUxQZ+rxLEn6jeRNVMf48BaPNdaUdoMs8LY4P-GROiOnw@mail.gmail.com> <cd501541-deb5-f2f5-e086-cca44b40c87d@huawei.com>
In-Reply-To: <cd501541-deb5-f2f5-e086-cca44b40c87d@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Jun 2021 09:00:31 -0700
Message-ID: <CAP-5=fU05k62d57pbWquqv3Z1RFzWMOB1d3OFEcEax5btEWEzg@mail.gmail.com>
Subject: Re: perf tool: About tests debug level
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 4:58 AM John Garry <john.garry@huawei.com> wrote:
>
> On 22/06/2021 06:04, Ian Rogers wrote:
> >> ---- end ----
> >> Parse and process metrics: FAILED!
> >>
> >> Note that the "FAILED" messages from the test code come from pr_debug().
> >>
> >> In a way, I feel that pr_debug()/err from the test is more important
> >> than pr_debug() from the core code (when running a test).
> >>
> >> Any opinion on this or how to improve (if anyone agrees with me)? Or am
> >> I missing something? Or is it not so important?
> > Hi John,
> >
>
> Hi Ian,
>
> > I think the issue is that in the parsing you don't know it's broken
> > until something goes wrong. Putting everything on pr_err would cause
> > spam in the not broken case.
>
> Right, I would not suggest using pr_err everywhere.
>
> > Improving the parsing error handling is a
> > big task with lex and yacc to some extent getting in the way. Perhaps
> > a middle way is to have a parameter to the parser that logs more, and
> > recursively call this in the parser when parsing fails. I guess there
> > is also a danger of a performance hit.
>
> So I am thinking that for running a test, -v means different levels logs
> for test code and for core (non-test code). For example, -v prints
> pr_warn() and higher for test logs, but nothing for core logs. And then
> -vv for running a test gives pr_debug and above for test logs, and
> pr_warn and above for core logs. Or something like that.
>
> Maybe that is not a good idea. But I'm just saying that it's hard to
> debug currently at -v for tests.
>
> Thanks,
> John

I think this sounds good. It'd be nice also to have verbose output in
the shell tests following the same convention. There's currently no
verbose logging in shell tests but I propose it here:
https://lore.kernel.org/lkml/20210621215648.2991319-1-irogers@google.com/
By their nature some of the shell tests launch perf, perhaps there can
be some convention on passing the verbose flag through in those cases.

Thanks,
Ian
