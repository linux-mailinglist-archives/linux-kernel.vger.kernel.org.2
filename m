Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCDD402289
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhIGDmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 23:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhIGDmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 23:42:02 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE00C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 20:40:56 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id f6so7154425vsr.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 20:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wvo6JHOWHFIEExRMPZaMMKWS3Bh2tuuX+i1rIqG48Ks=;
        b=PUzcXIQYbaWGFyTv/GgArg+2AWFqUNfXZGZ1SEx20Y6aPPi8I6bIIspZmcJemIymo6
         61yHYvOciiArR80h9lmNxBWPAG358vsB8BUBmJLghf6PV2p895v4EKM4iYJF026AUclb
         enSc7tkzENFaeNg7o5v+4/DCYgzgptmiYnXdk3/md0WtPMF4VRl4QYnEj2qx5gA9Ur9p
         Sb8v9+HO796ghUVbw5i7S/KUsIeboSBy38UdNucfIUWA+NqSGsF24ImuwrzfbeQ2YJ6x
         GrL1TQb4lLTD2k6gGwATcPlA8iXGHFIrLBDyNp1T3f8vINtz6O5THutHF66kadkqo5ds
         zlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wvo6JHOWHFIEExRMPZaMMKWS3Bh2tuuX+i1rIqG48Ks=;
        b=nGrz+Rut9GBf3HS0L0yQ1gzbTYR+ArOO5AGtR/3WgQ5tzu8iZDujBGFfVylTBlniIe
         LC8uOJUTLTbZxs3zQW2O2AE82XzolzI37RF7OuWluxJibvo0KtcWzebtT6Y0NyU0nDPZ
         3Phb5qQvL0SQAmwI35fAcq3xbrXgNL1wFguQVbvfND8hgKCfme0X8jwwM9BDZ/L95c3U
         zmUA/+BlX/WFza9qxOYens9XM9TVW8sbVAhMnWUFtUG71PjhV64qxezavRwYxDfMvO8v
         EaeAc9i6699bqRSl9y/BzwaYQXIzHGAjBEHHIeDY6jeiajLwaCc9JLShjFBBRIS/+RAK
         2Shw==
X-Gm-Message-State: AOAM532DqkSwCewJnVQLleJQ8SQ3ZGDKuXX8qVdhi6/UcXZBJJxO6iwa
        nq0q/qPWUNEisXSUMORDa/ppmfpOe0QDASPdl34=
X-Google-Smtp-Source: ABdhPJxOJ8bvSy5eOOxQhslRLUiqjnix6uo2vdgVVGzhUCQisZ6aHpg9ihuck3GEwJGK+eMfWuartUSRL9RkF36G8Nw=
X-Received: by 2002:a67:cb83:: with SMTP id h3mr7715010vsl.8.1630986055696;
 Mon, 06 Sep 2021 20:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <YTXfmRIwWREJgEU9@zn.tnic> <CAPm50aLBt=YkFLi==-9U88YzwoJsmMTfEtj2v3+vx7fSRdDMLA@mail.gmail.com>
 <f89e1eee-aea8-7c59-3af5-8859a43e121c@intel.com> <CAPm50aLiB+O85mgcKcOZwO6J-DXjwK=p+7npBH-qVdkL-77Huw@mail.gmail.com>
 <77e8d483-4395-0017-300e-0886f75217bb@intel.com>
In-Reply-To: <77e8d483-4395-0017-300e-0886f75217bb@intel.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Tue, 7 Sep 2021 11:40:28 +0800
Message-ID: <CAPm50aL_eJm2s5GJD1OMFK3vt_iHLQrBueiz-NWS38H=Zz378w@mail.gmail.com>
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

On Tue, Sep 7, 2021 at 10:56 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> On 9/7/2021 10:35 AM, Hao Peng wrote:
> > On Tue, Sep 7, 2021 at 10:08 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote=
:
> >>
> >> On 9/7/2021 9:47 AM, Hao Peng wrote:
> >>> On Mon, Sep 6, 2021 at 5:30 PM Borislav Petkov <bp@alien8.de> wrote:
> >>>>
> >>>> On Mon, Sep 06, 2021 at 10:46:05AM +0800, Hao Peng wrote:
> >>>>> If hypervisor does not support MSR_IA32_TSX_CTRL, but guest support=
s
> >>>>> RTM and HLE features, it will affect TAA mitigation.
> >>>>>
> >>>>> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> >>>>> ---
> >>>>>    arch/x86/kernel/cpu/tsx.c | 7 +++++++
> >>>>>    1 file changed, 7 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> >>>>> index 9c7a5f049292..5e852c14fef2 100644
> >>>>> --- a/arch/x86/kernel/cpu/tsx.c
> >>>>> +++ b/arch/x86/kernel/cpu/tsx.c
> >>>>> @@ -122,6 +122,13 @@ void __init tsx_init(void)
> >>>>>
> >>>>>           if (!tsx_ctrl_is_supported()) {
> >>>>>                   tsx_ctrl_state =3D TSX_CTRL_NOT_SUPPORTED;
> >>>>> +
> >>>>> +               /* If hypervisor does not support MSR_IA32_TSX_CTRL=
 emulation,
> >>>>> +                * but guest supports RTM and HLE features, it will=
 affect TAA
> >>>>> +                * =EF=BC=88tsx_async_abort=EF=BC=89mitigation.
> >>>>> +                */
> >>>>> +               setup_clear_cpu_cap(X86_FEATURE_RTM);
> >>>>> +               setup_clear_cpu_cap(X86_FEATURE_HLE);
> >>
> >> anyway, IMHO, we shouldn't do anything here for TAA. It should be in
> >> taa_select_mitigation()
> >>
> >>>>>                   return;
> >>>>>           }
> >>>>
> >>>> How does that even happen - the hypervisor does not support the MSR =
but
> >>>> "guest supports" TSX features?!
> >>>>
> >>>> I guess the guest is detecting it wrong.
> >>>>
> >>>> What hypervisor, what guest, how do I reproduce?
> >>>>
> >>> hypervisor is kvm, guest is linux too.
> >>>> Please give full details.
> >>>>
> >>> The host I used is kernel-5.4, and guest is kernel-5.13.
> >>> MSR_IA32_TSX_CTRL is exposed
> >>> to guest and guest to support RTM and HLE features, no direct
> >>> dependence. at the qemu I
> >>> started guest with -cpu host-model.
> >>> I have viewed the code of kernel-5.4, and MSR_IA32_TSX_CTRL is not
> >>> exposed to guest.
> >>
> >> Does guest see TAA_NO bit?
> >>
> > Guest can't see taa_no, which requires updating qemu to solve. But I th=
ink
> > there is a compatibility process here.
>
> Anyway, there should be some existing code in kernel already to handle
> the case that CPUID reports TRM while MSR_IA32_CORE_CAPABILITIES doesn't
> report MSR_TSX_CTRL nor TAA_NO.
>
Can you point out which patches ? At present, guest is kernel-5.13
still has this problem.
Thanks.
> And the Patch itself makes no sense.
>
> >>> Thanks.
> >>>> --
> >>>> Regards/Gruss,
> >>>>       Boris.
> >>>>
> >>>> https://people.kernel.org/tglx/notes-about-netiquette
> >>
>
