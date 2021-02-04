Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6130F739
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbhBDQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:06:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbhBDQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:03:35 -0500
Date:   Thu, 04 Feb 2021 16:02:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612454572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utJFnViUtphxe/0J/TXjet7hM9bAesS5e5J+h0aTZ+g=;
        b=ExqUX8mMTBO+aHe3/zAHC4zaMV+cOv+lDPcN12xBkHlyX8q5xTBnBu4iJShKx3wrncIrMn
        rlf5zE8ban8ttkDFKWWUDU32PPRktPbhqSD4Qd4awKrzSa+ntRctUKeWp8++VOjnkGMJk5
        p6hjRXCbUrY5JdcOxRlPB5XlxH2ZpuQ8RVI7WaxtqJaQ4ySlmPqKRWmZc1futQUERYvnuX
        ZSCwNxcOft0AymlGwhuxS7sHZb1UZ3VxJ8WritXXXsHUYRThmgbvjUx8SH80kgYClj3L7J
        GB8M/Z3cgD8lUWeZRode5TOrOE9V+orkqkL+ejkcMoi1nljBrQXddD8IxXE1HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612454572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utJFnViUtphxe/0J/TXjet7hM9bAesS5e5J+h0aTZ+g=;
        b=/wRXdEtothNXvPI4/zYrfew/1DBGavp0z319CngL0aAGfgHSjbk7VHQr/LhljkpQFiz3Ox
        9WeqSPvY6QXqIECw==
From:   "irqchip-bot for Guo Ren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/csky-mpintc: Prevent selection on
 unsupported platforms
Cc:     Guo Ren <guoren@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210204074609.3553018-1-guoren@kernel.org>
References: <20210204074609.3553018-1-guoren@kernel.org>
MIME-Version: 1.0
Message-ID: <161245457066.23325.8560756263289178537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     be1abc5ba4d2082df6749ab95ec6f87c4d3dbb23
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/be1abc5ba4d2082df6749ab95ec6f87c4d3dbb23
Author:        Guo Ren <guoren@linux.alibaba.com>
AuthorDate:    Thu, 04 Feb 2021 15:46:08 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 04 Feb 2021 10:37:28 

irqchip/csky-mpintc: Prevent selection on unsupported platforms

The irq-csky-mpintc driver is only supported on CPU_CK860 and
it will generate a compilation error when selected with CPU_CK610.

As it is already selected directly in the architecture Kconfig,
drop the option to select it manually.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
[maz: rewrote commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210204074609.3553018-1-guoren@kernel.org
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f95d114..030895c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -427,7 +427,7 @@ config QCOM_PDC
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
 config CSKY_MPINTC
-	bool "C-SKY Multi Processor Interrupt Controller"
+	bool
 	depends on CSKY
 	help
 	  Say yes here to enable C-SKY SMP interrupt controller driver used
