Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C5341BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhCSLzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhCSLzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:55:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FDFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:55:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so8832021wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=16SrezVDUFLIfrypEfRbEYmWis6wKPZP7qnZqGpLLiw=;
        b=h7ccAW7DgcjVzbgiVaY1l1wBNrpA9KmW3Dooyu76IAA7kBCEAcSU+nWn8tHRNWWrtK
         8Q0WwqRYLNwmpyJNECO9yBxKQSA1Txa6FD7f7tk6nd2bRCISstVbPAs/og4PCBBMtJ6d
         KORX1Uf0k05N/JbPXaIm/b2BKyXLnzRgL+hKx4lo72NzScxS6EPy1OWS5HYRQr9x6edz
         Gg5ulloByZQWmG6EXKp7WoU9EHfhrtiSUgLFjJ+/IVHXrrrAzIO8MptWCE/sh4yz2Hve
         axJ8mi9i7EelNXNBF+RcVtNH3G/XoeGr6RstC8DrMf9AeVw+EQRJngq2GU2KNQq2ySHD
         +bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=16SrezVDUFLIfrypEfRbEYmWis6wKPZP7qnZqGpLLiw=;
        b=QoADgHNpxejOpYuY2htiCYzt2o59pec5KNhyL49mVqbVdpEFe9DXKMQSRSX95/Kgx4
         ri1aKF0QEwwIvXvAL7nxs3TmdhLP5Yh9D4kfNollVrKfRHEuEcuRXTkltTPSt7nguo1N
         J8zo68f1VtnnQQylCQ7V9arUN/F+5bUfjfh/YQfJzbBXcSZxzXYVrdR5dDIH22MMQp+T
         b/oP0aGLvfe9Y6mPGRWFsDmIry79Bc5ws3PI1idlC5LhuO+r795yxKKdWE7XegvNssEl
         AuVWcyN5snbdQFR8bKx9JcwUW/o/8eRaPZTC0NaytF3Z7/uE3lYoXB0xj7ysI8KVln/X
         EsEA==
X-Gm-Message-State: AOAM5308VZp/yAJdipTiE6jV3noeL6DOhyeOMJs8gY3YOZFwAX/JMaew
        +m3lVd+4UfQdr6TrsNJaj3Q4pB08cDUlygDxnwUumA==
X-Google-Smtp-Source: ABdhPJyRJcT/mt4qYvM/Q9ELsEmQYLQxBkW4qp8stU8HbCrrz0jA8zmVNM+GHnVzA+rfIXsX2z0yCXBA1e3GvUbex78=
X-Received: by 2002:a5d:558b:: with SMTP id i11mr4062628wrv.176.1616154921222;
 Fri, 19 Mar 2021 04:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-19-suzuki.poulose@arm.com> <CAJ9a7VhHP3_mRWQujVPxcguF4W17tNhogGqAFj6MF2nJ+Y==Fw@mail.gmail.com>
 <5685C840-7F03-4A53-9183-D5771308F5B8@arm.com>
In-Reply-To: <5685C840-7F03-4A53-9183-D5771308F5B8@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 19 Mar 2021 11:55:10 +0000
Message-ID: <CAJ9a7Vikvrxzrv1vwA3327L6_3_P72YrATMmy9L+ENb9Bc2m9Q@mail.gmail.com>
Subject: Re: [PATCH v4 18/19] coresight: sink: Add TRBE driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Suzuki,

On Fri, 19 Mar 2021 at 10:30, Suzuki K Poulose <suzuki.poulose@arm.com> wro=
te:
>
> Hi Mike
>
> > On 8 Mar 2021, at 17:26, Mike Leach <mike.leach@linaro.org> wrote:
> >
> > Hi Suzuki,
> >
> > On Thu, 25 Feb 2021 at 19:36, Suzuki K Poulose <suzuki.poulose@arm.com>=
 wrote:
> >>
> >> From: Anshuman Khandual <anshuman.khandual@arm.com>
> >>
> >> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which =
is
> >> accessible via the system registers. The TRBE supports different addre=
ssing
> >> modes including CPU virtual address and buffer modes including the cir=
cular
> >> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_=
EL1),
> >> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But=
 the
