Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862C543B2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 14:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhJZNBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:01:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45416 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233472AbhJZNBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:01:11 -0400
Received: from zn.tnic (p200300ec2f131c00c33a466bd07bd714.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1c00:c33a:466b:d07b:d714])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76BC81EC05C4;
        Tue, 26 Oct 2021 14:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635253126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OwPKnikJFbwjaEimBLJyqiKRQa/C4bxjCed1TbjuQrg=;
        b=G4Im+sDEyGyG5gBFhgpbPBP57tgn0tTAPMoc0hpedcPUaffIdrYSTwmrkjstsOC13Xrl6T
        3k3uNLY07x0W2jCIBI9NMDDsFWGGZ49T58S/NJC2mIWgOmkEUL2PzlZ/92fvbbbnoFrYTo
        s6sBjk9mc9XyyriVitOLNUPvMJ1JFn4=
Date:   Tue, 26 Oct 2021 14:58:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] x86/mm/64: Flush global TLB on boot and AP bringup
Message-ID: <YXf7hBEbW0CmwYwz@zn.tnic>
References: <20211001154817.29225-1-joro@8bytes.org>
 <20211001154817.29225-3-joro@8bytes.org>
 <YXfQoO0McyPiOFwz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXfQoO0McyPiOFwz@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:55:44AM +0200, Borislav Petkov wrote:
> > +	movq	%cr4, %rcx
> > +	movq	%rcx, %rax
> > +	xorq	$X86_CR4_PGE, %rcx
> > +	movq	%rcx, %cr4
> > +	movq	%rax, %cr4

Also, I'm wondering if you could compact this even more by defining a
function toggling the PGE bit and calling it from everywhere, even from
asm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
