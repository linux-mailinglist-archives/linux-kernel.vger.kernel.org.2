Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA4E37A0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhEKHlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhEKHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:41:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142A1C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:40:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i14so15169030pgk.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIBNpTle/O27myJCmciNO53uHzWamFB21GPf0L/RmPo=;
        b=RJtRHgCKZRK4QDHewRkfyYxrwhOpxj8yV1yb8Iv7z/oCATNbCl2sph+jtGJx4rKymC
         ZRRX1kwKn8Gn0AqITdMIyhCS10fPRafujEF7imKLjE8fJVsnj9oTxjYTLt2IAk6K4ZVz
         TLUCsU4ELi6LFUedIWg+2HKKBZgxqHA0ZXYphpDAGDpdoqXvY7RH3pt/9Pp5IZh+Iw4I
         Cz/apFCxmIAZkYitJ6Ziml3T8uNOaW2exysG+KdKS44aWoAIyqPoiNCBmrK9XbCxjeyF
         6XjNrhBHgdfsbIBykMWbZ35H/dzVjWnJGqkvmgYrI4hzDYO+TfBFmXmIr4D/l2VyZrQb
         BdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIBNpTle/O27myJCmciNO53uHzWamFB21GPf0L/RmPo=;
        b=SOElC4fiT+loTKpzZc3N37q5ISLCK+8i9XAzpa1yDZxo/vxrgMOp+HzqlNN6A9qS+K
         kic7UhNFuAGt6ab+4jTkloyA2G5R0yB/8Q+RxCosedMZpibchdl9UU9/dXqCxNq5lTDX
         BPD4ubU8eCAvC58diP2k9PCqOBMUq1u4lP4ndCHrrME/IiecoK5NQnwOPAbwrdOzbilp
         gNgbvuvp2V+6LqQ2WvdW+MTfugXObNTtyb81Ss51PisIBerTgkGE3Qe8M8/iaj7RmE/I
         O3GDf3wbZp6CSwPhkW7wb2s5y4N+rf1hMfi2ta0ZxzDGNyBDMfh+2nQucdTnKMaq4Z2S
         z4xw==
X-Gm-Message-State: AOAM531kyBVFo616awxFAWKimNaNE+l2XnJxKLpZSKtqG/4ikglARRmM
        Q1qZ2Cp/f5RmZpEYLu8reDGMd8yKM6AVwYht+IxZ+A==
X-Google-Smtp-Source: ABdhPJz2KPy/gL564iw8c6ONdAwkuLnoO5vN1LyC29mdrcPXPSatL3wtEnYgoO4l2pHCSUK/06y8FNQU+cGUKrKLT5I=
X-Received: by 2002:aa7:9907:0:b029:28e:ab99:2a75 with SMTP id
 z7-20020aa799070000b029028eab992a75mr28153237pff.36.1620718804296; Tue, 11
 May 2021 00:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210507095814.17933-1-james.clark@arm.com> <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <CAJ9a7VjAvr9uKYqo9VJhFRB74vt6Jxf0G+Fm2OFm-dxAVdbpsw@mail.gmail.com>
In-Reply-To: <CAJ9a7VjAvr9uKYqo9VJhFRB74vt6Jxf0G+Fm2OFm-dxAVdbpsw@mail.gmail.com>
From:   Denis Nikitin <denik@google.com>
Date:   Tue, 11 May 2021 00:39:52 -0700
Message-ID: <CAOYpmdHGRyyXVOjgbYqUFB8BnPdaQiRC+gnuQhY+iSyhF_FP7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
To:     Mike Leach <mike.leach@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Branislav Rankov <branislav.rankov@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

1. This is a different issue and it's already confirmed as the hw bug.
Reset of the coresight generator may happen at any time and
it goes to normal only after the device reboot.

Thanks,
Denis


