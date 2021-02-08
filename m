Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B263313589
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhBHOru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232129AbhBHOdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:33:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF0E464E30;
        Mon,  8 Feb 2021 14:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612794776;
        bh=6KdzPmYqB+bGvxQs/MeqN8+No+/dd/gL7m2Dw37//uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRxcx/CzDqmm4c++0Yqjr8ULS70s5iUOjyryFfltC8Nh1jciCm4FVQCFWeC6lf2l/
         NCxLd1tT3BNbg4MKtkYidcnaLY0NZV0KKXXJMJDKvBkcvsUh2N2qjunOr0EZSEUZo2
         5ol0kGGH+7wX+DPe1MLj7koxS0sUJJoVUjuWrB795/sQhFe4fczU8cmM6BSeFYHOgr
         CCH0NA/qYle0yA0DxCBrBvu5TMjLax1+Ti+xUKyuIoKbsrj33arc3d7FFfRNnrBEUj
         /pFtS3a8uvOELDElhswdUPrmFfnScr9Q3DXldE0Y62WcypCettcUoOX8LDuap+CWFQ
         dl/NkZ6/RmH2Q==
Date:   Mon, 8 Feb 2021 14:32:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Hector Martin <marcan@marcan.st>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 00/23] arm64: Early CPU feature override, and
 applications to VHE, BTI and PAuth
Message-ID: <20210208143248.GA25934@willie-the-truck>
References: <20210208095732.3267263-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208095732.3267263-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Feb 08, 2021 at 09:57:09AM +0000, Marc Zyngier wrote:
> It recently came to light that there is a need to be able to override
> some CPU features very early on, before the kernel is fully up and
> running. The reasons for this range from specific feature support
> (such as using Protected KVM on VHE HW, which is the main motivation
> for this work) to errata workaround (a feature is broken on a CPU and
> needs to be turned off, or rather not enabled).
> 
> This series tries to offer a limited framework for this kind of
> problems, by allowing a set of options to be passed on the
> command-line and altering the feature set that the cpufeature
> subsystem exposes to the rest of the kernel. Note that this doesn't
> change anything for code that directly uses the CPU ID registers.

I applied this locally, but I'm seeing consistent boot failure under QEMU when
KASAN is enabled. I tried sprinkling some __no_sanitize_address annotations
around (see below) but it didn't help. The culprit appears to be
early_fdt_map(), but looking a bit more closely, I'm really nervous about the
way we call into C functions from __primary_switched. Remember -- this code
runs _twice_ when KASLR is active: before and after the randomization. This
also means that any memory writes the first time around can be lost due to
the D-cache invalidation when (re-)creating the kernel page-tables.

Will

--->8

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index dffb16682330..751ed55261b5 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -195,7 +195,7 @@ static __init void parse_cmdline(void)
 /* Keep checkers quiet */
 void init_feature_override(void);
 
-asmlinkage void __init init_feature_override(void)
+asmlinkage void __init __no_sanitize_address init_feature_override(void)
 {
        int i;
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 61845c0821d9..33581de05d2e 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -170,12 +170,12 @@ static void __init smp_build_mpidr_hash(void)
 
 static void *early_fdt_ptr __initdata;
 
-void __init *get_early_fdt_ptr(void)
+void __init __no_sanitize_address *get_early_fdt_ptr(void)
 {
        return early_fdt_ptr;
 }
 
-asmlinkage void __init early_fdt_map(u64 dt_phys)
+asmlinkage void __init __no_sanitize_address early_fdt_map(u64 dt_phys)
 {
        int fdt_size;
 

