Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B040FE13
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbhIQQoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIQQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:44:13 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849BAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:42:51 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a15so12930892iot.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MEJKdicHZC2UAgfEdwT2iHw1l7KOjJh6r2QG98JUaM=;
        b=EylKgqeiBF29JmeKt4QPfs9VXtmF66zBxKOFN+O5j4djlZNEBAGkjtgsTg64QYotxh
         xs2sgOfcG+DtQ8fCzLNwc7+2Y5FgjWpCZD5OX4kduKEZ40DiNSjt6k+05DLAes427b5e
         3L/pjobz7bB88Moz+WWhb7Lwt6dOKN3RRFih2pk+ebb7ZsraYergtIbptc+SXERQFa1A
         r1Gqf3s9LiGkA5TJduEur6qoOVKhPayQM6bsqDIl0N92BLUdL9eIbW/6l+94l6b+HuWb
         4gHoWcFDSYLamHdSMuvmaQzKhHS0KYuaHgWfotxGQ0XA0XktFIngQrmC2GF2sd8b8O30
         9atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MEJKdicHZC2UAgfEdwT2iHw1l7KOjJh6r2QG98JUaM=;
        b=noiLq2/4i+HjBRahcrvjFYK+KPxXJoIgFI6h1f/H86r7LUChitMZtpgZCeTkjUzPJ6
         P5EZOrS6ieIQz5qJsKhN8mDWfOnbyKN0nrdKwHmSyQTUxDJuoiHh9nTvihtGGz+4qQik
         TcieVEkQblS3qvGCOknavJ7ejeTUnbXtGopk1Njg4vGxxGDl8YskZ2Qs+7dje42KGW/7
         NfYUbwLBMqRHuqcWKWhjPzp/fyE/zMi49s/gAbjPCcxPHghJ8BBBL5FBPyWjfkjK3cW/
         6bK/ZoXeJCACiC5CeAxdVkVwNI/tPGwZA6wrwXFvNjmwQ8fxzcGV7E7lz7/XyrZJeokV
         M6Wg==
X-Gm-Message-State: AOAM530Hrgsfir1S8oWn8nvwrbdRML4CMAw7cxIx8WjfWth6lV7OSmhq
        8hwny4mP4x2RehCnrKDSqXMu5nnH/pFFYrN8AVDMDA==
X-Google-Smtp-Source: ABdhPJzN842+8n6F892ufNOSC3p15tpHYWe0RFW1nxZk42/H/3g548F62A7CY00Em6U6jJeagToefnaF22LnthVLHWk=
X-Received: by 2002:a6b:670f:: with SMTP id b15mr6164364ioc.15.1631896970647;
 Fri, 17 Sep 2021 09:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com> <20210909075700.4025355-2-eranian@google.com>
 <20210909190342.GE4323@worktop.programming.kicks-ass.net> <878s04my3b.fsf@mpe.ellerman.id.au>
 <875yv8ms7f.fsf@mpe.ellerman.id.au> <CABPqkBQZ48b51vh1vqafOwVK2tBqYFNFGJT2x-a39Ma0TbS=tA@mail.gmail.com>
 <b21bf42e-377d-36d0-49c3-af1e4edf5496@linux.ibm.com> <CABPqkBQvvNQa=hb4OnYqH-f=DJiRWE+bTmv4i+gNvEdoSEHM4w@mail.gmail.com>
 <878rzvk7h0.fsf@mpe.ellerman.id.au> <CABPqkBRrx5vnPqTEnuQOeoJxyjiszCG7EMdK35ES=rHKYUNBpQ@mail.gmail.com>
 <874kajjs1e.fsf@mpe.ellerman.id.au>
In-Reply-To: <874kajjs1e.fsf@mpe.ellerman.id.au>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 17 Sep 2021 09:42:39 -0700
Message-ID: <CABPqkBQ=9pev4=iF+JwB8DZ391GGAkFbtBidkFeOt2MPeC0hyg@mail.gmail.com>
Subject: Re: [PATCH v1 01/13] perf/core: add union to struct perf_branch_entry
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com,
        atrajeev@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 5:38 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Stephane Eranian <eranian@google.com> writes:
> > Hi,
> >
> > On Fri, Sep 17, 2021 at 12:05 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>
> >> Stephane Eranian <eranian@google.com> writes:
> >> > Hi,
> >> >
> >> > Thanks for fixing this in the perf tool. But what about the struct
> >> > branch_entry in the header?
> >>
> >> I'm not sure what you mean.
> >>
> >> We can't change the order of the fields in the header, without breaking
> >> existing userspace on BE systems.
> >>
> > Ok, I think I had missed that. You are saying that the
> > #ifdef (__BIG_ENDIAN_BITFIELD) vs __LITTLE_ENDIAN_BITFIELD
> >
> > is only added to kernel-only data structures?
>
> No, we *should* have used __BIG/LITTLE_ENDIAN_BITFIELD for the uapi
> definition, but we forgot.
>
But are you suggesting it cannot be fixed?

> >> It's annoying that the bit numbers are different between LE & BE, but I
> >> think it's too late to change that.
> >>
> > I agree.
> >
> >> So nothing should change in the branch_entry definition in the header.
> >>
> >> My comment on your patch was that adding the union with val, makes it
> >> easier to misuse the bitfields, because now the values can be accessed
> >> via the bitfields and also via val, but when using val you have to know
> >> that the bit numbers differ between BE/LE.
> >>
> > Ok, I get it now. We do not need to expose val to user. This is added
> > for kernel code convenience only.
>
> Yeah. Putting the union with val in the uapi encourages userspace to
> misuse val to bypass the bitfields, and that risks causing endian bugs.
>
> > But if we keep it in kernel, that may break some other rules about
> > uapi headers.
>
> I don't follow what you mean there.
>
> We could use #ifdef __KERNEL__ in the uapi header to make the union
> kernel-only, see below, but it's pretty gross.
>
>  struct perf_branch_entry {
>         __u64   from;
>         __u64   to;
>  #ifdef __KERNEL__
>         union {
>                 __u64   val;        /* to make it easier to clear all fields */
>                 struct {
>  #endif
>                         __u64   mispred:1,  /* target mispredicted */
>                                 predicted:1,/* target predicted */
>                                 in_tx:1,    /* in transaction */
>                                 abort:1,    /* transaction abort */
>                                 cycles:16,  /* cycle count to last branch */
>                                 type:4,     /* branch type */
>                                 reserved:40;
>  #ifdef __KERNEL__
>                 };
>         };
>  #endif
>  };
>
>
> If we just do the inline I suggested we can clear the flags in a single
> source line, and the generated code seems fine too, eg:
>
> static inline void clear_perf_branch_entry_flags(struct perf_branch_entry *e)
> {
>         e->mispred = 0;
>         e->predicted = 0;
>         e->in_tx = 0;
>         e->abort = 0;
>         e->cycles = 0;
>         e->type = 0;
>         e->reserved = 0;
> }
>
Ok, let's do the inline then. That looks like a cleaner solution to me
assuming the compiler does the right thing.
