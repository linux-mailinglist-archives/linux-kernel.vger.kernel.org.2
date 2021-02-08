Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B56313DB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhBHSig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:38:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234422AbhBHQbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:31:35 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBC264E8C;
        Mon,  8 Feb 2021 16:30:53 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l99R4-00CpnW-SH; Mon, 08 Feb 2021 16:30:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Feb 2021 16:30:50 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
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
In-Reply-To: <20210208143248.GA25934@willie-the-truck>
References: <20210208095732.3267263-1-maz@kernel.org>
 <20210208143248.GA25934@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <e4969ab634754a927f812788b2b2f082@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, marcan@marcan.st, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-08 14:32, Will Deacon wrote:
> Hi Marc,
> 
> On Mon, Feb 08, 2021 at 09:57:09AM +0000, Marc Zyngier wrote:
>> It recently came to light that there is a need to be able to override
>> some CPU features very early on, before the kernel is fully up and
>> running. The reasons for this range from specific feature support
>> (such as using Protected KVM on VHE HW, which is the main motivation
>> for this work) to errata workaround (a feature is broken on a CPU and
>> needs to be turned off, or rather not enabled).
>> 
>> This series tries to offer a limited framework for this kind of
>> problems, by allowing a set of options to be passed on the
>> command-line and altering the feature set that the cpufeature
>> subsystem exposes to the rest of the kernel. Note that this doesn't
>> change anything for code that directly uses the CPU ID registers.
> 
> I applied this locally, but I'm seeing consistent boot failure under 
> QEMU when
> KASAN is enabled. I tried sprinkling some __no_sanitize_address 
> annotations
> around (see below) but it didn't help. The culprit appears to be
> early_fdt_map(), but looking a bit more closely, I'm really nervous 
> about the
> way we call into C functions from __primary_switched. Remember -- this 
> code
> runs _twice_ when KASLR is active: before and after the randomization. 
> This
> also means that any memory writes the first time around can be lost due 
> to
> the D-cache invalidation when (re-)creating the kernel page-tables.

Nailed it. Of course, before anything starts writing from C code, we 
need
to have initialised KASAN. kasan_init.c itself is compiled without any
address sanitising, but we can't repaint all the stuff that is called
from early_fdt_map() (quite a lot).

So the natural thing to do is to keep kasan_early_init() as the first
thing we do in C code, and everything falls from that.

Any chance you could try that on top and see if that cures your problem?
If that works for you, I'll push an updates series.

Thanks,

         M.

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index bce66d6bda74..09a5b603c950 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -429,13 +429,13 @@ SYM_FUNC_START_LOCAL(__primary_switched)
  	bl	__pi_memset
  	dsb	ishst				// Make zero page visible to PTW

+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+	bl	kasan_early_init
+#endif
  	mov	x0, x21				// pass FDT address in x0
  	bl	early_fdt_map			// Try mapping the FDT early
  	bl	init_feature_override
  	bl	switch_to_vhe
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
-	bl	kasan_early_init
-#endif
  #ifdef CONFIG_RANDOMIZE_BASE
  	tst	x23, ~(MIN_KIMG_ALIGN - 1)	// already running randomized?
  	b.ne	0f

-- 
Jazz is not dead. It just smells funny...
