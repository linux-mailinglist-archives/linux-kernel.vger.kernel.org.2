Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286B83A969A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhFPJzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:55:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35144 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhFPJyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:54:54 -0400
Received: from zn.tnic (p200300ec2f0c2b0089cf8396f15d74fc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2b00:89cf:8396:f15d:74fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B457E1EC0402;
        Wed, 16 Jun 2021 11:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623837167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=55YUTD0xMLR3eNdyrRtKxQw5aZ564OZYbwRRlI5/7Qc=;
        b=pR+teYe/PbB/g8UygDO3kkYxp3sVClD0rupzgrLDiGMYKVp5plXF1UjSabb9C+7EkHmjoZ
        v4PaJQyLErOQE34MhpnE6ngd7TgnwvOl87ZrXSVJMc1umxip9oB9bw/L+h+zGd0flWeHPL
        l4/IPMqD7Di+6PV6UtKjrZF9xkiTygI=
Date:   Wed, 16 Jun 2021 11:52:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
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
Subject: Re: [PATCH v2 03/12] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YMnJ5V4NU1JF2KAZ@zn.tnic>
References: <YMI2MtZ/poULESej@zn.tnic>
 <20210612210219.2164766-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210612210219.2164766-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 02:02:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +void __init tdx_early_init(void)
> +{
> +	if (!cpuid_has_tdx_guest())
> +		return;
> +
> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> +
> +	pr_info("Guest is initialized\n");

As I had typed, without the "is":

	pr_info("Guest initialized\n");

We're trying to keep dmesg style from becoming prose. :)

Rest looks ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
