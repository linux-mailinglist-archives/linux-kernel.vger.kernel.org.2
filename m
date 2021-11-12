Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4601B44EFBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhKLWwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhKLWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:52:14 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BCDC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:49:23 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d10so27568037ybe.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7HDJ664v/RwIPpmSVXGcLuI+sDj2LgWjotX8mqnP0ns=;
        b=i9YvXMO4zYCstxMt235bAlY8b3amJwFL0CbbFWUIkkEOfWOmeZvNPI70V8PiuNooil
         rlw5ksPZfLlmSO33eApKbOnyJHDiPlfTwfWnH1iche5zVzZdvxEKt1GBUWLhO4nRGC/l
         mPy8OKpaWzUzCmatHwQUpb+1Anrjgi5msG36Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7HDJ664v/RwIPpmSVXGcLuI+sDj2LgWjotX8mqnP0ns=;
        b=18N9JRa3dQ4i+aeYc2nXwyhKo3XiTdvIINfCkh0CgBYN7sOrnPRfxqpY3lO7JiLTBs
         s1mdcPwfnDqsHEiZJoXPNNs4TwqsZa7OCOfn/7ydfCQo8v38XlLQYpsdHoSvZd7k6GE9
         Z+vQXoUXhSTPN75aOFCLYLhVLW35g+rzhaAKEA6Q6RC0XLrfxVO2Vrt0G8NosSKBhOed
         W314spZ0hhfJ6gl2Nzn65SsIrKAF8caQ0XDbwqsbRBQmWI/2/I+mumaWybR56aTF5VeW
         YOLv9yC1h/67HGZawXJOZpGTFTz2OvroqQZaeM+MradLkveZpKyJay2FlHGsIA8hlTEG
         jvow==
X-Gm-Message-State: AOAM5333H0wDOvUW8ZXbjruyOsVHplBF5hn8c/KjGbuh3JQ4fioSTmFM
        liubGhICJv7FXOM4fmNgbm8Jks20iBHfKbNTFWTv
X-Google-Smtp-Source: ABdhPJycjOYJD/u505GkmiRnzUBcmb7UhNA1BxvRkw9g8aYyLPvaZ2PZsT6uXKdgdXetXkzBIaA2yi355CipYVmFv7E=
X-Received: by 2002:a25:73d0:: with SMTP id o199mr19792875ybc.87.1636757362169;
 Fri, 12 Nov 2021 14:49:22 -0800 (PST)
MIME-Version: 1.0
References: <mhng-6c25dda6-4c85-447c-ad9c-7641f2858b10@palmerdabbelt-glaptop>
 <mhng-40d64bc7-5a95-4a16-af45-1d7fd7c6167e@palmerdabbelt-glaptop>
 <CAOnJCUJpLSWJ1VsJuUwfrG8vn0+hCkg2RgdOhNLTEq8C7Mo88w@mail.gmail.com> <b3cc6176-60b0-119c-ba1d-1fdc015bd081@canonical.com>
In-Reply-To: <b3cc6176-60b0-119c-ba1d-1fdc015bd081@canonical.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 12 Nov 2021 17:49:11 -0500
Message-ID: <CAOnJCUKO6YzYsq4XqPHg8SwkbZ_GrE8iyUSmJGKOHkrdE0Bc+A@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] RISC-V: Use SBI SRST extension when available
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Philipp Tomsich <ptomsich@ventanamicro.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Kumar Sankaran <ksankaran@ventanamicro.com>,
        Mark Himelstein <markhimelstein@riscv.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 10:19 AM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/29/21 08:10, Atish Patra wrote:
> > On Wed, Jul 28, 2021 at 9:30 PM Palmer Dabbelt <palmer@dabbelt.com> wro=
te:
> >>
> >> On Sun, 11 Jul 2021 11:59:33 PDT (-0700), Palmer Dabbelt wrote:
> >>> On Fri, 09 Jul 2021 22:01:02 PDT (-0700), Anup Patel wrote:
> >>>>
> >>>>
> >>>> =EF=BB=BFOn 08/07/21, 9:22 AM, "Anup Patel" <anup@brainfault.org> wr=
ote:
> >>>>
> >>>>      On Wed, Jul 7, 2021 at 1:57 AM Palmer Dabbelt <palmerdabbelt@go=
ogle.com> wrote:
> >>>>      >
> >>>>      > On Mon, 21 Jun 2021 21:46:46 PDT (-0700), anup@brainfault.org=
 wrote:
> >>>>      > > Hi Palmer,
> >>>>      > >
> >>>>      > > On Wed, Jun 9, 2021 at 5:43 PM Anup Patel <anup.patel@wdc.c=
om> wrote:
> >>>>      > >>
> >>>>      > >> The SBI SRST extension provides a standard way to poweroff=
 and
