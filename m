Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED26945706A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhKSOQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhKSOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:16:54 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:13:53 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s139so21960446oie.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ABKMDfwitq7owZrAzc9+tcuk1/+LD/nidZAorFNB/Kw=;
        b=rHWScJWorPN+xE1EUwY23Vsf++u+TXnKWCEbYqRU2lPBnsl8lsfxLIrXwE+UlcJ7TR
         lTfvx8L7H5WT9BLEe3c6NN7Qck7VgKzFTbffF72dkiWpSGgsWGdI9NuUoIa5dDXdFEBe
         qebdp1whvK0dKY7EKrKfBeLsnTzc837f0I9kIaQzOmdW21Ge6JJgTRY2t72/RGyUYw/W
         WRZg5EAqwMh0n39Y0BIt8lsA71ZdUqmvMkgpwVi2Kfl4uCVndJmhooKpiQPFCE5oCpkT
         l/4neHoW5mfCGzGkYMD4gzNGxozbzQfgZcngsM7Srkf2o4f/BjMulQPlRgbseG0Y02Y6
         kdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ABKMDfwitq7owZrAzc9+tcuk1/+LD/nidZAorFNB/Kw=;
        b=mAxixn2aePANIVO+Zj8SmMvXGO9kEGddJKWtaTpFOYshUp5Npt53JINOowc0Lznvc8
         XQAFqthQHt9VuJLBLWnygGDwB9HopyMXKGKRwCdqzPCmsI4ECK/y8I+llAviq3Cx7Myq
         yeOZqJLmZQmcKvKrVQM1cFsfSSc+GCCN5xL+/skUV9oe8gdiYIEDymyzz6esyc+PQ32x
         h4dqzoJIXQbrEMjbICcRPIrl4mZx6rrhL0wTLkAlXcRwTx3zm01T45Gr2qrVWVYIbJLz
         //ngoHCgtK1Y/7jWUfYAzTYOtOdWErmr3iGx7O2aYiYXs/LUpKobNblD6sYUJmL0rWKS
         uLkA==
X-Gm-Message-State: AOAM532nQWkfGGF0ms2fIABcxOiExeOlFvzX9O9MUB1o09z3YbtFtQ6w
        y5l4VnSoOrQMGrDDC9KGIEvrpAE1Co8sF0ef5dYeXA==
X-Google-Smtp-Source: ABdhPJzldF7dI8j5ETOBOzs8mtWAeT+OB03WPt0gs9jz+1lPrf+N/lYCWNuSEDyMYddG5c0jUlD9G2p8FVftiwh6FkM=
X-Received: by 2002:aca:3104:: with SMTP id x4mr5550365oix.128.1637331232021;
 Fri, 19 Nov 2021 06:13:52 -0800 (PST)
MIME-Version: 1.0
References: <1637130234-57238-1-git-send-email-quic_jiangenj@quicinc.com>
 <CACT4Y+YwNawV9H7uFMVSCA5WB-Dkyu9TX+rMM3FR6gNGkKFPqw@mail.gmail.com>
 <DM8PR02MB8247720860A08914CAA41D42F89C9@DM8PR02MB8247.namprd02.prod.outlook.com>
 <CACT4Y+a07DxQdYFY6uc5Y4GhTUbcnETij6gg3y+JRDvtwSmK5g@mail.gmail.com>
 <DM8PR02MB8247A19843220E03B34BA440F89C9@DM8PR02MB8247.namprd02.prod.outlook.com>
 <CACT4Y+Y36wgP_xjYVQApNLdMOFTr2-KCHc=AipcZyZiAhwf1Nw@mail.gmail.com>
 <CACT4Y+YF4Ngm6em_Sn2p+N0x1L+O8A=BEVTNhd00LmSZ+aH1iQ@mail.gmail.com> <CA+fCnZct-Fy6JEUoHgk0h=2aFeBAWz2Ax_kOCee3-i_6zU-wfQ@mail.gmail.com>
In-Reply-To: <CA+fCnZct-Fy6JEUoHgk0h=2aFeBAWz2Ax_kOCee3-i_6zU-wfQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 19 Nov 2021 15:13:40 +0100
Message-ID: <CACT4Y+bYvCKikJK_HwwPHWW057E-s1cDzQNm7KTNz_hXTUOWzQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: add KCOV_PC_RANGE to limit pc range
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     "JianGen Jiao (QUIC)" <quic_jiangenj@quicinc.com>,
        syzkaller <syzkaller@googlegroups.com>,
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

 On Fri, 19 Nov 2021 at 15:09, Andrey Konovalov <andreyknvl@gmail.com> wrot=
