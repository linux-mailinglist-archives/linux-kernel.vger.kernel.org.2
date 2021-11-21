Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18DE458552
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbhKURTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhKURTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:19:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1CEC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:16:35 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so28187692wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMskKUFojdaSx7FY5tXnrdrylHqeuhnkZBYNT3YKaC0=;
        b=ahVa5nKsJeGoG6b//fbORyjKR5viDRITqYKqkUSARIJMDmo7P/m2EaSmP8KHlhLoQE
         gjq2iaeKhGJ/4h15lJh45DpgrSV2W0yf9/ASRkwO+OQ5MQz0gFZ7IsPXdMgAcA5nNhhg
         y7tGI2v54VqGhcrxcQx/ZPjddJXGh7Gz2nb6toNyPQ5ZRKlMhacV3ojQstDD7T5AE7Up
         L+1LU62r0jNBsUAYwpiQ9t83tQXoDPEWlLq/a1rIXr/7zQrgIIttRAXpckTt8+QgwXx5
         NEOBfPPgF+4zbPbnz3NNT4+BWwrMzzzEpZKOK0DlHEcU5Ljx2yKyz2EkPqp0rH2JxSBX
         w5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMskKUFojdaSx7FY5tXnrdrylHqeuhnkZBYNT3YKaC0=;
        b=bDAR6J+vGQIxCrjQBqPb63/ppjAc7t1JB242cIzWKpAqkm0FLUbBoklyYWtwJj47KZ
         6Vq40Rru9vh/Epk6ZNz5Z529dIl1kDmwNEhwG6Sfp3MrECj7J4hTWCR6PMhLkY8a1vis
         qUXPtZixfhbOizpn4GRSRcfv0dkRsWpKTXYIQt+w+/K0OqbRZ69hmLe8LMDyArD+JUiO
         bXeyb5odGyQw/KoOtYZhKUSfpPzBUQ5O7tT0HoHsNRraZ90y584WWkLIdx6dl8wCp9jJ
         CoJUXyWkCjxhSGWPb9sB83I6a5JoUwGwysiJJhtrr6dWbgdiqOgZFNcX7x0rHMgqmTPK
         eIgQ==
X-Gm-Message-State: AOAM531BkoD0TpYfXhatX8c6puNzWAcye47y3UlhKJlmMMAfZoa4uPx5
        R1ARPCF1pVYlIUvDHZeiNap05080pEmpPTX+gLU=
X-Google-Smtp-Source: ABdhPJyVbkwmwyFw19aMyUhynkNe8l4JUuv9cA/T+H6G7ZtjyteeN2yPfAeegBnVfio9oV+m/2gAviUC9nHsOa4BDG8=
X-Received: by 2002:adf:efc6:: with SMTP id i6mr30334050wrp.428.1637514993816;
 Sun, 21 Nov 2021 09:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20211113120632.94754-1-xiehuan09@gmail.com> <20211113120632.94754-3-xiehuan09@gmail.com>
 <20211119230936.76337b13cd0fd15d66d437b8@kernel.org>
In-Reply-To: <20211119230936.76337b13cd0fd15d66d437b8@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 22 Nov 2021 01:16:21 +0800
Message-ID: <CAEr6+EAZUH-pG81-mMa2j5MSgLqDRZGKxRzO4P-y+AUqfBMMrA@mail.gmail.com>
Subject: Re: [RFC][PATCH v5 3/4] trace/objtrace: Add testcases for objtrace
 trigger parsing
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, Nov 19, 2021 at 10:09 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Sat, 13 Nov 2021 20:06:31 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Please add a patch description here.
>
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > ---
> >  .../ftrace/test.d/trigger/trigger-objtrace.tc | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> > new file mode 100644
> > index 000000000000..4efcd7eee694
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> > @@ -0,0 +1,41 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test objtrace-trigger
> > +# requires: kprobe_events
>
> Hmm, didn't you add something for this in <tracefs>/README?

Sorry, I ignored  it.

> Instead of checking trigger file, I recommend to update
>
> There is a text data in the kernel/trace/trace.c;
> static const char readme_msg[] =
> ...
>         "\t   trigger: traceon, traceoff\n"
>         "\t            enable_event:<system>:<event>\n"
>         "\t            disable_event:<system>:<event>\n"
> #ifdef CONFIG_HIST_TRIGGERS
>         "\t            enable_hist:<system>:<event>\n"
>         "\t            disable_hist:<system>:<event>\n"
> #endif
>
> You can add somewhere near there as
>
> #ifdef CONFIG_TRACE_OBJECT
>         "\t            objtrace:add:..." // fill syntax.
> #endif
>
> And then, you can write the pattern in the requires line, like
>
> # requires: kprobe_events "objtrace":README
>
> Thank you,

Thanks, I will add them to <tracefs>/README, and modify the
trigger-objtrace.tc file.

> > +
> > +fail() { #msg
> > +    echo $1
> > +    exit_fail
> > +}
> > +
> > +echo 'p bio_add_page arg1=$arg1' > kprobe_events
> > +
> > +FEATURE=`grep objtrace events/kprobes/p_bio_add_page_0/trigger`
> > +if [ -z "$FEATURE" ]; then
> > +    echo "objtrace trigger is not supported"
> > +    exit_unsupported
> > +fi
>
>
> > +
> > +echo "Test objtrace trigger"
> > +echo 'objtrace:add:0x28(arg1):u32:1 if comm == "cat"' > \
> > +     events/kprobes/p_bio_add_page_0/trigger
> > +if [ -z $? ]; then
> > +     fail "objtrace trigger syntax error"
> > +fi
> > +
> > +echo "Test objtrace semantic errors"
> > +
> > +# Being lack of type size
> > +! echo 'objtrace:add:0x28(arg1):1' > events/kprobes/p_bio_add_page_0/trigger
> > +# Being lack of objtrace command
> > +! echo 'objtrace:0x28(arg1):u32:1' > events/kprobes/p_bio_add_page_0/trigger
> > +# Bad parameter name
> > +! echo 'objtrace:add:argx:u32:1' > events/kprobes/p_bio_add_page_0/trigger
> > +
> > +echo "reset objtrace trigger"
> > +
> > +echo '!objtrace:add:0x28(arg1):u32' > \
> > +     events/kprobes/p_bio_add_page_0/trigger
> > +echo '-:p_bio_add_page_0' >> ./kprobe_events
> > +
> > +exit 0
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
Thanks,
---
JeffXie