> >>>>      > >> reboot the system irrespective to whether Linux RISC-V S-m=
ode
> >>>>      > >> is running natively (HS-mode) or inside Guest/VM (VS-mode)=
.
> >>>>      > >>
> >>>>      > >> The SBI SRST extension is available in the SBI v0.3 specif=
ication.
> >>>>      > >> (Refer, https://github.com/riscv/riscv-sbi-doc/releases/ta=
g/v0.3.0-rc1)
> >>>>      > >
> >>>>      > > Can you please consider this patch for Linux-5.14-rc1 ?
> >>>>      > >
> >>>>      > > The SBI v0.3 spec is already frozen and this patch has been
> >>>>      > > floating on LKML for quite a few months now.
> >>>>      >
> >>>>      > I didn't realize that SBI-0.3 had been frozed.  That link is =
to a RC,
> >>>>      > the cooresponding v0.3.0 tag isn't in that repo.  Can you giv=
e me a
> >>>>      > pointer to the frozen spec?
> >>>>
> >>>>      Here's the link to SBI v0.3.0 tag:
> >>>>      https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0
> >>>>
> >>>>      We treat RC tags as frozen in SBI spec because no functional
> >>>>      changes are done in SBI spec after it is tagged as RC. We only
> >>>>      do typo fixes and clarifications on SBI spec RC release.
> >>>
> >>> Treating the 0.3.0-rc1 as frozen as soon as it's released is a
> >>> terrifying policy: some of the fixes I sent in after I saw rc1 releas=
ed
> >>> change the actual meaning of the text, even if they were meant to cha=
nge
> >>> them to what I thought the intended meaning was supposed to be.  That
> >>> means the actual text of 0.3.0-rc1 and 0.3.0 conflict with each other=
.
> >>> Given that frozen comes with a guarntee of backwards compatibility, d=
oes
> >>> that mean that the behavior allowed by 0.3.0-rc1 is compliant with th=
e
> >>> SBI, even if it was likely just allowed by a wording mistake?
> >>>
> >>> If you're going to freeze things at rc1 then you really need to be qu=
ite
> >>> explicit about that, as generally the point of RCs is to elicit
> >>> review/testing.  Looks like I was the only person to have provided an=
y
> >>> review, so I guess I was the only one who assumed "We don't expect an=
y
> >>> significant functional changes. We will wait for any further feedback
> >>> and release the official v0.3 in a month or so." actually meant "this=
 is
> >>> frozen".
> >>>
> >>>> Can you take this patch for Linux-5.14 ??
> >>>
> >>> No, sorry, it's way too late for that.  Please be specific about when
> >>> you freeze specifications in the future, so we can all stay on the sa=
me
> >>> page.
> >>
> >> I went and talked to Krste, and he says that there's a whole process f=
or
> >> freezing extensions that this hasn't gone through.  They don't have
> >> anything written down that I can point to, but can you guys please jus=
t
> >> get on the same page about this?  It seems like every time I talk to
> >
> > Absolutely. The freezing extensions process is documented right now[1]
> > but that is only meant
> > for ISA/hardware/platform specifications. There is no process defined
> > for a SBI specification which is purely
> > a software specification because SBI specification release
> > processes(v0.1 and v0.2) predate these documented processes.
> > The SBI specification is owned by the Platform HSC which falls under
> > the purview of software HC.
> > You can see a detailed chart of the RVI organization at [2]. All the
> > aspects of SBI specification are discussed
> > in platform meetings[3] and frozen only after public review[4] and
> > approval from the platform working group
> > and the software HC. The official SBI specification(v0.3) will also be
> > available along with all other RISC-V specifications
> > once they figure out how to structure non-ISA specifications.
> >
> > I have cc'd Kumar (chair of the Platform HSC) and Philip (chair of the
> > software HC) in case they want to add anything.
> > I was not aware of the fact that Krste/Andrew are not aware of the
> > progress of the SBI specification.
> > I will raise this topic during the next meeting and make sure they are
> > in the loop as well.
> >
> >> someone from the RISC-V foundation I get a conflicting description of
> >> what's going on, and I'm entirely out of patience when it comes to
> >> getting blamed for all the chaos over there.
> >>
> > I agree the RVI process has not been very clear in the past. However,
> > that has changed a lot in recent times thanks to Mark and
> > other working group chairs. I don't think anybody is blaming you for
> > the delay in ratification of the RVI specifications.
> > There is a clear path for all the specifications to be ratified e.g.
> > the AIA and H extensions are planned to be frozen by the end of this
> > year.
> > Let me know if you want to see the timeline of each specification and
> > I can point you to the correct sheet.
> >
> > [1] https://docs.google.com/presentation/d/1nQ5uFb39KA6gvUi5SReWfIQSiRN=
7hp6z7ZPfctE4mKk/edit#slide=3Did.ga0a994c3c8_0_6
> > [2] https://docs.google.com/presentation/d/1eEVuu6lRZd9iiDnZQSZME7Q7svt=
TG3pGIKHPmZ79B8E/edit#slide=3Did.ga275a504df_0_9
> > [3] https://github.com/riscv/riscv-platform-specs/wiki
> > [4] https://lists.riscv.org/g/tech-unixplatformspec/message/1042
>
> https://github.com/riscv-non-isa/riscv-sbi-doc/releases/tag/v0.3.1-rc1
> has:
>
> "This tag the release candidate of version 0.3.1 of the RISC-V SBI
> specification. It doesn't have any significant changes other than typos.
> A new release is created to adapt the ratification process for non-ISA
> specifications defined by RVI recently."
>
> Has this patch to wait until release 0.3.1 of the SBI specification is
> ratified?

Not ratified, Frozen (officially as per newly defined RVI process)

> What is the timeline?
>

Probably, a few more weeks. We have already presented it to the chairs
meeting and got it approved.
We are waiting for the TSC votes and some conclusion about the version
of frozen->ratified spec.
RVI wants all the specifications to start with 1.0 while SBI
specification has legacy version numbers.

The specification will be frozen and sent to the public review once
those items are resolved.

> Could you, please, provide a link the the non-ISA ratification process
> description.

Here is the template for every non-ISA specification has to follow
https://docs.google.com/document/d/1-DZQ-5IzQlG1PLX8acic9SaLaU8SQIHRYewBrE1=
Zoxo/edit?usp=3Dsharing

Here is the folder with all other specifications in pipeline
https://drive.google.com/drive/u/1/folders/11NFLODgCxTTORNrPhNT15cHV-fZLFn4=
U


>
> Best regards
>
> Heinrich




--
Regards,
Atish
