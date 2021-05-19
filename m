Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5393338987C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhESVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:20:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:46576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhESVUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:20:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB8C0B1F6;
        Wed, 19 May 2021 21:18:54 +0000 (UTC)
Date:   Wed, 19 May 2021 23:18:47 +0200
From:   Borislav Petkov <bp@suse.de>
To:     James Feeney <james@nurealm.net>
Cc:     linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux 5.12 - fails to boot - soft lockup - CPU#0 stuck for 23s!
 - RIP smp_call_function_single
Message-ID: <YKWAt1zLM2vfv4Sp@zn.tnic>
References: <8a9599b2-f4fe-af9b-90f5-af39c315ec2f@nurealm.net>
 <YKIqDdFNaXYd39wz@zn.tnic>
 <1876afbe-a167-2be5-3690-846700eeb76c@nurealm.net>
 <YKTygvN0QNlExEQP@zn.tnic>
 <984ee4ab-6e6b-cb0e-a4f1-ce2951994b1d@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <984ee4ab-6e6b-cb0e-a4f1-ce2951994b1d@nurealm.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 02:03:05PM -0600, James Feeney wrote:
> I had to ask, and got this answer:
> 
> ====
> The sources contain commits on top of upstream releases. This is why the tags contain -arch1 etc. For example, see https://git.archlinux.org/linux.git/log/?h=v5.11.16-arch1 , which adds 6 commits on top of the upstream "Linux 5.11.16" release, while https://git.archlinux.org/linux.git/log/?h=v5.12-arch1 only contains the long-standing "unprivileged_userns_clone" patch and the version number change, making it essentially vanilla.
> ====
> 
> There are no additional kernel patches in the build.

Yeah, ok, let's say you're running pretty much an upstream kernel.

> These boots are consecutive and are all from the same stock 5.12.0 kernel.

Yeah, that's weird. Box seems to boot fine in some cases. There's

[   26.864040] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[   26.874541] ACPI: OSL: Resource conflict: System may be unstable or behave erratically

Dunno how relevant this is - it probably has been the case since forever. 

> $ make menuconfig
> ...
> 
> This config option is not listed and is not changeable:

Bah, sorry about that. Use this small hunk ontop so that you can disable
it in menuconfig:

---
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index ce4f59213c7a..8c1376a20b54 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -9,7 +9,8 @@ config INTEL_POWERCLAMP
 	  user interface is exposed via generic thermal framework.
 
 config X86_THERMAL_VECTOR
-	def_bool y
+	tristate "X86 thermal vector"
+	default y
 	depends on X86 && CPU_SUP_INTEL && X86_LOCAL_APIC
 
 config X86_PKG_TEMP_THERMAL
---

and with it ontop, boot it the aforementioned way.

And then pls build 5.11 which doesn't have the therm_throt patch - I'd
like to see if that therm_throt thing is even loading. Because I don't
see something like:

[    0.302411] mce: CPU0: Thermal monitoring enabled (TM2)

in your dmesg. Could be some detection failure due to the change when
those happen. Althouth they shouldn't but who knows.

I have a similar box as yours:

[    0.305858] smpboot: CPU0: Intel(R) Pentium(R) Dual  CPU  E2180  @ 2.00GHz (family: 0x6, model: 0xf, stepping: 0xd)

a bit newer stepping and AFAIR, it boots fine but I'll try your .config
there to check just in case.

Thx.


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
