Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E959C40BF86
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhIOGEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhIOGEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:04:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05477C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 23:03:30 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id f6so2056647iox.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 23:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRdlO4hwfQlNtiMRxDq3ZWHIpkBIab9WIelLX69deY0=;
        b=j9Mg5FB6c4NB/pXIzmDQc7hZLhNYqIfqKQQ6+wRubokxkmBeQpiaXAekVwYRrPyxPE
         Y166ilid6gvhgWdH9/qxRW0bM2zR40qeTsERYF/JJKuSPGlhhiIgoXsS/kZHsF4geg7y
         Bvp4BrABLaN0DhJY2dZr/G00isje44+2Xs+PycgTIDl1gnkn2fZuJ/8YPXi3+grTOM8l
         1jvY8fLDk0H+KgViuzie5ElCwixkDoJ9TnY2I4Sax0F5s11R+p6cmcRlJf51+bokyapD
         mc5m08ZY2jJxCZdQNBSo1hTNLbJQNDrLGZ2neKKd6KAKOipU6JJ+yVyYndkqAmZHrvC5
         19oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRdlO4hwfQlNtiMRxDq3ZWHIpkBIab9WIelLX69deY0=;
        b=ahNTFFMCISM+lnZMCayQZmiIR3a5ZnxmyvY7UGDEynBISnQnyGrkCPSBTJu8nFhJph
         DsOsuG+DMDfRIHfIK06HVdfEyLdSskg4mb0KsTJI/Qc9LOS56Oyz8edtIcWHdUJPU6HO
         NpGBcFIxns01M45cYmpwOYliRo3867Jp4Qeru8CfB3saR/fjLp67/B/iS6Z5HDrb7yVf
         oDzk0+y98JRJbAfhLoKM21fEw+Cr+4Tdk6SygC5gbr0j/OC/WsCiC+5hOBreX4rpr7CH
         Ut0GlVB0/jLUaUy/6HdZ8Hs6uBlu0jbj9Q9fwF+evsVhHt2YNLHt+5FBuB/FGriTih86
         0nuA==
X-Gm-Message-State: AOAM531fHFwpk/PYTpUG6mD4UV3y/2xjp8+j+FfrrKqd2ovKW5CYWSC0
        dpRjjGqzrU1CdIHKdcO+SHabYexW+MkdeLWq0sIVWw==
X-Google-Smtp-Source: ABdhPJzBLNXyhstF6OvtsHoUILRT7WkNTt6UpPk/amShK4W4tMKe7BibOJb9/jwEa/ujWAbbAJ/ExxVrmrjdR0Omm6Q=
X-Received: by 2002:a05:6602:1581:: with SMTP id e1mr16922245iow.49.1631685809177;
 Tue, 14 Sep 2021 23:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com> <20210909075700.4025355-2-eranian@google.com>
 <20210909190342.GE4323@worktop.programming.kicks-ass.net> <878s04my3b.fsf@mpe.ellerman.id.au>
 <875yv8ms7f.fsf@mpe.ellerman.id.au>
In-Reply-To: <875yv8ms7f.fsf@mpe.ellerman.id.au>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 14 Sep 2021 23:03:18 -0700
Message-ID: <CABPqkBQZ48b51vh1vqafOwVK2tBqYFNFGJT2x-a39Ma0TbS=tA@mail.gmail.com>
Subject: Re: [PATCH v1 01/13] perf/core: add union to struct perf_branch_entry
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com,
        atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,


On Fri, Sep 10, 2021 at 7:16 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Peter Zijlstra <peterz@infradead.org> writes:
> >> On Thu, Sep 09, 2021 at 12:56:48AM -0700, Stephane Eranian wrote:
> >>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> >>> index f92880a15645..eb11f383f4be 100644
> >>> --- a/include/uapi/linux/perf_event.h
> >>> +++ b/include/uapi/linux/perf_event.h
> >>> @@ -1329,13 +1329,18 @@ union perf_mem_data_src {
> >>>  struct perf_branch_entry {
> >>>     __u64   from;
> >>>     __u64   to;
> >>> -   __u64   mispred:1,  /* target mispredicted */
> >>> -           predicted:1,/* target predicted */
> >>> -           in_tx:1,    /* in transaction */
> >>> -           abort:1,    /* transaction abort */
> >>> -           cycles:16,  /* cycle count to last branch */
> >>> -           type:4,     /* branch type */
> >>> -           reserved:40;
> >>> +   union {
> >>> +           __u64   val;        /* to make it easier to clear all fields */
> >>> +           struct {
> >>> +                   __u64   mispred:1,  /* target mispredicted */
> >>> +                           predicted:1,/* target predicted */
> >>> +                           in_tx:1,    /* in transaction */
> >>> +                           abort:1,    /* transaction abort */
> >>> +                           cycles:16,  /* cycle count to last branch */
> >>> +                           type:4,     /* branch type */
> >>> +                           reserved:40;
> >>> +           };
> >>> +   };
> >>>  };
> >>
> >>
> >> Hurpmh... all other bitfields have ENDIAN_BITFIELD things except this
> >> one. Power folks, could you please have a look?
> >
> > The bit number of each field changes between big and little endian, but
> > as long as kernel and userspace are the same endian, and both only
> > access values via the bitfields then it works.
> ...
> >
> > It does look like we have a bug in perf tool though, if I take a
> > perf.data from a big endian system to a little endian one I don't see
> > any of the branch flags decoded. eg:
> >
> > BE:
> >
> > 2413132652524 0x1db8 [0x2d0]: PERF_RECORD_SAMPLE(IP, 0x1): 5279/5279: 0xc00000000045c028 period: 923003 addr: 0
> > ... branch stack: nr:28
> > .....  0: c00000000045c028 -> c00000000dce7604 0 cycles  P   0
> >
> > LE:
> >
> > 2413132652524 0x1db8 [0x2d0]: PERF_RECORD_SAMPLE(IP, 0x1): 5279/5279: 0xc00000000045c028 period: 923003 addr: 0
> > ... branch stack: nr:28
> > .....  0: c00000000045c028 -> c00000000dce7604 0 cycles      0
> >                                                          ^
> >                                                          missing P
> >
> > I guess we're missing a byte swap somewhere.
>
> Ugh. We _do_ have a byte swap, but we also need a bit swap.
>
> That works for the single bit fields, not sure if it will for the
> multi-bit fields.
>
> So that's a bit of a mess :/
>
Based on what I see in perf_event.h for other structures, I think I
can make up what you would need for struct branch_entry. But Iit would
be easier if you could send me a patch that you would have verified on
your systems.
Thanks.
