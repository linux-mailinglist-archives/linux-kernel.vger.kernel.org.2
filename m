Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA24033A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 07:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhIHFIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 01:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhIHFIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 01:08:20 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415A3C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 22:07:13 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id s126so348842vkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 22:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vhKS75PrHBFIhQLrE36iDZUz0yJIZoiRmtXOsoWmUz8=;
        b=GpkbbHd/vM38KWaAB5OrpxGMo3wDCr1SwCbk40xmVmv6irgLYrsngmSic3+TECTfQ/
         hhH2BWkFf5Sz9n+KTHV6BQz2rEthAB22PHD439dG4voT3EjvHvmKyxjLwIe2JeEh+4ft
         hh4f3rkiBHKyO/XyR25JukmBlpBjlZcOTzwa9dDCgivD5xo1VXt5ZND0uHPkJSneUah3
         QBE4MYrYCB0MMvpZZHURkhpqhv9Xl/aMGPX/mTDhR3VhJ65XvVVKutB+/C1nloFXZzyh
         bwR25VcnaUR/6vqXNGZg+qIgeqTFfmmYVaGQXCGVSzOAeDBdcbpSm2EmP+A7tuxp3AhD
         9xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vhKS75PrHBFIhQLrE36iDZUz0yJIZoiRmtXOsoWmUz8=;
        b=oLvbd10QRBKW23/7KcTtxrW5Ot8LyQ8ZYTsEwlOCvLHvziWnChOCrmOKpJ/rMxbFRb
         QQm8jGTRy8By3CuQTWYyQ/Lzt7gYdpO6WHTBhYZz9qECuXJLIoPGTc/u8QqJw5HjlHaK
         mhwcw7+tGrOcaCDYL+J7moKg8hjzBC4IlPaRc1CiNdQH2uSa4YVbDHAs8DEZt0XcrvHh
         4HTrRTZno8yC7/+vXJWc5xdQkPbj3b18MjQE/jl4G4tO5GWnKVahQbeb5PvxWtYOmedk
         rMO87o2N2U9RlwajMz9pMmHbgvZ9a+g8BzHMB2jTLrfyhTPuZeVlT28gOFakX78iZH0n
         Immw==
X-Gm-Message-State: AOAM5307sBii/JUmuvp3BBrR9QjAhRQ2KHvbDf1rn2oXTTUimt53VpSQ
        /rGHw+PQRFLv97ZhX8OeP5jnD9ibn7JGszSgqog=
X-Google-Smtp-Source: ABdhPJzUpmfaopUaO1PhN3AAYZCaTrVMuljcr1JsKA1JBn4clBg//Ge+OaTwZhnXEMceF/2/XnnnFGHcVum0pct3Oxc=
X-Received: by 2002:a1f:23d0:: with SMTP id j199mr1021738vkj.21.1631077632347;
 Tue, 07 Sep 2021 22:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <20210907051454.56eocxfxeuqixlf6@gupta-dev2.localdomain> <CAPm50aLWUJZbgmvrt09S9LKowuH28NQpn7ZSuCkJGf_=jKFjXg@mail.gmail.com>
 <20210907225912.2i6cmprvauyxrhlu@gupta-dev2.localdomain>
In-Reply-To: <20210907225912.2i6cmprvauyxrhlu@gupta-dev2.localdomain>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Wed, 8 Sep 2021 13:06:44 +0800
Message-ID: <CAPm50aLFvP=F6Lz9M-a5aNcrx+cEkAZ6NPWwEShEx2yKk64c_g@mail.gmail.com>
Subject: Re: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not supported
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 6:57 AM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On 07.09.2021 14:36, Hao Peng wrote:
> >On Tue, Sep 7, 2021 at 1:13 PM Pawan Gupta
> ><pawan.kumar.gupta@linux.intel.com> wrote:
> >>
> >> On 06.09.2021 10:46, Hao Peng wrote:
> >> >If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
> >> >RTM and HLE features, it will affect TAA mitigation.
> >>
> >> Guests are on purpose not allowed to control TSX via MSR_IA32_TSX_CTRL=
,
> >> otherwise a malicious guest can enable TSX and attack host or other
> >> guests. The TAA mitigation within a guest is same as MDS i.e.
> >> micro-architectural buffer clear using VERW instruction. Support for
> >> VERW is added by the microcode update and enumerate by
> >> MSR_ARCH_CAP[MD_CLEAR] bit.
> >>
> >> >Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> >> >---
> >> > arch/x86/kernel/cpu/tsx.c | 7 +++++++
> >> > 1 file changed, 7 insertions(+)
> >> >
> >> >diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> >> >index 9c7a5f049292..5e852c14fef2 100644
> >> >--- a/arch/x86/kernel/cpu/tsx.c
> >> >+++ b/arch/x86/kernel/cpu/tsx.c
> >> >@@ -122,6 +122,13 @@ void __init tsx_init(void)
> >> >
> >> >        if (!tsx_ctrl_is_supported()) {
> >> >                tsx_ctrl_state =3D TSX_CTRL_NOT_SUPPORTED;
> >> >+
> >> >+               /* If hypervisor does not support MSR_IA32_TSX_CTRL e=
mulation,
> >> >+                * but guest supports RTM and HLE features, it will a=
ffect TAA
> >> >+                * =EF=BC=88tsx_async_abort=EF=BC=89mitigation.
> >> >+                */
> >> >+               setup_clear_cpu_cap(X86_FEATURE_RTM);
> >> >+               setup_clear_cpu_cap(X86_FEATURE_HLE);
> >>
> >> This is not correct. TSX feature can exist without TSX_CTRL MSR.
> >> Moreover, clearing the cached bits with setup_clear_cpu_cap() doesn't
> >> disable the TSX feature in CPU.
> >>
> >After applying this patch, the output of
> >/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
> >becomes =E2=80=9CMitigation: TSX disabled=E2=80=9D.Do you mean that tsx =
is still
> >enabled in this case in guest?
>
> If the host has TSX enabled, guest can use TSX instructions irrespective
> of what cpu capabilities in the guest says.
>
I understand that guest cannot produce any actual effects on the hardware,
so if the host has resolved the TAA bug on the hardware, does the guest act=
ually
have no vulnerability no matter what TAA status is displayed?
> >I made a mistake in the description before. This problem occurred
> >under the qemu -cpu Icelake-server .
>
> So looks like the real problem is with qemu feature definitions for
> cpu "Icelake-Server", it is probably not exporting "taa-no".
>
Yes, I already know the reason, but because it is inconvenient to
update the version of
the host component, consider the guest compatibility method.
> >When I debug this problem to -cpu host, the guest can see taa-no.
> >Thanks.
>
> Thats good.
