Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966873A2E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFJOhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:37:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34868 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhFJOhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:37:51 -0400
Received: from zn.tnic (p200300ec2f0cf600da53221f61d679bd.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:da53:221f:61d6:79bd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DFD01EC0104;
        Thu, 10 Jun 2021 16:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623335754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jdI2XpaRT+cUe5QAdM2QLk9s1m9GRHZ4hIDsodyeOnU=;
        b=YDYgOA9TeZB90dHTBCwtQksnfiBZGl4V2V+jlQnpDi9q351dY76OV6PY/t5ZemrEqVEzBq
        8XvT7Ypd8Z1B1nDoVFcPF7gukDDCzvSt8yUFt3+e0nzjVhlCpc0/3mLDw+W+X+AXoWsInL
        wCRILHC1NXIBH8SKBnn/2FB8qijYtVY=
Date:   Thu, 10 Jun 2021 16:35:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v1 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YMIjRC7dD4als88Z@zn.tnic>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMIFVh9WpDiUuRsa@zn.tnic>
 <20210610142943.uohw6nzpip5yi4no@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210610142943.uohw6nzpip5yi4no@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 05:29:43PM +0300, Kirill A. Shutemov wrote:
> No, "tdx" is host feature. It is part TDX host enabling. This feature
> indicates that kernel runs within TDX guest and named accordingly.

So there will be X86_FEATURE_TDX_GUEST and X86_FEATURE_TDX, latter to
mean TDX host functionality?

Are those patches somewhere public for me to see?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
