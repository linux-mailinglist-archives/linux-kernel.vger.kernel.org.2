Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9779B35A73C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhDITjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhDITjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:39:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6614FC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 12:39:31 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0be100a8e90a67ff2fdfe0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:e100:a8e9:a67:ff2f:dfe0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91BC91EC04A9;
        Fri,  9 Apr 2021 21:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617997169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=piAEnbi9i8uJD27RCRs0AnB3SDzJBLyh+CujT1uDyxc=;
        b=iM5/UlyjnK1s2Wi9+Zn2HGYWIsVl2sz6F7Iy/aXBvySBb9iaxeI0XeESG62GvK2SIRoFGN
        CSIR/DgZjVxLdgoC86jjO314kF9WLIhaeVD7EF8iD4hY7H+TzC98VtgBzmTRrAfU5FKtll
        WReREubbxu9vMyXjIA/qEvTyM21+SJ0=
Date:   Fri, 9 Apr 2021 21:39:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Saripalli, RK" <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/5] x86/cpufeatures: Define feature bits to support
 mitigation of PSF
Message-ID: <20210409193929.GI15567@zn.tnic>
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210406155004.230790-2-rsaripal@amd.com>
 <20210409174134.GH15567@zn.tnic>
 <cc5476c9-fe4e-6b4c-d323-37b90237b32b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc5476c9-fe4e-6b4c-d323-37b90237b32b@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 01:22:49PM -0500, Saripalli, RK wrote:
> > And I think you don't need this one either if we do a "light" controls
> > thing but lemme look at the rest first.

Ok, and what I mean with "lite" version is something like this below
which needs finishing and testing.

Initially, it could support the cmdline params:

predict_store_fwd={on,off,auto}

to give people the opportunity to experiment with the feature.

If it turns out that prctl and seccomp per-task toggling is needed then
sure, we can extend but I don't see the reason for a whole separate set
of options yet. Especially is ssbd already controls this.

AFAICT, of course and if I'm not missing some other aspect here.

Thx.

---
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2d11384dc9ab..226b73700f88 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1165,3 +1165,22 @@ void set_dr_addr_mask(unsigned long mask, int dr)
 		break;
 	}
 }
+
+static int __init psf_cmdline(char *str)
+{
+	if (!boot_cpu_has(X86_FEATURE_PSFD))
+		return 0;
+
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off")) {
+		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
+		setup_clear_cpu_cap(X86_FEATURE_PSFD);
+	}
+
+	return 0;
+}
+early_param("predict_store_fwd", psf_cmdline);
+
+

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
