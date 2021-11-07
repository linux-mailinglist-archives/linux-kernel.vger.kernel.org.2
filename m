Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0E44729A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 11:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhKGLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 06:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhKGLAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 06:00:45 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABDFC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 02:58:03 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id bq14so13019701qkb.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 02:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=hWSo8DJQtX4GR7sZ4HDGGcwPNQ6XTO9xR3T8gxf+CbM=;
        b=Ry0BZOsKiVK5/YemWvFUeofA/NFeTHLMZiL8o7KH+EyE/ORTNoJkdAFF9qgkaIJ5r0
         Sv8u3iIx1I/20p3xYyxrvgRg9Jb+304+mruE+gFRMiEvage22dqrt/567Zq+6FdNN2Vt
         t1ef6xuq1MRZFGc6Z6sLBtNtJ0/e/sl12fA1owcQxh6iy+BL+Wi3K2T/FTvqFW+Y8Jyb
         M6nnIvivrecQAYNqfFE9OrPHXq2KP9dJQkg48XM8igP1Cmdms1IgtUur8QBjv2hbk9PU
         jr1ZeI66rG0wirn3gstcQ3iN39qYmLtZMJzEf8xR2y3akOOjRCoUZDgIWDvh4+AkXGVI
         cf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=hWSo8DJQtX4GR7sZ4HDGGcwPNQ6XTO9xR3T8gxf+CbM=;
        b=mTsN7ysrg0EXjQV57pBnmQfDvbYmwsRCgn7rTSQpiuGqIMT6kiGHY7o7FK51IGiKDK
         NG/U3bAnKwp+UtM28pq8yRfEAvB1kAZZW2gC3WLMZ8Jzh8Qop8LdSjw4YaRAlE/4FIya
         jQqgBNrijxn9cAxgwtUHmgvXnJRB5zDm79Ey5bdg/6rO1d1YRJVBMn1/FqfpMt8w/Qtl
         CWfRtT3kIVk3A/3hWyYB3hIVSHmRw6+UCMDU5zXxXBms2WuEtKrxZIMvNM6I61SSqNuq
         yJZIZe0BbwE8731iiARk5PcnjCyCOVIvCQTlmwT4iB3le8TmT0EufVgLUY2I0gUxLj6m
         WNqQ==
X-Gm-Message-State: AOAM531+TgPTqLLtkXt2Lbk06nJHLUHOa6sl3/oKDpjnW24BK92kNjef
        Us+nQMuj62AYLMgwb07cN9eY1KHe2Uk=
X-Google-Smtp-Source: ABdhPJwz/rllM0WCAxqVxlz9mK2t/Hn7xuO8Da8Ek/b6ZNRStIAR2Wul+AmI4fJgLqongANRF5KGvQ==
X-Received: by 2002:a05:620a:448e:: with SMTP id x14mr56229275qkp.406.1636282681617;
        Sun, 07 Nov 2021 02:58:01 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 17sm8952105qtw.16.2021.11.07.02.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 02:58:01 -0800 (PST)
