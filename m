Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDE139677B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhEaR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhEaR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:58:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA385C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:55:30 -0700 (PDT)
Received: from zn.tnic (p200300ec2f080f00c524a4d22cb87212.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:c524:a4d2:2cb8:7212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8064F1EC052C;
        Mon, 31 May 2021 19:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622483728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q9BzzXtfPxNugxRAv21AN0P5i1cLxaiZOApwtnz102U=;
        b=jeCI17jlnnzHH5VHS+uRV0nFcSOlx4KEXEQ62YnMMu93N6BgYzkUWOTyt1oqTYurPyjKws
        5QYmiyzHIjS//kV/LdMlIu7cEt2UXel4360U6JGM4nF2ef1SZVYPYicLLz12exaCE+WTgN
        0sDWlrQSpDykb5aOFjk439VAohz+Feo=
Date:   Mon, 31 May 2021 19:55:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
Message-ID: <YLUjCqdPu/8eWuB+@zn.tnic>
References: <YJm5QY8omAvdpBO9@google.com>
 <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic>
 <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <YKgA1od/SqycWWds@zn.tnic>
 <86b4d995-9619-81fa-5ef4-86f48ab01e96@amd.com>
 <a94e1fb8-50bf-ef69-6553-237937029c5d@linux.intel.com>
 <YLT9AGodkvct8YTO@zn.tnic>
 <96a63ddf-98f9-7095-f7bb-100bf56a4d10@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96a63ddf-98f9-7095-f7bb-100bf56a4d10@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:32:44AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> I think above requirement is satisfied in following implementation.

Well, I suggested a single protected_guest_has() function which does:

        if (AMD)
                amd_protected_guest_has(...)
        else if (Intel)
                intel_protected_guest_has(...)
        else
                WARN()

where amd_protected_guest_has() is implemented in arch/x86/kernel/sev.c
and intel_protected_guest_has() is implemented in, as far as I can
follow your paths in the diff, in arch/x86/kernel/tdx.c.

No is_protected_guest() and no ARCH_HAS_PROTECTED_GUEST.

Just the above controlled by CONFIG_INTEL_TDX_GUEST or whatever
the TDX config item is gonna end up being and on the AMD side by
CONFIG_AMD_MEM_ENCRYPT.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
