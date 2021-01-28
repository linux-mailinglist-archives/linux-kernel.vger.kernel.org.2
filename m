Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F4E307321
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhA1Jsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232085AbhA1JrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:47:02 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D853664DD1;
        Thu, 28 Jan 2021 09:46:21 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l53sZ-00Aa8x-JG; Thu, 28 Jan 2021 09:46:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 28 Jan 2021 09:46:19 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V3 10/14] arm64: nvhe: Allow TRBE access at EL1
In-Reply-To: <d0daf831-3340-87f2-a021-0b775ce7af2a@arm.com>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-11-git-send-email-anshuman.khandual@arm.com>
 <12b1572e2568d4936f0458649065fe64@kernel.org>
 <d0daf831-3340-87f2-a021-0b775ce7af2a@arm.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <05c4cde3da791e7effd6196a197f5c98@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, mathieu.poirier@linaro.org, mike.leach@linaro.org, lcherian@marvell.com, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28 09:34, Suzuki K Poulose wrote:
> On 1/27/21 9:58 AM, Marc Zyngier wrote:
>> On 2021-01-27 08:55, Anshuman Khandual wrote:
>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> 
>>> When the kernel is booted at EL2 in a nvhe configuration,
>>> enable the TRBE access to the EL1. The EL1 still can't trace
>>> EL2, unless EL2 permits explicitly via TRFCR_EL2.E2TRE.
>>> 
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> 
>> Acked-by: Marc Zyngier <maz@kernel.org>
>> 
>> One comment below, though:
>> 
>>> ---
>>>  arch/arm64/include/asm/el2_setup.h | 19 +++++++++++++++++++
>>>  arch/arm64/include/asm/kvm_arm.h   |  2 ++
>>>  2 files changed, 21 insertions(+)
>>> 
>>> diff --git a/arch/arm64/include/asm/el2_setup.h
>>> b/arch/arm64/include/asm/el2_setup.h
>>> index a7f5a1b..05ecce9 100644
>>> --- a/arch/arm64/include/asm/el2_setup.h
>>> +++ b/arch/arm64/include/asm/el2_setup.h
>>> @@ -72,6 +72,25 @@
>>>  .endif
>>> 
>>>  3:
>>> +
>>> +.ifeqs    "\mode", "nvhe"
>>> +    /*
>>> +     * If the Trace Buffer is available, allow
>>> +     * the EL1 to own it. Note that EL1 cannot
>>> +     * trace the EL2, as it is prevented by
>>> +     * TRFCR_EL2.E2TRE == 0.
>>> +     */
>>> +    ubfx    x0, x1, #ID_AA64DFR0_TRBE_SHIFT, #4
>>> +    cbz    x0, 1f
>>> +
>>> +    mrs_s    x0, SYS_TRBIDR_EL1
>>> +    and    x0, x0, TRBIDR_PROG
>>> +    cbnz    x0, 1f
>>> +    mov    x0, #(MDCR_EL2_E2TB_EL1_OWN << MDCR_EL2_E2TB_SHIFT)
>>> +    orr    x2, x2, x0
>>> +.endif
>>> +
>>> +1:
>> 
>> Note that this will (badly) conflict with the late-VHE patches[1],
>> where this code path has been reworked.
> 
> Thanks for the heads up. We will need to see how things get merged.
> Ideally this patch and the previous one (TRBE definitions could go
> via the arm64 tree / kvm tree), in which case we could rebase these
> two patches on the respective tree.

I think the current plan of action is to go via the arm64 tree,
given that there is nothing really KVM specific there. I'll respin
the series one last (hopefully!) time on Monday. Let me know if
you need a hand with the rebasing.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
