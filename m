Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B977143A6A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 00:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhJYWh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 18:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbhJYWh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 18:37:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E49C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:35:33 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q6so13572104iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klXlN0zJqmk1eWnEu+/hXLI1dokmsVhjoAFEcoHuwqQ=;
        b=aGRYtffqOi9dXZ21RrjBjD+l82dN+ifp8T+Q11C1BXTSKNp87NEYH/sGros9Un1tIV
         ISYmYeKll86s2JbJqasIxVigulSD/WoVDZU2vCptei1vtpaT7i7H4Y/PYOK7A00JhWZ4
         MFAZUlb/5ouNzs4+yNq35EminP3BzcGrnzFlCM8iRQP1DJgeebqvSk+4bVf5LmyXEC7J
         aS3nNwSL3X7nz48mF+9h3tASo9lBbNBMQHQIeSOLuWQfjkTISoac3sGqlJRWyuKZDuIx
         rhoUJ6YjOR7k6eibf6iBxDvOr82MVzlt6NPHX/yOqY8kE195MR+TEVQGuBEwDogVpGgA
         CRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klXlN0zJqmk1eWnEu+/hXLI1dokmsVhjoAFEcoHuwqQ=;
        b=uxG2BPm4jH3ZSJLt8yztdsfht6OL0OVkwCeOetVU2djNj4eDOp7TDOBoNrcH1GD1Id
         yDWYL8u50SY6CLmP1IV9NlgC4czTijz21s9IlWbIxR/wQF8A5p49JI3gFFobAg2vIfBb
         EbTev04Icy6pZa2Fy2RwaQJJCGupKNoKOHkkvzAFVpxcEU91PsRAxVvuYYP5c2MROkCN
         EOYpFYdPgQrULvaETs9ZE6Q/2Up7N/kVWGPJMSMk4b72yO0MiQPM/j3+Bi6ADId7gadl
         LHan+BiRQSRPUl7eMWry2LDG032ualAg7tniLYtsPcNunQZzgSTuHyU1K/70ONCTPCZd
         tg/A==
X-Gm-Message-State: AOAM532Ui/Sceij5qXIwyeaLNa+aSKWfcw1M1jB5JiOMtGDryXW08SY7
        o6tsjyAVC6FwqEVOzKVXwJg11ALWELeookUQArT2mQ==
X-Google-Smtp-Source: ABdhPJzIG3rsyIADjAI5BsAKx0xhIqdqDYgIZSpry+dx35b7xS9gb0tArEZTTa6JKifPXfk8dksRCGCx+aG8KilXe58=
X-Received: by 2002:a05:6638:4115:: with SMTP id ay21mr12897670jab.90.1635201332884;
 Mon, 25 Oct 2021 15:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com> <20211013174604.747276-7-irogers@google.com>
 <YXAM31HKzS4/qJw/@krava>
In-Reply-To: <YXAM31HKzS4/qJw/@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 25 Oct 2021 15:35:20 -0700
Message-ID: <CAP-5=fWJyUi7M9rQyafYKNeCdUKru33sO3Ld5c8RxDT60+FBTw@mail.gmail.com>
Subject: Re: [PATCH v2 06/22] perf test: Add helper functions for abstraction.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 5:34 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Oct 13, 2021 at 10:45:48AM -0700, Ian Rogers wrote:
>
> SNIP
>
> >       else
> >               pr_debug("%s subtest %d:", t->desc, subtest + 1);
> > @@ -218,11 +257,10 @@ static int test_and_print(struct test_suite *t, bool force_skip, int subtest)
> >               pr_info(" Ok\n");
> >               break;
> >       case TEST_SKIP: {
> > -             const char *skip_reason = NULL;
> > -             if (t->subtest.skip_reason)
> > -                     skip_reason = t->subtest.skip_reason(subtest);
> > -             if (skip_reason)
> > -                     color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", skip_reason);
> > +             const char *reason = skip_reason(t, subtest);
> > +
> > +             if (reason)
> > +                     color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", reason);
> >               else
> >                       color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip\n");
> >       }
> > @@ -397,7 +435,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> >       int width = shell_tests__max_desc_width();
> >
> >       for_each_test(j, k, t) {
> > -             int len = strlen(t->desc);
> > +             int len = strlen(test_description(t, -1));
> >
> >               if (width < len)
> >                       width = len;
> > @@ -407,17 +445,15 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> >               int curr = i++, err;
> >               int subi;
> >
> > -             if (!perf_test__matches(t->desc, curr, argc, argv)) {
> > +             if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
> >                       bool skip = true;
> >                       int subn;
> >
> > -                     if (!t->subtest.get_nr)
> > -                             continue;
> > -
> > -                     subn = t->subtest.get_nr();
> > +                     subn = num_subtests(t);
>
> should you call continue on !subn ?

It's not necessary. When subn == 0 then the loop won't be taken and
skip == true, so the immediately after "if (skip) continue;" will
happen.

Thanks,
Ian

> jirka
>
> >
> >                       for (subi = 0; subi < subn; subi++) {
> > -                             if (perf_test__matches(t->subtest.get_desc(subi), curr, argc, argv))
> > +                             if (perf_test__matches(test_description(t, subi),
> > +                                                     curr, argc, argv))
> >                                       skip = false;
> >                       }
> >
> > @@ -425,22 +461,23 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> >                               continue;
> >               }
> >
>
> SNIP
>
