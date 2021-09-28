Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5889C41ADA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbhI1LNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:13:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50728 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239068AbhI1LNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:13:24 -0400
Received: from zn.tnic (p200300ec2f13b20069aed57ec2bcdfb7.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:69ae:d57e:c2bc:dfb7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75EB81EC06D0;
        Tue, 28 Sep 2021 13:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632827504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jLnQq2aQoc6AJkXVMWgQbvX1exAx3qQHPR9BO5CDeH0=;
        b=B3IXHLzor6eXqa2OvU9HN1h31pznboo+xmBNTh5YbbhsBuqXPiVMtpjXKThCPpo8pO4iFm
        sixeGKMxRARvcQAKr4hSo8kgqZYb3SMc65zEWx3GT9GstUsFwEhfDBv14VDYhud8TJ0tkK
        euJ3C3mwP1n/W68XDTjhkx6ay9kvESI=
Date:   Tue, 28 Sep 2021 13:11:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/12] x86/tdx: Add Intel ARCH support to
 cc_platform_has()
Message-ID: <YVL4ZUGhfsh1QfRX@zn.tnic>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210916183550.15349-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YUTI5Vy/fLT/q/Lh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUTI5Vy/fLT/q/Lh@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 06:57:09PM +0200, Borislav Petkov wrote:
> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> index b43bacdc40da..6037201c8437 100644
> --- a/arch/x86/kernel/cc_platform.c
> +++ b/arch/x86/kernel/cc_platform.c
> @@ -18,6 +18,8 @@ bool cc_platform_has(enum cc_attr attr)
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>  	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>  		return amd_cc_platform_has(attr);
> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
		 ^^^^^^^^^^^^^

Hmm, ok, so this won't work. I did:

---
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..9024a9f58603 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -64,6 +64,8 @@ bool cc_platform_has(enum cc_attr attr)
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
 
+	WARN_ON_ONCE(!boot_cpu_data.initialized);
+
 	return false;
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);

---

ontop of the latest version:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc3-cc

and it fires, see below.

So I'm thinking you should use cpuid_has_tdx_guest() instead but cache
its result so that you don't call CPUID each time the kernel executes
cc_platform_has().

This way there won't be any false positives.

Thx.

early console in setup code
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/cc_platform.c:67 cc_platform_has+0x4c/0x60
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc3+ #3
[    0.000000] RIP: 0010:cc_platform_has+0x4c/0x60
[    0.000000] Code: 85 ff b8 01 00 00 00 74 24 48 8b 05 2e 8e 1d 01 48 f7 d0 83 e0 01 c3 83 ff 03 75 13 48 8b 05 1b 8e 1d 01 48 d1 e8 83 e0 01 c3 <0f> 0b c3 f3 c3 31 c0 c3 48 8b 05 05 8e 1d 01 83 e0 01 c3 cc e8 8b
[    0.000000] RSP: 0000:ffffffff82203f20 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
[    0.000000] RAX: 0000000000000000 RBX: ffff888000013950 RCX: 0000000000000000
[    0.000000] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000000000001
[    0.000000] RBP: ffff888000013950 R08: 0000ffffffffffff R09: ffff0000ffffffff
[    0.000000] R10: ffffffff0000ffff R11: 00000000000001f0 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.000000] FS:  0000000000000000(0000) GS:ffffffff89624000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: 0000000000000000 CR3: 00000000096a4000 CR4: 00000000000000a0
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  ? sme_map_bootdata+0xe/0x57
[    0.000000]  ? copy_bootdata+0x9/0x5a
[    0.000000]  ? x86_64_start_kernel+0x57/0x73
[    0.000000]  ? secondary_startup_64_no_verify+0xb0/0xbb
[    0.000000]  </TASK>
[    0.000000] random: get_random_bytes called from __warn+0xc2/0x140 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