e:
> > > +Kaipeng, Hangbin who contributed the coverage filter to syzkaller.
> > > This is a discussion about adding a similar filter to the kernel. You
> > > can see whole discussion here:
> > > https://groups.google.com/g/kasan-dev/c/TQmYUdUC08Y
> >
> > Joey, what do you think in general about passing a filter bitmap to the=
 kernel?
> >
> > Since the bitmap is large, it can make sense to reuse it across
> > different KCOV instances.
> > I am thinking about something along the following lines:
> >
> > kcov_fd =3D open("/debugfs/kcov");
> > filter_fd =3D ioctl(kcov_fd, KCOV_CREATE_FILTER, &{... some args
> > specifying start/end ...});
> > filter =3D mmap(..., filter_fd);
> > ... write to the filter ...
> >
> > ...
> > kcov_fd2 =3D open("/debugfs/kcov");
> > ioctl(kcov_fd2, KCOV_ATTACH_FILTER, filter_fd);
> > ioctl(kcov_fd2, KCOV_ENABLE);
> >
> >
> > This would allow us to create 2 filters:
> > 1. One the interesting subsystems
> > 2. Second only for yet uncovered PCs in the interesting subsystems
> > (updated as we discover more coverage)
> >
> > During fuzzing we attach the second filter to KCOV.
> > But when we want to obtain full program coverage, we attach the first o=
ne.
> >
> > The filters (bitmaps) are reused across all threads in all executor
> > processes (so that we have only 2 filters globally per VM).
> >
> > KCOV_CREATE_FILTER could also accept how many bytes each bit
> > represents (that scaling factor, as hardcoding 4, 8, 16 may be bad for
> > a stable kernel interface).
> >
> > But I am still not sure how to support both the main kernel and
> > modules. We could allow setting up multiple filters for different PC
> > ranges. Or may be just 2 (one for kernel and one for modules range).
> > Or maybe 1 bitmap can cover both kernel and modules?
> >
> > Thoughts?
>
> Throwing in a thought without a concrete design suggestion: how about
> en eBPF-based filter? The flexibility would allow covering as many PC
> ranges as one wants. And, perhaps, do other things.

This is definitely interesting and flexible. eBPF have different types
of maps nowadays and these can be accessed from user-space as well.
Alternatively could we attach just an eBPF map as a filter?
But we would need to measure overhead, this will be executed for every
basic block of code.



> > > On Fri, 19 Nov 2021 at 12:21, JianGen Jiao (QUIC)
> > > <quic_jiangenj@quicinc.com> wrote:
> > > >
> > > > Yes, on x86_64, module address space is after kernel. But like belo=
w on arm64, it's different.
> > > >
> > > > # grep stext /proc/kallsyms
> > > > ffffffc010010000 T _stext
> > > > # cat /proc/modules |sort -k 6 | tail -2
> > > > Some_module_1 552960 0 - Live 0xffffffc00ca05000 (O)
> > > > Some_module_1 360448 0 - Live 0xffffffc00cb8f000 (O) # cat /proc/mo=
dules |sort -k 6 | head -2
> > > > Some_module_3 16384 1 - Live 0xffffffc009430000
> > > >
> > > > -----Original Message-----
> > > > From: Dmitry Vyukov <dvyukov@google.com>
> > > > Sent: Friday, November 19, 2021 6:38 PM
> > > > To: JianGen Jiao (QUIC) <quic_jiangenj@quicinc.com>
> > > > Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; LKML <linux-k=
ernel@vger.kernel.org>; Alexander Lochmann <info@alexander-lochmann.de>; Li=
kai Ding (QUIC) <quic_likaid@quicinc.com>
> > > > Subject: Re: [PATCH] kcov: add KCOV_PC_RANGE to limit pc range
> > > >
> > > > WARNING: This email originated from outside of Qualcomm. Please be =
wary of any links or attachments, and do not enable macros.
> > > >
> > > > On Fri, 19 Nov 2021 at 04:17, JianGen Jiao (QUIC) <quic_jiangenj@qu=
icinc.com> wrote:
> > > > >
> > > > > Hi Dmitry,
> > > > > I'm using the start, end pc from cover filter, which currently is=
 the fast way compared to the big bitmap passing from syzkaller solution, a=
s I only set the cover filter to dirs/files I care about.
> > > >
> > > > I see.
> > > > But if we are unlucky and our functions of interest are at the very=
 low and high addresses, start/end will cover almost all kernel code...
