Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9442938E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbhJKPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:39:13 -0400
Received: from foss.arm.com ([217.140.110.172]:34614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243263AbhJKPjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:39:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6DB9101E;
        Mon, 11 Oct 2021 08:37:08 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E367F3F694;
        Mon, 11 Oct 2021 08:37:06 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Documentation: admin-guide: Document side effects when pKVM is enabled
Date:   Mon, 11 Oct 2021 16:38:35 +0100
Message-Id: <20211011153835.291147-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to KVM for arm64 has made it impossible for the host to
hibernate or use kexec when protected mode is enabled via the kernel
command line.

There are people who rely on kexec (for example, developers who use kexec
as a quick way to test a new kernel), let's document this change in
behaviour, so it doesn't catch them by surprise and we have a place to
point people to if it does.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
Based on the tip of the pkvm/restrict-hypercalls series [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/pkvm/restrict-hypercalls

 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..741e33fd444a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2372,7 +2372,9 @@
 				   state is kept private from the host.
 				   Not valid if the kernel is running in EL2.
 
-			Defaults to VHE/nVHE based on hardware support.
+			Defaults to VHE/nVHE based on hardware support. Setting
+			mode to "protected" will disable kexec and hibernation
+			for the host.
 
 	kvm-arm.vgic_v3_group0_trap=
 			[KVM,ARM] Trap guest accesses to GICv3 group-0
-- 
2.33.0

