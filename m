Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F6B3A356C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFJVJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJVJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:09:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3526C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 14:07:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cf600c1d899d9d1fa7d9d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:c1d8:99d9:d1fa:7d9d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46D6A1EC047E;
        Thu, 10 Jun 2021 23:07:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623359272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U66o5NPctiBjexTUVOAi9pIBymcgh42hxbtqNj2WUcE=;
        b=kYC8/2QvAyJKwVIqZ6vMf0j6Ulu2E/oBdLTbE/JKpDebUpfLqsZQH50IIvYdg180Q0JVSG
        ulCxVB6GOD0A2d7rLha1++7HHT+xSkgMxIe6QGr2Ol4eG+NDg52H2jtb7ey7Z/tItvzvhd
        zcth3Z2f3s1JEnZTzg2tTmTMIEl/jp4=
Date:   Thu, 10 Jun 2021 23:07:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 04/11] x86/x86: Add is_tdx_guest() interface
Message-ID: <YMJ/IrBZiCsNMtvO@zn.tnic>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMJvNGyIaBItV9c6@zn.tnic>
 <3437ff11-4656-2c2a-ae58-04b77b6ff663@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3437ff11-4656-2c2a-ae58-04b77b6ff663@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 02:01:41PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Is it alright to use vendor name in prot_guest_has() flag? I thought
> we want to keep them generic.

Sure but keeping them only generic doesn't work in cases like this.

And just like you have:

+/* Protected Guest Feature Flags (leave 0-0xff for arch specific flags) */

there could be ranges for vendor-specific flags.

Intel at 200-2ff
AMD   at 300-3ff

which is 256 per vendor, so should be enough. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
