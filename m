Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED930EFB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhBDJa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:30:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233760AbhBDJay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:30:54 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01DA64F48;
        Thu,  4 Feb 2021 09:30:10 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l7axk-00BwvW-Bz; Thu, 04 Feb 2021 09:30:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Feb 2021 09:30:08 +0000
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
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v6 06/21] arm64: Move VHE-specific SPE setup to
 mutate_to_vhe()
In-Reply-To: <20210203211319.GA19694@willie-the-truck>
References: <20210201115637.3123740-1-maz@kernel.org>
 <20210201115637.3123740-7-maz@kernel.org>
 <20210203211319.GA19694@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <a660fd06d43451b4693fbb65f2ee1b56@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2021-02-03 21:13, Will Deacon wrote:
> Hi Marc,
> 
> On Mon, Feb 01, 2021 at 11:56:22AM +0000, Marc Zyngier wrote:
>> There isn't much that a VHE kernel needs on top of whatever has
>> been done for nVHE, so let's move the little we need to the
>> VHE stub (the SPE setup), and drop the init_el2_state macro.
>> 
>> No expected functional change.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Acked-by: David Brazdil <dbrazdil@google.com>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  arch/arm64/kernel/hyp-stub.S | 28 +++++++++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/arm64/kernel/hyp-stub.S 
>> b/arch/arm64/kernel/hyp-stub.S
>> index 373ed2213e1d..6b5c73cf9d52 100644
>> --- a/arch/arm64/kernel/hyp-stub.S
>> +++ b/arch/arm64/kernel/hyp-stub.S
>> @@ -92,9 +92,6 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>>  	msr	hcr_el2, x0
>>  	isb
>> 
>> -	// Doesn't do much on VHE, but still, worth a shot
>> -	init_el2_state vhe
>> -
>>  	// Use the EL1 allocated stack, per-cpu offset
>>  	mrs	x0, sp_el1
>>  	mov	sp, x0
>> @@ -107,6 +104,31 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>>  	mrs_s	x0, SYS_VBAR_EL12
>>  	msr	vbar_el1, x0
>> 
>> +	// Fixup SPE configuration, if supported...
>> +	mrs	x1, id_aa64dfr0_el1
>> +	ubfx	x1, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
>> +	mov	x2, xzr
>> +	cbz	x1, skip_spe
>> +
>> +	// ... and not owned by EL3
>> +	mrs_s	x0, SYS_PMBIDR_EL1
>> +	and	x0, x0, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
>> +	cbnz	x0, skip_spe
>> +
>> +	// Let the SPE driver in control of the sampling
>> +	mrs_s	x0, SYS_PMSCR_EL1
>> +	bic	x0, x0, #(1 << SYS_PMSCR_EL2_PCT_SHIFT)
>> +	bic	x0, x0, #(1 << SYS_PMSCR_EL2_PA_SHIFT)
>> +	msr_s	SYS_PMSCR_EL1, x0
> 
> Why do we need to touch pmscr_el1 at all? The SPE driver should take 
> care of
> that, no? If you drop the pmscr_el1 accesses, I think you can drop the
> pmbidr_el1 check as well.

That's definitely a brain fart, and is what we need on the nVHE path,
not here. Doing the same thing twice isn't exactly helpful.

> And actually, then why even check dfr0? Doing the
> bic for the mdcr_el1.e2pb bits is harmless.
> 
>> +	mov	x2, #MDCR_EL2_TPMS
>> +
>> +skip_spe:
>> +	// For VHE, use EL2 translation and disable access from EL1
>> +	mrs	x0, mdcr_el2
>> +	bic	x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
>> +	orr	x0, x0, x2
>> +	msr	mdcr_el2, x0
> 
> Doesn't this undo the setting of mdcr_el2.hpmn if SPE is not present or
> unavailable? (This wouldn't be an issue if we removed the skip_spe 
> paths
> altogether).

I don't think it does. We only clear the E2PB bits (harmless, as you 
point
out above), and OR something that is either 0 (no SPE) or MDCR_EL2_TPMS.
In any case, the HPMN bits are preserved (having been set during the 
nVHE
setup).

I think the following patch addresses the above issue, which I'll squash
with the original patch. Please shout if I missed anything.

Thanks,

         M.

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index aa7e8d592295..3e08dcc924b5 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -115,29 +115,9 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
  	mrs_s	x0, SYS_VBAR_EL12
  	msr	vbar_el1, x0

-	// Fixup SPE configuration, if supported...
-	mrs	x1, id_aa64dfr0_el1
-	ubfx	x1, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
-	mov	x2, xzr
-	cbz	x1, skip_spe
-
-	// ... and not owned by EL3
-	mrs_s	x0, SYS_PMBIDR_EL1
-	and	x0, x0, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
-	cbnz	x0, skip_spe
-
-	// Let the SPE driver in control of the sampling
-	mrs_s	x0, SYS_PMSCR_EL1
-	bic	x0, x0, #(1 << SYS_PMSCR_EL2_PCT_SHIFT)
-	bic	x0, x0, #(1 << SYS_PMSCR_EL2_PA_SHIFT)
-	msr_s	SYS_PMSCR_EL1, x0
-	mov	x2, #MDCR_EL2_TPMS
-
-skip_spe:
-	// For VHE, use EL2 translation and disable access from EL1
+	// Use EL2 translations for SPE and disable access from EL1
  	mrs	x0, mdcr_el2
  	bic	x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
-	orr	x0, x0, x2
  	msr	mdcr_el2, x0

  	// Transfer the MM state from EL1 to EL2

-- 
Jazz is not dead. It just smells funny...
