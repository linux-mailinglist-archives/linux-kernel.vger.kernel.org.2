Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4345374E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhKPQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:27:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44996 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231355AbhKPQ1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:27:35 -0500
Received: from zn.tnic (p200300ec2f139500c63f2e8e3aeb06f1.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:9500:c63f:2e8e:3aeb:6f1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88FFD1EC03C9;
        Tue, 16 Nov 2021 17:24:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637079877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lp2HTnQhzpSNEzRM5eWlfJC/0eW2Wn4rTznwJfAAlBk=;
        b=mWh65VGCi1PHighNxpP41rtq0T+e+lzcyHhxUtdykIxNAZlf4jrUIcZeB9LE9kRY0IoDaC
        E9BNqPU8fu/7BbUo0aparBg/j8MboSs3Q8VnCmj6fXMzN1Dpx3g8CILloamRgokc2bo3fJ
        +f2DoOZQilATkYyHgQxiDhD1YRdAIYo=
Date:   Tue, 16 Nov 2021 17:24:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] x86: Skip WBINVD instruction for VM guest
Message-ID: <YZPbQVwWOJCrAH78@zn.tnic>
References: <20211116005027.2929297-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116005027.2929297-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 04:50:27PM -0800, Kuppuswamy Sathyanarayanan wrote:
> -#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
> +#define ACPI_FLUSH_CPU_CACHE()				\
> +do {							\
> +	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))	\

cpu_feature_enabled()

If you wanna query a X86_FEATURE_* bit, from now on, use only this
function.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
