Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B661454F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbhKQVMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbhKQVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:12:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5540C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:09:21 -0800 (PST)
Received: from zn.tnic (p200300ec2f13a300b32e6dc1ffa6ff5c.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a300:b32e:6dc1:ffa6:ff5c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 270BF1EC0298;
        Wed, 17 Nov 2021 22:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637183360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WiDVEedPiLZcsRlHIegyqdvQlNQDJCR3ow68P1n4MJ0=;
        b=UHeaiKlJM8jE8bnSYc8lbACt4s8lzmod5/lrNh8yjpbbZ4OGhdlAJmsjYvFBuTKo7QK3Bg
        1k9B3uw4vmsCy8wE9xI7HiJsjQaCXwBBHmF5w2QD2EYGp6+RxdTonwWd22zV0Xf2kyOdtN
        8PeBeQGTv9uWhf4tp4MLbMFFs8KVZM0=
Date:   Wed, 17 Nov 2021 22:09:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Message-ID: <YZVvdyHhPTzzZbiu@zn.tnic>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
 <YZVOfGtHyiZg1pIP@zn.tnic>
 <980ceab6-6686-c8f3-72b8-5743ca517bdf@linux.intel.com>
 <0f0b9784-1902-1526-2796-7d1a7ab17fb6@intel.com>
 <21f1325d-d97e-1bb7-ea87-d84e44089ab4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21f1325d-d97e-1bb7-ea87-d84e44089ab4@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 12:54:56PM -0800, Sathyanarayanan Kuppuswamy wrote:
> It is not only for idle case. We also need to support emulation of
> normal halt case (which is used in cases like reboot or
> early_fixup_exception(), etc.).

This is more of that piecemeal feeding of people asking why. Please sit
down and explain exactly and in detail why you need this. "We need to
support emulation" is not nearly good enough.

I don't think any of the people who replied on this thread *actually*
know *why* PV support is needed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
