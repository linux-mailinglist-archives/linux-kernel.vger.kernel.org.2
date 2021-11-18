Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103FA4557CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbhKRJQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:16:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39266 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245010AbhKRJQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:16:47 -0500
Received: from zn.tnic (p200300ec2f18440012dcc1639703e693.dip0.t-ipconnect.de [IPv6:2003:ec:2f18:4400:12dc:c163:9703:e693])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C36C61EC056D;
        Thu, 18 Nov 2021 10:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637226825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hgiI/i8pUaO8S6tWUefEiJVVzp7wOp0BvxHStcvHm2U=;
        b=Wg/GC0UGW5PkjlotKPQZYsojpUY5+6SMLzWIocNFl6WSWEbLHBTmCPGj5oZFu2KeT/vsgl
        O8qOLtJisrFQ3smFYVhjMg33XYSe0CnSS+ceoFmIiV7wRBGZNT9pu9JLzNxpv28broGvJ0
        +r7hfQQdVZEX8HVVeZ+Fz06VxN2dmp0=
Date:   Thu, 18 Nov 2021 10:13:37 +0100
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
Message-ID: <YZYZQap45Jg+SPqp@zn.tnic>
References: <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
 <YZVOfGtHyiZg1pIP@zn.tnic>
 <980ceab6-6686-c8f3-72b8-5743ca517bdf@linux.intel.com>
 <0f0b9784-1902-1526-2796-7d1a7ab17fb6@intel.com>
 <21f1325d-d97e-1bb7-ea87-d84e44089ab4@linux.intel.com>
 <YZVvdyHhPTzzZbiu@zn.tnic>
 <d826f932-a6a4-de7d-b0ea-f8e1f9bfe012@linux.intel.com>
 <99c70f8d-3275-8aed-5bb3-8b386dcb5e82@intel.com>
 <d3fa3c72-b420-0b5c-f385-bad1d56fcd0d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3fa3c72-b420-0b5c-f385-bad1d56fcd0d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 05:26:15PM -0800, Sathyanarayanan Kuppuswamy wrote:
> I meant it not scalable because, for any new use case of HLT
> instruction, it would need substitution again. We cannot always keep
> tracking its uses in the future, right?

I don't understand what the whole hoopla is about:

	alternative_call(halt, tdx_halt, X86_FEATURE_TDX_GUEST, ...)

No PV needed.

> Also, If we make any changes to the core emulation code (like arguments
> change), we will have to re-touch these use cases to handle it.

We do change the core code all the time to accomodate new stuff. You
should be seeing that constantly with the rate of change happening...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
