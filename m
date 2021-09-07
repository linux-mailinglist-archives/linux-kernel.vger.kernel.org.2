Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2A4023B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhIGG6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbhIGG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:58:31 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C1BC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 23:57:25 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id a21so7405298vsp.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J7VHRI9T1c9fqoqvaQKoARKEEN+VKzY+Zq7qx4zBGy4=;
        b=p+CkCDssvSNybe7ezh6rPvgeeXmdojCcs5KUTf03vgoCrs37STpEFgf3qB9DBVYc43
         3PmNQq3kAy2FEniz8UPbnK4MwBIF+WsnOkYfqHvNSAPSAjER570Bgy3KiGK2F2gM1QJb
         OlsrfHIZA3DAg1bqrHIdN4Q1M1PaZj4pdNGyim19FGIVcYDNkxptt6Q/iLFvVnguxWHd
         uOL/364LgYUXdKHwVaeYCmydFmyjpJUbgeFzSPcT8ub/GsEYUjUAUC+sxpqy6YQHBQRP
         WhLPG+gy4b+mPG8iFe1LxPZg2T9t4fGzSSFWiyHJawJ8AvVr+nJF3wlUfEAnY3U9Na2b
         VAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J7VHRI9T1c9fqoqvaQKoARKEEN+VKzY+Zq7qx4zBGy4=;
        b=hzbq5bQ9HJM3tKMVBvieLwulu9/IXZ7h3WbiyYP7VKmIbtWd5ylIf/j0a8+3MtE9zR
         tW8RisPcUex/RJkGYVnsguBLoavnH0sjLOIQrd1fuwBPUcTTPBaETFHwTvdnpi6FGB67
         qk9kz3+zY82kIfOAYn4QR+GDuaZcoe1HcLSEYltCy/8ec6ex1iR1Z5fAXpcUmuTKZxXh
         1w30ZGQN4uTXBWI+2shfreIep0arZvs8kIMzDRl/UrNGn6cYA6hvPHFUjuNHNN80bWjV
         trzA9AUEzNFOS5u4YWxkthZhaDiIMk58gUem1dEDf+pWep3vjFGJduTEGAEys6/jwJ7z
         oG0w==
X-Gm-Message-State: AOAM5324kka12ZPatItE8aQRWZkMwlbzr2+PaXnJWbMyQVRYhaPa3+nt
        2DYELd41gC6jc2FoLzTpWTXlY6Qxc4YJ80w6JIE=
X-Google-Smtp-Source: ABdhPJwvSUGWDIfS1BiAk436621duhK3yyCafTtkbvIk2SQs4ZQsVSgV4HdLtV99tFzqcPYAEFHd+jDRTOnxBs5BUKE=
X-Received: by 2002:a67:cb83:: with SMTP id h3mr7945302vsl.8.1630997844691;
 Mon, 06 Sep 2021 23:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <YTXfmRIwWREJgEU9@zn.tnic> <CAPm50aLBt=YkFLi==-9U88YzwoJsmMTfEtj2v3+vx7fSRdDMLA@mail.gmail.com>
 <f89e1eee-aea8-7c59-3af5-8859a43e121c@intel.com> <CAPm50aLiB+O85mgcKcOZwO6J-DXjwK=p+7npBH-qVdkL-77Huw@mail.gmail.com>
 <77e8d483-4395-0017-300e-0886f75217bb@intel.com> <CAPm50aL_eJm2s5GJD1OMFK3vt_iHLQrBueiz-NWS38H=Zz378w@mail.gmail.com>
 <cae10a15-1c21-4cf4-dff5-2123613f1b41@intel.com> <CAPm50a+crBuP9wH2zCqcD22+wmsb4pj3A9rT_G+64=EV9KLg5w@mail.gmail.com>
 <20210907053816.qldtcxkxxv7hkzgv@gupta-dev2.localdomain>
