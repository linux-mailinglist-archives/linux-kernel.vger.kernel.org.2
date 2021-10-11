Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABD0428FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhJKOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:02:45 -0400
Received: from foss.arm.com ([217.140.110.172]:56384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238353AbhJKOAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:00:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A31FB101E;
        Mon, 11 Oct 2021 06:58:45 -0700 (PDT)
Received: from [10.1.31.146] (e127744.cambridge.arm.com [10.1.31.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44E453F694;
        Mon, 11 Oct 2021 06:58:43 -0700 (PDT)
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
 <20211004062638.GB174271@leoy-ThinkPad-X240s>
 <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
 <20211006093620.GA14400@leoy-ThinkPad-X240s>
 <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
 <be937a2e-311b-2a8b-1094-39c203c6d9f3@arm.com>
 <CAM9d7cho2hN+NDWd9-P-AQAf3D8WfPgCpEDe7cD6hk5FoA_c8Q@mail.gmail.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <87dad53f-a9a5-cd36-7348-ee10f4edd8fb@arm.com>
Date:   Mon, 11 Oct 2021 14:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cho2hN+NDWd9-P-AQAf3D8WfPgCpEDe7cD6hk5FoA_c8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On 09/10/2021 01:12, Namhyung Kim wrote:

> Hi German,
>
> On Fri, Oct 8, 2021 at 4:08 AM German Gomez <german.gomez@arm.com> wrote:
>
> [...]
>
> I think we should use context-switch even for kernel samples, but
> only if the context packets are not available.
>
> Thanks,
> Namhyung

I think I agree with that you say. If --switch-events is not enabled by
default like you mention, an user could opt-in to using the fallback if
there's no better option for kernel tracing yet.

@Leo, what are your thoughts on this? Perhaps adding a warning message
to tell the user to please enable context packets, otherwise the results
will have workload-dependant inaccuracies, could be a good enough
compromise?

Thanks,
German
