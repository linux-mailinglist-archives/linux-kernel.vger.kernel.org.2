Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD83F9B23
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245333AbhH0Oup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbhH0Ouo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:50:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F46CC061796
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:49:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oa17so4703391pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=14M76fSGlvACgnYuGU3A/x3DEJPAcKiBE8JXzhdP/4U=;
        b=pLAL3YBvEH241wYB1s4aywKaz7QeJRhSbGv+nktb/1x+GCOg0VVDMExMGUZWmZPsDc
         NVzspVTDa3lSW0dyJijr23zu+7tSFARHT4kxKiTs7I83HrgoOR9ZjAM+CS/Hri3F1VJJ
         2cgbzigcjgD1FFxs8iuFU4QSJYpY905pXBKXs7PumwcHwyCCbOr2tLcIMDqqbkJHwm7W
         OY/wxvG8MYV6F0/ygGfrV94k17Tq04+ngUI3kmNaGgMrAB+BvHmQiIoMrL8UQ47WIDLc
         HbsUHl+jyqAkK128CP0oKREgIRQL0mf5zrS45lyHYrnz5h3QUE60Siq/ksEiSLoHHDKJ
         dUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=14M76fSGlvACgnYuGU3A/x3DEJPAcKiBE8JXzhdP/4U=;
        b=s6MFXXwKqeBXvMc/he9lJvvONP2mMOtfBumnVGu0hrNtMqh/rdWrdM/91PK8zCo441
         lguhAMahzHhmz7bA4gFyZm6xvKc5YSjtbMSevQlZSgUyJejaAa7RZbcxkr9vaTWyAw9J
         QJCEpt+S2yjdjKYczpc5DFIB4P++xm5+UhrplR7KqaqpNNo5fGCdp+7JArW8VmNc89Yo
         PTDhahC1xof6RW/ulNeSHaWeGStYr0jXbQzT9fm/U3++A4wt7JyLcSVQx2nsZCCqmdBg
         +8M8jVOu6b3PbCWFs7cUyuNSLYMsOc57kZ/daEE+YQmdB/+gOROXQK1LsYxjQlm92chn
         pLug==
X-Gm-Message-State: AOAM53266uU1PlHMjAtEazyd9/kJQWKUJioNRlTr1/57oLcEhqAHC73f
        RFolbNI0OTOqT0l5CgnL9IxJ9Q==
X-Google-Smtp-Source: ABdhPJwNNMMmz636sWquZ+PrJBprWwR45xsHh4a4A1+VNHMucrkqN70WbnI4m5X0u5NEISGgHsWDDA==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id q13mr23772297pjq.217.1630075794782;
        Fri, 27 Aug 2021 07:49:54 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x4sm6940653pff.126.2021.08.27.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 07:49:54 -0700 (PDT)
Date:   Fri, 27 Aug 2021 14:49:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 05/15] perf: Track guest callbacks on a per-CPU basis
Message-ID: <YSj7jq32U8Euf38o@google.com>
References: <20210827005718.585190-1-seanjc@google.com>
 <20210827005718.585190-6-seanjc@google.com>
 <YSiRBQQE7md7ZrNC@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSiRBQQE7md7ZrNC@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021, Peter Zijlstra wrote:
> On Thu, Aug 26, 2021 at 05:57:08PM -0700, Sean Christopherson wrote:
> > Use a per-CPU pointer to track perf's guest callbacks so that KVM can set
> > the callbacks more precisely and avoid a lurking NULL pointer dereference.
> 
> I'm completely failing to see how per-cpu helps anything here...

It doesn't help until KVM is converted to set the per-cpu pointer in flows that
are protected against preemption, and more specifically when KVM only writes to
the pointer from the owning CPU.  

> > On x86, KVM supports being built as a module and thus can be unloaded.
> > And because the shared callbacks are referenced from IRQ/NMI context,
> > unloading KVM can run concurrently with perf, and thus all of perf's
> > checks for a NULL perf_guest_cbs are flawed as perf_guest_cbs could be
> > nullified between the check and dereference.
> 
> No longer allowing KVM to be a module would be *AWESOME*. I detest how
> much we have to export for KVM :/
> 
> Still, what stops KVM from doing a coherent unreg? Even the
> static_call() proposed in the other patch, unreg can do
> static_call_update() + synchronize_rcu() to ensure everybody sees the
> updated pointer (would require a quick audit to see all users are with
> preempt disabled, but I think your using per-cpu here already imposes
> the same).

Ignoring static call for the moment, I don't see how the unreg side can be safe
using a bare single global pointer.  There is no way for KVM to prevent an NMI
from running in parallel on a different CPU.  If there's a more elegant solution,
especially something that can be backported, e.g. an rcu-protected pointer, I'm
all for it.  I went down the per-cpu path because it allowed for cleanups in KVM,
but similar cleanups can be done without per-cpu perf callbacks.

As for static calls, I certainly have no objection to employing static calls for
the callbacks, but IMO we should not be relying on static call for correctness,
i.e. the existing bug needs to be fixed first.
