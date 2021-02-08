Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C058C313DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhBHSod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbhBHQrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:47:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F71C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 08:46:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b145so10070775pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNIRDaAi2ttUX2BwT0eUxftB7rMbwd0s7iNYvsQxqIM=;
        b=DvWmqTiXK/tfwiqP0CRyLh8rTLUNIVDh34KaTK+LeNoPkBpMUYRJ4wlrOoDkkRvBDE
         +OzGQ9zai4tYDojdE7z0j65kmDwUE4M3rF9kWiWSS2TH7yD9OP3swFufn+S/exgDnzXh
         Y8wl6FLvplxW7M/urXzNkR8S7lJ8vWJlg/Y9WNj9JOV7GjFQhw+TbdZ0mhl6WVPfltcn
         vDPG+g7oulJ+1LjRbmHvnLpwRB/Jw5D5UDkphH6bMSeL7VQFwwxr3yRRb+lh4xCDQsD5
         XGl99eh/V1HepufofyxXKpoLUS2hap6H+xhu7kZdmUVBtFcd6HEkPjpoIsF9wvWqlDVt
         X5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bNIRDaAi2ttUX2BwT0eUxftB7rMbwd0s7iNYvsQxqIM=;
        b=G2EAjb2OEOAFQWr5Bi0CleH5Yalf9Ek5/z0b3SfUa/aWKwIQILVr5yq0uiwvabUkyS
         JCcJrOy4Z6KW43DcrcHDSxLYpKQim8UE9K/z/SoE7KLOrBSfGovGt2Mnr8n29/D3CIce
         3okT3XNdztFannEAmtRgnOPbibTcCS7v0AhxDnAkYLQKjk3R/xeTxsBJrbEvlxvK/Ol8
         /kZe8Ir6c1gfjfFq+iNxoKU8lxooLalMDR6ryPkjtjwEk6mLhVYTmjdyvVeB0i8gSAcn
         Mgscx3EmmSKDBnl4LeQ+hJtFeEsehRHDwtcxcvd6S9AaJXTqIaVy7ZW+dHeUl4uEctRX
         fI5w==
X-Gm-Message-State: AOAM531BXqpeVcyf90CZK3eH9XSuqDhhLrdlPw4aXfpH18pxc16YeY6m
        nGqmZCXcOXCJQxGk63EACZCHvg==
X-Google-Smtp-Source: ABdhPJz+mGTNSN2zKYo+/YorUukj0PKZMpOZCCARW7Yi811M3D5aANogEa3MfGD0IXUKRYHEuTGhEw==
X-Received: by 2002:a63:1524:: with SMTP id v36mr17841967pgl.383.1612802790364;
        Mon, 08 Feb 2021 08:46:30 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e4db:abc1:a5c0:9dbc])
        by smtp.gmail.com with ESMTPSA id 16sm15991358pjc.28.2021.02.08.08.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 08:46:29 -0800 (PST)
Date:   Mon, 8 Feb 2021 08:46:23 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YCFq3y5b62NsmBhO@google.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YCEQiDNSHTGBXBcj@hirez.programming.kicks-ass.net>
 <20210208162301.GA365765@tassilo.jf.intel.com>
 <YCFnwnzgHXNGKW+M@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCFnwnzgHXNGKW+M@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021, Peter Zijlstra wrote:
> On Mon, Feb 08, 2021 at 08:23:01AM -0800, Andi Kleen wrote:
> > > > +#ifdef CONFIG_INTEL_TDX_GUEST
> > > > +DEFINE_IDTENTRY(exc_virtualization_exception)
> > > > +{
> > > > +	struct ve_info ve;
> > > > +	int ret;
> > > > +
> > > > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > > > +
> > > > +	/* Consume #VE info before re-enabling interrupts */
> > > 
> > > So what happens if NMI happens here, and triggers a nested #VE ?
> > 
> > Yes that's a gap. We should probably bail out and reexecute the original
> > instruction. The VE handler would need to set a flag for that.

No, NMI cannot happen here.  The TDX-Module "blocks" NMIs until the #VE info is
consumed by the guest.

> > Or alternatively the NMI always gets the VE information and puts
> > it on some internal stack, but that would seem clunkier.
> 
> The same is possible with MCE and #DB I imagine.

The MCE "architecture" for a TDX guest is rather stupid.  The guest is required
to keep CR4.MCE=1, but at least for TDX 1.0 the VMM is not allowed to inject #MC.
So, for better or worse, #MC is a non-issue.

#VE->#DB->#VE would be an issue, presumably this needs to be noinstr (or whatever
it is that prevents #DBs on functions).