On Fri, May 7, 2021 at 7:09 AM Mike Leach <mike.leach@linaro.org> wrote:
>
> Hi James,
>
> 1) Not sure about this particular target - but previously all 0
> timestamps have been the result of not enabling a clock or the
> coresight timestamp generator.
>
> 2) Given that you can synthesise timestamps when all the values are
> all 0 - does this not imply that they could be synthesised when they
> are not present at all?
>
> Cheers
>
> Mike
>
> On Fri, 7 May 2021 at 11:02, James Clark <james.clark@arm.com> wrote:
> >
> >
> >
> > On 07/05/2021 12:58, James Clark wrote:
> > > There is an intermittent issue on Trogdor devices that
> > > results in all Coresight timestamps having a value of zero.
> >
> > I've attached a file here that has the issue. From the dump you
> > can see the zero timestamps:
> >
> >         Idx:69; ID:10;  I_TIMESTAMP : Timestamp.; Updated val = 0x0
> >         Idx:71; ID:10;  I_ATOM_F1 : Atom format 1.; E
> >         Idx:72; ID:10;  I_ADDR_S_IS0 : Address, Short, IS0.; Addr=0xFFFFFFE723C65824 ~[0x5824]
> >
> > This doesn't have an impact on decoding as they end up being
> > decoded in file order as in with timeless mode.
> >
> > James
> >
> > > Because zero is currently treated as "not found" rather
> > > than "found but zero", this breaks the decoding flow
> > > when it would otherwise work.
> > >
> > > This patch adds an out parameter and return code so
> > > the difference between zero and non-existent timestamps
> > > can be determined.
> > >
> > > There is also a change to fix an underflow.
> > >
> > > Although this is a workaround, the change is technically
> > > a valid way of writing the cs_etm__etmq_get_timestamp()
> > > function. It could have been written similarly to this
> > > without trying to work around this issue, so it's no less
> > > correct. But, because it's a workaround to a problem
> > > elsewhere, I will submit this as an RFC for feedback.
> > >
> > > This patch applies on top of the "[PATCH v2 0/2] perf
> > > cs-etm: Set time on synthesised samples to preserve ordering"
> > > patchset.
> > >
> > > Co-developed-by: Denis Nikitin <denik@chromium.org>
> > > Signed-off-by: Denis Nikitin <denik@chromium.org>
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > > ---
> > >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  5 ++++-
> > >  tools/perf/util/cs-etm.c                      | 22 +++++++++----------
> > >  2 files changed, 15 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index b01d363b9301..947e44413c6e 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -320,7 +320,10 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
> > >        * which instructions started by subtracting the number of instructions
> > >        * executed to the timestamp.
> > >        */
> > > -     packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> > > +     if (packet_queue->instr_count >= elem->timestamp)
> > > +             packet_queue->cs_timestamp = 0;
> > > +     else
> > > +             packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> > >       packet_queue->next_cs_timestamp = elem->timestamp;
> > >       packet_queue->instr_count = 0;
> > >
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index e5c1a1b22a2a..1969921c406a 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -210,13 +210,14 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
> > >       etmq->pending_timestamp_chan_id = trace_chan_id;
> > >  }
> > >
> > > -static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
> > > +static int cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
> > > +                                   u64 *timestamp,
> > >                                     u8 *trace_chan_id)
> > >  {
> > >       struct cs_etm_packet_queue *packet_queue;
> > >
> > >       if (!etmq->pending_timestamp_chan_id)
> > > -             return 0;
> > > +             return -ENODATA;
> > >
> > >       if (trace_chan_id)
> > >               *trace_chan_id = etmq->pending_timestamp_chan_id;
> > > @@ -224,13 +225,15 @@ static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
> > >       packet_queue = cs_etm__etmq_get_packet_queue(etmq,
> > >                                                    etmq->pending_timestamp_chan_id);
> > >       if (!packet_queue)
> > > -             return 0;
> > > +             return -ENODATA;
> > >
> > >       /* Acknowledge pending status */
> > >       etmq->pending_timestamp_chan_id = 0;
> > >
> > >       /* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
> > > -     return packet_queue->cs_timestamp;
> > > +     if (timestamp)
> > > +             *timestamp = packet_queue->cs_timestamp;
> > > +     return 0;
> > >  }
> > >
> > >  static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
> > > @@ -864,11 +867,10 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
> > >                * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
> > >                * the timestamp calculation for us.
> > >                */
> > > -             cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
> > > -
> > > -             /* We found a timestamp, no need to continue. */
> > > -             if (cs_timestamp)
> > > +             if (!cs_etm__etmq_get_timestamp(etmq, &cs_timestamp, &trace_chan_id)) {
> > > +                     /* We found a timestamp, no need to continue. */
> > >                       break;
> > > +             }
> > >
> > >               /*
> > >                * We didn't find a timestamp so empty all the traceid packet
> > > @@ -2286,9 +2288,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
> > >               if (ret)
> > >                       goto out;
> > >
> > > -             cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
> > > -
> > > -             if (!cs_timestamp) {
> > > +             if (cs_etm__etmq_get_timestamp(etmq, &cs_timestamp, &trace_chan_id)) {
> > >                       /*
> > >                        * Function cs_etm__decode_data_block() returns when
> > >                        * there is no more traces to decode in the current
> > >
>
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
