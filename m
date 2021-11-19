Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0291B456F52
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhKSNK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhKSNK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:10:27 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:07:25 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso16757945otr.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aDk04/F7yoiClgwfZwj/hPTXhimnuur9+WHv6bEm1dI=;
        b=hSRPw2QoIgJy9AdUYORZwU1wchIQ+ZSWDZ3paNnQciM4b3HxhiT11CLXVeb/JT+xi9
         zbi1uGTPvSHkkxl4AjXI4awaopnVqHEbhqIdTSYBvgAuTv/5HqS58DeQ1FrKR21A5aZ8
         7DkORz+1wjGudU0zbexoTprfFjtdkO3wcyMoF3Xf9PZOJzjy25ATIxOiLKKiW786hyII
         +6KmI9I1mLpzaSGIbJqfOiYSSSdl7LV5VA79smSQDoJa7POVCBRgzX5fkGkhPE7rcUZD
         bDRFkqFtGqftUrIkjPt3Y3l/mdUjwy2DhLInCn4YwN5XDrXd5xchzYemvRgPJYiP5wDu
         N1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aDk04/F7yoiClgwfZwj/hPTXhimnuur9+WHv6bEm1dI=;
        b=VFxHUExLscQKAiQgVeQRMiuu7cQg/I3L3OOVOnkyMT2dTObdLN/AKlP59GzyYpwBGX
         i/Bxe8ywTsRzioYdYA9MI2142T6CM8OAR8ENDBVpAhbvjpZAFthb0jMYyzFW0frEglFR
         kspY/eeeE4G9EYkdI5+syr/gnOfKIDRz24zvV04KFrj4PIKo9dd8/WquQrCorJFuE1Nv
         B441o5U1dT/WRsxy0AHNjsMrA20pz6RckGTRhbbNlnHselmRKlktvt/xuAotbM54kY4m
         e1SoK9m/r6Ba1Cr4TEBqqWnHxsICJjCQ0bMc0j+wxo/yFebwRRg0z+OYmLcuJIKcGvfA
         QHXw==
X-Gm-Message-State: AOAM531U1ST7gcRpNyvh6fjeZHyB4qUQ8Yw8nhW1qbuxMzGfCUbuha59
        IhDrCU0qaFq3UE2Y+JuH8U2zljH02h+YlrlvqOdqUQ==
X-Google-Smtp-Source: ABdhPJz30OdYbxri7In0GTfF2wDyeE5JfWwVGzQsLqQ3HeDcFgeeXgkVglZdkyya3PSUeTjucuOId3qgIaQXU9OdIek=
X-Received: by 2002:a05:6830:1356:: with SMTP id r22mr4379158otq.196.1637327244850;
 Fri, 19 Nov 2021 05:07:24 -0800 (PST)
MIME-Version: 1.0
References: <1637130234-57238-1-git-send-email-quic_jiangenj@quicinc.com>
 <CACT4Y+YwNawV9H7uFMVSCA5WB-Dkyu9TX+rMM3FR6gNGkKFPqw@mail.gmail.com>
 <DM8PR02MB8247720860A08914CAA41D42F89C9@DM8PR02MB8247.namprd02.prod.outlook.com>
 <CACT4Y+a07DxQdYFY6uc5Y4GhTUbcnETij6gg3y+JRDvtwSmK5g@mail.gmail.com>
 <DM8PR02MB8247A19843220E03B34BA440F89C9@DM8PR02MB8247.namprd02.prod.outlook.com>
 <CACT4Y+Y36wgP_xjYVQApNLdMOFTr2-KCHc=AipcZyZiAhwf1Nw@mail.gmail.com>
In-Reply-To: <CACT4Y+Y36wgP_xjYVQApNLdMOFTr2-KCHc=AipcZyZiAhwf1Nw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 19 Nov 2021 14:07:13 +0100
Message-ID: <CACT4Y+YF4Ngm6em_Sn2p+N0x1L+O8A=BEVTNhd00LmSZ+aH1iQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: add KCOV_PC_RANGE to limit pc range
To:     "JianGen Jiao (QUIC)" <quic_jiangenj@quicinc.com>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Lochmann <info@alexander-lochmann.de>,
        "Likai Ding (QUIC)" <quic_likaid@quicinc.com>,
        Kaipeng Zeng <kaipeng94@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 at 13:55, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> +Kaipeng, Hangbin who contributed the coverage filter to syzkaller.
