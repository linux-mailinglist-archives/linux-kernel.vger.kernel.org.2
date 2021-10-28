Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966A743F38C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhJ1Xnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhJ1Xnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 19:43:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEF1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 16:41:05 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id q74so13641041ybq.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 16:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yl1nkZWSVdhXNZgNIo/eN9U2NpZji7LG27lqyAkf4fQ=;
        b=UkcSh/HJZO1lLDNloPUHsimUNnqPhpZeCaegj1Ec73j0+DOokq75vZT/jNJvxzBHDx
         VLTnOs/QnGWTOiWahQ3Lqh5Lrbjk4mCe5iH6Z9884Bs2woaz9RIUts2L5tunPn/aNdpR
         Mf0SkobiPWPdwzJswOpMmVbrJSeIwtNv9BZnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yl1nkZWSVdhXNZgNIo/eN9U2NpZji7LG27lqyAkf4fQ=;
        b=XTM9CTRZWit4NUZ2OB9D625tbN6lfI2PwwGNhghvxE/clE+4vXlzgGJhiSWRB5fN8u
         mStLQrXHwfzy9bSWPA77PHhRuA43AW1NFJ5WQu5n5Hjjcjx0z3bCxS6SQiVNePpXdLNk
         7/WiLvPWPB9Yx+7hgtcbbWH4B7YLyqxOU1H2TUTxw7Z23lJu3st8U4TqkonnN4Y0c0ES
         +pAHLxDjnmyA20LG2nVBANQn+EwL08tRPENdk/6yTQRKl70RKXtSC6WdSYEaaOyQglOJ
         JhjqBo3eY5kam5d/ntz5yA6Bff4nisfuFOQbIZoautT5USKlzsu/AE4pZWIcqlYlC185
         aQWQ==
X-Gm-Message-State: AOAM531JFLL2VUpvZIyik+R/jlpjFTXh+P7CAXFGNVUHE2IiJkZ2WuG3
        Nx+34zyAHB/E8DLtSAa+wl+JD/y+KzGU0FKPpglF
X-Google-Smtp-Source: ABdhPJzdwnYiDfjlPyPemJ3Ro9PhM3VNHou0DSNi3u6TdxFi0k8NACvo6B/YP5o1op79bxLGBjRvFi3nTcqQAlAWIPU=
X-Received: by 2002:a25:86c4:: with SMTP id y4mr7865478ybm.258.1635464464543;
 Thu, 28 Oct 2021 16:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy2oV9fNtsY258h6zQS6Us7GyW6B_ox6U1Um2Why354-gA@mail.gmail.com>
 <mhng-730fea8d-0455-4333-a731-1e7b0e062587@palmerdabbelt-glaptop>
In-Reply-To: <mhng-730fea8d-0455-4333-a731-1e7b0e062587@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 28 Oct 2021 16:40:53 -0700
Message-ID: <CAOnJCU+ikYtAh5Pjzk+jkc_sUpTktmF-aDkafv2EE_6Ymp5F_Q@mail.gmail.com>
Subject: Re: Out-of-bounds access when hartid >= NR_CPUS
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <anup@brainfault.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, re@w6rz.net,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:16 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 28 Oct 2021 09:21:31 PDT (-0700), anup@brainfault.org wrote:
> > On Thu, Oct 28, 2021 at 8:39 PM Palmer Dabbelt <palmer@dabbelt.com> wro=
te:
> >>
> >> On Wed, 27 Oct 2021 16:34:15 PDT (-0700), atishp@atishpatra.org wrote:
> >> > On Tue, Oct 26, 2021 at 2:34 AM Heiko St=C3=BCbner <heiko@sntech.de>=
 wrote:
> >> >>
> >> >> Am Dienstag, 26. Oktober 2021, 10:57:26 CEST schrieb Geert Uytterho=
even:
> >> >> > Hi Heiko,
> >> >> >
> >> >> > On Tue, Oct 26, 2021 at 10:53 AM Heiko St=C3=BCbner <heiko@sntech=
.de> wrote:
> >> >> > > Am Dienstag, 26. Oktober 2021, 08:44:31 CEST schrieb Geert Uytt=
erhoeven:
> >> >> > > > On Tue, Oct 26, 2021 at 2:37 AM Ron Economos <re@w6rz.net> wr=
ote:
> >> >> > > > > On 10/25/21 8:54 AM, Geert Uytterhoeven wrote:
> >> >> > > > > > When booting a kernel with CONFIG_NR_CPUS=3D4 on Microchi=
p PolarFire,
> >> >> > > > > > the 4th CPU either fails to come online, or the system cr=
ashes.
> >> >> > > > > >
> >> >> > > > > > This happens because PolarFire has 5 CPU cores: hart 0 is=
 an e51,
> >> >> > > > > > and harts 1-4 are u54s, with the latter becoming CPUs 0-3=
 in Linux:
