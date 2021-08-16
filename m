Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96D53EDE04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhHPTqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPTqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:46:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9603C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:46:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u1so4762165plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pas4X2WVDOsiV9fhTjYpmCxyme9t8OW4i6YbwNjwjUI=;
        b=aqFwDTmk7VWodxEGEYyaav4U6cqFhZlDM7KUR+KZEaRBhBSL3vLdn5J4e9i2uaeiql
         21cEWi37z4fh4vVE+r8gcA3r1X/CDqe8GU3u0xIVSj7Jn+p/VB3eg52lF5+3ghSpiNm1
         b50fBKBQql+VPK65M7IDzezmhNNSW4HA2dId8DB3v4HEYlFLSqFRqvz/k1k1Jb9GdHa6
         UvetrpCy1JpobQ0x7MUajgj9UkaEg8RwRSZvubrZiwGf5UYUlStnQGrXnSuV0E7b6dpH
         VntTWOI/T/2Pm4pd++Rz6wq9/KDwZp997ntekPMt87lGYqsYc+baMyApQIR+H3rYEmbj
         e5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pas4X2WVDOsiV9fhTjYpmCxyme9t8OW4i6YbwNjwjUI=;
        b=JE1rDUICYVh8RfuIi0oTdiVjORXu2PhJYCGwEvR1Ij4JyCvmuzCnhwFrtEqQljFRrm
         yfkAoFEBvUWTyrT2Y8AO2szenGVSvOzUk5SAgInEt4iB530rfSv8oC6yPdTcfdiM2/dZ
         JCq8uW9JSop4Ry6v7oZdSfHhSHtA76KwjASMNhID0jzLZ0Md6tkAWEBmiykciraqabBq
         4WBMFx3BiUJmMAMGxPRgSB1djZaP5NVfOVnYsxhLC8RygbFbPmZAItZCovD30rR1h5Q8
         ewNGOLxV1uG2rFSo9Qoe9HQHMOHgrQK86SLCV2cNhi7gsuJPiSvMVlvn6vrhWhaIXtCQ
         c62g==
X-Gm-Message-State: AOAM530FITHCLfonYOmPV2j1p0NnK47Dr7EYnB+h7q46RjCE0aYRMTbb
        1Sd+6hrPQ2SKTl6y6vmjDXHmLEojCmQV1fHJLZd0Nw==
X-Google-Smtp-Source: ABdhPJzAEoWSga20Oj9NdFatouGMBDmVSAVnb7MxxPdgrJOQ+kB3igXxZ/z/Q4iJcLnLRhWfEHyzioMRf16U0NVlksE=
X-Received: by 2002:a17:902:9a8e:b0:12d:cb3c:c4d7 with SMTP id
 w14-20020a1709029a8e00b0012dcb3cc4d7mr452742plp.18.1629143174086; Mon, 16 Aug
 2021 12:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210726164135.1745059-1-kaleshsingh@google.com> <20210816172228.GA9015@e123356-lin.trondheim.arm.com>
In-Reply-To: <20210816172228.GA9015@e123356-lin.trondheim.arm.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 16 Aug 2021 12:46:03 -0700
Message-ID: <CAC_TJvffc6Sbnu3KO-7NMVNZHMc2zkOpEpdxnV+u5F7Edwthhw@mail.gmail.com>
Subject: Re: [PATCH] tracing/gpu: Add gpu_mem_imported tracepoint
To:     =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        John Reitan <john.reitan@arm.com>,
        Mark Underwood <mark.underwood@arm.com>,
        Gary Sweet <gary.sweet@broadcom.com>,
        Stephen Mansfield <stephen.mansfield@imgtec.com>,
        mbalci@quicinc.com, mkrom@qti.qualcomm.com,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 10:22 AM =C3=98rjan Eide <orjan.eide@arm.com> wrote=
:
>
> On Mon, Jul 26, 2021 at 04:41:31PM +0000, Kalesh Singh wrote:
> > The existing gpu_mem_total tracepoint allows GPU drivers a unifrom way
> > to report the per-process and system-wide GPU memory usage. This
> > tracepoint reports a single total of the GPU private allocations and th=
e
> > imported memory. [1]
> >
> > To allow distinguishing GPU private vs imported memory, add
> > gpu_mem_imported tracepoint.
> >
> > GPU drivers can use this tracepoint to report the per-process and globa=
l
> > GPU-imported memory in a uniform way.
>
> Right, as imported dma-buf memory is usually shared between two or more
> processes it will be hard to reconcile system memory usage with process
> private GPU memory and imported dma-buf memory in a single total sum. It
> will be good to improve this and having a separate imported GPU memory
> size is good.
>
> > For backward compatility with already existing implementations of
> > gpu_mem_total by various Android GPU drivers, this is proposed as a new
> > tracepoint rather than additional args to gpu_mem_total.
>
> Is this for compatibility with kernel GPU drivers only, or are there
> user space users of the existing tracepoint that can't cope with it
> being extended?
>
> The eBPF used by Android to track the GPU memory is the only established
> user of the tracepoint that I know about. Can existing versions of the
> eBPF can handle this OK?
>
> If the only worry is GPU kernel drivers then I think that extending the
> existing tracepoint, to add a new field with the imported memory sum,
> will be better. There doesn't appear to be any in-kernel GPU drivers
> implementing this yet, and other GPU kernel drivers can just be extended
> to use the new extended tracepoint. As long as there's some mechanism to
> detect the extended variant of the tracepoint for backports, if the new
> tracepoint is ever backported to older kernels, that shouldn't be a
> problem.