> This is a discussion about adding a similar filter to the kernel. You
> can see whole discussion here:
> https://groups.google.com/g/kasan-dev/c/TQmYUdUC08Y

Joey, what do you think in general about passing a filter bitmap to the ker=
nel?

Since the bitmap is large, it can make sense to reuse it across
different KCOV instances.
I am thinking about something along the following lines:

kcov_fd =3D open("/debugfs/kcov");
filter_fd =3D ioctl(kcov_fd, KCOV_CREATE_FILTER, &{... some args
specifying start/end ...});
filter =3D mmap(..., filter_fd);
... write to the filter ...

...
kcov_fd2 =3D open("/debugfs/kcov");
ioctl(kcov_fd2, KCOV_ATTACH_FILTER, filter_fd);
ioctl(kcov_fd2, KCOV_ENABLE);


This would allow us to create 2 filters:
1. One the interesting subsystems
2. Second only for yet uncovered PCs in the interesting subsystems
(updated as we discover more coverage)

During fuzzing we attach the second filter to KCOV.
But when we want to obtain full program coverage, we attach the first one.

The filters (bitmaps) are reused across all threads in all executor
processes (so that we have only 2 filters globally per VM).

KCOV_CREATE_FILTER could also accept how many bytes each bit
represents (that scaling factor, as hardcoding 4, 8, 16 may be bad for
a stable kernel interface).

But I am still not sure how to support both the main kernel and
modules. We could allow setting up multiple filters for different PC
ranges. Or may be just 2 (one for kernel and one for modules range).
Or maybe 1 bitmap can cover both kernel and modules?

Thoughts?


> On Fri, 19 Nov 2021 at 12:21, JianGen Jiao (QUIC)
> <quic_jiangenj@quicinc.com> wrote:
> >
> > Yes, on x86_64, module address space is after kernel. But like below on=
 arm64, it's different.
> >
> > # grep stext /proc/kallsyms
> > ffffffc010010000 T _stext
> > # cat /proc/modules |sort -k 6 | tail -2
> > Some_module_1 552960 0 - Live 0xffffffc00ca05000 (O)
> > Some_module_1 360448 0 - Live 0xffffffc00cb8f000 (O) # cat /proc/module=
s |sort -k 6 | head -2
> > Some_module_3 16384 1 - Live 0xffffffc009430000
> >
> > -----Original Message-----
> > From: Dmitry Vyukov <dvyukov@google.com>
> > Sent: Friday, November 19, 2021 6:38 PM
> > To: JianGen Jiao (QUIC) <quic_jiangenj@quicinc.com>
> > Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; LKML <linux-kerne=
l@vger.kernel.org>; Alexander Lochmann <info@alexander-lochmann.de>; Likai =
Ding (QUIC) <quic_likaid@quicinc.com>
> > Subject: Re: [PATCH] kcov: add KCOV_PC_RANGE to limit pc range
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary=
 of any links or attachments, and do not enable macros.
> >
> > On Fri, 19 Nov 2021 at 04:17, JianGen Jiao (QUIC) <quic_jiangenj@quicin=
c.com> wrote:
> > >
> > > Hi Dmitry,
> > > I'm using the start, end pc from cover filter, which currently is the=
 fast way compared to the big bitmap passing from syzkaller solution, as I =
only set the cover filter to dirs/files I care about.
> >
> > I see.
> > But if we are unlucky and our functions of interest are at the very low=
 and high addresses, start/end will cover almost all kernel code...
