Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC0402219
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhIGBs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 21:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhIGBsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 21:48:55 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD8FC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 18:47:49 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id j5so2773738vki.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 18:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VRQ2NT5P6lslZai3b6+lYryp+86xw04llh15jxL+wkw=;
        b=h1X8Vt06g7Z0C3a1MlWO1uCmfRCmGVUxfezoabIMI00lbuF1qZsyulsC59wamiN993
         5EwNJgieohQUCkQ2NaGmzgvwESKwZvY/q9lLoim3zMjfx+zRQUNh3405Yw5DoCfclfc9
         +080+bfiyIJoG8f75F+Zqt3UpAHt53jpZekosFP2u6+N282gnvfeBPMtfFt3u0QCIVsE
         92PXoqo6xD41Z4e9c/WjQoe4vwsV8VP1CvTa0iWKKhV7OIVKktNGZl2J+d+89e3b4AND
         HDcD8d21/dzC1Y/in9J43dPVeGNhTfy3LggYnZ2gembplNRS0a3K4bwkVxFKSkmIVmec
         kovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRQ2NT5P6lslZai3b6+lYryp+86xw04llh15jxL+wkw=;
        b=qRkVDhSdiPUBBCraLjM0SAItTVquNoyH+6nh3XoBTGoRxllbG7e4Qv2ikELkHKEpDo
         Co/etzUdqEDsGlSAQT2Luqte/wHqaDHes+R0pWZt3PA9XcVHwrXSvB0ZH7XcLC2en0lU
         Qa+CvegeLUDuPZ4rpZodhFr8bHL9AZQ1g8vAxFJHnwZcl1+mv6f0ioEfnbwNjFp6u7dY
         +nw/hDqUpMQt9RiUV+hje7uJXC9w4IMPjl1Iuh53a+raEviz6Vz23NZKw6JEHD7TBMau
         AcelUQBMU8wz9TtnZfAZCpDqSWFDQ4YmUtNUWXIDHrNz4mvG4JgJ70OG2xhEUW8LAaVr
         FIcA==
X-Gm-Message-State: AOAM530RSxTxfN9ub2bHE/yyXwyztxI+cwWNSKJNllRYknTYnDy8Se01
        pPqCu9y+pgTnAHFi+qftrLamwdk3HeXWr9MiGhU=
X-Google-Smtp-Source: ABdhPJw2TTdKkFNeecc2gY/rtMF+RIY9EyENK+YEAp4jvqYkpTPibcnG1m6t6Miz3YNOZH1MOH+e3jm37tPtswg/vgQ=
X-Received: by 2002:a1f:add0:: with SMTP id w199mr6851778vke.0.1630979269098;
 Mon, 06 Sep 2021 18:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <YTXfmRIwWREJgEU9@zn.tnic>
In-Reply-To: <YTXfmRIwWREJgEU9@zn.tnic>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Tue, 7 Sep 2021 09:47:21 +0800
Message-ID: <CAPm50aLBt=YkFLi==-9U88YzwoJsmMTfEtj2v3+vx7fSRdDMLA@mail.gmail.com>
Subject: Re: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not supported
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 5:30 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Sep 06, 2021 at 10:46:05AM +0800, Hao Peng wrote:
> > If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
> > RTM and HLE features, it will affect TAA mitigation.
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  arch/x86/kernel/cpu/tsx.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> > index 9c7a5f049292..5e852c14fef2 100644
> > --- a/arch/x86/kernel/cpu/tsx.c
> > +++ b/arch/x86/kernel/cpu/tsx.c
> > @@ -122,6 +122,13 @@ void __init tsx_init(void)
> >
> >         if (!tsx_ctrl_is_supported()) {
> >                 tsx_ctrl_state =3D TSX_CTRL_NOT_SUPPORTED;
> > +
> > +               /* If hypervisor does not support MSR_IA32_TSX_CTRL emu=
lation,
> > +                * but guest supports RTM and HLE features, it will aff=
ect TAA
> > +                * =EF=BC=88tsx_async_abort=EF=BC=89mitigation.
> > +                */
> > +               setup_clear_cpu_cap(X86_FEATURE_RTM);
> > +               setup_clear_cpu_cap(X86_FEATURE_HLE);
> >                 return;
> >         }
>
> How does that even happen - the hypervisor does not support the MSR but
> "guest supports" TSX features?!
>
> I guess the guest is detecting it wrong.
>
> What hypervisor, what guest, how do I reproduce?
>
hypervisor is kvm, guest is linux too.
> Please give full details.
>
The host I used is kernel-5.4, and guest is kernel-5.13.
MSR_IA32_TSX_CTRL is exposed
to guest and guest to support RTM and HLE features, no direct
dependence. at the qemu I
started guest with -cpu host-model.
I have viewed the code of kernel-5.4, and MSR_IA32_TSX_CTRL is not
exposed to guest.
Thanks.
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
