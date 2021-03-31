Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DC834F847
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 07:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhCaFal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 01:30:41 -0400
Received: from zinan.dashjr.org ([192.3.11.21]:43992 "EHLO zinan.dashjr.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhCaFaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 01:30:11 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2021 01:30:11 EDT
Received: from ishibashi.lan (unknown [12.190.236.208])
        (Authenticated sender: luke-jr)
        by zinan.dashjr.org (Postfix) with ESMTPSA id 1C9E238A00BD;
        Wed, 31 Mar 2021 05:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dashjr.org; s=zinan;
        t=1617168003; bh=odLfxRSk012Q4ss7k6SdPrlnMY8Ly0GWSjqsUm/HXEg=;
        h=From:To:Subject:Date;
        b=pyI3gUUD3nyZz8z6cbuXpAlIYbTd3Hl+RlTwYwjYpceVR5jMghxUM5kmizp13r70f
         X6ol980htTqSwb/M2EknLZhuPtgR3p1S3H3rz96ODy1iOXiFgt1EiW48P+QDVexeou
         66wn0HRjGgQFoJyWXW3AXH30BxT7jxP4ZEasDmEY=
X-Hashcash: 1:25:210331:linux-kernel@vger.kernel.org::X/DK8+IXvmGG5+m8:arMxX
X-Hashcash: 1:25:210331:trivial@kernel.org::QPL9MVPaBAbWM0g0:aJzzp
X-Hashcash: 1:25:210331:x86@kernel.org::sqvjGCpKHMp4MXe=:cke1d
X-Hashcash: 1:25:210331:tglx@linutronix.de::IXst3dn5gGjd5VYQ:a/CKK
X-Hashcash: 1:25:210331:mingo@redhat.com::dAE3bLo1JU7NEO1C:VPo9
X-Hashcash: 1:25:210331:bp@alien8.de::mhs+SEPD8UTDXU55:256O
From:   Luke Dashjr <luke@dashjr.org>
To:     linux-kernel@vger.kernel.org, trivial@kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] arch/x86: Encourage rather than discourage x2apic support
Date:   Wed, 31 Mar 2021 05:16:41 +0000
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202103310516.42497.luke@dashjr.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-core SMP doesn't work on modern Intel CPUs (at least Comet Lake) without
x2apic. Unsure users should say Y.
    
Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398ee..ddb42707bd069 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -446,9 +446,10 @@ config X86_X2APIC
          This enables x2apic support on CPUs that have this feature.
 
          This allows 32-bit apic IDs (so it can support very large systems),
-         and accesses the local apic via MSRs not via mmio.
+         and accesses the local apic via MSRs not via mmio. It is also needed
+         to use multiple cores on modern Intel CPUs.
 
-         If you don't know what to do here, say N.
+         If you don't know what to do here, say Y.
 
 config X86_MPPARSE
        bool "Enable MPS table" if ACPI
--
2.6.23
