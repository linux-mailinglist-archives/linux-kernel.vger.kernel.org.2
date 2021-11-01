Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5D441D78
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhKAPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:39:33 -0400
Received: from foss.arm.com ([217.140.110.172]:42254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhKAPjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:39:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CDE013A1;
        Mon,  1 Nov 2021 08:36:57 -0700 (PDT)
Received: from [10.1.33.137] (e127744.cambridge.arm.com [10.1.33.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99B6C3F5A1;
        Mon,  1 Nov 2021 08:36:54 -0700 (PDT)
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Leo Yan <leo.yan@linaro.org>
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
 <20211101151101.GA375622@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <70967300-4854-30d5-7ab4-5e2601052036@arm.com>
Date:   Mon, 1 Nov 2021 15:36:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211101151101.GA375622@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 01/11/2021 15:11, Leo Yan wrote:
> Hi German,
>
> On Fri, Oct 29, 2021 at 11:51:16AM +0100, German Gomez wrote:
> [...]
> Have one concern: if cannot find the context packet, will the decoder
> drop the SPE packets until it find the first context packet?  If this
> is the case, I am concern the decoder will run out for all packets
> and doesn't generate any samples if the SPE trace data doesn't contain
> any context packet.

Not really. It will only peek at the first decoded packet without
dropping it. I couldn't think of a corner case where the decoder might
miss a context packet for the first records (I also haven't seen any -1
values so far).

>> ï¿½ï¿½ï¿½ if (!spe->use_ctx_pkt_for_pid &&
>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ event->header.type == PERF_RECORD_SWITCH))
>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ err = arm_spe_context_switch(spe, event, sample);
>>
>> Then we could apply patch [1] which wasn't fully merged in the end,
>> including similar `if (spe->use_ctx_pkt_for_pid)` to collect the pid/tid
>> from the context packets.
>>
>> What do you think?
> Except the above concern, the solution looks good to me.

I realized I cannot use the heap for it will not work in timeless
decoding. We can still use the queues though. By the way, is this return
statement in the arm_spe__setup_queue() function misplaced?

    if (spe->timeless_decoding)
            return 0;

Judging by the long comment in the arm_spe_run_decoder() function, it
seems like it should be placed somewhere below the call to "ret =
arm_spe_decode(...)", otherwise arm_spe_run_decoder() will begin with an
uninitialized record?

Thanks,
German

>
> Thanks,
> Leo
