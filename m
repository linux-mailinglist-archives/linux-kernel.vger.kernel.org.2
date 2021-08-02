Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53D33DDCA7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhHBPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhHBPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:46:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67FC061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:46:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ca5so25710267pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Q8GPtUEDsZnvVcYI9DEHGIcb7f0tGzkxrNpYDg2qaU=;
        b=uow+0XtDub2IqIcws3lM4NZ7uaUdL+cd84LTX4KtuCE3l37WKA2N+zxg5/iVd8BXRq
         fX1WFK1I+yFnvLf4UWLznAAWEPerkoHJShkJ28aOvH2VE6TE1vJoeCYklWFB4N39ajUz
         h+hfQex/9Ng6SEilyRyJXJ67tdLF7zbsHtQ1G3sFPnONGHZMXdCLYOd+81GbwBsSNn9b
         giIDjtOcFzOwECu6+D5R6Pkkjq/ZLiN5ZdLbDKeGW2WyenxRSyUfN3o/1s7SyEygNRcN
         LNysSnrbcnPA0eFtCIgxq0vL89LGrGe1GzjhZuGXb4Ry/t+e0QRN5DuEzkFQkJuRGucW
         zxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Q8GPtUEDsZnvVcYI9DEHGIcb7f0tGzkxrNpYDg2qaU=;
        b=CExKCdrdGDuTgyDJHfuOM+rvJDFJtVJx98rEU8IDLioYpU0ezPl+12yOxjN6yXDjsH
         vGtGtoilMMQ7k7J428El8tNkW/lcnQDm7WbDK1FCwiNLFmc+fOdbRWrxsitixduv5QKR
         LuhRZE8d7Ikv08ia8d2Wi89jmjQY9zyHMqCf5TiAWBJDKFJgel0aLT6gkU0eiOnv7hUR
         KjnNAdSH+p0h5a2rTtODjYx2+SL1aJyUNflWT3VMgRwMXpkPQX0BVJuc8v7IgnCea2oJ
         C02qiygda/QYJK23chpwotwY6CFcgWXz1ZeMjgjF1KluuY5k1orqFsiiP5PR1w8Yo8f6
         HPQQ==
X-Gm-Message-State: AOAM531jNPw/zQH5eaSMTn69auVxTiXM8c7ydccnviUt3EuZIZQEjdtn
        Nid57v+j67sWyKk/T6dmAZjN+w==
X-Google-Smtp-Source: ABdhPJyD2vWo9Vn05mBGwtYf+avY1EFSSDpDQQAstgMR7/9Wwz/17fZavGw+io3OGZXkoX9XNrwNMw==
X-Received: by 2002:a65:6441:: with SMTP id s1mr3109877pgv.214.1627919169557;
        Mon, 02 Aug 2021 08:46:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b7sm12046336pfl.195.2021.08.02.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:46:09 -0700 (PDT)
Date:   Mon, 2 Aug 2021 15:46:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Tao Xu <tao3.xu@intel.com>, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: VMX: Enable Notify VM exit
Message-ID: <YQgTPakbT+kCwMLP@google.com>
References: <20210525051204.1480610-1-tao3.xu@intel.com>
 <YQRkBI9RFf6lbifZ@google.com>
 <b0c90258-3f68-57a2-664a-e20a6d251e45@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c90258-3f68-57a2-664a-e20a6d251e45@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021, Xiaoyao Li wrote:
> On 7/31/2021 4:41 AM, Sean Christopherson wrote:
> > On Tue, May 25, 2021, Tao Xu wrote:
> > >   #endif /* __KVM_X86_VMX_CAPS_H */
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 4bceb5ca3a89..c0ad01c88dac 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -205,6 +205,10 @@ module_param(ple_window_max, uint, 0444);
> > >   int __read_mostly pt_mode = PT_MODE_SYSTEM;
> > >   module_param(pt_mode, int, S_IRUGO);
> > > +/* Default is 0, less than 0 (for example, -1) disables notify window. */
> > > +static int __read_mostly notify_window;
> > 
> > I'm not sure I like the idea of trusting ucode to select an appropriate internal
> > threshold.  Unless the internal threshold is architecturally defined to be at
> > least N nanoseconds or whatever, I think KVM should provide its own sane default.
> > E.g. it's not hard to imagine a scenario where a ucode patch gets rolled out that
> > adjusts the threshold and starts silently degrading guest performance.
> 
> You mean when internal threshold gets smaller somehow, and cases
> false-positive that leads unexpected VM exit on normal instruction? In this
> case, we set increase the vmcs.notify_window in KVM.

Not while VMs are running though.

> I think there is no better to avoid this case if ucode changes internal
> threshold. Unless KVM's default notify_window is bigger enough.
> 
> > Even if the internal threshold isn't architecturally constrained, it would be very,
> > very helpful if Intel could publish the per-uarch/stepping thresholds, e.g. to give
> > us a ballpark idea of how agressive KVM can be before it risks false positives.
> 
> Even Intel publishes the internal threshold, we still need to provide a
> final best_value (internal + vmcs.notify_window). Then what's that value?

The ideal value would be high enough to guarantee there are zero false positives,
yet low enough to prevent a malicious guest from causing instability in the host
by blocking events for an extended duration.  The problem is that there's no
magic answer for the threshold at which a blocked event would lead to system
instability, and without at least a general idea of the internal value there's no
answer at all.

IIRC, SGX instructions have a hard upper bound of 25k cycles before they have to
check for pending interrupts, e.g. it's why EINIT is interruptible.  The 25k cycle
limit is likely a good starting point for the combined minimum.  That's why I want
to know the internal minimum; if the internal minimum is _guaranteed_ to be >25k,
then KVM can be more aggressive with its default value.

> If we have an option for final best_value, then I think it's OK to just let
> vmcs.notify_window = best_value. Then the true final value is best_value +
> internal.
>  - if it's a normal instruction, it should finish within best_value or
> best_value + internal. So it makes no difference.
>  - if it's an instruction in malicious case, it won't go to next instruction
> whether wait for best_value or best_value + internal.

...

> > > +
> > >   	vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK, 0);
> > >   	vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, 0);
> > >   	vmcs_write32(CR3_TARGET_COUNT, 0);           /* 22.2.1 */
> > > @@ -5642,6 +5653,31 @@ static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
> > >   	return 0;
> > >   }
> > > +static int handle_notify(struct kvm_vcpu *vcpu)
> > > +{
> > > +	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
> > > +
> > > +	if (!(exit_qual & NOTIFY_VM_CONTEXT_INVALID)) {
> > 
> > What does CONTEXT_INVALID mean?  The ISE doesn't provide any information whatsoever.
> 
> It means whether the VM context is corrupted and not valid in the VMCS.

Well that's a bit terrifying.  Under what conditions can the VM context become
corrupted?  E.g. if the context can be corrupted by an inopportune NOTIFY exit,
then KVM needs to be ultra conservative as a false positive could be fatal to a
guest.