> > > >
> > > > > I checked
> > > > > https://groups.google.com/g/kasan-dev/c/oVz3ZSWaK1Q/m/9ASztdzCAAA=
J,
> > > > > The bitmap seems not the same as syzkaller one, which one will be=
 used finally?
> > > >
> > > > I don't know yet. We need to decide.
> > > > In syzkaller we are more flexible and can change code faster, while=
 kernel interfaces are stable and need to be kept forever. So I think we ne=
ed to concentrate more on the good kernel interface and then support it in =
syzkaller.
> > > >
> > > > > ``` Alexander's one
> > > > > + pos =3D (ip - canonicalize_ip((unsigned long)&_stext)) / 4; idx=
 =3D pos
> > > > > + % BITS_PER_LONG; pos /=3D BITS_PER_LONG; if (likely(pos <
> > > > > + t->kcov_size)) WRITE_ONCE(area[pos], READ_ONCE(area[pos]) | 1L =
<<
> > > > > + idx);
> > > > > ```
> > > > > Pc offset is divided by 4 and start is _stext. But for some arch,=
 pc is less than _stext.
> > > >
> > > > You mean that modules can have PC < _stext?
> > > >
> > > > > ``` https://github.com/google/syzkaller/blob/master/syz-manager/c=
ovfilter.go#L139-L154
> > > > >         data :=3D make([]byte, 8+((size>>4)/8+1))
> > > > >         order :=3D binary.ByteOrder(binary.BigEndian)
> > > > >         if target.LittleEndian {
> > > > >                 order =3D binary.LittleEndian
> > > > >         }
> > > > >         order.PutUint32(data, start)
> > > > >         order.PutUint32(data[4:], size)
> > > > >
> > > > >         bitmap :=3D data[8:]
> > > > >         for pc :=3D range pcs {
> > > > >                 // The lowest 4-bit is dropped.
> > > > >                 pc =3D uint32(backend.NextInstructionPC(target, u=
int64(pc)))
> > > > >                 pc =3D (pc - start) >> 4
> > > > >                 bitmap[pc/8] |=3D (1 << (pc % 8))
> > > > >         }
> > > > >         return data
> > > > > ```
> > > > > Pc offset is divided by 16 and start is cover filter start pc.
> > > > >
> > > > > I think divided by 8 is more reasonable? Because there is at leas=
t one instruction before each __sanitizer_cov_trace_pc call.
> > > > > 0000000000000160 R_AARCH64_CALL26  __sanitizer_cov_trace_pc
> > > > > 0000000000000168 R_AARCH64_CALL26  __sanitizer_cov_trace_pc
> > > > >
> > > > > I think we still need my patch because we still need a way to kee=
p the trace_pc call and post-filter in syzkaller doesn't solve trace_pc dro=
pping, right?
> > > >
> > > > Yes, the in-kernel filter solves the problem of trace capacity/over=
flows.
> > > >
> > > >
> > > > > But for sure I can use the bitmap from syzkaller.
> > > > >
> > > > > THX
> > > > > Joey
> > > > > -----Original Message-----
> > > > > From: Dmitry Vyukov <dvyukov@google.com>
> > > > > Sent: Thursday, November 18, 2021 10:00 PM
> > > > > To: JianGen Jiao (QUIC) <quic_jiangenj@quicinc.com>
> > > > > Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; LKML
> > > > > <linux-kernel@vger.kernel.org>; Alexander Lochmann
> > > > > <info@alexander-lochmann.de>
> > > > > Subject: Re: [PATCH] kcov: add KCOV_PC_RANGE to limit pc range
> > > > >
> > > > > WARNING: This email originated from outside of Qualcomm. Please b=
e wary of any links or attachments, and do not enable macros.
> > > > >
> > > > > ,On Wed, 17 Nov 2021 at 07:24, Joey Jiao <quic_jiangenj@quicinc.c=
om> wrote:
> > > > > >
> > > > > > Sometimes we only interested in the pcs within some range, whil=
e
> > > > > > there are cases these pcs are dropped by kernel due to `pos >=
=3D
> > > > > > t->kcov_size`, and by increasing the map area size doesn't help=
.
> > > > > >
> > > > > > To avoid disabling KCOV for these not intereseted pcs during bu=
ild
> > > > > > time, adding this new KCOV_PC_RANGE cmd.
> > > > >
> > > > > Hi Joey,
> > > > >
> > > > > How do you use this? I am concerned that a single range of PCs is=
 too restrictive. I can only see how this can work for single module (conti=
nuous in memory) or a single function. But for anything else (something in =
the main kernel, or several modules), it won't work as PCs are not continuo=
us.
> > > > >
> > > > > Maybe we should use a compressed bitmap of interesting PCs? It al=
lows to support all cases and we already have it in syz-executor, then syz-=
executor could simply pass the bitmap to the kernel rather than post-filter=
.
> > > > > It's also overlaps with the KCOV_MODE_UNIQUE mode that +Alexander=
 proposed here:
