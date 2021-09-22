Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF1414D97
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhIVP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbhIVP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:59:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D73EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:58:04 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB9641EC051E;
        Wed, 22 Sep 2021 17:57:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632326278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ry9Z69LQArNbVtPmCuRDweOphdtc94L4dVIHpBekN7c=;
        b=NCb5G93fgk04Z2kWoYDwBQTP8e5F9qd58TBdUrkNmhNrC8qdF/up7c028VJBvnwal9xUYX
        Dv0ZbbDkFXiAgYsniyNqarrANQJUFV27++v1GQELTaOcVS5SiGraygAkQnkgP03prqJgCf
        VbqJxEOAIpJPHVvZCmLnEFCJ2nW3U1I=
Date:   Wed, 22 Sep 2021 17:57:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/mce: Get rid of msr_ops
Message-ID: <YUtSgEa8O5vyALSj@zn.tnic>
References: <YUsesVeZ8PPC5iV5@zn.tnic>
 <2B1FFC77-A740-41AE-BF8C-FB238B9DF7F5@intel.com>
 <YUs1vu7lxevL1EpO@zn.tnic>
 <f73c2f6790d6428393348869bc7c7e73@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f73c2f6790d6428393348869bc7c7e73@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 03:22:01PM +0000, Luck, Tony wrote:
> Also:
> 
> 	switch (enum) {
> 	actions for every value of that enum
> 	}
> 
> doesn't need a default: option

Right, my thought was to catch silly stuff like this here:

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b355ce737543..dfecf65e5407 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1714,6 +1714,7 @@ static void __mcheck_cpu_init_clear_banks(void)
 			continue;
 		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
 		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+		wrmsrl(mca_msr_reg(i, 12), 0);
 	}
 }
 

but we already warn nicely there:

[    0.146457] unchecked MSR access error: WRMSR to 0x0 (tried to write 0x0000000000000000) at rIP: 0xffffffff8103234b (__mcheck_cpu_init_clear_banks+0x6b/0xe0)
[    0.147550] Call Trace:
[    0.147836]  mcheck_cpu_init+0x16c/0x4a0
[    0.148234]  identify_cpu+0x3fe/0x670
[    0.148607]  identify_boot_cpu+0xc/0x94
[    0.148995]  check_bugs+0x26/0xaef
[    0.149353]  ? __get_locked_pte+0x14a/0x200
[    0.149777]  start_kernel+0x602/0x621
[    0.150153]  secondary_startup_64_no_verify+0xb0/0xbb

and the mce_rd/wrmsrl() wrappers even panic.

So default case gone.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
