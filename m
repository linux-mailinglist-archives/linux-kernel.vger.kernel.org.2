Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040D8396627
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhEaQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:59:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50868 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234560AbhEaPOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:14:47 -0400
Received: from zn.tnic (p200300ec2f080f002c54d32600da041e.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:2c54:d326:da:41e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B0651EC04DE;
        Mon, 31 May 2021 17:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622473986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HwgSxkLt0UgwY2k2NfcpDpKTqJoXBqHgNG0w5G0EBIs=;
        b=ot7HOL/U1uS9/6uQ4oZQ7Y0bpigtDRfMx8mvI2hbiVnyVQwXx3IhowyqMPDUj3NwYeTxFt
        NHNjabN9rcU3jH0+zRQvBcbePIjLutzbn5pl0PO3Tpz0cU9iq8/AtJWaG5itaz9Onzfq0n
        qwt7U/V1tRY3eYezkdQGtG0IrxlLM/I=
Date:   Mon, 31 May 2021 17:13:04 +0200
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
Message-ID: <YLT9AGodkvct8YTO@zn.tnic>
References: <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com>
 <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic>
 <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <YKgA1od/SqycWWds@zn.tnic>
 <86b4d995-9619-81fa-5ef4-86f48ab01e96@amd.com>
 <a94e1fb8-50bf-ef69-6553-237937029c5d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a94e1fb8-50bf-ef69-6553-237937029c5d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 11:21:21AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Following is the sample implementation. Please let me know your
> comments.

Doesn't look like what I suggested here:

https://lkml.kernel.org/r/YKfPLlulaqwypNkO@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
