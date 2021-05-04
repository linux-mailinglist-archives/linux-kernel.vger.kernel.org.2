Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFAE372F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhEDSPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhEDSPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:15:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58730C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 11:14:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h11so8738881pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A37r92Zoxb3Wwdyl0dNZeG4YgRPk+mhN+xQeVWOiYY4=;
        b=jAtkm9ykx1VNiILhpLEdQMPqaBsPtaQJQfNgwNhvIWWlrO/7bnYa7Izcl8n4aq82PR
         9UFLeQrq4jIjDENycYU35NUYrFqvXgp150XpnyMCtMLU2Rke17UP+s4SQ2U45N+Y4EyN
         OGc1kvokNvhLMEN3QjzF6lSV96/z/VUtaaeuChjxPRGt5ye+BHhO2PsD9UrVls5Zbghf
         TZYFTF4RGEaYMrSbCDA8XPms+AQU3hqKPUuFTpdUzFeFeVFCN0b9DfvKaGWseHKl3g69
         cxL67JVon3pSpA9lgPvq/REDxyTjcQj7EXVnIah/QQB/lUze/NDfCHpkZbDuG4BEUq9h
         krDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A37r92Zoxb3Wwdyl0dNZeG4YgRPk+mhN+xQeVWOiYY4=;
        b=Yas4cx1/iO0BRZTOSJ0JvIW31iAVPdYPbjMphSsUjcErV6ix/j2Au70oADRZrfCHxM
         84dQe5X1vHWovjAoeUYVad+Lbz78bqG05hIwDmByIanNanbbd0N9CRI9fvr9/L+sJp7B
         psOMi/n9ug2PjSlqhFRFRm1DySyetrVqp165teEMwmSTwdyceLYkkucXQ8FW4Dhy9m/v
         1Dep0Pa/9XgF5+5p5lkpmNv7XQuWG9vwsqMuqC9FtI74l9TXzEvrOcVA3U8NMCvzeBQ7
         1FLowTK18U+t9vVL1LEgeDOwaDQynuuTi61aTgC1PeSwKvOpcx4uYJwgX+zTSstH29w4
         mtfw==
X-Gm-Message-State: AOAM530z7Tb+dh8PacO5URR5koeoeaIrf4xeVwwxZc9c+rc2rhs4Qbb7
        D518oNT6eCEGwVdwgdCNTqzjuQ==
X-Google-Smtp-Source: ABdhPJwjwLucy9r3EDI9ixrwIALMgiMSArRKl5Ii+uWMKtG7b0cBWxEfnNOCnV4k5DzMXwUe4RqEJQ==
X-Received: by 2002:a65:4486:: with SMTP id l6mr24775072pgq.347.1620152086769;
        Tue, 04 May 2021 11:14:46 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id mn22sm4363357pjb.24.2021.05.04.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 11:14:46 -0700 (PDT)
Date:   Tue, 4 May 2021 18:14:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 01/15] KVM: VMX: Do not adverise RDPID if ENABLE_RDTSCP
 control is unsupported
Message-ID: <YJGPElJzMRGcyzAL@google.com>
References: <20210504171734.1434054-1-seanjc@google.com>
 <20210504171734.1434054-2-seanjc@google.com>
 <CALMp9eToSSQ=8Dy4Vt5-GYEB4YB9c6-LTp8c60C97LOY9ufdjg@mail.gmail.com>
 <CALMp9eQEP32pqFMtn2WZy1B_Aq1x-J52WhF2tC0dNd0vrdhmPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eQEP32pqFMtn2WZy1B_Aq1x-J52WhF2tC0dNd0vrdhmPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021, Jim Mattson wrote:
> On Tue, May 4, 2021 at 10:37 AM Jim Mattson <jmattson@google.com> wrote:
> >
> > On Tue, May 4, 2021 at 10:17 AM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > Clear KVM's RDPID capability if the ENABLE_RDTSCP secondary exec control is
> > > unsupported.  Despite being enumerated in a separate CPUID flag, RDPID is
> > > bundled under the same VMCS control as RDTSCP and will #UD in VMX non-root
> > > if ENABLE_RDTSCP is not enabled.
> > >
> > > Fixes: 41cd02c6f7f6 ("kvm: x86: Expose RDPID in KVM_GET_SUPPORTED_CPUID")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> >
> > But KVM will happily emulate RDPID if the instruction causes a #UD
> > VM-exit, won't it? See commit fb6d4d340e05 (KVM: x86: emulate RDPID).
> 
> Oh, after reading the second patch, I now see why this is needed.

Yeah.  Technically, once common x86 can query MSR_TSC_AUX support directly at
the end of the series, the emulation enumeration could be:

		if (kvm_is_supported_user_return_msr(MSR_TSC_AUX))
			entry->ecx = F(RDPID);

I think I actually meant to do that, then lost track of that TODO item when
reworking the series for the umpteenth time.

Practically speaking, the only way for kvm_is_supported_user_return_msr() to be
meaningful vs. kvm_cpu_cap_has() is if RDTSCP is supported in hardware but the
VMCS control is not available.  And I suppose there's also the case where
X86_FEATURE_RDTSCP was cleared by the kernel, but I feel like KVM should respect
the kernel's avoidance of RDTSCP/MSR_TSC_AUX in that case.  Regarding the silly
VMCS case, I have no objection to making the change, but I also don't care if we
sweep it under the rug.
