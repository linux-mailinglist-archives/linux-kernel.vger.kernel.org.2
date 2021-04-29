Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C636ECED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbhD2PDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhD2PD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:03:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9489C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:02:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a4f00261a50588b71a803.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4f00:261a:5058:8b71:a803])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7AE3A1EC0118;
        Thu, 29 Apr 2021 17:02:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619708559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NOcatuN4XreT3yxQdVGVFIBdjt3FM9ZXlUyEyrjCkL0=;
        b=p3HwlQM0uLzkbBakEdfPdwqwK7+vAN+eKFN9wBgM5t5D1NYu06/eYGPyEKUeX+PvmodNYg
        Q4sAq3+u/gRunLxS+pG4bqq4IQVsBZaqO7gkwh1Z0i7+KZ8dfprfbFHOyFCbjWEzwHouge
        XIRdFDtDl/Udk+dUPr74Tv7m0z+bDf0=
Date:   Thu, 29 Apr 2021 17:02:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Saripalli, RK" <rsaripal@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Reiji Watanabe <reijiw@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com
Subject: Re: [v3 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
Message-ID: <YIrKkqmXlK36E2lN@zn.tnic>
References: <20210428160349.158774-1-rsaripal@amd.com>
 <20210428160349.158774-2-rsaripal@amd.com>
 <CAAeT=FyqjYqcUBRtvCiHv5sUN34kdi7kTfbfUfHZ6jR0tve+Og@mail.gmail.com>
 <84eddb82-7626-c1e0-78b3-a92b5039e011@amd.com>
 <238f41fd-2f7b-cfa0-b538-2a659c38c7e3@amd.com>
 <75258a4d-131d-766a-b20c-b3cc5ee65817@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75258a4d-131d-766a-b20c-b3cc5ee65817@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 09:32:35AM -0500, Saripalli, RK wrote:
> Yes, I agree with his analysis and fixing it.

So you can do this and correct the comment above it to explain why
you're doing the "tmp" thing.

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..536136e0daa3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -78,6 +78,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
 
 void __init check_bugs(void)
 {
+	u64 tmp = 0;
+
 	identify_boot_cpu();
 
 	/*
@@ -97,7 +99,9 @@ void __init check_bugs(void)
 	 * init code as it is not enumerated and depends on the family.
 	 */
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+
+	x86_spec_ctrl_base |= tmp;
 
 	/* Allow STIBP in MSR_SPEC_CTRL if supported */
 	if (boot_cpu_has(X86_FEATURE_STIBP))

---

and as Tom correctly suggests, set X86_FEATURE_MSR_SPEC_CTRL in
psf_cmdline() so that the above loading of the base value works.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
