Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF24022E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 06:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhIGEkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 00:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIGEkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 00:40:37 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7788EC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 21:39:31 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id l24so4869861uai.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 21:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=muAtmFk8EW8AT3D1cyjk+uuRCMlDhq4lTi32y59wnD0=;
        b=iFAs2jn9JfPMhFjxzdFLUoZepMDTpSEGgV69ccxCR22rtqQxvz00SCmCtQ6rgD1uhA
         NhpdWgrHmgOMOI99tRwMfv4uOyFQxeRyI/ln8CEmWG5kekZOF4lBrgbkQ7d/1xgoD7kX
         94z5+z55ar1NNCKO3N4mmhZaejQF2yKFNJapesx0Pmjmjp4/cXA6fAlAu2//2FYc0hEM
         dAVoBN2JN+0K/9L6oFZ/5Wa/ImHX1g94vpfVxV8SDcdQmK3jzF8HFoXBrE/maozFULHo
         aQcb1YsLmhimzNTIfjOMWqUcmFLVtTioBSGyESoLigYdWkekCuL7AbMQnt1RamZqZZXU
         IFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=muAtmFk8EW8AT3D1cyjk+uuRCMlDhq4lTi32y59wnD0=;
        b=VbeZSdSK8EBY+ETRDuFqBFnBj4b49za6WRQJVnPqQIEx2t7fII1CJctNjdbA/7c0L0
         Y/vMYcPYQgF1R+KEw1iiYOEBxmI5W/VN/2RX8XvmdOrILDN9YhK4AvcTj7R64p2i+dTF
         uyJO3w4U1OTwn/k2nVrsGtaBhlam7szbtd/7C/YpPfuV0lGn0BYRM6mhNXI/yJBeQ2Ej
         caRQCNHVab79YTq//MgLr69s1cG+bX8KOX0N9IKIr6TocMlwR8EBWInz4yK9CitwSlRZ
         TFR7CQmAW9Jq1xefD5bHGubQ1qfbIK9q2maM6qXGfvmaQ0WKnLQTQXZX+KPZpV3GAqQp
         7zRA==
X-Gm-Message-State: AOAM533YEaj+NVqXi6dsPpu84UMl7IgdXC/y6tMJIzXxr12BWFvGA8Zr
        N+AORv+KqQNNaFw+14yrnSPdF2PUJ/7lAg3neOY=
X-Google-Smtp-Source: ABdhPJy9Yuu8VOkzcoSdw3osvnCl8rrL+qu/9YWJ53meP7MRr6YGJPsqOwWiVPoc2zXbw8W5FdrcsIrW+9JNO69QPa4=
X-Received: by 2002:ab0:28d2:: with SMTP id g18mr7379906uaq.40.1630989570562;
 Mon, 06 Sep 2021 21:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <YTXfmRIwWREJgEU9@zn.tnic> <CAPm50aLBt=YkFLi==-9U88YzwoJsmMTfEtj2v3+vx7fSRdDMLA@mail.gmail.com>
 <f89e1eee-aea8-7c59-3af5-8859a43e121c@intel.com> <CAPm50aLiB+O85mgcKcOZwO6J-DXjwK=p+7npBH-qVdkL-77Huw@mail.gmail.com>
 <77e8d483-4395-0017-300e-0886f75217bb@intel.com> <CAPm50aL_eJm2s5GJD1OMFK3vt_iHLQrBueiz-NWS38H=Zz378w@mail.gmail.com>
 <cae10a15-1c21-4cf4-dff5-2123613f1b41@intel.com>
