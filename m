Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBD32E048
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 04:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCEDqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 22:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCEDqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 22:46:03 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58356C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 19:46:03 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v9so1308073lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 19:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ArP2QxXhXsHO9IYd6aC5W/1+S3Xa68nFulFY4QAnoPg=;
        b=QZP9EkYpO17zYsV+TvkIUeoVUSJyZUFFb1m5jW2oabK0SXMjeevcPfXDmM5XIY9tDL
         EvPjAmXmExNYa33iA332ymuaMJXoFzoxskHi0In3XeSGUKAMJLBVUNqgDjarmbEAyetM
         Kt3PrmCZ0np4JIFA0NXYspvBy1rNWRgQiN56s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ArP2QxXhXsHO9IYd6aC5W/1+S3Xa68nFulFY4QAnoPg=;
        b=nonV2YF2wtGimXe0nI+28g3LRvNiNZSLCxK36G9z92PVFx3WTgVrnbVR7zg2ja/OD/
         LdfChDqG39NRyrZSia4GYP4OejwzQTdTPBLPjtGfm0XXUk5E/CAsPTw378l5gD45z8xQ
         kNtdWbfkOYJugFg70ZsVgr3p3xkQU6h2xLDqGBvGgIWpaJyy5YH5CYCUmj2PmaxIWYpt
         C3iIifaXVhgMgaU0k+ea1t2yMPvAWsABTmOF9FFlOC/AVTlbMbXJ8Dse7p+g6+jXO8mu
         Y1KwV6btOKaCh7WCH02LWSNroEMTtRF7/BhO61+AqOey8MhRfXrFwbQHoDMtH8utiCJC
         f+rg==
X-Gm-Message-State: AOAM5317lJSk7qufD0M/16q45IivyKMSKZodRxTpM2VXyyh5PYHzGDxC
        GifBEa3abw2hVhuCa11RaWfLpi6kO+7Npg==
X-Google-Smtp-Source: ABdhPJz6wd8WkcaKnB+2WnrLro7gwWlzZVvyPgWbmWZCiPaz6nWbq+HiDHr0HSfN5o/mI/NteCRD9g==
X-Received: by 2002:a19:8c13:: with SMTP id o19mr4008296lfd.225.1614915961477;
        Thu, 04 Mar 2021 19:46:01 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id h10sm143364ljb.101.2021.03.04.19.46.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 19:46:01 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id n16so1277004lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 19:46:00 -0800 (PST)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr4015090lfo.201.1614915960446;
 Thu, 04 Mar 2021 19:46:00 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Mar 2021 19:45:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQWHDUFjzmAazg8WN0BR7nOyHmduj-MV1GWWDUu+UKCQ@mail.gmail.com>
Message-ID: <CAHk-=wgQWHDUFjzmAazg8WN0BR7nOyHmduj-MV1GWWDUu+UKCQ@mail.gmail.com>
Subject: "struct perf_sample_data" alignment
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sp there's a note about new warnings in 5.12-rc1 that I looked at, and
many of the warnings made me go "Whaaa?". They were all of the type

   warning: 'perf_event_aux_event' uses dynamic stack allocation

and then when I go look, I see nothing that looks like a dynamic stack
allocation at all.

But you know what? The warning is kind of misleading, but at the same
time it's true in a sense. The problem is that the function (and a lot
of other functions) has a local variable like this:

        struct perf_sample_data sample;

and the definition of that "struct perf_sample_data" has
____cacheline_aligned at the end.

And guess what? That means that now the compiler has actually to play
games with manually aligning the frame of that function, since the
natural stack alignment is *not* a full cacheline aligned thing. So
it's kind of true: the frame allocation is mnot a simple static thing,
it's a nasty complex thing that wastes memory and time.

That ____cacheline_aligned goes back many years, this is not new, it
seems to come from back in 2014: commit 2565711fb7d7 ("perf: Improve
the perf_sample_data struct layout").

But it really seems entirely and utterly bogus. That cacheline
alignment makes things *worse*, when the variables are on the local
stack. The local stack is already going to be dirty and in the cache,
and aligning those things isn't going to - and I quote from the code
in that commend in that commit - "minimize the cachelines touched".

Quite the reverse. It's just going to make the stack frame use *more*
memory, and make any cacheline usage _worse_.

Maybe there are static (non-automatic) cases of that "struct
perf_sample_data" where the alignment makes sense, but it does not
seem to make sense on the _type_. It should be on those individual
variables, not on every perf_sample_data.

I didn't make any real effort to analyze this, but from a few quick
greps, it looks like every single case is an automatic variable on the
stack, and that the forced alignment is actually a bad thing every
single time. It never ever generates better cache use, but it _does_
generate worse code, and bigger stack frames.

Hmm? What am I missing?

                 Linus