> >> access to the trace buffer could be prohibited by a higher exception l=
evel
> >> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a =
CPU
> >> private interrupt (PPI) on address translation errors and when the buf=
fer
> >> is full. Overall implementation here is inspired from the Arm SPE driv=
er.
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Mike Leach <mike.leach@linaro.org>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>
> >> +
> >> +static unsigned long arm_trbe_update_buffer(struct coresight_device *=
csdev,
> >> +                                           struct perf_output_handle =
*handle,
> >> +                                           void *config)
> >> +{
> >> +       struct trbe_drvdata *drvdata =3D dev_get_drvdata(csdev->dev.pa=
rent);
> >> +       struct trbe_cpudata *cpudata =3D dev_get_drvdata(&csdev->dev);
> >> +       struct trbe_buf *buf =3D config;
> >> +       enum trbe_fault_action act;
> >> +       unsigned long size, offset;
> >> +       unsigned long write, base, status;
> >> +       unsigned long flags;
> >> +
> >> +       WARN_ON(buf->cpudata !=3D cpudata);
> >> +       WARN_ON(cpudata->cpu !=3D smp_processor_id());
> >> +       WARN_ON(cpudata->drvdata !=3D drvdata);
> >> +       if (cpudata->mode !=3D CS_MODE_PERF)
> >> +               return 0;
> >> +
> >> +       perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RA=
W);
> >> +
> >> +       /*
> >> +        * We are about to disable the TRBE. And this could in turn
> >> +        * fill up the buffer triggering, an IRQ. This could be consum=
ed
> >> +        * by the PE asynchronously, causing a race here against
> >> +        * the IRQ handler in closing out the handle. So, let us
> >> +        * make sure the IRQ can't trigger while we are collecting
> >> +        * the buffer. We also make sure that a WRAP event is handled
> >> +        * accordingly.
> >> +        */
> >> +       local_irq_save(flags);
> >> +
> >> +       /*
> >> +        * If the TRBE was disabled due to lack of space in the AUX bu=
ffer or a
> >> +        * spurious fault, the driver leaves it disabled, truncating t=
he buffer.
> >> +        * Since the etm_perf driver expects to close out the AUX buff=
er, the
> >> +        * driver skips it. Thus, just pass in 0 size here to indicate=
 that the
> >> +        * buffer was truncated.
> >> +        */
> >> +       if (!is_trbe_enabled()) {
> >> +               size =3D 0;
> >> +               goto done;
> >> +       }
> >> +       /*
> >> +        * perf handle structure needs to be shared with the TRBE IRQ =
handler for
> >> +        * capturing trace data and restarting the handle. There is a =
probability
> >> +        * of an undefined reference based crash when etm event is bei=
ng stopped
> >> +        * while a TRBE IRQ also getting processed. This happens due t=
he release
> >> +        * of perf handle via perf_aux_output_end() in etm_event_stop(=
). Stopping
> >> +        * the TRBE here will ensure that no IRQ could be generated wh=
en the perf
> >> +        * handle gets freed in etm_event_stop().
> >> +        */
> >> +       trbe_drain_and_disable_local();
> >> +       write =3D get_trbe_write_pointer();
> >> +       base =3D get_trbe_base_pointer();
> >> +
> >> +       /* Check if there is a pending interrupt and handle it here */
> >> +       status =3D read_sysreg_s(SYS_TRBSR_EL1);
> >> +       if (is_trbe_irq(status)) {
> >> +
> >> +               /*
> >> +                * Now that we are handling the IRQ here, clear the IR=
Q
> >> +                * from the status, to let the irq handler know that i=
t
> >> +                * is taken care of.
> >> +                */
> >> +               clr_trbe_irq();
> >> +               isb();
> >> +
> >> +               act =3D trbe_get_fault_act(status);
> >> +               /*
> >> +                * If this was not due to a WRAP event, we have some
> >> +                * errors and as such buffer is empty.
> >> +                */
> >> +               if (act !=3D TRBE_FAULT_ACT_WRAP) {
> >> +                       size =3D 0;
> >> +                       goto done;
> >> +               }
> >
> > We are using TRBE FILL mode - which halts capture on a full buffer and
> > triggers the IRQ, without disabling the source first.
> > This means that the mode is inherently lossy (unless by some unlikely
> > co-incidence the last byte that caused the wrap was also the last byte
> > to be sent from an ETE that was in the process of being disabled.)
> > Therefore we must have a perf_aux_output_flag(handle,
> > PERF_AUX_FLAG_TRUNCATED) call in here to signal that some trace was
> > lost, for consistence of operation with ETR etc, and intelpt.
> >
>
> I agree that the there is a bit of loss here due to the FILL mode. But it=
 is not  comparable to that of the ETR. In this case, the WRAP event is tri=
ggered when we flush the ETE. i.e, this could be mostly due to the fact tha=
t the tracing was enabled for the kernel mode and the last few bytes of tra=
ce which caused the FILL belong to the code responsible for stopping the co=
mponents in the CoreSight trace. I personally do not think this data is of =
any interest to the user.
> Otherwise, if the data didn=E2=80=99t belong to the perf event side, it s=
hould have triggered the IRQ.
>
> This is true in case of the buffer overflow interrupt too, with a bit mor=
e data lost. i.e, since the interrupt is PPI, the overflow is triggered whe=
n the buffer is full (which includes the data that is cached in the TRBE). =
But there could be a bit of data that is still cached in the ETE, before it=
 is captured in the trace. And the moment we get a FILL event, we stop exec=
uting anything that is relevant for the Trace session (as we are in the dri=
ver handling the interrupt).
> And then we reconfigure the buffer to continue the execution. Now, the in=
terrupt delivery is not necessarily synchronous and there could be data los=
t in the interval between WRAP event and the IRQ is triggered.
>
> I am OK with suggesting that there was some loss of trace data during the=
 session, if we hit WRAP event. But this could cause worry to the consumers=
 that they lost too much of trace data of their interest, while that is not=
 the case.
>

We can never know what has been lost. It may be some trace around the
driver of no interest to the user, it may also be an event or
timestamp related to an earlier marker - which could be highly
relevant.
With ETR we do not know how much is lost on wrap - it might be one
byte, it might be much more - but the point is we mark as truncated
for _any_ amount.

It is unfortunate that we will see multiple buffers marked as
truncated - but this is far better than creating the false impression
that no trace has been lost - that there is a continuous record where
there is not.
For some users - such as autofdo where sampling is taking place anyway
- truncated buffers probably do not matter. For others - who are
looking to trace a specific section of code - then they need to be
aware that there could be decode anomolies relating to buffer wrap.

Regards

Mike

> >> +static inline unsigned long get_trbe_limit_pointer(void)
> >> +{
> >> +       u64 trblimitr =3D read_sysreg_s(SYS_TRBLIMITR_EL1);
> >> +       unsigned long limit =3D (trblimitr >> TRBLIMITR_LIMIT_SHIFT) &=
 TRBLIMITR_LIMIT_MASK;
> >> +       unsigned long addr =3D limit << TRBLIMITR_LIMIT_SHIFT;
> >
> > Could this not be:
> > unsigned long addr =3D trblimitr & (TRBLIMITR_LIMIT_MASK <<
> > TRBLIMITR_LIMIT_SHIFT);
> > like the base ponter below?
> >
>
> Sure, it can be consistent.
>
>
> >> +
> >> +       WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
> >> +       return addr;
> >> +}
> >> +
> >> +static inline unsigned long get_trbe_base_pointer(void)
> >> +{
> >> +       u64 trbbaser =3D read_sysreg_s(SYS_TRBBASER_EL1);
> >> +       unsigned long addr =3D trbbaser & (TRBBASER_BASE_MASK << TRBBA=
SER_BASE_SHIFT);
> >> +
> >> +       WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
> >> +       return addr;
> >> +}
> >> +
>
> Thank you for the review
>
> Kind regards
> Suzuki
>


--=20
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