Hi =C3=98rjan. Thank you for your comments.

The compatibility concern was regarding existing user space tools when
devices with older kernels (having the older  gpu_mem_total format)
upgrade to newer android releases.

In android, there are 2 user space tools that depend on this
tracepoint: the bpf program to capture the tracepoint data [1] and the
Perfetto profiling tool [2]. I=E2=80=99ve confirmed that Perfetto can handl=
e
both the old and new formats if only a new field is added and the
types of existing fields remain unchanged. For the bpf program, it
turns out we can detect the format from gpu_mem_total/format and load
different versions of the bpf program accordingly.

I'll repost a new version adding only the new imported_mem field.

Thanks,
Kalesh

[1] https://cs.android.com/android/platform/superproject/+/92e677d80bc48772=
a36ef0d2d9db3195b2dfcf65:frameworks/native/services/gpuservice/bpfprogs/gpu=
_mem.c;l=3D51
[2] https://perfetto.dev

>
> --
> =C3=98rjan
>
> > [1] https://lore.kernel.org/r/20200302234840.57188-1-zzyiwei@google.com=
/
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  include/trace/events/gpu_mem.h | 51 ++++++++++++++++++++++++----------
> >  1 file changed, 36 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_=
mem.h
> > index 26d871f96e94..b9543abf1461 100644
> > --- a/include/trace/events/gpu_mem.h
> > +++ b/include/trace/events/gpu_mem.h
> > @@ -13,21 +13,7 @@
> >
> >  #include <linux/tracepoint.h>
> >
> > -/*
> > - * The gpu_memory_total event indicates that there's an update to eith=
er the
> > - * global or process total gpu memory counters.
> > - *
> > - * This event should be emitted whenever the kernel device driver allo=
cates,
> > - * frees, imports, unimports memory in the GPU addressable space.
> > - *
> > - * @gpu_id: This is the gpu id.
> > - *
> > - * @pid: Put 0 for global total, while positive pid for process total.
> > - *
> > - * @size: Size of the allocation in bytes.
> > - *
> > - */
> > -TRACE_EVENT(gpu_mem_total,
> > +DECLARE_EVENT_CLASS(gpu_mem_template,
> >
> >       TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> >
> > @@ -51,6 +37,41 @@ TRACE_EVENT(gpu_mem_total,
> >               __entry->size)
> >  );
> >
> > +/*
> > + * The gpu_memory_total event indicates that there's an update to eith=
er the
> > + * global or process total gpu memory counters.
> > + *
> > + * This event should be emitted whenever the kernel device driver allo=
cates,
> > + * frees, imports, unimports memory in the GPU addressable space.
> > + *
> > + * @gpu_id: This is the gpu id.
> > + *
> > + * @pid: Put 0 for global total, while positive pid for process total.
> > + *
> > + * @size: Size of the allocation in bytes.
> > + *
> > + */
> > +DEFINE_EVENT(gpu_mem_template, gpu_mem_total,
> > +     TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> > +     TP_ARGS(gpu_id, pid, size));
> > +
> > +/*
> > + * The gpu_mem_imported event indicates that there's an update to the
> > + * global or process imported gpu memory counters.
> > + *
> > + * This event should be emitted whenever the kernel device driver impo=
rts
> > + * or unimports memory (allocated externally) in the GPU addressable s=
pace.
> > + *
> > + * @gpu_id: This is the gpu id.
> > + *
> > + * @pid: Put 0 for global total, while positive pid for process total.
> > + *
> > + * @size: Size of the imported memory in bytes.
> > + */
> > +DEFINE_EVENT(gpu_mem_template, gpu_mem_imported,
> > +     TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> > +     TP_ARGS(gpu_id, pid, size));
> > +
> >  #endif /* _TRACE_GPU_MEM_H */
> >
> >  /* This part must be outside protection */
> >
> > base-commit: ff1176468d368232b684f75e82563369208bc371
> > --
> > 2.32.0.432.gabb21c7263-goog
> >
