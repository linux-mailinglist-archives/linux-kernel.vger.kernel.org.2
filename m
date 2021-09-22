Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CCA41489F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbhIVMSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhIVMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:18:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F60EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:17:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC1621EC051F;
        Wed, 22 Sep 2021 14:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632313014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bPqfYE8RZbJ72xbl93j2JzQG8AN+hGnfzeqayWkvLAI=;
        b=ToL9LnoF9tRMccxG9lT5nbKCHTUScOQiLGYu2ML6Aq22WQDNACTAvt15Wf8Pcz4CKHAAiN
        AuxARku8myqmhQFgoovqoE3nLrS47qHP1HwyVGEgMA6pxVEzuC3m7hcldtnOGQAPt1k+Ks
        WnkMAlR9bOOHEXgmb21JJ3qxMRqjJYY=
Date:   Wed, 22 Sep 2021 14:16:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/mce: Get rid of msr_ops
Message-ID: <YUsesVeZ8PPC5iV5@zn.tnic>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-4-bp@alien8.de>
 <YUgSd6Sl/bFaGydO@agluck-desk2.amr.corp.intel.com>
 <YUhHC7SJ+/xTnuI4@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUhHC7SJ+/xTnuI4@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:32:11AM +0200, Borislav Petkov wrote:
> but please don't make me add more helper functions. Those MSR defines
> already have "SMCA" and "IA32" in their names so that should be a good
> enough differentiation, I'd say.

I just had a better idea - it is compact but regular and one can see at
a quick glance which block is for which set of MSRs:

u32 mca_msr_reg(int bank, enum mca_msr reg)
{
        if (mce_flags.smca) {
                switch (reg) {
                case MCA_CTL:    return MSR_AMD64_SMCA_MCx_CTL(bank);    break;
                case MCA_ADDR:   return MSR_AMD64_SMCA_MCx_ADDR(bank);   break;
                case MCA_MISC:   return MSR_AMD64_SMCA_MCx_MISC(bank);   break;
                case MCA_STATUS: return MSR_AMD64_SMCA_MCx_STATUS(bank); break;
                default: goto out; break;
                }
        }

        switch (reg) {
        case MCA_CTL:    return MSR_IA32_MCx_CTL(bank);    break;
        case MCA_ADDR:   return MSR_IA32_MCx_ADDR(bank);   break;
        case MCA_MISC:   return MSR_IA32_MCx_MISC(bank);   break;
        case MCA_STATUS: return MSR_IA32_MCx_STATUS(bank); break;
        default: goto out; break;
        }

out:
        WARN_ON_ONCE(1);
        return 0;
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
