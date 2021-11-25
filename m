Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C2245D827
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348803AbhKYKYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:24:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60562 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354630AbhKYKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:22:45 -0500
X-UUID: 26fc32c3237e44a29d9bf0d5a4d95a41-20211125
X-UUID: 26fc32c3237e44a29d9bf0d5a4d95a41-20211125
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2036478998; Thu, 25 Nov 2021 18:19:31 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Nov 2021 18:19:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Nov
 2021 18:19:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Nov 2021 18:19:29 +0800
Message-ID: <e055e71f0ca7bcb351b9097ba8f8f4a9d324623c.camel@mediatek.com>
Subject: Re: [PATCH v3 1/1] arm64/cpufeature: Optionally disable MTE via
 command-line
From:   Yee Lee <yee.lee@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <nicholas.Tang@mediatek.com>,
        <Kuan-Ying.lee@mediatek.com>, <chinwen.chang@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 25 Nov 2021 18:19:29 +0800
In-Reply-To: <20210802153036.GH18685@arm.com>
References: <20210730144957.30938-1-yee.lee@mediatek.com>
         <20210730144957.30938-2-yee.lee@mediatek.com>
         <20210802153036.GH18685@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-02 at 16:30 +0100, Catalin Marinas wrote:
> On Fri, Jul 30, 2021 at 10:49:53PM +0800, yee.lee@mediatek.com wrote:
> > From: Yee Lee <yee.lee@mediatek.com>
> > 
> > For some low-end devices with limited resources,
> > MTE needs to be optionally disabled to save system
> > costs such as tag memory and firmware controls.
> 
> I understand the cost of using MTE but I don't fully get what you
> mean
> by firmware controls. If the ID_AA64PFR1_EL1.MTE reports that MTE is
> present, the firmware should have initialised MTE correctly (e.g. tag
> allocation storage, SCR_EL3.ATA) and not rely on a kernel command
> line
> argument that may or may not be present.
> 
> > This allows ID_AA64PFR1_EL1.MTE to be overridden on 
> > its shadow value by giving "arm64.nomte" on cmdline,
> > and to suppress MTE feature.
> > 
> > Suggested-by: Marc Zyngier <maz@kernel.org>
> > Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> 
> While this patch appears to disable MTE, I don't think it can fully
> prevent the access to the allocation tag storage, so the firmware
> must
> still initialise it correctly.
> 
> The issue is that __cpu_setup already configures the MAIR_EL1
> register
> to use Normal Tagged memory for the kernel mapping and SCTLR_EL1.ATA
> is
> set. The TCF field is zero, so no tag checking, but I couldn't figure
> out from the ARM ARM whether this also prevents LDR/STR from
> attempting
> to fetch the allocation tags. I think it's only the ATA bit and the
> MAIR
> configuration.
> 
> With this patch, KASAN_HW_TAGS (if configured) won't be used and MTE
> will not be presented to user applications, if that's what you want,
> but
> does not fully disable MTE.
> 

As pointed out earlier, the hardware has been verified that still has
transaction sending to DRAM due to mair_el1(Normal_tagged) is
setup.  That means the override in this patch would be incompleted and
cannot achieve to avoid undesired hardware confliction by disabling
MTE.

Do we have other options to delay the configuration on MAIR_EL1 after
the override? Or maybe another CONFIG to bypass the init in
__cpu_setup?


> Since May this year, the ARM ARM was updated so that
> SCTLR_EL1.ATA/ATA0
> are not permitted to be cached in the TLB. We could therefore move
> the
> setting to cpu_enable_mte(). Something like below, untested (to be
> folded into your patch):
> 
> diff --git a/arch/arm64/include/asm/sysreg.h
> b/arch/arm64/include/asm/sysreg.h
> index aa53954c2f6b..cac23455a2b5 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -698,8 +698,7 @@
>  	(SCTLR_ELx_M    | SCTLR_ELx_C    | SCTLR_ELx_SA   |
> SCTLR_EL1_SA0   | \
>  	 SCTLR_EL1_SED  | SCTLR_ELx_I    | SCTLR_EL1_DZE  |
> SCTLR_EL1_UCT   | \
>  	 SCTLR_EL1_NTWE | SCTLR_ELx_IESB | SCTLR_EL1_SPAN |
> SCTLR_ELx_ITFSB | \
> -	 SCTLR_ELx_ATA  | SCTLR_EL1_ATA0 | ENDIAN_SET_EL1 |
> SCTLR_EL1_UCI   | \
> -	 SCTLR_EL1_EPAN | SCTLR_EL1_RES1)
> +	 ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_EPAN |
> SCTLR_EL1_RES1)
> 
>  /* MAIR_ELx memory attributes (used by Linux) */
>  #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
> diff --git a/arch/arm64/kernel/cpufeature.c
> b/arch/arm64/kernel/cpufeature.c
> index 9035c367d08b..23b1e3d83603 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1841,6 +1841,9 @@ static void bti_enable(const struct
> arm64_cpu_capabilities *__unused)
>  #ifdef CONFIG_ARM64_MTE
>  static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  {
> +	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
> +	isb();
> +
>  	/*
>  	 * Clear the tags in the zero page. This needs to be done via
> the
>  	 * linear map which has the Tagged attribute.
> 

