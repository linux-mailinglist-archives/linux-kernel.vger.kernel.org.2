Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38C3C61C1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhGLRXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhGLRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:23:06 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD406C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 10:20:16 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q16so11129423oiw.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/g8dTtqEdW34OwE46m1MAAewcTdXVykzo2F4gfcfFFQ=;
        b=FgzYbYWWchiFEX7JgzLKKjpNjSXbJFtN64/66JKLT7nxtDXqKdS6dmH55joKAL+sXz
         BxIQNE9emF49HbPJ+lPO2V++Kc5y++hSFU0F+z7Lv7o2iYOub3UWC1bAA0cp3kD/dOf6
         ji4OkDM89dDb2iK2vZzHUwweAI7g6BoUt7h6FmNNTDcQIyGIeuJofzEzyKxvL1Bvwz+O
         zQP9ciarNI2bFATzZ7+oGOi7/BoKEAC78+KpGDYMm/aySIVbDs9mJwnGFnjBAUkr15mJ
         iws9TWsO9v5liXhfcImCSsWYTZjUlhEtD6LHxZg14KIwkotAg7CKC4nCFuHiGlHCWWNx
         8OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/g8dTtqEdW34OwE46m1MAAewcTdXVykzo2F4gfcfFFQ=;
        b=J2pVgLucXfAC0mbTYTtElw3CvD+wYUZgVSWmMlZtSgX9o+Jd2gQWKfdt3a2/t6jndN
         35O4bp2OesEMe6pEL7h17W7t8JQta7H4Tz6TwzucyiuNMXsneNUk375zhWmzqdsK0tuM
         RIrIl+31/5Z73mGrb/GScFgalZQpNAJJFZuMAp7HVfX0mhLX0HyQQdanGyvNUmCytGsp
         TZEDe/MhISmVD8Kr7HABU9dCfNyiiCX2Ibfhy7/d5goxcx3FlhZDgPNQW73aQac2Sgvz
         tYtoS7pOjr6VvNKp4zyYCDlZdlk8Z8bB8+7ng4eHsMI8CMIRWOCiWrs1eIcflnVo42nK
         thFw==
X-Gm-Message-State: AOAM532lPYFNuiRIkhd3EmBmu+Vp0WwUJSTUww+DteigzgywuMsxl9CM
        jPasLCwMq+67HINROw8Rwck/tULtU8h/m55DVr5b0Q==
X-Google-Smtp-Source: ABdhPJwCTwS+1GiIchwcl2et26v1BPVnXTvxhpqTj7f2o9f4uQ8NqprnWvmsykCIPGrQTpb07BkYbdGEmxSQSDOApoo=
X-Received: by 2002:aca:1e07:: with SMTP id m7mr38610835oic.28.1626110415883;
 Mon, 12 Jul 2021 10:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <1625825111-6604-1-git-send-email-weijiang.yang@intel.com>
 <1625825111-6604-7-git-send-email-weijiang.yang@intel.com>
 <CALMp9eQEs9pUyy1PpwLPG0_PtF07tR2Opw+1b=w4-knOwYPvvg@mail.gmail.com>
 <CALMp9eQ+9czB0ayBFR3-nW-ynKuH0v9uHAGeV4wgkXYJMSs1=w@mail.gmail.com>
 <20210712095305.GE12162@intel.com> <d73eb316-4e09-a924-5f60-e3778db91df4@gmail.com>
In-Reply-To: <d73eb316-4e09-a924-5f60-e3778db91df4@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 12 Jul 2021 10:20:04 -0700
Message-ID: <CALMp9eQmK+asv7fXeUpF2UiRKL7VmZx44HMGj67aSqm0k9nKVg@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] KVM: x86/vmx: Save/Restore host MSR_ARCH_LBR_CTL state
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        seanjc@google.com, vkuznets@redhat.com, wei.w.wang@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 3:19 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> On 12/7/2021 5:53 pm, Yang Weijiang wrote:
> > On Fri, Jul 09, 2021 at 04:41:30PM -0700, Jim Mattson wrote:
> >> On Fri, Jul 9, 2021 at 3:54 PM Jim Mattson <jmattson@google.com> wrote=
:
> >>>
> >>> On Fri, Jul 9, 2021 at 2:51 AM Yang Weijiang <weijiang.yang@intel.com=
> wrote:
> >>>>
> >>>> If host is using MSR_ARCH_LBR_CTL then save it before vm-entry
> >>>> and reload it after vm-exit.
> >>>
> >>> I don't see anything being done here "before VM-entry" or "after
> >>> VM-exit." This code seems to be invoked on vcpu_load and vcpu_put.
> >>>
> >>> In any case, I don't see why this one MSR is special. It seems that i=
f
> >>> the host is using the architectural LBR MSRs, then *all* of the host
> >>> architectural LBR MSRs have to be saved on vcpu_load and restored on
> >>> vcpu_put. Shouldn't  kvm_load_guest_fpu() and kvm_put_guest_fpu() do
> >>> that via the calls to kvm_save_current_fpu(vcpu->arch.user_fpu) and
> >>> restore_fpregs_from_fpstate(&vcpu->arch.user_fpu->state)?
> >>
> >> It does seem like there is something special about IA32_LBR_DEPTH, tho=
ugh...
> >>
> >> Section 7.3.1 of the Intel=C2=AE Architecture Instruction Set Extensio=
ns
> >> and Future Features Programming Reference
> >> says, "IA32_LBR_DEPTH is saved by XSAVES, but it is not written by
> >> XRSTORS in any circumstance." It seems like that would require some
> >> special handling if the host depth and the guest depth do not match.
> > In our vPMU design, guest depth is alway kept the same as that of host,
> > so this won't be a problem. But I'll double check the code again, thank=
s!
>
> KVM only exposes the host's depth value to the user space
> so the guest can only use the same depth as the host.

The allowed depth supplied by KVM_GET_SUPPORTED_CPUID isn't enforced,
though, is it?
