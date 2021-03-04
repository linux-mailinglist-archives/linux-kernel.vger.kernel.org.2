Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B1932D7C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhCDQ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhCDQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:26:44 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2BDC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:26:04 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x24so2066683pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=53gUuM3tYcEpBOX8DzoT48e7H0uFPBc3J55ZgQ9xJw8=;
        b=YljGwnbX10fWNhc20I0KKhH9gK4WXp0dUCfGgGCL5rER97ypw9hEtX1yvKI8OI/38Q
         yP6I7qTvac5OJeUKpJ4P7aQDsyzn4bQJOrq1Sp/rln37W1k6PqQpW44YXEn+XCgDKze2
         WZJi9ZQO1fz1NeQcgJ5kxjvS/ATQSZUq4lUovHkBUQ10JvnFgmbK+xbP6cXVhbY3fixF
         CN44Gbq67qff032CC5cmvN4oOS5qcFXzjaWHJk9k6EU3DSsgqGPKnLi18o1jDte0LuwD
         vzMTZRZRDDuseQG5Fxf92ACCRiMnVIbCktjHGixgKp79lysS2QPwvAPTQi/Ipt6SBgyw
         TSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53gUuM3tYcEpBOX8DzoT48e7H0uFPBc3J55ZgQ9xJw8=;
        b=OiqkUz/fCqLaM7ngguVh4cQHKXFcoGLci6qPlKTNFQ2CYCklappkG2S0EPplOloGlK
         KgN6WPBdKX2qSxt/hfVkk7PlU60fmpiqo2coSbweuwkYMhqUyK2IKwedYaTqqJprP642
         Ay67ATUEwmZBB36RqwpUTODO80Y8UxVV48QqnPd4BCIb6KrNrPzaQpnNvDg6UrdTooMH
         9/oX7z7h7FN0ECgsadWqLV98aZm1BfXPIh+9gGu7HxOghDLarbtXUfSIm3H6s+JO1GrT
         IDkOVvoyiNmL6k1Hxvfw6Uv3nWczhrsM2mnhAiARcwMON6U0+wwj7MKmaciF6dxKUsSZ
         JZ2g==
X-Gm-Message-State: AOAM532DmE9QGcIMNCM54C1d+QQqIPfXXXyf3RqzJE/prh4nd3roJFCv
        ef1PezqmXFLuPMUeJL+w7fO/eg==
X-Google-Smtp-Source: ABdhPJwx5DJnKAEccZEtUxwAkv1X9dtjLWmfLmm9yOYEE+g75XUTJSXYSs1Ie0xcVYaNldrpihIPaw==
X-Received: by 2002:a62:1791:0:b029:1ed:161e:9083 with SMTP id 139-20020a6217910000b02901ed161e9083mr4495651pfx.68.1614875163853;
        Thu, 04 Mar 2021 08:26:03 -0800 (PST)
Received: from google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
        by smtp.gmail.com with ESMTPSA id c193sm3294385pfc.180.2021.03.04.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:26:03 -0800 (PST)
Date:   Thu, 4 Mar 2021 08:25:56 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     "Xu, Like" <like.xu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, wei.w.wang@intel.com,
        Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu@linux.intel.com>
Subject: Re: [PATCH v3 6/9] KVM: vmx/pmu: Add MSR_ARCH_LBR_CTL emulation for
 Arch LBR
Message-ID: <YEEKFEJyLYSplm7w@google.com>
References: <20210303135756.1546253-1-like.xu@linux.intel.com>
 <20210303135756.1546253-7-like.xu@linux.intel.com>
 <YD/FFsTq6wprdMCB@google.com>
 <88d2481d-5435-1ffb-dc98-5534c446bd52@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d2481d-5435-1ffb-dc98-5534c446bd52@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021, Xu, Like wrote:
> On 2021/3/4 1:19, Sean Christopherson wrote:
> > > @@ -4463,6 +4470,8 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> > >   		vmcs_writel(GUEST_SYSENTER_ESP, 0);
> > >   		vmcs_writel(GUEST_SYSENTER_EIP, 0);
> > >   		vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
> > > +		if (cpu_has_vmx_arch_lbr())
> > > +			vmcs_write64(GUEST_IA32_LBR_CTL, 0);
> > Not that any guest is likely to care, but is the MSR cleared on INIT?  The SDM
> > has specific language for warm reset, but I can't find anything for INIT.
> > 
> >    On a warm reset, all LBR MSRs, including IA32_LBR_DEPTH, have their values
> >    preserved. However, IA32_LBR_CTL.LBREn is cleared to 0, disabling LBRs. If a
> >    warm reset is triggered while the processor is in C6, also known as warm init,
> >    all LBR MSRs will be reset to their initial values.
> 
> I was told that the reset behavior of GUEST_IA32_LBR_CTL
> would be the same as the GUEST_IA32_DEBUGCTL (true for INIT as well).

Yes, and DEBUGCTL is preserved on INIT.

	if (!init_event) {
		vmcs_write32(GUEST_SYSENTER_CS, 0);
		vmcs_writel(GUEST_SYSENTER_ESP, 0);
		vmcs_writel(GUEST_SYSENTER_EIP, 0);
		vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
	}

Table 22-10 in the SDM:

	All Other MSRs | Pwr up or Reset: | INIT:
			 Undefined          Unchanged


If IA32_LBR_DEPTH is weirdly exempt, it needs to be documented.  I doubt that's
the case though.

> It looks we have not strictly distinguished the guest's power concept C*.
> Do we have two trap paths for "warm reset" and "warm init" ?

No.  Despite the name .vcpu_reset, KVM doesn't even have a RESET path, userspace
is responsible for modelling RESET.