> >
> > > I checked
> > > https://groups.google.com/g/kasan-dev/c/oVz3ZSWaK1Q/m/9ASztdzCAAAJ,
> > > The bitmap seems not the same as syzkaller one, which one will be use=
d finally?
> >
> > I don't know yet. We need to decide.
> > In syzkaller we are more flexible and can change code faster, while ker=
nel interfaces are stable and need to be kept forever. So I think we need t=
o concentrate more on the good kernel interface and then support it in syzk=
aller.
> >
> > > ``` Alexander's one
> > > + pos =3D (ip - canonicalize_ip((unsigned long)&_stext)) / 4; idx =3D=
 pos
> > > + % BITS_PER_LONG; pos /=3D BITS_PER_LONG; if (likely(pos <
> > > + t->kcov_size)) WRITE_ONCE(area[pos], READ_ONCE(area[pos]) | 1L <<
> > > + idx);
> > > ```
> > > Pc offset is divided by 4 and start is _stext. But for some arch, pc =
is less than _stext.
> >
> > You mean that modules can have PC < _stext?
> >
> > > ``` https://github.com/google/syzkaller/blob/master/syz-manager/covfi=
lter.go#L139-L154
> > >         data :=3D make([]byte, 8+((size>>4)/8+1))
> > >         order :=3D binary.ByteOrder(binary.BigEndian)
> > >         if target.LittleEndian {
> > >                 order =3D binary.LittleEndian
> > >         }
> > >         order.PutUint32(data, start)
> > >         order.PutUint32(data[4:], size)
> > >
> > >         bitmap :=3D data[8:]
> > >         for pc :=3D range pcs {
> > >                 // The lowest 4-bit is dropped.
> > >                 pc =3D uint32(backend.NextInstructionPC(target, uint6=
4(pc)))
> > >                 pc =3D (pc - start) >> 4
> > >                 bitmap[pc/8] |=3D (1 << (pc % 8))
> > >         }
> > >         return data
> > > ```
> > > Pc offset is divided by 16 and start is cover filter start pc.
> > >
> > > I think divided by 8 is more reasonable? Because there is at least on=
e instruction before each __sanitizer_cov_trace_pc call.
> > > 0000000000000160 R_AARCH64_CALL26  __sanitizer_cov_trace_pc
> > > 0000000000000168 R_AARCH64_CALL26  __sanitizer_cov_trace_pc
> > >
> > > I think we still need my patch because we still need a way to keep th=
e trace_pc call and post-filter in syzkaller doesn't solve trace_pc droppin=
g, right?
> >
> > Yes, the in-kernel filter solves the problem of trace capacity/overflow=
s.
> >
> >
> > > But for sure I can use the bitmap from syzkaller.
> > >
> > > THX
> > > Joey
> > > -----Original Message-----
> > > From: Dmitry Vyukov <dvyukov@google.com>
> > > Sent: Thursday, November 18, 2021 10:00 PM
> > > To: JianGen Jiao (QUIC) <quic_jiangenj@quicinc.com>
> > > Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; LKML
> > > <linux-kernel@vger.kernel.org>; Alexander Lochmann
> > > <info@alexander-lochmann.de>
> > > Subject: Re: [PATCH] kcov: add KCOV_PC_RANGE to limit pc range
> > >
> > > WARNING: This email originated from outside of Qualcomm. Please be wa=
ry of any links or attachments, and do not enable macros.
> > >
> > > ,On Wed, 17 Nov 2021 at 07:24, Joey Jiao <quic_jiangenj@quicinc.com> =
wrote:
> > > >
> > > > Sometimes we only interested in the pcs within some range, while
> > > > there are cases these pcs are dropped by kernel due to `pos >=3D
> > > > t->kcov_size`, and by increasing the map area size doesn't help.
> > > >
> > > > To avoid disabling KCOV for these not intereseted pcs during build
> > > > time, adding this new KCOV_PC_RANGE cmd.
> > >
> > > Hi Joey,
> > >
> > > How do you use this? I am concerned that a single range of PCs is too=
 restrictive. I can only see how this can work for single module (continuou=
s in memory) or a single function. But for anything else (something in the =
main kernel, or several modules), it won't work as PCs are not continuous.
> > >
> > > Maybe we should use a compressed bitmap of interesting PCs? It allows=
 to support all cases and we already have it in syz-executor, then syz-exec=
