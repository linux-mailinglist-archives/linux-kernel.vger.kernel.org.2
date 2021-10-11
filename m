Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2246F4296B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhJKSSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231697AbhJKSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633976180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H82X7xRMODdZ4WEyS/ecEKADaJNvP9H/PqLV/Kv09G8=;
        b=L9eq1b+Atio5euPWBPBKj665WaUYuGpY4F66gyTfF4gv8/uUoMJyXMgXHviGVE0Y7UlDzY
        DJkwiBYnn9hi0GeL5AOyHWELGFPfnLhfhpjIIw0macYAsNssZzmh8/dquRuf8xk+ZRWVMk
        yrBpzvCDcdXFEzDWavRCctiEUgE8QMY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-b68F5Il6Pa-329bJL4X6Rw-1; Mon, 11 Oct 2021 14:16:19 -0400
X-MC-Unique: b68F5Il6Pa-329bJL4X6Rw-1
Received: by mail-qt1-f198.google.com with SMTP id 90-20020aed3163000000b002a6bd958077so13989916qtg.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H82X7xRMODdZ4WEyS/ecEKADaJNvP9H/PqLV/Kv09G8=;
        b=1putM6GRsP0FbnyLaa5V1gxuP9/QQKV46hvZlR77zB8pCaiYIDaJb1umXZDZkSzSfF
         s9EmBPN8KoBFIGk/4inXAqLiOO25NAnG8xNsogdZFBb+QDu/i/JmWyauRUrMSQCbHg1A
         vxEztD3gpCWXCT9zHPpds+7wWg5GLi9TIx72b+zb9lPMsDwSVBMeYnJO9AspXIHiSBVB
         TBlAEbK7I7lIc65gGEpQd4cx0UUwM6RBFJ9d122hdShq+N02CUCZGqyrkfPJY9+3vAdC
         fv1E2Op30bPWVd7vfHeuGHNDvXu7fOSHUOEyqsa+CxIfgU50/rjrb6Msb+KAD3gIMWVZ
         mkHQ==
X-Gm-Message-State: AOAM53154nTtLDBBqeYDf+9XBWi1lcz2ngSqfYGnYuoQ+0LtxtM9K9DB
        mCjfsc+3zgiWOY17SiFX2tqNT3Fm295dAvC8xCmfkssbbpQKmUuHsRm+fKi1K9c0oJi2tEp7ISA
        o30bBRcv/Qe0uMRP7AkI/njmP
X-Received: by 2002:ad4:46ab:: with SMTP id br11mr24958872qvb.33.1633976178460;
        Mon, 11 Oct 2021 11:16:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzfrJays15jS42HTdd5fDBYyP3bqCXbB4dhWeVXrgKHraYFT4MS3AeDWFU4ydMErPCW/g76Q==
X-Received: by 2002:ad4:46ab:: with SMTP id br11mr24958844qvb.33.1633976178221;
        Mon, 11 Oct 2021 11:16:18 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id l3sm4642202qkj.110.2021.10.11.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:16:17 -0700 (PDT)
Date:   Mon, 11 Oct 2021 11:16:13 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/11] x86/tdx: Handle CPUID via #VE
Message-ID: <20211011181613.mqvzj55xhlaotgaz@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211006202630.chblrhdqepsbtdaa@treble>
 <02e4f583-39dd-cac9-5b51-5fa9ba81b996@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02e4f583-39dd-cac9-5b51-5fa9ba81b996@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 07:25:44PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > - _tdx_halt() warns and doesn't return anything.
> 
> Since tdx_halt handler is shared with pv_ops, we can't return anything
> back (so we use WARN_ON to report the error).

Saying the "current structure of the code doesn't allow it" is not a
valid reason.

You could for example have _tdx_halt() return an error, and have the #VE
handler call _tdx_halt() directly so it can receive the error.

> > - tdx_read_msr_safe() and tdx_write_msr_safe() convert all errors to -EIO.
> 
> Return value does not matter. we only check for zero/non-zero value in
> tdx_handle_virtualization_exception(). we have used -EIO to convey that it is
> an IO error.

If I'm reading the GHCI spec right, the only possible error code for msr
access is VMCALL_INVALID_OPERAND.  Which sounds like -EINVAL to me.

> > - tdx_handle_cpuid() returns the raw vmcall error.
> > 
> > Second, as far as I can tell, the #VE handler doesn't check the actual
> > return code value, other than checking for non-zero.  Should it at least
> > be printed in a warning?
> 
> I don't think this is required. We can use trace to check the error code
> or argument details in failure case. Since we don't really use the
> error value, I am planning to change the #VE handler return type to
> bool.

In general the kernel prefers errno values instead of bool.  If
hard-coding an error, it should probably be hard-coded to a valid kernel
errno from within the inner handler (_tdx_halt(), tdx_read_msr_safe(),
etc).

That prevents confusion and will give the freedom to add more return
codes in the future, in case the inner handler wants to eventually
report multiple error types, or the top-level handler wants to handle
error types differently, or trace them, or warn, etc.

-- 
Josh

