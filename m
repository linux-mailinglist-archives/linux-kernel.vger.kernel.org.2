Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA9322F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhBWRQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhBWRQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:16:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1577DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:15:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b15so2265438pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jj9DO+ke1KJUo/ZsSRRN0jt9Q3wZoLjHifVaJsOxwGI=;
        b=NBHYqeiCKYpYjjdFRCdD58+WuzPuM0LZQ+R3Qo3dV+StHkW3szwnnkFIgVEwE3kQab
         zjBGdp/jvMBHJUqK2TeSBWrnV1L4tG/8XRt/BHhZnrcG6Iu1rSiXKsYc41wmYM+44SxG
         0jYfbtDmeOWtoq6/L1XD/ed6gUlGF0/1CYnia/EtyQ8E0By9IEh6hCrsKftUJdYOiwrN
         uUnRoxW4PubejoSP7jFqpmnAaF6zlhJxSuWA8U0uXvERpdzDy0OFYam3zETUlxAWG71M
         nrgH2zcXQoXIVMKDFslhay5uiySvS7CV4gH+Jjby8jtjfjaFvWlw0vIZO4nr54w5n8qz
         /+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jj9DO+ke1KJUo/ZsSRRN0jt9Q3wZoLjHifVaJsOxwGI=;
        b=sHwVBxw40g9tOqbxp7qbZeohzpavsLzbT0TXBtjf+cIzHJIanvm84FjFwpjVV1R+ok
         0nz+kxV5q7nQ8HTm+RXCwW0oOFxatk0U9gyolJlbLNBElIrzTWKtA9+R0qTIA6xQTNER
         k7YE1wbSCBrhUkrCrjZA+VMlAHL1gclUGr5XPMvcgTTSq7PSYxZQJorhkctrSOqPKsRd
         jG+ePL32q4ZYsKKiWDFtlKk1F1uOoYU62cMV2Aog37RwJqOxkgdq8/Dd2+I3s9iiY7I2
         oDbmQtt3m1xBiK6wuXBSWSot9XIacNRoiCpQwg8lUh9MjkLkgFlReEaqfeCVYRAL0XDG
         3dZg==
X-Gm-Message-State: AOAM531bQZvQs2EXDo2IeR5ltSA/ZOTTpSZa05VoohuxBdTF5LuPa0Fs
        eYgn/kcS3UplEiBOvSO+2Mo5ww==
X-Google-Smtp-Source: ABdhPJxrc6FVzTc+KiYGWNkxpla4tFwe8MryZL/oMXcurKjkRkhgGsjUIXsXmXBqOM0VefRajHTtIA==
X-Received: by 2002:a17:90a:de8d:: with SMTP id n13mr30320105pjv.136.1614100519509;
        Tue, 23 Feb 2021 09:15:19 -0800 (PST)
Received: from google.com ([2620:15c:f:10:c939:813f:76bc:d651])
        by smtp.gmail.com with ESMTPSA id m10sm3825929pjn.33.2021.02.23.09.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:15:18 -0800 (PST)
Date:   Tue, 23 Feb 2021 09:15:12 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: vmx/pmu: Fix dummy check if lbr_desc->event is
 created
Message-ID: <YDU4II6Jt+E5nFmG@google.com>
References: <20210223013958.1280444-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223013958.1280444-1-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021, Like Xu wrote:
> If lbr_desc->event is successfully created, the intel_pmu_create_
> guest_lbr_event() will return 0, otherwise it will return -ENOENT,
> and then jump to LBR msrs dummy handling.
> 
> Fixes: 1b5ac3226a1a ("KVM: vmx/pmu: Pass-through LBR msrs when the guest LBR event is ACTIVE")
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index d1df618cb7de..d6a5fe19ff09 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -320,7 +320,7 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
>  	if (!intel_pmu_is_valid_lbr_msr(vcpu, index))
>  		return false;
>  
> -	if (!lbr_desc->event && !intel_pmu_create_guest_lbr_event(vcpu))
> +	if (!lbr_desc->event && intel_pmu_create_guest_lbr_event(vcpu))
>  		goto dummy;

Wouldn't it be better to create an event only on write?  And really, why create
the event in this flow in the first place?  In normal operation, can't event
creation be deferred until GUEST_IA32_DEBUGCTL.DEBUGCTLMSR_LBR=1?  If event
creation fails in that flow, I would think KVM would do its best to create an
event in future runs without waiting for additional actions from the guest.

Also, this bug suggests there's a big gaping hole in the test coverage.  AFAICT,
event contention would lead to a #GP crash in the host due to lbr_desc->event
being dereferenced, no?

>  
>  	/*
> -- 
> 2.29.2
> 