> >> >> > > > > >    - unused core has hartid 0 (sifive,e51),
> >> >> > > > > >    - processor 0 has hartid 1 (sifive,u74-mc),
> >> >> > > > > >    - processor 1 has hartid 2 (sifive,u74-mc),
> >> >> > > > > >    - processor 2 has hartid 3 (sifive,u74-mc),
> >> >> > > > > >    - processor 3 has hartid 4 (sifive,u74-mc).
> >> >> > > > > >
> >> >> > > > > > I assume the same issue is present on the SiFive fu540 an=
d fu740
> >> >> > > > > > SoCs, but I don't have access to these.  The issue is not=
 present
> >> >> > > > > > on StarFive JH7100, as processor 0 has hartid 1, and proc=
essor 1 has
> >> >> > > > > > hartid 0.
> >> >> > > > > >
> >> >> > > > > > arch/riscv/kernel/cpu_ops.c has:
> >> >> > > > > >
> >> >> > > > > >      void *__cpu_up_stack_pointer[NR_CPUS] __section(".da=
ta");
> >> >> > > > > >      void *__cpu_up_task_pointer[NR_CPUS] __section(".dat=
a");
> >> >> > > > > >
> >> >> > > > > >      void cpu_update_secondary_bootdata(unsigned int cpui=
d,
> >> >> > > > > >                                         struct task_struc=
t *tidle)
> >> >> > > > > >      {
> >> >> > > > > >              int hartid =3D cpuid_to_hartid_map(cpuid);
> >> >> > > > > >
> >> >> > > > > >              /* Make sure tidle is updated */
> >> >> > > > > >              smp_mb();
> >> >> > > > > >              WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> >> >> > > > > >                         task_stack_page(tidle) + THREAD_S=
IZE);
> >> >> > > > > >              WRITE_ONCE(__cpu_up_task_pointer[hartid], ti=
dle);
> >> >> > > > > >
> >> >> > > > > > The above two writes cause out-of-bound accesses beyond
> >> >> > > > > > __cpu_up_{stack,pointer}_pointer[] if hartid >=3D CONFIG_=
NR_CPUS.
> >> >> > > > > >
> >> >> > > > > >      }
> >> >> >
> >> >> > > > https://riscv.org/wp-content/uploads/2017/05/riscv-privileged=
-v1.10.pdf
> >> >> > > > says:
> >> >> > > >
> >> >> > > >     Hart IDs might not necessarily be numbered contiguously i=
n a
> >> >> > > >     multiprocessor system, but at least one hart must have a =
hart
> >> >> > > >     ID of zero.
> >> >> > > >
> >> >> > > > Which means indexing arrays by hart ID is a no-go?
> >> >> > >
> >> >> > > Isn't that also similar on aarch64?
> >> >> > >
> >> >> > > On a rk3399 you get 0-3 and 100-101 and with the paragraph abov=
e
> >> >> > > something like this could very well exist on some riscv cpu too=
 I guess.
> >> >> >
> >> >> > Yes, it looks like hart IDs are similar to MPIDRs on ARM.
> >> >>
> >> >> and they have the set_cpu_logical_map construct to map hwids
> >> >> to a continuous list of cpu-ids.
> >> >>
> >> >> So with hartids not being necessarily continuous this looks like
> >> >> riscv would need a similar mechanism.
> >> >>
> >> >
> >> > RISC-V already has a similar mechanism cpuid_to_hartid_map. Logical
> >> > cpu ids are continuous
> >> > while hartid can be sparse.
> >> >
> >> > The issue here is that __cpu_up_stack/task_pointer are per hart but
> >> > array size depends on the NR_CPUs
> >> > which represents the logical CPU.
> >> >
> >> > That's why, having a maximum number of hartids defined in config wil=
l
> >> > be helpful.
> >>
> >> I don't understand why we'd have both: if we can't find a CPU number f=
or
> >> a hart, then all we can do is just leave it offline.  Wouldn't it be
> >> simpler to just rely on NR_CPUS?  We'll need to fix the crashes on
> >> overflows either way.,
> >
> > For HSM ops, we can easily fix this limitation because the HART
> > start call has an opaque parameter which can be used to specify TP
> > and SP for the HART being brought up.
> >

Sounds good to me. I will try to send a patch.

> > For spinwait ops, I don't see much value in fixing sparse hartid
> > problems so let's document this problem and have appropriate
> > checks in spinwait ops for out-of-bound array checks.
>
> Seems reasonable.  That's the legacy method anyway, so hopefully vendors
> will have moved to the new stuff by the time we get sufficiently sparse
> hart IDs that this matters.

I hope so too. At least documenting this bug would be useful for
anybody trapping this bug while
using older spinwait methods. It will be an excuse for them to move to
shiny & better booting methods.

>
> We should fix the crashes, though.  Happy to take a patch, otherwise
> I'll throw something together.
>
> >
> > Regards,
> > Anup



--=20
Regards,
Atish
