Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFAE3B7840
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhF2TKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 15:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhF2TKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:10:48 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6C9C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 12:08:21 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a6so90373ioe.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQZ/MG27uCidkTSCI4YoLKoh50so7qSZQ7ja/JlUo2I=;
        b=Gay8DKwtPNOIcUv3WQZgu6ebp3xm3yjkSUbCgRHh5G5dW/iU/Z4b0YKoNPOY2OoRK3
         nnMi42TFY99ajD/oOZkRsZgsDDqoIZGjkuA8k4jtbuqCXbHb4i/KoP8cbgZpK2xkFPUM
         riDcAWG0xttwHPE4eoZh8qy7clDrX6vcLeglrb2TtC0PiBjupAVxAYDRw21H5GUrDEmG
         doBfxpJzfRtAL5WsekApdYYur75uuHRgOAKP9bqp32kD9NEASskZgOpVj3tr79nMir1G
         BNqbowXpXlijfsIgMkE41lF/aDfo7SHxNfPAhaWrlwVKPfYG8e9sGElk2is6N1+poaDQ
         FeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQZ/MG27uCidkTSCI4YoLKoh50so7qSZQ7ja/JlUo2I=;
        b=O0tDMFWrAgFSBmxB+1on+f60+HPvJ6U3QK6TUbp/bJ8usdmurhaOphbj3q4DOUWNxx
         NJX/f2wSYWA84LFKIzjwxeTTyzlvXT/2jIKpcDo0T763kn/nF2KSl0x5Bz8Sds4ZxQOc
         YJe2zzTpZJbavB0KMEanlvSTRfBVfqaTvGIU1JLqeEMFjVzOi2/0NdDLtZJhZzFtWqWD
         okoxHAUTGSL7hNwLt7ACZvuktz/qc35W80GYxBoxwdi5MzzJTPGyD+flz/ECbJ3cKsQL
         svigcMeAwvnW9n269bx5SlvjQ4w04gokVfi03JgLYnJ9cVh2+5eW5AaFUog62Nduozcm
         davQ==
X-Gm-Message-State: AOAM533wSy6jypDfAgBlHzorCf7yD7EdHi+PeEdaoYkRucYg8qNxVwLJ
        8o0C/UenKN4Ev9vxGJjtHDdrAuWa84hq62U2IVYRiQ==
X-Google-Smtp-Source: ABdhPJwr4eRuStLNOekxh98VR4+O4WuPucXa0Z1PA4EcpEt7hPH4pcEgGfGWcA5PF8295m8rsdosb9z+GbGIvofUCLE=
X-Received: by 2002:a5d:8d16:: with SMTP id p22mr5123773ioj.90.1624993700558;
 Tue, 29 Jun 2021 12:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210624164303.28632-1-james.clark@arm.com> <20210624164303.28632-3-james.clark@arm.com>
 <20210628012744.GA158794@leoy-ThinkPad-X240s> <c7906b72-e547-da37-c387-23de65831ac4@arm.com>
 <20210628120802.GC200044@leoy-ThinkPad-X240s> <20210628200132.GB1200359@p14s> <b9a3ae95-987b-d1de-a242-141e7444aa83@arm.com>
In-Reply-To: <b9a3ae95-987b-d1de-a242-141e7444aa83@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 29 Jun 2021 13:08:09 -0600
Message-ID: <CANLsYky4XgfN40O2nYOsFo--XoVUgCDOVqm_r0MG_s8QsN2+LA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Al Grant <al.grant@arm.com>,
        Branislav Rankov <branislav.rankov@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 at 02:52, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 28/06/2021 21:01, Mathieu Poirier wrote:
> > On Mon, Jun 28, 2021 at 08:08:02PM +0800, Leo Yan wrote:
> >> On Mon, Jun 28, 2021 at 11:38:34AM +0100, James Clark wrote:
> >>
> >> [...]
> >>
> >>>>>  static int cs_etm__process_auxtrace_event(struct perf_session *session,
> >>>>>                                     union perf_event *event,
> >>>>>                                     struct perf_tool *tool __maybe_unused)
> >>>>> @@ -2462,7 +2478,8 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
> >>>>>                           cs_etm__dump_event(etm, buffer);
> >>>>>                           auxtrace_buffer__put_data(buffer);
> >>>>>                   }
> >>>>> - }
> >>>>> + } else if (dump_trace)
> >>>>> +         dump_queued_data(etm, &event->auxtrace);
> >>>>
> >>>> IIUC, in the function cs_etm__process_auxtrace_event(), since
> >>>> "etm->data_queued" is always true, below flow will never run:
> >>>>
> >>>>     if (!etm->data_queued) {
> >>>>         ......
> >>>>
> >>>>         if (dump_trace)
> >>>>             if (auxtrace_buffer__get_data(buffer, fd)) {
> >>>>                     cs_etm__dump_event(etm, buffer);
> >>>>                     auxtrace_buffer__put_data(buffer);
> >>>>             }
> >>>>     }
> >>>>
> >>>> If so, it's better to use a new patch to polish the code.
> >>>>
> >>>
> >>> Hi Leo,
> >>>
> >>> I think this is not true in piped mode because there is no auxtrace index.
> >>> In that mode, events are processed only in file order and cs_etm__process_auxtrace_event()
> >>> is called for each buffer.
> >>>
> >>> You can reproduce this with something like this:
> >>>
> >>>      ./perf record -o - ls > stdio.data
> >>>      cat stdio.data | ./perf report -i -
> >>
> >> You are right!  I tried these two commands with cs_etm event, just as
> >> you said, in this case, the AUX trace data is not queued; so the flow
> >> for "if (!etm->data_queued)" should be kept.  If so, I am very fine
> >> for current change.  Thanks for sharing the knowledge.
> >>
> >>> There are some other Coresight features that don't work as expected in this mode, like
> >>> sorting timestamps between CPUs. The aux split patchset won't work either because random
> >>> access isn't possible. And the TRBE patch that I'm working on now won't work, because it
> >>> also requires the random access to lookup the flags on the AUX record to configure the
> >>> decoder for unformatted trace.
> >>
> >
> > There is a lot of things happening in this area.  Based on the above should I
> > still plan to review this set or should I wait for another revision?
>
> From my point of view, this one is final. It looks like both Leo and I have tested
> it with and without his snapshot changes and it's working as expected in both cases.
>

Very well - I will start working on it once I'm through with the
ultrasoc patchset.

> Thanks
> James
>
> >
> > Thanks,
> > Mathieu
> >
> >> Cool, looking forward for the patches :)
> >>
> >> Leo
