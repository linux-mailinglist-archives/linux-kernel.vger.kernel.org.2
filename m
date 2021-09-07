Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB7740224F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhIGChG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 22:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhIGChF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 22:37:05 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBB0C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 19:35:59 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id l24so4749489uai.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 19:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bcQBVvZ60mrnxPLYeY7PhO5GlFGEHyH0BOWX/UIfFug=;
        b=acdPWXKUEnxjE81lb8oAb8zJjypbygoxbca9ok7yBFqGHsCYtEqcC+vYw+UdszyNWS
         hE3yl+ty8GqLZujWrm4nGPtqIR7LzcaZjr3oT0nPnU8daAHe2Bq1JlsfuimX15l3NsnA
         l7rc6ST9Si6m+NaI5iYqXdz6lFhZTzy1cBqxUI4qBuhcjRq1EwlGsPAH3HEG3uuVbBaF
         rXPPq3J0gAE3fvxMLYgbdRgsWnIa7jMtXNrn1yNufTo3dLTWJoUaylDxKfjkXNRH2wuc
         STj7hL8Ad1qZYRtkv/TjybAcXmM4LSnpx+EFs2l0Ki6FIHy+s5ROkzlLAYYaPTrb4mTa
         1AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bcQBVvZ60mrnxPLYeY7PhO5GlFGEHyH0BOWX/UIfFug=;
        b=TE7q7xcn9K4QqeOQKcd7ryyK7U2QckM69DlpsMNqQgPioE7auN1NPjhPpaHPD7RZr0
         utiQJ8cRtL7AHDNBlOs2pYwJLFgqZJKi4uTBs2z58BLMece1qPXt4OmUOGy591Ljezy+
         3bOoSuYqXSkwWq4FCQprAr2fy+yj/+ug0XzyFo8njgTHyZuihz995fBA3Fw06QsMWFF8
         6MTOJIrKBMz66tC+5TIWUFz9b7Ym2HQuFX7GY08YMmAVD/G28Rd+pCGQMLfYYEdT9Idt
         KFMtgPKDN45MOTZBPSH/s/9HXzboi5i+ODVOL7ueZAkxCNWF/KIhWNtlI9zLbyGYeqL5
         wBUA==
X-Gm-Message-State: AOAM533+HhMi08hZ2DVwm9n9DkJvSZYDfr2KorGYSvohczeP804DKhSI
        IiutOUOco2N8kCcnq95sdeiyJJT80nfmvXoJWYZVtzNCX0rFnA==
X-Google-Smtp-Source: ABdhPJz1ALwLd8twnOHkpg2mhRyxVO8v+0kwyNWdMoUU5uddHSDKZBZWkfqabq9Gn4VQCGy9ESd4F95Rzdhjp1T49EQ=
X-Received: by 2002:a9f:2429:: with SMTP id 38mr7556967uaq.67.1630982159026;
 Mon, 06 Sep 2021 19:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <YTXfmRIwWREJgEU9@zn.tnic> <CAPm50aLBt=YkFLi==-9U88YzwoJsmMTfEtj2v3+vx7fSRdDMLA@mail.gmail.com>
 <f89e1eee-aea8-7c59-3af5-8859a43e121c@intel.com>
In-Reply-To: <f89e1eee-aea8-7c59-3af5-8859a43e121c@intel.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Tue, 7 Sep 2021 10:35:31 +0800
Message-ID: <CAPm50aLiB+O85mgcKcOZwO6J-DXjwK=p+7npBH-qVdkL-77Huw@mail.gmail.com>
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

On Tue, Sep 7, 2021 at 10:08 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> On 9/7/2021 9:47 AM, Hao Peng wrote:
> > On Mon, Sep 6, 2021 at 5:30 PM Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Mon, Sep 06, 2021 at 10:46:05AM +0800, Hao Peng wrote:
> >>> If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
> >>> RTM and HLE features, it will affect TAA mitigation.
> >>>
> >>> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> >>> ---
> >>>   arch/x86/kernel/cpu/tsx.c | 7 +++++++
> >>>   1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> >>> index 9c7a5f049292..5e852c14fef2 100644
> >>> --- a/arch/x86/kernel/cpu/tsx.c
> >>> +++ b/arch/x86/kernel/cpu/tsx.c
> >>> @@ -122,6 +122,13 @@ void __init tsx_init(void)
> >>>
> >>>          if (!tsx_ctrl_is_supported()) {
> >>>                  tsx_ctrl_state =3D TSX_CTRL_NOT_SUPPORTED;
> >>> +
> >>> +               /* If hypervisor does not support MSR_IA32_TSX_CTRL e=
mulation,
> >>> +                * but guest supports RTM and HLE features, it will a=
ffect TAA
> >>> +                * =EF=BC=88tsx_async_abort=EF=BC=89mitigation.
> >>> +                */
> >>> +               setup_clear_cpu_cap(X86_FEATURE_RTM);
> >>> +               setup_clear_cpu_cap(X86_FEATURE_HLE);
>
> anyway, IMHO, we shouldn't do anything here for TAA. It should be in
> taa_select_mitigation()
>
> >>>                  return;
> >>>          }
> >>
> >> How does that even happen - the hypervisor does not support the MSR bu=
t
> >> "guest supports" TSX features?!
> >>
> >> I guess the guest is detecting it wrong.
> >>
> >> What hypervisor, what guest, how do I reproduce?
> >>
> > hypervisor is kvm, guest is linux too.
> >> Please give full details.
> >>
> > The host I used is kernel-5.4, and guest is kernel-5.13.
> > MSR_IA32_TSX_CTRL is exposed
> > to guest and guest to support RTM and HLE features, no direct
> > dependence. at the qemu I
> > started guest with -cpu host-model.
> > I have viewed the code of kernel-5.4, and MSR_IA32_TSX_CTRL is not
> > exposed to guest.
>
> Does guest see TAA_NO bit?
>
Guest can't see taa_no, which requires updating qemu to solve. But I think
there is a compatibility process here.
> > Thanks.
> >> --
> >> Regards/Gruss,
> >>      Boris.
> >>
> >> https://people.kernel.org/tglx/notes-about-netiquette
>
