Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93365455117
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbhKQX0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbhKQX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:26:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5FFC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qN8JoXRSSc5h71hoQG+ulpo22EIdWe1+8WXcvP4avRI=; b=on+ZIHDhznh+YO+E/DvnFjrZMD
        GaJKWv27+C3BU7HLXhJH9yTtzUmj5QoTMFG37ZmMFkHVfuK9OeWgtYelweweOdSuPwm7e8yDbr9yr
        Ed3Wi7npeVSwLVXGIk61nExs2lXuStflZwTFvE17xAUBFODCQvTeIgSvT1CGUGZtn4v738J3/bGJG
        9su252Vp7TvR1Uon9EOM/Utsy0S8P3fqBjtJAzaE+WKjtjg2EbWa1gT/Ke/5ivJMgla3EBrjVuu05
        YAvrDb7sFjB4rioL4P2JkHAoohWu8oY4txtuq3ZuD+qYituO+pJDq//zNtOAXRc7EJd4s90zqCK1T
        mL28YlJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnUH3-0081JK-MF; Wed, 17 Nov 2021 23:23:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64AC2985304; Thu, 18 Nov 2021 00:23:29 +0100 (CET)
Date:   Thu, 18 Nov 2021 00:23:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Message-ID: <20211117232329.GD174703@worktop.programming.kicks-ass.net>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
 <YZVOfGtHyiZg1pIP@zn.tnic>
 <980ceab6-6686-c8f3-72b8-5743ca517bdf@linux.intel.com>
 <0f0b9784-1902-1526-2796-7d1a7ab17fb6@intel.com>
 <21f1325d-d97e-1bb7-ea87-d84e44089ab4@linux.intel.com>
 <YZVvdyHhPTzzZbiu@zn.tnic>
 <d826f932-a6a4-de7d-b0ea-f8e1f9bfe012@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d826f932-a6a4-de7d-b0ea-f8e1f9bfe012@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 03:04:11PM -0800, Sathyanarayanan Kuppuswamy wrote:

> We need PV support to handle halt() and safe_halt() cases.
> 
> HLT instruction is generally used in cases like reboot, idle and
> exception fixup handlers.

Which exception calls hlt? Because idle and reboot can easily be done.

> In TDX guest, to support HLT instruction, it has to be emulated using
> a hypercall (aka TDVMCALL).
> 
> We have the following three ways to emulate the HLT instruction:
> 
> 1. Directly substitute TDVMCALLs in places where we require emulation.
> 2. Use #VE exception handler to emulate it (In TDX guest, executing HLT
>    will lead to #VE exception).
> 3. Emulate it using pv_ops
> 
> Since option#1 is not a scalable approach, it can be ignored. Option #2
> is also not preferred because, we cannot differentiate between safe
> halt and normal halt use cases in the exception handler. 

Would not regs->flags & IF provide clue? I know STI normally has a
shadow, but wouldn't a trap in that shadow still get the flag straight?
I'm sure there's fun bugs around this, but surely TDX is new and doesn't
have these bugs.
