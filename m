Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB089341156
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 01:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhCSAJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 20:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhCSAJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 20:09:27 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44078C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 17:09:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c6so5547484qtc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=KPuaKcVHU66eqqcciUhXc4UiSEJpwQmqPaTMG9LVisE=;
        b=gJ4X5TW1Wd7rUr4XsKjjRtZqjTQtbAu7Be7w2G4dEKlwTBLodSnsx5t7yqtqOWzd0o
         QsFxiRTsod5NXwIM1cFxabe7rReFe3OTTO077t8PVwCE8d3Ax2RgYOizNYVrV2eSqqgv
         c+TXytIWxhRPktHpW+BCYTnbzK5iK9ORRauqa5qrZAiXK/Te8yo8fn5G3s56S9O9ClGE
         VfYWnwc5VeOfaMw/LmbkDh9oGDU4IpG2ET8uCV/EHlI+tjv24BeWYQMnBPvgd6xJ/eUr
         Hb/EkUL7+6+H/grT6ok4izljG2Jui6KclXV/Vbkqt5u/v1qa3nd7wFg4DM73vIh+o9BI
         WiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=KPuaKcVHU66eqqcciUhXc4UiSEJpwQmqPaTMG9LVisE=;
        b=T6EN22U+/rccWbNLvqnn8H3efHAYhknvz634DKdTUl0rY/wvP9Ry7M3w5Dvnhds0rn
         N4Ej0URsir8eV+K24c0sYj/RAMjX7LlAqgFUA8eVRBcGnrO63rz7Lw7eSqeHvOTvucZg
         bBSMqdqPTGNZxMseg+36u9J8M39t30hUkRHAJZUB7etxYsTSBZHy99iqa7PjICTW0iP6
         wWGpiXcpEmn+iljvFq0KjvCWX5vXvPQZncvl77qMw7uU3qHr8CP8R2tUrKzHjhUasCBZ
         h+OGJwBhhdWNrxEkEAsIjKsBjQupvAehfGKWJOdyNxu0smK9nMe18lDa99K9y+BG13s0
         kVQg==
X-Gm-Message-State: AOAM532+WFXXyefBzMuRYSTqAZioXpGCWsrYe0j7AYr1fJuIKf08a18V
        W+g7Uip1FhqrtK4TyezXYZI=
X-Google-Smtp-Source: ABdhPJxSPzxPz4fjRtRTxCyWmMBAFRj/fd7LWrhjpm04t4Kq+SxzFP2zzNL6f0o9liML9Q3BuEz5gQ==
X-Received: by 2002:ac8:4a18:: with SMTP id x24mr6071155qtq.33.1616112566155;
        Thu, 18 Mar 2021 17:09:26 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d84sm2990830qke.53.2021.03.18.17.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 17:09:25 -0700 (PDT)
Date:   Thu, 18 Mar 2021 21:09:11 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <YFPCul51MjrlY65P@krava>
References: <20210316211837.910506-1-songliubraving@fb.com> <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com> <YFH//FRPvrPswhld@kernel.org> <7D48A756-C253-48DE-B536-826314778404@fb.com> <YFPCul51MjrlY65P@krava>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
To:     Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <388AF530-5176-4DB9-93C4-6C302432CE12@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 18, 2021 6:14:34 PM GMT-03:00, Jiri Olsa <jolsa@redhat=2Ecom> wro=
te:
>On Thu, Mar 18, 2021 at 03:52:51AM +0000, Song Liu wrote:
>>=20
>>=20
>> > On Mar 17, 2021, at 6:11 AM, Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>> >=20
>> > Em Wed, Mar 17, 2021 at 02:29:28PM +0900, Namhyung Kim escreveu:
>> >> Hi Song,
>> >>=20
>> >> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb=2Ecom>
>wrote:
>> >>>=20
>> >>> perf uses performance monitoring counters (PMCs) to monitor
>system
>> >>> performance=2E The PMCs are limited hardware resources=2E For
>example,
>> >>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu=2E
>> >>>=20
>> >>> Modern data center systems use these PMCs in many different ways:
>> >>> system level monitoring, (maybe nested) container level
>monitoring, per
>> >>> process monitoring, profiling (in sample mode), etc=2E In some
>cases,
>> >>> there are more active perf_events than available hardware PMCs=2E
>To allow
>> >>> all perf_events to have a chance to run, it is necessary to do
>expensive
>> >>> time multiplexing of events=2E
>> >>>=20
>> >>> On the other hand, many monitoring tools count the common metrics
>(cycles,
>> >>> instructions)=2E It is a waste to have multiple tools create
>multiple
>> >>> perf_events of "cycles" and occupy multiple PMCs=2E
>> >>=20
>> >> Right, it'd be really helpful when the PMCs are frequently or
>mostly shared=2E
>> >> But it'd also increase the overhead for uncontended cases as BPF
>programs
>> >> need to run on every context switch=2E  Depending on the workload,
>it may
>> >> cause a non-negligible performance impact=2E  So users should be
>aware of it=2E
>> >=20
>> > Would be interesting to, humm, measure both cases to have a firm
>number
>> > of the impact, how many instructions are added when sharing using
>> > --bpf-counters?
>> >=20
>> > I=2Ee=2E compare the "expensive time multiplexing of events" with its
>> > avoidance by using --bpf-counters=2E
>> >=20
>> > Song, have you perfmormed such measurements?
>>=20
>> I have got some measurements with perf-bench-sched-messaging:
>>=20
>> The system: x86_64 with 23 cores (46 HT)
>>=20
>> The perf-stat command:
>> perf stat -e
>cycles,cycles,instructions,instructions,ref-cycles,ref-cycles <target,
>etc=2E>
>>=20
>> The benchmark command and output:
>> =2E/perf bench sched messaging -g 40 -l 50000 -t
>> # Running 'sched/messaging' benchmark:
>> # 20 sender and receiver threads per group
>> # 40 groups =3D=3D 1600 threads run
>>      Total time: 10X=2EXXX [sec]
>>=20
>>=20
>> I use the "Total time" as measurement, so smaller number is better=2E=
=20
>>=20
>> For each condition, I run the command 5 times, and took the median of
>
>> "Total time"=2E=20
>>=20
>> Baseline (no perf-stat)			104=2E873 [sec]
>> # global
>> perf stat -a				107=2E887 [sec]
>> perf stat -a --bpf-counters		106=2E071 [sec]
>> # per task
>> perf stat 				106=2E314 [sec]
>> perf stat --bpf-counters 		105=2E965 [sec]
>> # per cpu
>> perf stat -C 1,3,5 			107=2E063 [sec]
>> perf stat -C 1,3,5 --bpf-counters 	106=2E406 [sec]
>
>I can't see why it's actualy faster than normal perf ;-)
>would be worth to find out

Isn't this all about contended cases?

>
>jirka
>
>>=20
>> From the data, --bpf-counters is slightly better than the regular
>event
>> for all targets=2E I noticed that the results are not very stable=2E
>There=20
>> are a couple 108=2Exx runs in some of the conditions (w/ and w/o=20
>> --bpf-counters)=2E
>>=20
>>=20
>> I also measured the average runtime of the BPF programs, with=20
>>=20
>> 	sysctl kernel=2Ebpf_stats_enabled=3D1
>>=20
>> For each event, if we have one leader and two followers, the total
>run=20
>> time is about 340ns=2E IOW, 340ns for two perf-stat reading
>instructions,=20
>> 340ns for two perf-stat reading cycles, etc=2E=20
>>=20
>> Thanks,
>> Song
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
