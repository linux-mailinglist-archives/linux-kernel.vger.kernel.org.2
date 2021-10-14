Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2BB42D8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJNMDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhJNMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:03:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57670C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:01:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634212867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E29PD96EzFrxnOIpww5mYifRqBkBqnRUmqoBddSE54g=;
        b=PHwFnZIIoy3Zz6/huQE8qIfPU1FTPAX8t4cBoG6SKy9Wm2HLDx5Gbk6WX+l5UwAyXTq76d
        oepLg3PMaMoc0QtUBf2p7FN+W/lYYXm4S/3Axmle1lyEG6pz5r0fLv3ZlF1Fgk/h6jDASd
        7W2df3WhxNT93IBpoBlobyeFjdMgrgduYYORAwLzw4LtiKPRQWtJJbUTWLm7JNXrA6uxdY
        Dvw9waXiVtmeHFJwppzmwrAEj0P8L4MZi9T7bFPpmXfgeMNFDQH4RgZHi4dOcAW+5zmbio
        7zNjE9Xwf0ph3vyn+1oF6fRMGjPfr6AK8B2FSfr4K59no5bKbaYHKWab24E38w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634212867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E29PD96EzFrxnOIpww5mYifRqBkBqnRUmqoBddSE54g=;
        b=hfOeU6AYC4Oa8hDRFSvuq8gpMT6w3UdAudNpzUBduFvj7E8k26ZJgdiRr/sluSP6auvSZj
        vEQxoa1I20ezA+Aw==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 11/11] x86/tdx: Handle CPUID via #VE
In-Reply-To: <20211009053747.1694419-12-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-12-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 14 Oct 2021 14:01:06 +0200
Message-ID: <87a6jb7r3x.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> When running virtualized, the CPUID instruction is handled differently
> based on the leaf being accessed.  The behavior depends only on the
> leaf and applies equally to both kernel/ring-0 and userspace/ring-3
> execution of CPUID. Historically, there are two basic classes:
>
>  * Leaves handled transparently to the guest
>  * Leaves handled by the VMM
>
> In a typical guest without TDX, "handled by the VMM" leaves cause a
> VMEXIT.  TDX replaces these VMEXITs with a #VE exception in the guest.
> The guest typically handles the #VE by making a hypercall to the VMM.
>
> The TDX module specification [1], section titled "CPUID Virtualization"
> talks about a few more classes of CPUID handling. But, for the purposes
> of this patch, the "handled transparently" CPUID leaves are all lumped
> together because the guest handling is the same.

What means 'for the purposes of this patch'? And I have no idea what's
lumped together means either.

#VE is either raised on CPUID leaf/sub-leaf combinations which are not
part of the CPUID virtualization table or on request of the guest for
all CPUID invocations (either Ring0 or Ring3 or both).

So this patch implements the #VE handling for EXIT_REASON_CPUID by
handing it through to the hypercall, which in turn lets the TDX module
handle it by invoking the host VMM.

So unless the guest requested #VE on all CPUID invocations it won't see
a #VE for the transparent leaf/sub-leaf combinations. #VE is raised
for the VMM handled ones which goes through the hypercall, right?

I must be missing something, but that last paragraph does not make any
sense to me.

Thanks,

        tglx
