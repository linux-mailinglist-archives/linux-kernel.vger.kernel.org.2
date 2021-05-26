Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B91391110
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhEZG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhEZG5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:57:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:55:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so350528pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OghfnCYzIco1oCB8DECwfdKUj+xfk1JNRs+3JjyLdXI=;
        b=CCftkdps53BVXky2a9t4INCXiuBpldrwHuYcfsj9FttPg9GWoJMIbrkQPyFn2MYHIf
         bkw6b6zp9AUYdfjPZQroCwWoeyRlmE/2TAfr3U37E7UB8yknBqC4cvY0lHPvUlROS9UD
         eao02dBf+HTJvDo3JdkmS0VaouKxD1I+3c1LTjCckBYxsaLqCMVotKxMKJtEZE1izPs6
         f812utp0zPSVIfJajOBZORYmQJu76xCDQYPyv06KK5Hh2/ftc1MNKSg0KycP8XdMDo6L
         nblUf2RnO1XQakl22pTpRPpHxuKKjUKg5PWuXVFDXzZ6OEYb0/MSMYpcVEnSnUtDzb38
         pnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OghfnCYzIco1oCB8DECwfdKUj+xfk1JNRs+3JjyLdXI=;
        b=op/GLI9TUPvWviIrfu20otfNcsbWBuxQZZtoUVfzLVuwcWQjw+Xa2EFnF0+GTkDB/2
         wXfzj9TsTOSmbAvj/Eq7XIjrNhj+bsoPDDMBCHf3gGg5+r2entYZsbQ/qRvZr3U0jGII
         RM/SXOc7TKr2Ha6stbrclm8gz6hdcY09rs/wJMdexyJBo5aTdZDNEkINNeAKMlI7u77/
         EDEIJi3sqc+Tu4sA+QjG1qSH5fqmnOwGVuM//lSEIyF5lS8V75XNQvcrtTu9vCiNcyix
         0R/QyCaG048AQrp/h9y6/uJ1yNaLwnBmUAy6lP6fFi4aU64SyEH8gtakqI/saqXVM655
         PYjg==
X-Gm-Message-State: AOAM530Yfl/0sI+E0L5tIp6j6hGyjcBa6u1gJmnDqt6RO6XORZQqpIui
        KJfeaovb20cSkMqLVAM1kMCctvQOhB6ubbZSP0Q53g==
X-Google-Smtp-Source: ABdhPJzyaejiTydXm07i/HmREiEYAcJNxFQUzAXDcvtQus1UwAnFRkMd3F6EUE8wkrNfH1tbPx7q4VrM4ztY4bhY21M=
X-Received: by 2002:a17:90a:6f06:: with SMTP id d6mr34723831pjk.216.1622012151775;
 Tue, 25 May 2021 23:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-17-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-17-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 25 May 2021 23:55:36 -0700
Message-ID: <CAAeT=FxQzCnMECRjSxi6J1KVdCnMaRYCOxeE-9efmN_BFFGsAw@mail.gmail.com>
Subject: Re: [PATCH 16/43] KVM: VMX: Stuff vcpu->arch.apic_base directly at
 vCPU RESET
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Write vcpu->arch.apic_base directly instead of bouncing through
> kvm_set_apic_base().  This is a glorified nop, and is a step towards
> cleaning up the mess that is local APIC creation.
>
> When using an in-kernel APIC, kvm_create_lapic() explicitly sets
> vcpu->arch.apic_base to MSR_IA32_APICBASE_ENABLE to avoid its own
> kvm_lapic_set_base() call in kvm_lapic_reset() from triggering state
> changes.  That call during RESET exists purely to set apic->base_address
> to the default base value.  As a result, by the time VMX gets control,
> the only missing piece is the BSP bit being set for the reset BSP.
>
> For a userspace APIC, there are no side effects to process (for the APIC).
>
> In both cases, the call to kvm_update_cpuid_runtime() is a nop because
> the vCPU hasn't yet been exposed to userspace, i.e. there can't be any
> CPUID entries.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
