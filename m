Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EEB364CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhDSVHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhDSVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:07:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3588FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 14:07:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so2288130edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqWPSSLK1ZAc2II95YLqkgqUWBy+c7lJqMXj3jcV9S0=;
        b=T3Q7GLrxBf5JAI3wJ57yqVrAKv9Tyw9NnQ6Pj9uHFyMTtITMSYJx7SD5I6jxpacruB
         1/1qMGUUUISgiLxGjHIC+IjuuGWhBd85mXZfPAS+bcnN+cdo03XjEsBydNwygwyZOBx+
         FLtB7j/A670+BO2tcPhWG/tuRiaGmChnI8tx4QBXwjhfc8C8h+ooJL2PZcBjInLA+3pZ
         jLy3h1dvm07FmUWlY82Dtqkmp/xUTBSFSgzJwTmuWiIoIBa7kigXVIUhhb7av2zipHtF
         zDaAjO9cV3KnQP9ykUue7bGtTud2XCUpXdBNUiwbd6j547d3vHFBwHQh91eK6KHHD3u9
         nJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqWPSSLK1ZAc2II95YLqkgqUWBy+c7lJqMXj3jcV9S0=;
        b=byb700zTP9h4Qx1O/wovIkkPPTwWXgLvkY9SY4xl+kWPHBqteagkuT5kpyF1czViQo
         Udb1FVS4wQ7cjv35t8CKO5rGYclcj/bzzom1B9/XoN4dtBVU33XGnCtx6RJyRDGWi4M/
         N8M0Tgrg1l7HGQVoX8RQLdLLK3yXJ3zIpdDd/0qd79xhJkWcZ8XP1Jpor3y23xceevCg
         CX1T3HESmw7Z9zINh3jS9vVwT6n/WW9WVSB0s5U4n2ZLAI5wHxG1Nd7tvbRhHY6BhMQl
         iU2RQ0bqc++F8BwhSf9ZybMxrskc447gI7sUTBPycFCEnCW/+KYaPGY2/UaNcFfBfk6d
         27Cg==
X-Gm-Message-State: AOAM532b9pc+JTVrRRRxsPY5q3j6aJ9aun8bn/6X8amPw2W6zomFvbwM
        LUS9DjnarOK3YQvA9dseA3Y3RshdE6mS9tPRX1w7t9v33tq33A==
X-Google-Smtp-Source: ABdhPJzxIOhgV/ML+J0N2gtnQmUaGvRP/H4Rj7HWzg7DRfZR6INVWCd21eAAL6//fvQeqohKO8x/0DFQsCYeb3YY11M=
X-Received: by 2002:aa7:dd0f:: with SMTP id i15mr8570558edv.12.1618866439584;
 Mon, 19 Apr 2021 14:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210419184455.2987243-1-lrizzo@google.com> <20210419191712.GB26214@worktop.programming.kicks-ass.net>
In-Reply-To: <20210419191712.GB26214@worktop.programming.kicks-ass.net>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Mon, 19 Apr 2021 23:07:08 +0200
Message-ID: <CAMOZA0JxwQFfA=acfr255xcR85ztv-URwaQQFHR6RrLk-cPbvg@mail.gmail.com>
Subject: Re: [PATCH] smp: add a best_effort version of smp_call_function_many()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, axboe@kernel.dk,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 9:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Apr 19, 2021 at 11:44:55AM -0700, Luigi Rizzo wrote:
> > Regardless of the 'wait' argument, smp_call_function_many() must spin
> > if any of the target CPUs have their csd busy waiting to be processed
> > for a previous call. This may cause high tail latencies e.g. when some
> > of the target CPUs are running functions that disable interrupts for a
> > long time; getrusage() is one possible culprit.
> >
> > Here we introduce a variant, __smp_call_function_many(), that adds
> > a third 'best_effort' mode to the two existing ones (nowait, wait).
> > In best effort mode, the call will skip CPUs whose csd is busy, and if
> > any CPU is skipped it returns -EBUSY and the set of busy in the mask.
> > This allows the caller to decide how to proceed, e.g. it might retry at
> > a later time, or use a private csd, etc..
> >
> > The new function is a compromise to avoid touching existing callers of
> > smp_call_function_many(). If the feature is considered interesting, we
> > could even replace the 'wait' argument with a ternary 'mode' in all
> > smp_call_function_*() and derived methods.
>
> I don't see a user of this...

This is actually something for which I was looking for feedback:

my use case is similar to a periodic garbage collect request:
the caller tells targets that it may be time to do some work,
but it does not matter if the request is dropped because the
caller knows who was busy and will reissue pending requests later.

I would expect something like the above could be useful e.g.
in various kinds of resource manager.

However, a grep for on_each_cpu_*() and smp_call_function_*()
mostly returns synchronous calls (wait=1).

Any possible candidates that people can think of ?

thanks
luigi
