Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9516C30EDB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhBDHto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:49:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhBDHtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:49:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FC4264F4E;
        Thu,  4 Feb 2021 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612424942;
        bh=K1NMfN2cnYO6F2v6C6+STdJSSTVIhJNptvnW5Dfax54=;
        h=From:To:Cc:Subject:Date:From;
        b=a3Q6vYUmgP+3ds+v5YpJfvIgQgZedL8kEsC1x0fj1XQzVU91ga+eBlATgsqeudj3n
         SW6sxUen1D1QvzxGnCowneAfBBSBR3fFcX95+10ELOpv3dbMR4SLNyCb4LenkbZVHR
         i6sdENHW7AUEXOHMK2+Ni/XopmmoLgeeM3bh7Ay2NJ4bshVvW/2Uj/J8vVjxz9dqIn
         IBnxKPaRUoISgNfPTDQ+POGEJ+qsxqQ3dM8y0QcPEZ7OAo5znCsmqrY2TwkwXidFtW
         o4HBrYprG2Cr6AB+eCpQGIVIqgH/uAF7tGSFQ3b+dEcFGPSc+VpdO7bwdNBF/SQqJS
         FHYOM7kKph5Jg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 1/2] drivers/irqchip: Fixup csky,mpintc compile error with CPU_CK610
Date:   Thu,  4 Feb 2021 15:46:08 +0800
Message-Id: <20210204074609.3553018-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The irq-csky-mpintc.c only could support CPU_CK860 and it will
compile error with CPU_CK610.

It has beed selected in arch/csky/Kconfig

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---
v2: Drop the string after bool,
    as suggested by Marc Zyngier <maz@kernel.org>

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b147f22a78f4..53abecb8c792 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -432,7 +432,7 @@ config QCOM_PDC
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
 config CSKY_MPINTC
-	bool "C-SKY Multi Processor Interrupt Controller"
+	bool
 	depends on CSKY
 	help
 	  Say yes here to enable C-SKY SMP interrupt controller driver used
-- 
2.17.1

