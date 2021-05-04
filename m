Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A31372F37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhEDRvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhEDRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:51:18 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E25C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 10:50:22 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id e25so9588147oii.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCkRHCN61kfizqWJXP1PWNpclqjzIE2ZjByqn8qit3M=;
        b=TJ5hcE62aB70t3wRgov2kIHjvIshRaIKwKhsS6AKdPP57RDYO/z30LoU/rF67pU0XU
         IX8UJLBud9zuRfHTIlVO/nC7FH2uePijzicdHzldgmLPR59XrR5NnW8i/dr6td/UiKEe
         +2l5dD8yXCQ14uQwkasfUugjgt3fHHCqDtcmA4+c0Nx9+AsX+DWmpKYLE7ndkYCluTGP
         Ff/X1Cz7eEwgxJONcOl06k3gXPXPGY3nmZXgc4RpwISc5vPk4pewq0R4oddwgpc43Kxu
         igyvApR6auWvoSXDFL3RbIDTX4Q1sGlY/YD01BsPMY3+n+ohgtbTvxm91vcssZbXIWUP
         Fi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCkRHCN61kfizqWJXP1PWNpclqjzIE2ZjByqn8qit3M=;
        b=qRwees55nkjM4iR/5urQmQSc5Rm6X/AVyQaBwkTBYkSurgPbfLnf7TFjjZ8i+ltGDN
         bvQXhYOYqmIqPWs3q6n24VYIveqSjdWyrTK1Ao+iR3Kra6g7u4oFkAY5QrsAESTHyilT
         /CdPo5GBWqpOwB0pf9XmiKNM5I9GSkLgpsBFSGDlSGLwQeAUq6ybuAKkaFTrVgRl7aF9
         2846iKzMAae/DuqKdczvRmBnyDKcB6VtzWGXTKU2QosI3EvpL5KhORyA/bMLozAt2Fil
         eAFXbBXGhon1cMErpMCXLoZ6TYeU4oWAQpiG3MD0LKh87RuSt9hz2NuDb0/ttKvU1BrJ
         9mLw==
X-Gm-Message-State: AOAM5324CQJi8K8mkhKYOYUEmbM6F13TMYDEd/esuRW6nanWn0igedPF
        WxPo6jiaqr9rw4S/ltCAFzpIDhsSev3ABZ8JGX7ynQ==
X-Google-Smtp-Source: ABdhPJzF70u/lwIhgpkw/qWojuBy7ba9HmvvzYL4q9yPwPYvQ7BSZD6+KuS92/zihXTjnwbz8wZQPTVc2liKABG/L08=
X-Received: by 2002:aca:3cd6:: with SMTP id j205mr18533711oia.28.1620150621183;
 Tue, 04 May 2021 10:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com> <20210504171734.1434054-3-seanjc@google.com>
In-Reply-To: <20210504171734.1434054-3-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 4 May 2021 10:50:10 -0700
Message-ID: <CALMp9eTqoiiwDdXZQ=MYpaEp-g1z=1SeAqqk6TNU9MFeRJayWQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] KVM: x86: Emulate RDPID only if RDTSCP is supported
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 10:17 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Do not advertise emulation support for RDPID if RDTSCP is unsupported.
> RDPID emulation subtly relies on MSR_TSC_AUX to exist in hardware, as
> both vmx_get_msr() and svm_get_msr() will return an error if the MSR is
> unsupported, i.e. ctxt->ops->get_msr() will fail and the emulator will
> inject a #UD.
>
> Note, RDPID emulation also relies on RDTSCP being enabled in the guest,
> but this is a KVM bug and will eventually be fixed.
>
> Fixes: fb6d4d340e05 ("KVM: x86: emulate RDPID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed by: Jim Mattson <jmattson@google.com>