In-Reply-To: <20210907053816.qldtcxkxxv7hkzgv@gupta-dev2.localdomain>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Tue, 7 Sep 2021 14:56:57 +0800
Message-ID: <CAPm50aJDC0isfu5gujPjmDn_pvAmQw0mQu_Pv5S67r2TvSgyvg@mail.gmail.com>
Subject: Re: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not supported
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, Borislav Petkov <bp@alien8.de>,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 1:36 PM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On 07.09.2021 12:39, Hao Peng wrote:
> >On Tue, Sep 7, 2021 at 12:26 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> >>
> >> On 9/7/2021 11:40 AM, Hao Peng wrote:
> >> > On Tue, Sep 7, 2021 at 10:56 AM Xiaoyao Li <xiaoyao.li@intel.com> wr=
ote:
> >> >>
> >> >> On 9/7/2021 10:35 AM, Hao Peng wrote:
> >> >>> On Tue, Sep 7, 2021 at 10:08 AM Xiaoyao Li <xiaoyao.li@intel.com> =
wrote:
> >> >>>>
> >> >>>> On 9/7/2021 9:47 AM, Hao Peng wrote:
> >> >>>>> On Mon, Sep 6, 2021 at 5:30 PM Borislav Petkov <bp@alien8.de> wr=
ote:
> >> >>>>>>
> >> >>>>>> On Mon, Sep 06, 2021 at 10:46:05AM +0800, Hao Peng wrote:
> >> >>>>>>> If hypervisor does not support MSR_IA32_TSX_CTRL, but guest su=
pports
> >> >>>>>>> RTM and HLE features, it will affect TAA mitigation.
> >> >>>>>>>
> >> >>>>>>> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> >> >>>>>>> ---
> >> >>>>>>>     arch/x86/kernel/cpu/tsx.c | 7 +++++++
> >> >>>>>>>     1 file changed, 7 insertions(+)
> >> >>>>>>>
> >> >>>>>>> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/t=
sx.c
> >> >>>>>>> index 9c7a5f049292..5e852c14fef2 100644
> >> >>>>>>> --- a/arch/x86/kernel/cpu/tsx.c
> >> >>>>>>> +++ b/arch/x86/kernel/cpu/tsx.c
> >> >>>>>>> @@ -122,6 +122,13 @@ void __init tsx_init(void)
> >> >>>>>>>
> >> >>>>>>>            if (!tsx_ctrl_is_supported()) {
> >> >>>>>>>                    tsx_ctrl_state =3D TSX_CTRL_NOT_SUPPORTED;
> >> >>>>>>> +
> >> >>>>>>> +               /* If hypervisor does not support MSR_IA32_TSX=
_CTRL emulation,
> >> >>>>>>> +                * but guest supports RTM and HLE features, it=
 will affect TAA
> >> >>>>>>> +                * =EF=BC=88tsx_async_abort=EF=BC=89mitigation=
.
> >> >>>>>>> +                */
> >> >>>>>>> +               setup_clear_cpu_cap(X86_FEATURE_RTM);
> >> >>>>>>> +               setup_clear_cpu_cap(X86_FEATURE_HLE);
> >> >>>>
> >> >>>> anyway, IMHO, we shouldn't do anything here for TAA. It should be=
 in
> >> >>>> taa_select_mitigation()
> >> >>>>
> >> >>>>>>>                    return;
> >> >>>>>>>            }
> >> >>>>>>
> >> >>>>>> How does that even happen - the hypervisor does not support the=
 MSR but
> >> >>>>>> "guest supports" TSX features?!
> >> >>>>>>
> >> >>>>>> I guess the guest is detecting it wrong.
> >> >>>>>>
> >> >>>>>> What hypervisor, what guest, how do I reproduce?
> >> >>>>>>
> >> >>>>> hypervisor is kvm, guest is linux too.
> >> >>>>>> Please give full details.
> >> >>>>>>
> >> >>>>> The host I used is kernel-5.4, and guest is kernel-5.13.
> >> >>>>> MSR_IA32_TSX_CTRL is exposed
> >> >>>>> to guest and guest to support RTM and HLE features, no direct
> >> >>>>> dependence. at the qemu I
> >> >>>>> started guest with -cpu host-model.
> >> >>>>> I have viewed the code of kernel-5.4, and MSR_IA32_TSX_CTRL is n=
ot
> >> >>>>> exposed to guest.
> >> >>>>
> >> >>>> Does guest see TAA_NO bit?
> >> >>>>
> >> >>> Guest can't see taa_no, which requires updating qemu to solve. But=
 I think
> >> >>> there is a compatibility process here.
> >> >>
> >> >> Anyway, there should be some existing code in kernel already to han=
dle
> >> >> the case that CPUID reports TRM while MSR_IA32_CORE_CAPABILITIES do=
esn't
> >> >> report MSR_TSX_CTRL nor TAA_NO.
> >> >>
> >> > Can you point out which patches ? At present, guest is kernel-5.13
> >> > still has this problem.
> >>
> >> What's the output of 'cat
> >> /sys/devices/system/cpu/vulnerabilities/tsx_async_abort' on your guest=
?
> >>
> >Vulnerable: Clear CPU buffers attempted, no microcode; SMT Host state un=
known.
>
> This suggests that the microcode is old. Can you please share the output
> of below cmds on host and guest:
>
>         $ grep . /sys/devices/system/cpu/vulnerabilities/*
host : not affected
guest: Vulnerable: Clear CPU buffers attempted, no microcode; SMT Host
state unknown.
>         $ lscpu
>         $ grep microcode /proc/cpuinfo | uniq
host: microcode       : 0xd000250
guest: microcode       : 0x1
>         $ cat /proc/cmdline
There are no command line parameters for tsx both host and guest.
>
> Thanks,
> Pawan
