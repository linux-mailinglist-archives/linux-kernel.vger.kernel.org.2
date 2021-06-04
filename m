Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF8739B5D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFDJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:23:22 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:41807 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhFDJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:23:21 -0400
Received: by mail-pl1-f180.google.com with SMTP id o12so952480plk.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mBAEhjZZRv7Jcy7Zua0pi2TsECX3PFBDfNxkyFGsLO0=;
        b=GFzrB6mDdP8QDUkM5E2D3SpI1YuNW543kJ1Zx1kk0NuEJ9dY60dkreacgqq7B7HMEs
         uqcy1p2HaKtSeecuRPdMc+ZpGU/OEc3CdNONynbGrv/3vMYyT7bl4zUw0YUQ9/GOQcn/
         p9MzmRmMsJwpomp+rOKp0w+JG2E9nloY+xf18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mBAEhjZZRv7Jcy7Zua0pi2TsECX3PFBDfNxkyFGsLO0=;
        b=UPKO4tEfjNmo9KVuaGfUfHOHZd98J12an/ZE4mdl0qRxyvaNN9435zLCXATKJppN/p
         1Vu+LVjlxGa+eqehpTJk9XFRrlUEi7Ef7piVB5kaRmVwkzfkuUVl5VMN+wSCyEex2+z+
         QD3SdxwrPgAqT+sYuftXWhZTk6j1844uQHr4Cb39CVa/lGkfrtj4VbOLNkt3ZgzAk1pO
         PRxcW0nQRTEBI4c5zuJYVkEM794bWXCySF7nw6NScYXk1xPgrRZOECuWEWBh5IQ2z0z7
         YktNiCDj9EgZ9RJhhpfziyoT8UoXEnIH6Qcbk3h7hkmjAsJgNx2XON9MEgl7X4WBMuXl
         nYzQ==
X-Gm-Message-State: AOAM5338tPI4KQkei64LdM6oZEjSSyATQ9YMlyayCW/MoHlv4OB8j3Ed
        Tn2ijqQ4qVGKDBVIzFGiFb5NHw==
X-Google-Smtp-Source: ABdhPJxqC/sFmH8NWFwbR+x7mytZyDKEx7TFmgf8/+UGv7fZox1XEZk3IYhTIOf3hSBOmUz/xertuQ==
X-Received: by 2002:a17:90b:607:: with SMTP id gb7mr3845129pjb.5.1622798435671;
        Fri, 04 Jun 2021 02:20:35 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:36b:f5b6:c380:9ccf])
        by smtp.gmail.com with ESMTPSA id p19sm4236799pjv.21.2021.06.04.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:20:34 -0700 (PDT)
Date:   Fri, 4 Jun 2021 18:20:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [RFC][PATCH] kvm: add suspend pm-notifier
Message-ID: <YLnwXD5pPplTrmoZ@google.com>
References: <20210603164315.682994-1-senozhatsky@chromium.org>
 <87v96uyq2v.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v96uyq2v.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/04 09:46), Marc Zyngier wrote:
[..]
> > +void kvm_arch_pm_notifier(struct kvm *kvm)
> > +{
> > +#ifdef CONFIG_PM
> > +	int c;
> > +
> > +	mutex_lock(&kvm->lock);
> > +	for (c = 0; c < kvm->created_vcpus; c++) {
> > +		struct kvm_vcpu *vcpu = kvm->vcpus[c];
> > +		int r;
> > +
> > +		if (!vcpu)
> > +			continue;
> 
> Wouldn't kvm_for_each_vcpu() avoid this kind of checks?

Right, that's what I do in v2, which I haven't posted yet.

[..]
> > +#include <linux/notifier.h>
> > +
> >  #ifndef KVM_MAX_VCPU_ID
> >  #define KVM_MAX_VCPU_ID KVM_MAX_VCPUS
> >  #endif
> > @@ -579,6 +581,10 @@ struct kvm {
> >  	pid_t userspace_pid;
> >  	unsigned int max_halt_poll_ns;
> >  	u32 dirty_ring_size;
> > +
> > +#ifdef CONFIG_PM
> > +	struct notifier_block pm_notifier;
> > +#endif
> 
> I'd certainly like to be able to opt out from this on architectures
> that do not implement anything useful in the PM callbacks.

Well on the other hand PM-callbacks are harmless on those archs, they
won't overload the __weak function.

> Please consider making this an independent config option that individual
> archs can buy into.

Sure, I can take a look into this, but how is this better than __weak
function? (that's a real question)

[..]
> > +#ifdef CONFIG_PM
> > +static int kvm_pm_notifier_call(struct notifier_block *bl,
> > +				unsigned long state,
> > +				void *unused)
> > +{
> > +	struct kvm *kvm = container_of(bl, struct kvm, pm_notifier);
> > +
> > +	switch (state) {
> > +	case PM_HIBERNATION_PREPARE:
> > +	case PM_SUSPEND_PREPARE:
> > +		kvm_arch_pm_notifier(kvm);
> 
> How about passing the state to the notifier callback? I'd expect it to
> be useful to do something on resume too.

For different states we can have different kvm_arch functions instead.
kvm_arch_pm_notifier() can be renamed to kvm_arch_suspend_notifier(),
so that we don't need to have `switch (state)` in every arch-code. Then
for resume/post resume states we can have kvm_arch_resume_notifier()
arch functions.

> > +		break;
> > +	}
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static void kvm_init_pm_notifier(struct kvm *kvm)
> > +{
> > +	kvm->pm_notifier.notifier_call = kvm_pm_notifier_call;
> > +	kvm->pm_notifier.priority = INT_MAX;
> 
> How is this priority determined?

Nothing magical here. I want this to be executed first, before we suspend
ftrace, RCU and the like. Besides KVM is usually the last one to register
its PM callbacks, so there can be something on the notifier list that
returns NOTIFY_STOP_MASK in front of KVM PM-notifier list entry.
