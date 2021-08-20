Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562183F3254
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhHTRfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:35:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhHTRfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:35:31 -0400
Received: from zn.tnic (p200300ec2f107b00196adb237f9ce365.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:7b00:196a:db23:7f9c:e365])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D96FE1EC0589;
        Fri, 20 Aug 2021 19:34:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629480889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ra/7mQW79+c0tVxtuse8aU6V6XyXHtuoSW3joNYRlng=;
        b=gVbbTxnVt7SsxSFRW7lW/CZ2MJ8YrW1G19OVz5PnQzGP+/BUG/yN0Mz67sy1ty/4rl2A0P
        VB0y19VNMdrfFw4xAPm9zIhbx1dRRx7EUe4yin4ly07hFmkjJ24eCwKoSkdrHjKXq2XFu0
        g/flruk96bX90jJoykhYUfUY6muA28k=
Date:   Fri, 20 Aug 2021 19:35:32 +0200
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
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/12] x86/tdx: Get TD execution environment
 information via TDINFO
Message-ID: <YR/n5FgCUSlZ5npc@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YR/in4WqEQQ/LyPA@zn.tnic>
 <c5dc6c26-6157-c022-9d6b-f1ef10e6f736@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5dc6c26-6157-c022-9d6b-f1ef10e6f736@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 10:31:10AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> It is used in different patch set. If you prefer to move it there, I can
> move it to that patch set.

Yes please.

> I have already fixed reasonable check-patch issues. For this case, we
> want to use BUG_ON(). Failure in tdx_module_call means buggy TDX
> module. So it is safer to crash the kernel.

Ok, put that as a comment above it to explain why it cannot continue.
Also, make sure you issue an error message before it explodes so that
the user knows.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