In-Reply-To: <cae10a15-1c21-4cf4-dff5-2123613f1b41@intel.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Tue, 7 Sep 2021 12:39:03 +0800
Message-ID: <CAPm50a+crBuP9wH2zCqcD22+wmsb4pj3A9rT_G+64=EV9KLg5w@mail.gmail.com>
Subject: Re: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not supported
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 12:26 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> On 9/7/2021 11:40 AM, Hao Peng wrote:
> > On Tue, Sep 7, 2021 at 10:56 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote=
:
> >>
> >> On 9/7/2021 10:35 AM, Hao Peng wrote:
> >>> On Tue, Sep 7, 2021 at 10:08 AM Xiaoyao Li <xiaoyao.li@intel.com> wro=
te:
> >>>>
> >>>> On 9/7/2021 9:47 AM, Hao Peng wrote:
> >>>>> On Mon, Sep 6, 2021 at 5:30 PM Borislav Petkov <bp@alien8.de> wrote=
:
> >>>>>>
> >>>>>> On Mon, Sep 06, 2021 at 10:46:05AM +0800, Hao Peng wrote:
> >>>>>>> If hypervisor does not support MSR_IA32_TSX_CTRL, but guest suppo=
rts
> >>>>>>> RTM and HLE features, it will affect TAA mitigation.
> >>>>>>>
> >>>>>>> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> >>>>>>> ---
> >>>>>>>     arch/x86/kernel/cpu/tsx.c | 7 +++++++
> >>>>>>>     1 file changed, 7 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.=
c
> >>>>>>> index 9c7a5f049292..5e852c14fef2 100644
> >>>>>>> --- a/arch/x86/kernel/cpu/tsx.c
> >>>>>>> +++ b/arch/x86/kernel/cpu/tsx.c
> >>>>>>> @@ -122,6 +122,13 @@ void __init tsx_init(void)
> >>>>>>>
> >>>>>>>            if (!tsx_ctrl_is_supported()) {
> >>>>>>>                    tsx_ctrl_state =3D TSX_CTRL_NOT_SUPPORTED;
> >>>>>>> +
> >>>>>>> +               /* If hypervisor does not support MSR_IA32_TSX_CT=
RL emulation,
> >>>>>>> +                * but guest supports RTM and HLE features, it wi=
ll affect TAA
> >>>>>>> +                * =EF=BC=88tsx_async_abort=EF=BC=89mitigation.
> >>>>>>> +                */
> >>>>>>> +               setup_clear_cpu_cap(X86_FEATURE_RTM);
> >>>>>>> +               setup_clear_cpu_cap(X86_FEATURE_HLE);
> >>>>
> >>>> anyway, IMHO, we shouldn't do anything here for TAA. It should be in
> >>>> taa_select_mitigation()
> >>>>
> >>>>>>>                    return;
> >>>>>>>            }
> >>>>>>
> >>>>>> How does that even happen - the hypervisor does not support the MS=
R but
> >>>>>> "guest supports" TSX features?!
> >>>>>>
> >>>>>> I guess the guest is detecting it wrong.
> >>>>>>
> >>>>>> What hypervisor, what guest, how do I reproduce?
> >>>>>>
> >>>>> hypervisor is kvm, guest is linux too.
> >>>>>> Please give full details.
> >>>>>>
> >>>>> The host I used is kernel-5.4, and guest is kernel-5.13.
> >>>>> MSR_IA32_TSX_CTRL is exposed
> >>>>> to guest and guest to support RTM and HLE features, no direct
> >>>>> dependence. at the qemu I
> >>>>> started guest with -cpu host-model.
> >>>>> I have viewed the code of kernel-5.4, and MSR_IA32_TSX_CTRL is not
> >>>>> exposed to guest.
> >>>>
> >>>> Does guest see TAA_NO bit?
> >>>>
> >>> Guest can't see taa_no, which requires updating qemu to solve. But I =
think
> >>> there is a compatibility process here.
> >>
> >> Anyway, there should be some existing code in kernel already to handle
> >> the case that CPUID reports TRM while MSR_IA32_CORE_CAPABILITIES doesn=
't
> >> report MSR_TSX_CTRL nor TAA_NO.
> >>
> > Can you point out which patches ? At present, guest is kernel-5.13
> > still has this problem.
>
> What's the output of 'cat
> /sys/devices/system/cpu/vulnerabilities/tsx_async_abort' on your guest?
>
Vulnerable: Clear CPU buffers attempted, no microcode; SMT Host state unkno=
wn.
> > Thanks.
> >> And the Patch itself makes no sense.
> >>
> >>>>> Thanks.
> >>>>>> --
> >>>>>> Regards/Gruss,
> >>>>>>        Boris.
> >>>>>>
> >>>>>> https://people.kernel.org/tglx/notes-about-netiquette
> >>>>
> >>
>