utor could simply pass the bitmap to the kernel rather than post-filter.
> > > It's also overlaps with the KCOV_MODE_UNIQUE mode that +Alexander pro=
posed here:
> > > https://groups.google.com/g/kasan-dev/c/oVz3ZSWaK1Q/m/9ASztdzCAAAJ
> > > It would be reasonable if kernel uses the same bitmap format for thes=
e
> > > 2 features.
> > >
> > >
> > >
> > > > An example usage is to use together syzkaller's cov filter.
> > > >
> > > > Change-Id: I954f6efe1bca604f5ce31f8f2b6f689e34a2981d
> > > > Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
> > > > ---
> > > >  Documentation/dev-tools/kcov.rst | 10 ++++++++++
> > > >  include/uapi/linux/kcov.h        |  7 +++++++
> > > >  kernel/kcov.c                    | 18 ++++++++++++++++++
> > > >  3 files changed, 35 insertions(+)
> > > >
> > > > diff --git a/Documentation/dev-tools/kcov.rst
> > > > b/Documentation/dev-tools/kcov.rst
> > > > index d83c9ab..fbcd422 100644
> > > > --- a/Documentation/dev-tools/kcov.rst
> > > > +++ b/Documentation/dev-tools/kcov.rst
> > > > @@ -52,9 +52,15 @@ program using kcov:
> > > >      #include <fcntl.h>
> > > >      #include <linux/types.h>
> > > >
> > > > +    struct kcov_pc_range {
> > > > +      uint32 start;
> > > > +      uint32 end;
> > > > +    };
> > > > +
> > > >      #define KCOV_INIT_TRACE                    _IOR('c', 1, unsign=
ed long)
> > > >      #define KCOV_ENABLE                        _IO('c', 100)
> > > >      #define KCOV_DISABLE                       _IO('c', 101)
> > > > +    #define KCOV_TRACE_RANGE                   _IOW('c', 103, stru=
ct kcov_pc_range)
> > > >      #define COVER_SIZE                 (64<<10)
> > > >
> > > >      #define KCOV_TRACE_PC  0
> > > > @@ -64,6 +70,8 @@ program using kcov:
> > > >      {
> > > >         int fd;
> > > >         unsigned long *cover, n, i;
> > > > +        /* Change start and/or end to your interested pc range. */
> > > > +        struct kcov_pc_range pc_range =3D {.start =3D 0, .end =3D
> > > > + (uint32)(~((uint32)0))};
> > > >
> > > >         /* A single fd descriptor allows coverage collection on a s=
ingle
> > > >          * thread.
> > > > @@ -79,6 +87,8 @@ program using kcov:
> > > >                                      PROT_READ | PROT_WRITE, MAP_SH=
ARED, fd, 0);
> > > >         if ((void*)cover =3D=3D MAP_FAILED)
> > > >                 perror("mmap"), exit(1);
> > > > +        if (ioctl(fd, KCOV_PC_RANGE, pc_range))
> > > > +               dprintf(2, "ignore KCOV_PC_RANGE error.\n");
> > > >         /* Enable coverage collection on the current thread. */
> > > >         if (ioctl(fd, KCOV_ENABLE, KCOV_TRACE_PC))
> > > >                 perror("ioctl"), exit(1); diff --git
> > > > a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h index
> > > > 1d0350e..353ff0a 100644
> > > > --- a/include/uapi/linux/kcov.h
> > > > +++ b/include/uapi/linux/kcov.h
> > > > @@ -16,12 +16,19 @@ struct kcov_remote_arg {
> > > >         __aligned_u64   handles[0];
> > > >  };
> > > >
> > > > +#define PC_RANGE_MASK ((__u32)(~((u32) 0))) struct kcov_pc_range {
> > > > +       __u32           start;          /* start pc & 0xFFFFFFFF */
> > > > +       __u32           end;            /* end pc & 0xFFFFFFFF */
> > > > +};
> > > > +
> > > >  #define KCOV_REMOTE_MAX_HANDLES                0x100
> > > >
> > > >  #define KCOV_INIT_TRACE                        _IOR('c', 1, unsign=
ed long)
> > > >  #define KCOV_ENABLE                    _IO('c', 100)
> > > >  #define KCOV_DISABLE                   _IO('c', 101)
> > > >  #define KCOV_REMOTE_ENABLE             _IOW('c', 102, struct kcov_=
remote_arg)
> > > > +#define KCOV_PC_RANGE                  _IOW('c', 103, struct kcov_=
pc_range)
> > > >
> > > >  enum {
> > > >         /*
> > > > diff --git a/kernel/kcov.c b/kernel/kcov.c index 36ca640..59550450
> > > > 100644
> > > > --- a/kernel/kcov.c
> > > > +++ b/kernel/kcov.c
> > > > @@ -36,6 +36,7 @@
> > > >   *  - initial state after open()
> > > >   *  - then there must be a single ioctl(KCOV_INIT_TRACE) call
> > > >   *  - then, mmap() call (several calls are allowed but not useful)
> > > > + *  - then, optional to set trace pc range
> > > >   *  - then, ioctl(KCOV_ENABLE, arg), where arg is
> > > >   *     KCOV_TRACE_PC - to trace only the PCs
> > > >   *     or
> > > > @@ -69,6 +70,8 @@ struct kcov {
> > > >          * kcov_remote_stop(), see the comment there.
> > > >          */
> > > >         int                     sequence;
> > > > +       /* u32 Trace PC range from start to end. */
> > > > +       struct kcov_pc_range    pc_range;
> > > >  };
> > > >
> > > >  struct kcov_remote_area {
> > > > @@ -192,6 +195,7 @@ static notrace unsigned long
> > > > canonicalize_ip(unsigned long ip)  void notrace
> > > > __sanitizer_cov_trace_pc(void)  {
> > > >         struct task_struct *t;
> > > > +       struct kcov_pc_range pc_range;
> > > >         unsigned long *area;
> > > >         unsigned long ip =3D canonicalize_ip(_RET_IP_);
> > > >         unsigned long pos;
> > > > @@ -199,6 +203,11 @@ void notrace __sanitizer_cov_trace_pc(void)
> > > >         t =3D current;
> > > >         if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> > > >                 return;
> > > > +       pc_range =3D t->kcov->pc_range;
> > > > +       if (pc_range.start < pc_range.end &&
> > > > +               ((ip & PC_RANGE_MASK) < pc_range.start ||
> > > > +               (ip & PC_RANGE_MASK) > pc_range.end))
> > > > +               return;
> > > >
> > > >         area =3D t->kcov_area;
> > > >         /* The first 64-bit word is the number of subsequent PCs. *=
/
> > > > @@ -568,6 +577,7 @@ static int kcov_ioctl_locked(struct kcov *kcov,=
 unsigned int cmd,
> > > >         int mode, i;
> > > >         struct kcov_remote_arg *remote_arg;
> > > >         struct kcov_remote *remote;
> > > > +       struct kcov_pc_range *pc_range;
> > > >         unsigned long flags;
> > > >
> > > >         switch (cmd) {
> > > > @@ -589,6 +599,14 @@ static int kcov_ioctl_locked(struct kcov *kcov=
, unsigned int cmd,
> > > >                 kcov->size =3D size;
> > > >                 kcov->mode =3D KCOV_MODE_INIT;
> > > >                 return 0;
> > > > +       case KCOV_PC_RANGE:
> > > > +               /* Limit trace pc range. */
> > > > +               pc_range =3D (struct kcov_pc_range *)arg;
> > > > +               if (copy_from_user(&kcov->pc_range, pc_range, sizeo=
f(kcov->pc_range)))
> > > > +                       return -EINVAL;
> > > > +               if (kcov->pc_range.start >=3D kcov->pc_range.end)
> > > > +                       return -EINVAL;
> > > > +               return 0;
> > > >         case KCOV_ENABLE:
> > > >                 /*
> > > >                  * Enable coverage for the current task.
> > > > --
> > > > 2.7.4
