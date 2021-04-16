Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4E361DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbhDPKT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:19:58 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:40548 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbhDPKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:19:56 -0400
Received: by mail-lf1-f47.google.com with SMTP id f17so36909784lfu.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agSuEBpLGw6WiRVSHHusHcU7auKlzOniosJ5ceeovxM=;
        b=iDTsYAzFnAAs0Gz0MpDrSFKfBrFue29lmkgNh1XU5bQoRYPZ9d8Jc+C6JcFxdYTogE
         Wvyt2D/TjtVuYys1zHPVFtBG9/NCLqwlGpXHuWPFTveeOhGisEGq6FfMaLjDVbGNvwVK
         XwosSSM0Uk+DkEA+Fm/gCMcVTse+fAY0/JF9wlgFwuT1NmVyO5mfifq9IDc3EK+gS6LH
         NGayQDXY+6xsfE4J6QIYIAXwplR3ArpE6YBPuG++BU2lvEPRPuZdxljJPmBlGK2rQVkr
         7HHLq3D9ch0dMFK4B0Zao1RnMyaACMzip5euXMQH9UHmrF0cUT+/Q/qDHBBR18a2QAXg
         WyOw==
X-Gm-Message-State: AOAM533c/igMbBHIIr9z8ecFfgEVTeRd37nefIOTCk6EcsvZha4K2YJb
        SKvQSD2zXpWEEyytHOjnB8/6ac6hmSd8zomI4vo=
X-Google-Smtp-Source: ABdhPJwqfPbXlCiAAu+O3sytE2K0GpYxR8CCGwY3oHuN6cmvZ9WpPDf3orqA2EIVOnnCyOGwsaj29RL+0F95pKXAkgc=
X-Received: by 2002:ac2:4e6d:: with SMTP id y13mr2563680lfs.509.1618568371336;
 Fri, 16 Apr 2021 03:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net> <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
 <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net> <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
In-Reply-To: <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Apr 2021 19:19:20 +0900
Message-ID: <CAM9d7cjN9ZuTUCdSR-bZeuatSJnL769th_G4M=xvO542rezj1g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 6:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Duh.. this is a half-finished email I meant to save for later. Anyway,
> I'll reply more.

Nevermind, and thanks for your time! :-)

Namhyung
