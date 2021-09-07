Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADDE402381
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhIGGh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhIGGhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:37:55 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E7C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 23:36:49 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id j5so2933609vki.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 23:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=81bXsMWwM5zfaggPfko/bDGqWs9EhY347O7q94droCw=;
        b=USVRcy0R7yzuJZM7IUajLJzkN1P/uIELvwRNzaRgpMlARPA2GYSMSkp6eUuLI7+P5n
         giaOQDgEh67MhvYHSzXOSPszPplEu8HxhgL9vvwle+F5BzF79mJgp891D5u10wkzDHen
         Iebdb2aybP65GdCuYL8c6iUxhVMmSpBNWPIjQ/SAcCHzR0v7yLarxtP8IISlcTD/u4kq
         0I4dHKEXud8x8O0BcJkCfGQd6lIrf1hDhkmxppYX3yMwc+mRBXT1sDnsdypx61KYPzQs
         CQRV5syqmb7Ao6C/gJyciodkKBqqCo8iLEZzBOk+Skf3X7OEckOKbzVO2PNKuvZX3tZ1
         lFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=81bXsMWwM5zfaggPfko/bDGqWs9EhY347O7q94droCw=;
        b=ft7TjC8NQiTtBc2FVd6uPVKazZtjvaxAywU0ihWR489ADlNhJFQGcUHvTUB+Kbmuxp
         bHF9q6FKomxDJe27M4uBKEI15z3LwLdalOlL8HnQg2AkZ9saSYZJnT8nwhs682GnGx5X
         TLODXmmjhvFFKkvl1HTnpuTXSyOzCvUqyul93MTXgmSSrigvm0U/dBC/C1mbMS9+8ZVl
         3kBEv5rsnSPDOA/XJ2dUEGAGBtGbHljdV/B7Tqjv87gvkX2l3Yw4DRzFX3nj60EbWaP9
         FR3xAvMuW1/THzMtV/hvkpUP+EFJZq+wD5L9PzOwRp+ptMGLbfkbGhx/GM6UxjVUE6Iv
         NK8A==
X-Gm-Message-State: AOAM530QJoEDV0BnnBR9brnUl2t39GrtS04FFBmz++HfVw9AP32WPx4g
        WSz/orcJmRxZahjAlz1YNix8aiqS/7uFkuUyUKg=
X-Google-Smtp-Source: ABdhPJyuXYHhx4YZQaKGvwaxhTzKSCQ6n/8/F+R1iiZDVyfHlej081j8Tn6TlYlPLiX9Il78cvmu75YEe2o7M780mQk=
X-Received: by 2002:a1f:2f87:: with SMTP id v129mr7004725vkv.4.1630996608941;
 Mon, 06 Sep 2021 23:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <20210907051454.56eocxfxeuqixlf6@gupta-dev2.localdomain>
In-Reply-To: <20210907051454.56eocxfxeuqixlf6@gupta-dev2.localdomain>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Tue, 7 Sep 2021 14:36:21 +0800
Message-ID: <CAPm50aLWUJZbgmvrt09S9LKowuH28NQpn7ZSuCkJGf_=jKFjXg@mail.gmail.com>
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

On Tue, Sep 7, 2021 at 1:13 PM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On 06.09.2021 10:46, Hao Peng wrote:
> >If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
> >RTM and HLE features, it will affect TAA mitigation.
>
> Guests are on purpose not allowed to control TSX via MSR_IA32_TSX_CTRL,
> otherwise a malicious guest can enable TSX and attack host or other
> guests. The TAA mitigation within a guest is same as MDS i.e.
> micro-architectural buffer clear using VERW instruction. Support for
> VERW is added by the microcode update and enumerate by
> MSR_ARCH_CAP[MD_CLEAR] bit.
>
> >Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> >---
> > arch/x86/kernel/cpu/tsx.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> >diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> >index 9c7a5f049292..5e852c14fef2 100644
> >--- a/arch/x86/kernel/cpu/tsx.c
> >+++ b/arch/x86/kernel/cpu/tsx.c
> >@@ -122,6 +122,13 @@ void __init tsx_init(void)
> >
> >        if (!tsx_ctrl_is_supported()) {
> >                tsx_ctrl_state =3D TSX_CTRL_NOT_SUPPORTED;
> >+
> >+               /* If hypervisor does not support MSR_IA32_TSX_CTRL emul=
ation,
> >+                * but guest supports RTM and HLE features, it will affe=
ct TAA
> >+                * =EF=BC=88tsx_async_abort=EF=BC=89mitigation.
> >+                */
> >+               setup_clear_cpu_cap(X86_FEATURE_RTM);
> >+               setup_clear_cpu_cap(X86_FEATURE_HLE);
>
> This is not correct. TSX feature can exist without TSX_CTRL MSR.
> Moreover, clearing the cached bits with setup_clear_cpu_cap() doesn't
> disable the TSX feature in CPU.
>
After applying this patch, the output of
/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
becomes =E2=80=9CMitigation: TSX disabled=E2=80=9D.Do you mean that tsx is =
still
enabled in this case in guest?
I made a mistake in the description before. This problem occurred
under the qemu -cpu Icelake-server .
When I debug this problem to -cpu host, the guest can see taa-no.
Thanks.
> Thanks,
> Pawan
