Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D473EAA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhHLTDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235117AbhHLTDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:03:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EAE76109D;
        Thu, 12 Aug 2021 19:02:35 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mEFyL-004c9r-FF; Thu, 12 Aug 2021 20:02:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
Subject: [PATCH 5/5] arm64: Document the requirement for SCR_EL3.HCE
Date:   Thu, 12 Aug 2021 20:02:13 +0100
Message-Id: <20210812190213.2601506-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812190213.2601506-1-maz@kernel.org>
References: <20210812190213.2601506-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, zajec5@gmail.com, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, ardb@kernel.org, f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is amazing that we never documented this absolutely basic
requirement: if you boot the kernel at EL2, you'd better
enable the HVC instruction from EL3.

Really, just do it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/arm64/booting.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index a9192e7a231b..6c729d0c4bc2 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -212,6 +212,11 @@ Before jumping into the kernel, the following conditions must be met:
   - The value of SCR_EL3.FIQ must be the same as the one present at boot
     time whenever the kernel is executing.
 
+  For all systems:
+  - If EL3 is present and the kernel is entered at EL2:
+
+    - SCR_EL3.HCE (bit 8) must be initialised to 0b1.
+
   For systems with a GICv3 interrupt controller to be used in v3 mode:
   - If EL3 is present:
 
-- 
2.30.2

