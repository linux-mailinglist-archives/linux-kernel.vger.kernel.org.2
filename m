Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70A53195AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhBKWPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBKWPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:15:33 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D06C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:14:53 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id r77so6916358qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=PODLmcensEfgZug2I/n2EdIPTP+oXQQxlxWqHaBSMvE=;
        b=PGZpRXqZz3v6ysEf+3RdCR+AXGNav6FdMGtcfgT8dORBSYB5QgjpmVMRu7/kPgZV7B
         Ac2t3N41OzIGGG6qrxHG7fIWuozDfJZIrU2iUH7zk7NcgC23ZMyyn6P7KETR/b3Unsat
         fuZgJ/nGYR22OGFgs9hD53JROgCmTo1bOxF2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=PODLmcensEfgZug2I/n2EdIPTP+oXQQxlxWqHaBSMvE=;
        b=uIiXV50dM3MFs50dlLIQs7SPdfeuI8anAMnvnDkZo6gmdJU0OH7M6RF/RGwi8GKvGX
         KsWvVhHa6IOG/CTMYi8YGSsuN7S2xFmlm7p4WjfogEScCGBYlTIO1FvDj0PhOH+CkhXp
         MX0BwOTvIwChA2J+GlGG3/fkPRrnVRqOSkesVdIVBVDaJLVogfYbFDx5LpieSjzDF+Rb
         jYyveK+SU0HQLhvoMMQYYGyVTkHfiP2q9xiQHoQ9v/Cn0NSD+aA835BTldg7m/noyXLv
         OHlNLkcbm375tDqvMVwZqPbF+d6abZemr6OD7qogVyZnt9Cpv2QJqggqU4RDJM5ofCRL
         TlBQ==
X-Gm-Message-State: AOAM532tJOMRYpItNwFK9uxOTXfyWKkS8b1ucZyu+yGC/yA/kRYyypil
        31S58lDXA/II6M10yq8rR+vM1g==
X-Google-Smtp-Source: ABdhPJxm7fKz2IW+Lp5mEY83KYGNqCeQVKFrao3c9s5/xqP/1b1YyTCNAZI5g4DKOartCK5RACIjcQ==
X-Received: by 2002:a05:620a:227:: with SMTP id u7mr8983263qkm.226.1613081692559;
        Thu, 11 Feb 2021 14:14:52 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id v18sm4844052qkv.62.2021.02.11.14.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:14:51 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 11 Feb 2021 17:14:50 -0500 (EST)
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [perf] perf_fuzzer causes crash in intel_pmu_drain_pebs_nhm()
In-Reply-To: <d2005608-4214-ec01-d6b1-a7d19fab7bf9@linux.intel.com>
Message-ID: <2a655469-de9d-c80-dd7f-26436d6f03a@maine.edu>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu> <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu> <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net> <d2005608-4214-ec01-d6b1-a7d19fab7bf9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021, Liang, Kan wrote:

> > On Thu, Jan 28, 2021 at 02:49:47PM -0500, Vince Weaver wrote:
> I'd like to reproduce it on my machine.
> Is this issue only found in a Haswell client machine?
> 
> To reproduce the issue, can I use ./perf_fuzzer under perf_event_tests/fuzzer?
> Do I need to apply any parameters with ./perf_fuzzer?
> 
> Usually how long does it take to reproduce the issue?

On my machine if I run the commands
		echo 1 > /proc/sys/kernel/nmi_watchdog
                echo 0 > /proc/sys/kernel/perf_event_paranoid
                echo 1000 > /proc/sys/kernel/perf_event_max_sample_rate
                ./perf_fuzzer -s 30000 -r 1611784483

it is repeatable within a minute, but because of the nature of the fuzzer 
it probably won't work for you because the random events will diverge 
based on the different configs of the system.

I can try to generate a simple reproducer, I've just been extremely busy 
here at work and haven't had the chance.

If you want to try to reproduce it the hard way, run the
	./fast_repro99.sh
script in the perf_fuzzer directory.  It will start fuzzing.  My machine 
turned up the issue within a day or so.

Vince

