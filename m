Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F73776D0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhEINpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 09:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhEINpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 09:45:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C63C060698;
        Sun,  9 May 2021 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620567852;
        bh=9ch2PUL45IpkH4eG5cS4+vBEgw0GQo/G6mnYAZxfg7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRV2t2iwrvcNTzgIMCykAqEfh51YLjt5qNY1QhC+Y+6XN0IDKeK6cPBG/mzMnLpEc
         v1xo9MIAAbed1r4SjZakQHeDmMHB088hhcQiAR7762QrcM72dqIcYeYJiKIxyX7agr
         gLjFy3gJiUaUmvpz3rXdPhZMxylM6mBJH4V8lX803YTfG6QMX1eMu2lpVRsTO/nU61
         t6iiGFjiNPF0N33x0oi6Kbq0pd3QYJG+KQxI4h36eerU804Dj1BIin3O47fOr2LBHx
         6UoRWXMVe3qpmBBHLBxYm4DPHkdFbFYsTTOs+Hr52cgCQsjWkxMElsqTAE0eqOrwWz
         pj19CNVvRPwmQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D40514034C; Sun,  9 May 2021 10:44:08 -0300 (-03)
Date:   Sun, 9 May 2021 10:44:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Li,Rongqing" <lirongqing@baidu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCH][resend] perf x86 kvm-stat: support to analyze kvm msr
Message-ID: <YJfnKPoSdQp2sxm0@kernel.org>
References: <1618470001-7239-1-git-send-email-lirongqing@baidu.com>
 <a9a29f801740491bb97e765ff58a9772@baidu.com>
 <CAM9d7cj4nyr8qeUVOgC43-gyDOwPXBumBhHtpc2S-3f8WrWyKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj4nyr8qeUVOgC43-gyDOwPXBumBhHtpc2S-3f8WrWyKw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Apr 24, 2021 at 02:05:51AM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Thu, Apr 22, 2021 at 11:33 AM Li,Rongqing <lirongqing@baidu.com> wrote:
> > > Subject: [PATCH][resend] perf x86 kvm-stat: support to analyze kvm msr
> > >
> > > From: Lei Zhao <zhaolei27@baidu.com>
> > >
> > > usage:
> > >     - kvm stat
> > >       run a command and gather performance counter statistics
> > >
> > >     - show the result:
> > >       perf kvm stat report --event=msr
> > >
> > > See the msr events:
> > >
> > > Analyze events for all VMs, all VCPUs:
> > >
> > > MSR Access Samples  Samples% Time%  Min Time Max Time  Avg time
> > >
> > >   0x6e0:W   67007  98.17%   98.31%  0.59us   10.69us  0.90us ( +-
> > > 0.10% )
> > >   0x830:W    1186   1.74%    1.60%  0.53us  108.34us  0.82us ( +-
> > > 11.02% )
> > >    0x3b:R      66   0.10%    0.09%  0.56us    1.26us  0.80us ( +-
> > > 3.24% )
> > >
> > > Total Samples:68259, Total events handled time:61150.95us.
> > >
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > Signed-off-by: Lei Zhao <zhaolei27@baidu.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > > ---
> > >  tools/perf/arch/x86/util/kvm-stat.c |   46
> > > +++++++++++++++++++++++++++++++++++
> > >  1 files changed, 46 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/tools/perf/arch/x86/util/kvm-stat.c
> > > b/tools/perf/arch/x86/util/kvm-stat.c
> > > index 0729204..c5dd54f 100644
> > > --- a/tools/perf/arch/x86/util/kvm-stat.c
> > > +++ b/tools/perf/arch/x86/util/kvm-stat.c
> > > @@ -133,11 +133,56 @@ static void ioport_event_decode_key(struct
> > > perf_kvm_stat *kvm __maybe_unused,
> > >       .name = "IO Port Access"
> > >  };
> > >
> > > + /* The time of emulation msr is from kvm_msr to kvm_entry. */ static
> > > +void msr_event_get_key(struct evsel *evsel,
> > > +                              struct perf_sample *sample,
> > > +                              struct event_key *key)
> > > +{
> > > +     key->key  = evsel__intval(evsel, sample, "ecx");
> > > +     key->info = evsel__intval(evsel, sample, "write"); }
> > > +
> > > +static bool msr_event_begin(struct evsel *evsel,
> > > +                            struct perf_sample *sample,
> > > +                            struct event_key *key)
> > > +{
> > > +     if (!strcmp(evsel->name, "kvm:kvm_msr")) {
> > > +             msr_event_get_key(evsel, sample, key);
> > > +             return true;
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > > +
> > > +static bool msr_event_end(struct evsel *evsel,
> > > +                          struct perf_sample *sample __maybe_unused,
> > > +                          struct event_key *key __maybe_unused) {
> > > +     return kvm_entry_event(evsel);
> > > +}
> > > +
> > > +static void msr_event_decode_key(struct perf_kvm_stat *kvm
> > > __maybe_unused,
> > > +                                 struct event_key *key,
> > > +                                 char *decode)
> > > +{
> > > +     scnprintf(decode, decode_str_len, "%#llx:%s",
> > > +               (unsigned long long)key->key,
> > > +               key->info ? "W" : "R");
> > > +}
> > > +
> > > +static struct kvm_events_ops msr_events = {
> > > +     .is_begin_event = msr_event_begin,
> > > +     .is_end_event = msr_event_end,
> > > +     .decode_key = msr_event_decode_key,
> > > +     .name = "MSR Access"
> > > +};
> > > +
> > >  const char *kvm_events_tp[] = {
> > >       "kvm:kvm_entry",
> > >       "kvm:kvm_exit",
> > >       "kvm:kvm_mmio",
> > >       "kvm:kvm_pio",
> > > +     "kvm:kvm_msr",
> > >       NULL,
> > >  };
> > >
> > > @@ -145,6 +190,7 @@ struct kvm_reg_events_ops kvm_reg_events_ops[] = {
> > >       { .name = "vmexit", .ops = &exit_events },
> > >       { .name = "mmio", .ops = &mmio_events },
> > >       { .name = "ioport", .ops = &ioport_events },
> > > +     { .name = "msr", .ops = &msr_events },
> > >       { NULL, NULL },
> > >  };
> > >
> > > --
> > > 1.7.1
> >

-- 

- Arnaldo