> > > > > https://groups.google.com/g/kasan-dev/c/oVz3ZSWaK1Q/m/9ASztdzCAAA=
J
> > > > > It would be reasonable if kernel uses the same bitmap format for =
these
> > > > > 2 features.
> > > > >
> > > > >
> > > > >
> > > > > > An example usage is to use together syzkaller's cov filter.
> > > > > >
> > > > > > Change-Id: I954f6efe1bca604f5ce31f8f2b6f689e34a2981d
> > > > > > Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
> > > > > > ---
> > > > > >  Documentation/dev-tools/kcov.rst | 10 ++++++++++
> > > > > >  include/uapi/linux/kcov.h        |  7 +++++++
> > > > > >  kernel/kcov.c                    | 18 ++++++++++++++++++
> > > > > >  3 files changed, 35 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/dev-tools/kcov.rst
> > > > > > b/Documentation/dev-tools/kcov.rst
> > > > > > index d83c9ab..fbcd422 100644
> > > > > > --- a/Documentation/dev-tools/kcov.rst
> > > > > > +++ b/Documentation/dev-tools/kcov.rst
> > > > > > @@ -52,9 +52,15 @@ program using kcov:
> > > > > >      #include <fcntl.h>
> > > > > >      #include <linux/types.h>
> > > > > >
> > > > > > +    struct kcov_pc_range {
> > > > > > +      uint32 start;
> > > > > > +      uint32 end;
> > > > > > +    };
> > > > > > +
> > > > > >      #define KCOV_INIT_TRACE                    _IOR('c', 1, un=
signed long)
> > > > > >      #define KCOV_ENABLE                        _IO('c', 100)
> > > > > >      #define KCOV_DISABLE                       _IO('c', 101)
> > > > > > +    #define KCOV_TRACE_RANGE                   _IOW('c', 103, =
struct kcov_pc_range)
> > > > > >      #define COVER_SIZE                 (64<<10)
> > > > > >
> > > > > >      #define KCOV_TRACE_PC  0
> > > > > > @@ -64,6 +70,8 @@ program using kcov:
> > > > > >      {
> > > > > >         int fd;
> > > > > >         unsigned long *cover, n, i;
> > > > > > +        /* Change start and/or end to your interested pc range=
. */
> > > > > > +        struct kcov_pc_range pc_range =3D {.start =3D 0, .end =
=3D
> > > > > > + (uint32)(~((uint32)0))};
> > > > > >
> > > > > >         /* A single fd descriptor allows coverage collection on=
 a single
> > > > > >          * thread.
> > > > > > @@ -79,6 +87,8 @@ program using kcov:
> > > > > >                                      PROT_READ | PROT_WRITE, MA=
P_SHARED, fd, 0);
> > > > > >         if ((void*)cover =3D=3D MAP_FAILED)
> > > > > >                 perror("mmap"), exit(1);
> > > > > > +        if (ioctl(fd, KCOV_PC_RANGE, pc_range))
> > > > > > +               dprintf(2, "ignore KCOV_PC_RANGE error.\n");
> > > > > >         /* Enable coverage collection on the current thread. */
> > > > > >         if (ioctl(fd, KCOV_ENABLE, KCOV_TRACE_PC))
> > > > > >                 perror("ioctl"), exit(1); diff --git
> > > > > > a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h index
> > > > > > 1d0350e..353ff0a 100644
> > > > > > --- a/include/uapi/linux/kcov.h
> > > > > > +++ b/include/uapi/linux/kcov.h
> > > > > > @@ -16,12 +16,19 @@ struct kcov_remote_arg {
> > > > > >         __aligned_u64   handles[0];
> > > > > >  };
> > > > > >
> > > > > > +#define PC_RANGE_MASK ((__u32)(~((u32) 0))) struct kcov_pc_ran=
ge {
> > > > > > +       __u32           start;          /* start pc & 0xFFFFFFF=
F */
> > > > > > +       __u32           end;            /* end pc & 0xFFFFFFFF =
*/
> > > > > > +};
> > > > > > +
> > > > > >  #define KCOV_REMOTE_MAX_HANDLES                0x100
> > > > > >
> > > > > >  #define KCOV_INIT_TRACE                        _IOR('c', 1, un=
signed long)
> > > > > >  #define KCOV_ENABLE                    _IO('c', 100)
> > > > > >  #define KCOV_DISABLE                   _IO('c', 101)
> > > > > >  #define KCOV_REMOTE_ENABLE             _IOW('c', 102, struct k=
cov_remote_arg)
> > > > > > +#define KCOV_PC_RANGE                  _IOW('c', 103, struct k=
cov_pc_range)
> > > > > >
> > > > > >  enum {
> > > > > >         /*
> > > > > > diff --git a/kernel/kcov.c b/kernel/kcov.c index 36ca640..59550=
450
> > > > > > 100644
> > > > > > --- a/kernel/kcov.c
> > > > > > +++ b/kernel/kcov.c
> > > > > > @@ -36,6 +36,7 @@
> > > > > >   *  - initial state after open()
> > > > > >   *  - then there must be a single ioctl(KCOV_INIT_TRACE) call
> > > > > >   *  - then, mmap() call (several calls are allowed but not use=
ful)
> > > > > > + *  - then, optional to set trace pc range
> > > > > >   *  - then, ioctl(KCOV_ENABLE, arg), where arg is
> > > > > >   *     KCOV_TRACE_PC - to trace only the PCs
> > > > > >   *     or
> > > > > > @@ -69,6 +70,8 @@ struct kcov {
> > > > > >          * kcov_remote_stop(), see the comment there.
> > > > > >          */
> > > > > >         int                     sequence;
> > > > > > +       /* u32 Trace PC range from start to end. */
> > > > > > +       struct kcov_pc_range    pc_range;
> > > > > >  };
> > > > > >
> > > > > >  struct kcov_remote_area {
> > > > > > @@ -192,6 +195,7 @@ static notrace unsigned long
> > > > > > canonicalize_ip(unsigned long ip)  void notrace
> > > > > > __sanitizer_cov_trace_pc(void)  {
> > > > > >         struct task_struct *t;
> > > > > > +       struct kcov_pc_range pc_range;
> > > > > >         unsigned long *area;
> > > > > >         unsigned long ip =3D canonicalize_ip(_RET_IP_);
> > > > > >         unsigned long pos;
> > > > > > @@ -199,6 +203,11 @@ void notrace __sanitizer_cov_trace_pc(void=
)
> > > > > >         t =3D current;
> > > > > >         if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> > > > > >                 return;
> > > > > > +       pc_range =3D t->kcov->pc_range;
> > > > > > +       if (pc_range.start < pc_range.end &&
> > > > > > +               ((ip & PC_RANGE_MASK) < pc_range.start ||
> > > > > > +               (ip & PC_RANGE_MASK) > pc_range.end))
> > > > > > +               return;
> > > > > >
> > > > > >         area =3D t->kcov_area;
> > > > > >         /* The first 64-bit word is the number of subsequent PC=
s. */
> > > > > > @@ -568,6 +577,7 @@ static int kcov_ioctl_locked(struct kcov *k=
cov, unsigned int cmd,
> > > > > >         int mode, i;
> > > > > >         struct kcov_remote_arg *remote_arg;
> > > > > >         struct kcov_remote *remote;
> > > > > > +       struct kcov_pc_range *pc_range;
> > > > > >         unsigned long flags;
> > > > > >
> > > > > >         switch (cmd) {
> > > > > > @@ -589,6 +599,14 @@ static int kcov_ioctl_locked(struct kcov *=
kcov, unsigned int cmd,
> > > > > >                 kcov->size =3D size;
> > > > > >                 kcov->mode =3D KCOV_MODE_INIT;
> > > > > >                 return 0;
> > > > > > +       case KCOV_PC_RANGE:
> > > > > > +               /* Limit trace pc range. */
> > > > > > +               pc_range =3D (struct kcov_pc_range *)arg;
> > > > > > +               if (copy_from_user(&kcov->pc_range, pc_range, s=
izeof(kcov->pc_range)))
> > > > > > +                       return -EINVAL;
> > > > > > +               if (kcov->pc_range.start >=3D kcov->pc_range.en=
d)
> > > > > > +                       return -EINVAL;
> > > > > > +               return 0;
> > > > > >         case KCOV_ENABLE:
> > > > > >                 /*
> > > > > >                  * Enable coverage for the current task.
> > > > > > --
> > > > > > 2.7.4
