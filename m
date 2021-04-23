Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA31D3697F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbhDWRGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:06:43 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:44584 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:06:40 -0400
Received: by mail-lj1-f175.google.com with SMTP id a25so43143908ljm.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Scw7Z57rdAZa2hiqBu8RC+dLrEZpg3DOUeAN5WDTx40=;
        b=Jm6GZCbiNgZ4/GhUVJ0hq2PdhhB29uKJ5z5S66fS5gShijkR3C4F7xQiiQJfGHJnHD
         lbwgapj1lgy+jzxczVW2BJQCPl8XWucYTCGjmO4cZhfe7cI+Eui55YEXq4FJlxEXy+TF
         Zh9xuUUCDz4Sep1MCpCI0+g8lB3NfJTYo7K82bfBB28ChqP9YLXthuzcGDqKVkTFRf1v
         lFWGtDYUQQ4cUr0kyKG0gYj9YqySasJBJuDM2EBOfBJiKbtzF7qo84weYgLUYUN0KtVR
         DRMQWA5kCY5ls6I0VQQdRDUBrl4xfpRvTFcWxwvxWr6bsoOT7/Pc79vDZFIu5WA/bRWx
         bPkA==
X-Gm-Message-State: AOAM532ZGjS84rFa4ox+gX7Am9JKNQDjBTmxaJgSDsAu4orvGZSGb4Tl
        sNv/lLE+1BX1QvKXfDnT+NqAlDfE4hJeuKMRHQE=
X-Google-Smtp-Source: ABdhPJw0ey2XwzY3HOr7o82xaNlvuhHijnwYtg6C6LiAHxughdEE0Bqmcf6XJYew/0KLuNWGYhsG902Hm1D/nTpDJ3A=
X-Received: by 2002:a05:651c:30b:: with SMTP id a11mr3385392ljp.52.1619197562455;
 Fri, 23 Apr 2021 10:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <1618470001-7239-1-git-send-email-lirongqing@baidu.com> <a9a29f801740491bb97e765ff58a9772@baidu.com>
In-Reply-To: <a9a29f801740491bb97e765ff58a9772@baidu.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Apr 2021 02:05:51 +0900
Message-ID: <CAM9d7cj4nyr8qeUVOgC43-gyDOwPXBumBhHtpc2S-3f8WrWyKw@mail.gmail.com>
Subject: Re: [PATCH][resend] perf x86 kvm-stat: support to analyze kvm msr
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 22, 2021 at 11:33 AM Li,Rongqing <lirongqing@baidu.com> wrote:
> > Subject: [PATCH][resend] perf x86 kvm-stat: support to analyze kvm msr
> >
> > From: Lei Zhao <zhaolei27@baidu.com>
> >
> > usage:
> >     - kvm stat
> >       run a command and gather performance counter statistics
> >
> >     - show the result:
> >       perf kvm stat report --event=msr
> >
> > See the msr events:
> >
> > Analyze events for all VMs, all VCPUs:
> >
> > MSR Access Samples  Samples% Time%  Min Time Max Time  Avg time
> >
> >   0x6e0:W   67007  98.17%   98.31%  0.59us   10.69us  0.90us ( +-
> > 0.10% )
> >   0x830:W    1186   1.74%    1.60%  0.53us  108.34us  0.82us ( +-
> > 11.02% )
> >    0x3b:R      66   0.10%    0.09%  0.56us    1.26us  0.80us ( +-
> > 3.24% )
> >
> > Total Samples:68259, Total events handled time:61150.95us.
> >
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > Signed-off-by: Lei Zhao <zhaolei27@baidu.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> > ---
> >  tools/perf/arch/x86/util/kvm-stat.c |   46
> > +++++++++++++++++++++++++++++++++++
> >  1 files changed, 46 insertions(+), 0 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/kvm-stat.c
> > b/tools/perf/arch/x86/util/kvm-stat.c
> > index 0729204..c5dd54f 100644
> > --- a/tools/perf/arch/x86/util/kvm-stat.c
> > +++ b/tools/perf/arch/x86/util/kvm-stat.c
> > @@ -133,11 +133,56 @@ static void ioport_event_decode_key(struct
> > perf_kvm_stat *kvm __maybe_unused,
> >       .name = "IO Port Access"
> >  };
> >
> > + /* The time of emulation msr is from kvm_msr to kvm_entry. */ static
> > +void msr_event_get_key(struct evsel *evsel,
> > +                              struct perf_sample *sample,
> > +                              struct event_key *key)
> > +{
> > +     key->key  = evsel__intval(evsel, sample, "ecx");
> > +     key->info = evsel__intval(evsel, sample, "write"); }
> > +
> > +static bool msr_event_begin(struct evsel *evsel,
> > +                            struct perf_sample *sample,
> > +                            struct event_key *key)
> > +{
> > +     if (!strcmp(evsel->name, "kvm:kvm_msr")) {
> > +             msr_event_get_key(evsel, sample, key);
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static bool msr_event_end(struct evsel *evsel,
> > +                          struct perf_sample *sample __maybe_unused,
> > +                          struct event_key *key __maybe_unused) {
> > +     return kvm_entry_event(evsel);
> > +}
> > +
> > +static void msr_event_decode_key(struct perf_kvm_stat *kvm
> > __maybe_unused,
> > +                                 struct event_key *key,
> > +                                 char *decode)
> > +{
> > +     scnprintf(decode, decode_str_len, "%#llx:%s",
> > +               (unsigned long long)key->key,
> > +               key->info ? "W" : "R");
> > +}
> > +
> > +static struct kvm_events_ops msr_events = {
> > +     .is_begin_event = msr_event_begin,
> > +     .is_end_event = msr_event_end,
> > +     .decode_key = msr_event_decode_key,
> > +     .name = "MSR Access"
> > +};
> > +
> >  const char *kvm_events_tp[] = {
> >       "kvm:kvm_entry",
> >       "kvm:kvm_exit",
> >       "kvm:kvm_mmio",
> >       "kvm:kvm_pio",
> > +     "kvm:kvm_msr",
> >       NULL,
> >  };
> >
> > @@ -145,6 +190,7 @@ struct kvm_reg_events_ops kvm_reg_events_ops[] = {
> >       { .name = "vmexit", .ops = &exit_events },
> >       { .name = "mmio", .ops = &mmio_events },
> >       { .name = "ioport", .ops = &ioport_events },
> > +     { .name = "msr", .ops = &msr_events },
> >       { NULL, NULL },
> >  };
> >
> > --
> > 1.7.1
>
