Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A969538EBB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 17:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhEXPGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 11:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233066AbhEXPAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:00:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F7FF61461;
        Mon, 24 May 2021 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621867796;
        bh=eThF42QgHM2ceyuUbfHXSeQsf1W1pocY7rix57lF/sE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuJ+bwjVBpUt16mZ9z+TIiOjKEm7hlCl8noCezbb4tgAOwIgNUsZdHxDgHddRSAUs
         OBIPXXmFJhiNTrSR+Rv/iHklrDaW/2Up9EJk1+aV/mhRNgV1ONPErWMnqUsBAZRoI9
         mFmAroxCYq7q6OcioszB/VRSO7bs0beBBa3gKi/vGJiOtQ0O/Q7G0u1SAoi4gUGXVm
         8qRCmzX3Lwknsb1oeIxgs4JhJiy59n3c92m8wCjcS0xyDb8lleIyf+yoRpLItCVkbp
         gCfnqxUkV2H739o28Wad96T/kC+oLBsVo1Le3RVe6bue7zu4eVnxyg1Ttw2OZJtV1G
         Kx4yj+zR8D6Ig==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>, openrisc@lists.librecores.org
Subject: [PATCH AUTOSEL 5.4 43/52] openrisc: Define memory barrier mb
Date:   Mon, 24 May 2021 10:48:53 -0400
Message-Id: <20210524144903.2498518-43-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524144903.2498518-1-sashal@kernel.org>
References: <20210524144903.2498518-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 8b549c18ae81dbc36fb11e4aa08b8378c599ca95 ]

This came up in the discussion of the requirements of qspinlock on an
architecture.  OpenRISC uses qspinlock, but it was noticed that the
memmory barrier was not defined.

Peter defined it in the mail thread writing:

    As near as I can tell this should do. The arch spec only lists
    this one instruction and the text makes it sound like a completion
    barrier.

This is correct so applying this patch.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
[shorne@gmail.com:Turned the mail into a patch]
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/include/asm/barrier.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 arch/openrisc/include/asm/barrier.h

diff --git a/arch/openrisc/include/asm/barrier.h b/arch/openrisc/include/asm/barrier.h
new file mode 100644
index 000000000000..7538294721be
--- /dev/null
+++ b/arch/openrisc/include/asm/barrier.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_BARRIER_H
+#define __ASM_BARRIER_H
+
+#define mb() asm volatile ("l.msync" ::: "memory")
+
+#include <asm-generic/barrier.h>
+
+#endif /* __ASM_BARRIER_H */
-- 
2.30.2