Date:   Sun, 07 Nov 2021 07:57:55 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
User-Agent: K-9 Mail for Android
In-Reply-To: <11a4cec1-8169-0891-b9c8-4d3a7b689d86@amd.com>
References: <20211029224929.379505-1-namhyung@kernel.org> <20211103072112.32312-1-ravi.bangoria@amd.com> <CAM9d7chQH+Br6NJhDdjjOdV7FsODS0_Rj+w-UsfzUud27iPNbQ@mail.gmail.com> <YYbWUetkc6keL/Xa@kernel.org> <11a4cec1-8169-0891-b9c8-4d3a7b689d86@amd.com>
Message-ID: <4F788351-0DB6-4A31-B1B5-7065BAE6C3F8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 7, 2021 7:25:45 AM GMT-03:00, Ravi Bangoria <ravi=2Ebangoria@a=
md=2Ecom> wrote:
>
>
>On 07-Nov-21 12:54 AM, Arnaldo Carvalho de Melo wrote:
>> Em Fri, Nov 05, 2021 at 11:00:29AM -0700, Namhyung Kim escreveu:
>>> Hello,
>>>
>>> On Wed, Nov 3, 2021 at 12:22 AM Ravi Bangoria <ravi=2Ebangoria@amd=2Ec=
om> wrote:
>>>>
>>>>> The current logic for the perf missing feature has a bug that it can
>>>>> wrongly clear some modifiers like G or H=2E  Actually some PMUs don'=
t
>>>>> support any filtering or exclusion while others do=2E  But we check =
it
>>>>> as a global feature=2E
>>>>
>>>> (Sorry to pitch in bit late)
>>>>
>>>> AMD has one more problem on a similar line=2E On AMD, non-precise and
>>>> precise sampling are provided by core and IBS pmu respectively=2E Plu=
s,
>>>> core pmu has filtering capability but IBS does not=2E Perf by default
>>>> sets precise_ip=3D3 and exclude_guest=3D1 and goes on decreasing prec=
ise_ip
>>>> with exclude_guest set until perf_event_open() succeeds=2E This is
>>>> causing perf to always fallback to core pmu (non-precise mode) even i=
f
>>>> it's perfectly feasible to do precise sampling=2E Do you guys think t=
his
>>>> problem should also be addressed while designing solution for Namhyun=
g's
>>>> patch or solve it seperately like below patch:
>>>>
>>>> ---><---
>>>>
>>>> From 48808299679199c39ff737a30a7f387669314fd7 Mon Sep 17 00:00:00 200=
1
>>>> From: Ravi Bangoria <ravi=2Ebangoria@amd=2Ecom>
>>>> Date: Tue, 2 Nov 2021 11:01:12 +0530
>>>> Subject: [PATCH] perf/amd/ibs: Don't set exclude_guest by default
>>>>
>>>> Perf tool sets exclude_guest by default while calling perf_event_open=
()=2E
>>>> Because IBS does not have filtering capability, it always gets reject=
ed
>>>> by IBS PMU driver and thus perf falls back to non-precise sampling=2E=
 Fix
>>>> it by not setting exclude_guest by default on AMD=2E
>>>>
>>>> Before:
>>>>   $ sudo =2E/perf record -C 0 -vvv true |& grep precise
>>>>     precise_ip                       3
>>>>   decreasing precise_ip by one (2)
>>>>     precise_ip                       2
>>>>   decreasing precise_ip by one (1)
>>>>     precise_ip                       1
>>>>   decreasing precise_ip by one (0)
>>>>
>>>> After:
>>>>   $ sudo =2E/perf record -C 0 -vvv true |& grep precise
>>>>     precise_ip                       3
>>>>   decreasing precise_ip by one (2)
>>>>     precise_ip                       2
>>>>
>>>> Reported-by: Kim Phillips <kim=2Ephillips@amd=2Ecom>
>>>> Signed-off-by: Ravi Bangoria <ravi=2Ebangoria@amd=2Ecom>
>>>
>>> It'd be nice if it can cover explicit -e cycles:pp as well=2E  Anyway,
>>=20
>> Ravi, please consider Namhyung's request, a patch on top as I'm adding
>> this already=2E
>
>For explicit :pp modifier, evsel->precise_max does not get set and thus p=
erf
>does not try with different attr->precise_ip values while exclude_guest s=
et=2E
>So no issue with explicit :pp:
>
>  $ sudo =2E/perf record -C 0 -e cycles:pp -vvv |& grep "precise_ip\|excl=
ude_guest"
>    precise_ip                       2
>    exclude_guest                    1
>    precise_ip                       2
>    exclude_guest                    1
>  switching off exclude_guest, exclude_host
>    precise_ip                       2
>  ^C
>
>Also, with :P modifier, evsel->precise_max gets set but exclude_guest doe=
s
>not and thus :P also works fine:
>
>  $ sudo =2E/perf record -C 0 -e cycles:P -vvv |& grep "precise_ip\|exclu=
de_guest"
>    precise_ip                       3
>  decreasing precise_ip by one (2)
>    precise_ip                       2
>  ^C

Perfect, I'll add this analysis to the cset log message=2E

- Arnaldo
>
>Thanks,
>Ravi
