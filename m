Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34403EAA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhHLTDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234302AbhHLTC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:02:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E862A6108C;
        Thu, 12 Aug 2021 19:02:33 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mEFyJ-004c9r-W0; Thu, 12 Aug 2021 20:02:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
Subject: [PATCH 0/5] arm64: Survival kit for SCR_EL3.HCE==0 conditions
Date:   Thu, 12 Aug 2021 20:02:08 +0100
Message-Id: <20210812190213.2601506-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, zajec5@gmail.com, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, ardb@kernel.org, f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone vaguely familiar with the ARMv8 architecture would quickly
understand that entering the kernel at EL2 without enabling the HVC
instruction is... living dangerously. But as it turns out [0], there
is a whole range of (*cough*) "high quality" (*cough*) Broadcom
systems out there configured exactly like that.

If you are speechless, I'm right with you.

These machines have stopped being able to boot an upstream kernel
since 5.12, where we changed the way we switch from nVHE to VHE, as
this relies on the HVC instruction being usable... It is also worth
noting that these systems have never been able to use KVM. Or kexec.

This small series addresses the issue by detecting an UNDEFing HVC in
a fairly controlled environment, and in this case pretend that we have
booted at EL1. It also documents the requirement for SCR_EL3.HCE to be
set to *1* if the kernel is entered at EL2. Turns out that we really
have to state the obvious.

This has been tested on a FVP model with a hacked-up boot-wrapper.

Note that I really don't think any of this is -stable material, except
maybe for the documentation. It isn't 5.14 material either. Best case,
this is 5.15, or maybe even later. If ever.

	M. (drink required)

[0] https://lore.kernel.org/r/53f3a2d2-22f8-edee-2507-d41a4090dad7@gmail.com

Marc Zyngier (5):
  arm64: Directly expand __init_el2_nvhe_prepare_eret where needed
  arm64: Handle UNDEF in the EL2 stub vectors
  arm64: Detect disabled HVC early
  arm64: Warn on booting at EL2 with HVC disabled
  arm64: Document the requirement for SCR_EL3.HCE

 Documentation/arm64/booting.rst    |  5 +++++
 arch/arm64/include/asm/el2_setup.h |  6 ------
 arch/arm64/include/asm/virt.h      | 10 +++++++++
 arch/arm64/kernel/head.S           | 34 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       | 19 ++++++++++++++++-
 arch/arm64/kernel/smp.c            |  3 +++
 6 files changed, 70 insertions(+), 7 deletions(-)

-- 
2.30.2

