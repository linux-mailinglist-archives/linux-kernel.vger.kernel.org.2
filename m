Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE683FDE7D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhIAPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhIAPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:22:07 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF3CC061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:21:10 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r4so5837247ybp.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gig1xV75WPgcWCbAVzUvwyldJADLtKmZKbsQEozsnG4=;
        b=dOM8D5qIzsW661dVNjtSDVLtY8HEj17CwQ303RFpZhRW0ybAO3FO1liGDHTVNq0LHx
         EHtOOtu8m7lGVn7zzjRiqUiYZ8ntD+t3P6CkeUjMeKV73mlxuxanMBaL+SrEVyBxA6oB
         vmy6VDJvppQ8fGD3uRA2znX2yadW7DT22a+fGGGrDgstM8MfSO7dmZnGhpjudIxAh70S
         g702AunVPNBeAxCq5OFnwjH3UvGBFhGAXCcAr4g3kD7BXtVOvnoj8F87QNlGoaCrwBHD
         XZwh7/tRHOVCs4wGiLHG7wla6wDrlpwwxlCCflF1aKgheONCy1IK8G2UZwWBVjlFSQMs
         fOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gig1xV75WPgcWCbAVzUvwyldJADLtKmZKbsQEozsnG4=;
        b=ZOkAfVNALHGCIRyLPvGeKiy+1gsDx/R8/zOzGzz2pvIK/9DX3RG6Sw3QdS1WBWXGYD
         UkCeZeJiuW54b0j+bqwW43U2eWJgR8eoKmXYUy06qGR/IiMTouVsQmOQVoSkcroCjyow
         P6DH/j6K9hy5PPf2zVr21Nb3UySJUF7d/koznbvCBQfUeVxUIYZCq8B21WwQEPZ3DGVh
         UznH45VabIN/fbvxRISD5OjPk9nj9dkiDXxV+3ZJG0WtvBMy+Dm2dlGgtU+vfX82TAps
         aE1LUWV8jcS4O+BYNwcXB/UCpusSxfzdcXENjOCVyqWjCCeUtBa2S+PvjqIqt7Nb5nBb
         /0nQ==
X-Gm-Message-State: AOAM530QL9TZJ2+sf8MrF6oMJKDvZrhTUick60CPQUwfNyQ0YVxFiCSj
        z/F7MCKEgnLP7SkqXilNg6OoENyLmv+xxsMr/JeXlA==
X-Google-Smtp-Source: ABdhPJyLcSd7XPV6PDHJyvHdaldJi+y8H56wMrkSA8uIbWC5NoEgYggZtX8Sj6DS8TUKOyyq6zI2DAzaXKyqL34wk8w=
X-Received: by 2002:a25:6c05:: with SMTP id h5mr35958ybc.380.1630509669857;
 Wed, 01 Sep 2021 08:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210825154043.247764-1-yan2228598786@gmail.com>
 <CANn89iJO8jzjFWvJ610TPmKDE8WKi8ojTr_HWXLz5g=4pdQHEA@mail.gmail.com>
 <20210825231942.18f9b17e@rorschach.local.home> <CAE40pdd+yHnh6fyjYV0UDcZ_ZwTCzP019Mf4_tTKWFc_5M6gaw@mail.gmail.com>
 <8BA159CD-11AC-425C-9C7F-AA943CE9179F@goodmis.org>
In-Reply-To: <8BA159CD-11AC-425C-9C7F-AA943CE9179F@goodmis.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 1 Sep 2021 08:20:58 -0700
Message-ID: <CANn89i+rHC4AC88-V8QqBU36waaOxTVoii0xaEKk+oerzC3Egw@mail.gmail.com>
Subject: Re: [PATCH] net: tcp_drop adds `reason` parameter for tracing v2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Zhongya Yan <yan2228598786@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, hengqi.chen@gmail.com,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 7:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 26 Aug 2021 15:13:07 +1000
> Brendan Gregg <brendan.d.gregg@gmail.com> wrote:
>
> > On Thu, Aug 26, 2021 at 1:20 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 25 Aug 2021 08:47:46 -0700
> > > Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > > > @@ -5703,15 +5700,15 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
> > > > >                         TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
> > > > >                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPSYNCHALLENGE);
> > > > >                 tcp_send_challenge_ack(sk, skb);
> > > > > -               goto discard;
> > > > > +               tcp_drop(sk, skb, TCP_DROP_MASK(__LINE__, TCP_VALIDATE_INCOMING));
> > > >
> > > > I'd rather use a string. So that we can more easily identify _why_ the
> > > > packet was drop, without looking at the source code
> > > > of the exact kernel version to locate line number 1057
> > > >
> > > > You can be sure that we will get reports in the future from users of
> > > > heavily modified kernels.
> > > > Having to download a git tree, or apply semi-private patches is a no go.
> > > >
> > > > If you really want to include __FILE__ and __LINE__, these both can be
> > > > stringified and included in the report, with the help of macros.
> > >
> > > I agree the __LINE__ is pointless, but if this has a tracepoint
> > > involved, then you can simply enable the stacktrace trigger to it and
> > > it will save a stack trace in the ring buffer for you.
> > >
> > >    echo stacktrace > /sys/kernel/tracing/events/tcp/tcp_drop/trigger
> > >
> > > And when the event triggers it will record a stack trace. You can also
> > > even add a filter to do it only for specific reasons.
> > >
> > >    echo 'stacktrace if reason == 1' > /sys/kernel/tracing/events/tcp/tcp_drop/trigger
> > >
> > > And it even works for flags:
> > >
> > >    echo 'stacktrace if reason & 0xa' > /sys/kernel/tracing/events/tcp/tcp_drop/trigger
> > >
> > > Which gives another reason to use an enum over a string.
> >
> > You can't do string comparisons? The more string support Ftrace has,
> > the more convenient they will be. Using bpftrace as an example of
> > convenience and showing drop frequency counted by human-readable
> > reason and stack trace:
>
> Yes, you can (and pretty much always had this ability), but having
> flags is usually makes it easier (and faster).
>
> You can have 'stacktrace if reason ~ "*string*"' which will match
> anything with "string" in it.
>
> My main argument against strings is more of the space they take up in
> the ring buffer than the ability to filter.

Understood the concern about size, but it seems the trace includes many things.
Can we have an estimate of the size needed per event ?
If we do not use symbolic, but numbers, I am afraid this trace event
will only be used by a few TCP experts.

+               TP_printk("src=%pISpc dest=%pISpc mark=%#x data_len=%d
snd_nxt=%#x snd_una=%#x \
+                               snd_cwnd=%u ssthresh=%u snd_wnd=%u
srtt=%u rcv_wnd=%u \
+                               sock_cookie=%llx reason=%d
reason_type=%s reason_line=%d",
                                __entry->saddr, __entry->daddr, __entry->mark,
                                __entry->data_len, __entry->snd_nxt,
__entry->snd_una,
                                __entry->snd_cwnd, __entry->ssthresh,
__entry->snd_wnd,
-                               __entry->srtt, __entry->rcv_wnd,
__entry->sock_cookie, __entry->reason)
+                               __entry->srtt, __entry->rcv_wnd,
__entry->sock_cookie,
+                               __entry->reason,
+                               __print_symbolic(__entry->reason_code,
TCP_DROP_REASON),
+                               __entry->reason_line)
 );
