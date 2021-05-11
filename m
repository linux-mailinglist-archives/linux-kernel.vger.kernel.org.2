Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2E737AB86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEKQLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhEKQK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:10:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7E1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:09:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q15so11846065pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IjrFFPJC53lebLPOH5QRUVXmz4ihOhkij0I7QzCDBI0=;
        b=XcGb4jGjlJ6JO4vxlkNoZxxV11pXvU+oFMTV1r5oyRYzZo8CUqM0TxvcFJPRKg5lVf
         xFA6Eu8mHcLmEu3dplxBuNpOTarryk+zCnR0rOpd+YVIBuXQmYxs2IDA3byQmFrJQafI
         yMlWWBA7M/GOuE06gP0n4Seifx2RFiE+aztMDMkSy+wFaJuLr1QVK2/8bT7JKs0+KMmj
         vByvezV2m79Gi5LZfYDzv2xotK+3Hx+UhggOogV05Pm41AEZBD1RViip+bbidHfjLx61
         Bjjnmg/z226fxULvxCFRlpvyl8MWreccXUXvb1npKvoXVjEh2MeQtTF83cAg5gBz9yCq
         OmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IjrFFPJC53lebLPOH5QRUVXmz4ihOhkij0I7QzCDBI0=;
        b=nJNwOjmTH+tUfLc9CA2cbyego4EOttfpAw+Ujtw04NA25hE2+s5dSKazGeJDtS3rLR
         GCcxQNRA3a7Yng/lO+Zi/BYldzDlih4+skPdDoPbhAkf1B0desDXsSY0R8JYMUabfpJz
         Gjxzuu0ZTVOwYfaOUfCrBZSAfHR14HlatM8k1a1RlWr2OIH3lMtPUE/xOIHQmtUj6eot
         TpfOw9BrrLxxDlOEf8OJY1JZxaxErbuCe1TnhGydyDmIPtQCJEdvF+azq6O+ydxzEm2/
         usnPVKHIqiEB7mB94c4gMboIYv/Oi+SIHjBzeeIMmR64c7b/ogUtiedsJ6YV0Y43V8Ew
         2r6Q==
X-Gm-Message-State: AOAM530CCjUwxF+FeSurS2r4j5YgrUhsB0G5pYUkVEDD6dJOwI4knj9H
        wr+cxbftVB6GspGsueT7xwXsbw==
X-Google-Smtp-Source: ABdhPJzmmsIpuYEnKafc4HRT84mFXJz/TW3XfLuQ6ixT3txxj4R5VRjY5pgVYaRIjUQ0cu1nHQoCjQ==
X-Received: by 2002:a62:30c2:0:b029:289:116c:ec81 with SMTP id w185-20020a6230c20000b0290289116cec81mr31331906pfw.42.1620749391561;
        Tue, 11 May 2021 09:09:51 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id i3sm2468601pjv.30.2021.05.11.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 09:09:51 -0700 (PDT)
Date:   Tue, 11 May 2021 16:09:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <YJqsScgPlFx9j5qA@google.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jGmhkrd+Zr4RNcZ5qfXkYO-416Bw2_idVbrgij41yvYg@mail.gmail.com>
 <22d56f70-c69c-b3d2-51d6-962abdbc2882@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d56f70-c69c-b3d2-51d6-962abdbc2882@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021, Dave Hansen wrote:
> On 5/10/21 6:23 PM, Dan Williams wrote:
> >> To prevent TD guest from using MWAIT/MONITOR instructions,
> >> support for these instructions are already disabled by TDX
> >> module (SEAM). So CPUID flags for these instructions should
> >> be in disabled state.
> > Why does this not result in a #UD if the instruction is disabled by
> > SEAM? How is it possible to execute a disabled instruction (one
> > precluded by CPUID) to the point where it triggers #VE instead of #UD?
> 
> This is actually a vestige of VMX.  It's quite possible toady to have a
> feature which isn't enumerated in CPUID which still exists and "works"
> in the silicon.

No, virtualization holes are something else entirely.  

MONITOR/MWAIT are a bit weird; they do have an enable bit in IA32_MISC_ENABLE,
but most VMMs don't context switch IA32_MISC_ENABLE (load guest value on entry,
load host value on exit) because that would add ~250 cycles to every host<->guest
transition.  And IA32_MISC_ENABLE is shared between SMT siblings, which further
complicates loading the guest's value into hardware.  In the end, it's easier to
leave MONITOR/MWAIT enabled in hardware and instead force a VM-Exit.

As for why TDX injects #VE instead of #UD, I suspect it's for the same reason
that KVM emulates MONITOR/MWAIT as nops instead of injecting a #UD.  The CPUID
bit for MONITOR/MWAIT reflects their enabling in IA32_MISC_ENABLE, not raw
support in hardware.  That means there's no definitive way to enumerate to BIOS
that MONITOR/MWAIT are not supported, e.g. AFAICT, EDKII blindly assumes it can
enable MONITOR/MWAIT in IA32_MISC_ENABLE.  To justify #UD instead of #VE, TDX
would have to inject #GP on WRMSR to set IA32_MISC_ENABLE.ENABLE_MONITOR, and
even then there would be weirdness with respect to VMM behavior in response to
TDVMCALL(WRMSR) since the VMM could allow the virtual write.  In the end, it's
again simpler to inject #VE.

> There are all kinds of pitfalls to doing this, but folks evidently do it in
> public clouds all the time.

Virtualization holes are when instructions/features are enumerated via CPUID,
but don't have a control to hide the feature from the guest (or in the case of
CET, multiple feature are buried behind a single control).  So even if the VMM
hides the feature via CPUID, the guest can still _cleanly_ execute the
instruction if it's supported by the underlying hardware.

> The CPUID virtualization basically just traps into the hypervisor and
> lets the hypervisor set whatever register values it wants to appear when
> CPUID "returns".
> 
> But, the controls for what instructions generate #UD are actually quite
> separate and unrelated to CPUID itself.

Eh, any sane VMM will accurately represent its virtual CPU model via CPUID
insofar as possible, there are just too many creaky corners in x86 to make things
100% bombproof.
