Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA02D441D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhKAPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhKAPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:13:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A085C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:11:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p18so8433904plf.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FRxiYUYjjBjManTEC+FRiqOqoYoR9gbJXKuCAylEkiE=;
        b=NxtPH22PyRO1d+cm4wFFOdty/7D/lkwyQQFIj9ny6rc2j3QUqqnNZRxWKp/JmWgmqd
         D+wo4mZKmGiQ87MGQFw4KFb2HHQOej1i1tgIGb/VrmFa9RUr58JlRyKiJg4olkbTYWfg
         jxF/HnUXtBIHnPTKF8KHDpShN0k5hXm3TazDbopmQQCWaRwG/D3OQuCVeph4xDf98mG1
         ght6UelcbWR/u0amwlRkACGVKs2UlkbBGT0RBcGl0NbbB0dRxN2Gp5mzo9+EhkBB5ddh
         rWxE6pZFXW8pNmS2iEWXm7xSNj0GUESdgzZc3DVe+QbfNZASVxw4+6NnZ2of7khI/yt4
         fQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FRxiYUYjjBjManTEC+FRiqOqoYoR9gbJXKuCAylEkiE=;
        b=uyUnV7EyISa0vW/453n4h4XqqQRPpyrvR6sdhMGTHXRcsNFHza98h98hI/1YWNHZnE
         2tUjU8zv1hGI3juf0/JvQXNTMOj04WsI2l46DhqQCSP3EqPIvHRhSQ0Erj9oN66LO3uc
         EzEvhxdFxCQIbyFcrD6tso3huuIa7HuzofXeBedStQxN6SfgbubeGZ3NibMlc9xsDyrK
         YNrnWLCuPBg0OlBXiF7ay8EIzY+CB/C+3IYNWryVo+mO8nJH4sJ4QCFuGnils71K9IFR
         TjSX56A5jT0Z+s+x6PE4iUjYP8/NDAi51iLtVtPypurNrfFrogmHEiA634EwmEC9kzXA
         scVg==
X-Gm-Message-State: AOAM530ofnGp4BsKJ8IQGtkgMr0ZDybYsYl3EVouIJcmQzO0qgh3fBNF
        5Qh8fv20fOuveNperhFXmr3TWg==
X-Google-Smtp-Source: ABdhPJy0Wb4AWhFD2xMcZPIL/nB57LMoBAK6IARwjrE85gWXg4n3kHdtP2n1jbYVwonG6lHSFv8yQA==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr12513098pjb.230.1635779471829;
        Mon, 01 Nov 2021 08:11:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.136.124.227])
        by smtp.gmail.com with ESMTPSA id z22sm15037201pfa.214.2021.11.01.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:11:11 -0700 (PDT)
Date:   Mon, 1 Nov 2021 23:11:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
Message-ID: <20211101151101.GA375622@leoy-ThinkPad-X240s>
References: <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
 <be937a2e-311b-2a8b-1094-39c203c6d9f3@arm.com>
 <CAM9d7cho2hN+NDWd9-P-AQAf3D8WfPgCpEDe7cD6hk5FoA_c8Q@mail.gmail.com>
 <87dad53f-a9a5-cd36-7348-ee10f4edd8fb@arm.com>
 <20211011142940.GB37383@leoy-ThinkPad-X240s>
 <8a1eafe3-d19e-40d6-f659-de0e9daa5877@arm.com>
 <eae1a617-2624-dc1f-1ddb-ba9f5600819d@arm.com>
 <20211018132328.GG130233@leoy-ThinkPad-X240s>
 <cd354485-5267-0e07-eb18-ddd0d002ecc3@arm.com>
 <354d76da-5402-5c24-516f-c1f7e58590fc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <354d76da-5402-5c24-516f-c1f7e58590fc@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Fri, Oct 29, 2021 at 11:51:16AM +0100, German Gomez wrote:
> Hi Leo,
> 
> The current plan is to define a global flag in the `struct arm_spe` to
> select the method of pid tracing (context pkt, or switch events):
> 
>     struct arm_spe {
>        /* ... */
>        u8        use_ctx_pkt_for_pid;
>     }
> 
> The method could be determined by peeking at the top element of the
> `struct auxtrace_heap` at the beginning of the perf-report. If ctx
> packets have been collected, the first one should have a context_id !=
> -1. We could then tweak this part of Namhyung patch slightly:

Have one concern: if cannot find the context packet, will the decoder
drop the SPE packets until it find the first context packet?  If this
is the case, I am concern the decoder will run out for all packets
and doesn't generate any samples if the SPE trace data doesn't contain
any context packet.

> 
>     if (!spe->use_ctx_pkt_for_pid &&
>         (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
>          event->header.type == PERF_RECORD_SWITCH))
>             err = arm_spe_context_switch(spe, event, sample);
> 
> Then we could apply patch [1] which wasn't fully merged in the end,
> including similar `if (spe->use_ctx_pkt_for_pid)` to collect the pid/tid
> from the context packets.
> 
> What do you think?

Except the above concern, the solution looks good to me.

Thanks,
Leo
