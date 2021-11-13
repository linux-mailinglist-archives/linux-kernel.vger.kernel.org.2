Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0825944F026
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 01:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhKMADj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 19:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhKMADf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 19:03:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B283C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 16:00:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso8897706pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 16:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/T22u9uiXYSbjw4vUr/c0mCt/SzIILWdyE5tNdh2BGw=;
        b=VhQZsgvI1uZu/qRt1rBhl5uQ6ruHuXkwfFJUbOu/8oflm8Y8IjTfdrFpF5l4XDHMfw
         hNujv6cx9lgJ/C687c0csRkaZMgbMie5C4wI4UJn+h3SunYyBWEiUavPrYnyyBmgmypl
         U1v0ayQcKxxOxnWtaehUJOJ94L9U6hqLQBpJ1UKCUvsSfWv4j7QA2BzyLC2R76HJhpCp
         jH8Y7lsynNB8tRXk59LIf6m0nHpYJWaX7L/79Et5TybhPnccFu33hBQUB2JKrxjsWxoh
         hUaykcrY5mFgXt/znGHUGIqrt8hSXn/SZ318s9vC+/0BLbMS9RCdUVDk542SlhCeEoey
         k3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/T22u9uiXYSbjw4vUr/c0mCt/SzIILWdyE5tNdh2BGw=;
        b=aJNjxfrEgpcYvTUQuljR14im8O07lKYwb/+tsKIT56gBzLkIa3PrUdP2JV/PqxhZ5L
         2QwGJf/RoMQPsJhyFyH7lIr5ljtKyJoi6XBuImys5q3TUCD+mZjOiGLE0i0AjVl1fc90
         4BtV8QB3ShgJieoyJ0pz5x++MeJwgNeijmTQK6VI6xgrm4PZ8O9LB4w6mBOnfVwqtWqV
         MTGKahmsGFb4LZl7ZDcQTAW+pVenjiw37DslBDyTnlRbAm8XGBhMZKAHAeVAJIgLej24
         M20Y3QeNBs71elSRGr4OQh2ADbnsiJ/plSzIKu3m39zzqIHmoQYDh728PanxpuTOtE2g
         vxRw==
X-Gm-Message-State: AOAM533Gd+rgg/tQtc1qZ1Vx16eSC7pRF3RbV/jfiWqIxWACyHouSt7q
        iVuTB3/OUbLYgnF9mq574x1rOA==
X-Google-Smtp-Source: ABdhPJw0L5nRV7A2TEQulq2d+qnpOxthRLSY8VdwXH4zCv0Xvd9k+FIidmAI6gWHtGbettKqVbDWxQ==
X-Received: by 2002:a17:90b:1bcf:: with SMTP id oa15mr41527726pjb.161.1636761643547;
        Fri, 12 Nov 2021 16:00:43 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l6sm8544982pfc.126.2021.11.12.16.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 16:00:42 -0800 (PST)
Date:   Sat, 13 Nov 2021 00:00:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part2 v5 00/45] Add AMD Secure Nested Paging (SEV-SNP)
 Hypervisor Support
Message-ID: <YY8AJnMo9nh3tyPB@google.com>
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <CAMkAt6o0ySn1=iLYsH0LCnNARrUbfaS0cvtxB__y_d+Q6DUzfA@mail.gmail.com>
 <061ccd49-3b9f-d603-bafd-61a067c3f6fa@intel.com>
 <YY6z5/0uGJmlMuM6@zn.tnic>
 <YY7FAW5ti7YMeejj@google.com>
 <YY7I6sgqIPubTrtA@zn.tnic>
 <YY7Qp8c/gTD1rT86@google.com>
 <YY7USItsMPNbuSSG@zn.tnic>
 <CAMkAt6o909yYq3NfRboF3U3V8k-2XGb9p_WcQuvSjOKokmMzMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkAt6o909yYq3NfRboF3U3V8k-2XGb9p_WcQuvSjOKokmMzMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021, Peter Gonda wrote:
> On Fri, Nov 12, 2021 at 1:55 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Nov 12, 2021 at 08:37:59PM +0000, Sean Christopherson wrote:
> > > Let userspace decide what is mapped shared and what is mapped private.
> >
> > With "userspace", you mean the *host* userspace?

Yep.

> > > The kernel and KVM provide the APIs/infrastructure to do the actual
> > > conversions in a thread-safe fashion and also to enforce the current
> > > state, but userspace is the control plane.
> > >
> > > It would require non-trivial changes in userspace if there are multiple processes
> > > accessing guest memory, e.g. Peter's networking daemon example, but it _is_ fully
> > > solvable.  The exit to userspace means all three components (guest, kernel,
> > > and userspace) have full knowledge of what is shared and what is private.  There
> > > is zero ambiguity:
> > >
> > >   - if userspace accesses guest private memory, it gets SIGSEGV or whatever.
> >
> > That SIGSEGV is generated by the host kernel, I presume, after it checks
> > whether the memory belongs to the guest?

Yep.

> > >   - if kernel accesses guest private memory, it does BUG/panic/oops[*]
> >
> > If *it* is the host kernel, then you probably shouldn't do that -
> > otherwise you just killed the host kernel on which all those guests are
> > running.
> 
> I agree, it seems better to terminate the single guest with an issue.
> Rather than killing the host (and therefore all guests). So I'd
> suggest even in this case we do the 'convert to shared' approach or
> just outright terminate the guest.
> 
> Are there already examples in KVM of a KVM bug in servicing a VM's
> request results in a BUG/panic/oops? That seems not ideal ever.

Plenty of examples.  kvm_spurious_fault() is the obvious one.  Any NULL pointer
deref will lead to a BUG, etc...  And it's not just KVM, e.g. it's possible, if
unlikely, for the core kernel to run into guest private memory (e.g. if the kernel
botches an RMP change), and if that happens there's no guarantee that the kernel
can recover.

I fully agree that ideally KVM would have a better sense of self-preservation,
but IMO that's an orthogonal discussion.
