Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE7383401
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242801AbhEQPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242261AbhEQOyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:54:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FF97619B9;
        Mon, 17 May 2021 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621261488;
        bh=Bd27FTLLPS9PaoiW4XggeiQQjUdXygHDGB8ss44Di7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4Q3XbJ3SJ1R2tCaGd40SazK05mhewSuzhK7fRzFjg/yysqx1zvtwozgRGfFyfpIW
         qIHL5diioyeCUADOjaWKS88ebIrDz5uBmfFX/VD3fb8umiZnKH383JtFpJvoqs+iqZ
         tUfIqz0Ed0XpXOIy6RFSNZMzudsYvHU+BjLQwDsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Wang Nan <wangnan0@huawei.com>, Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.11 121/329] ARM: 9064/1: hw_breakpoint: Do not directly check the events overflow_handler hook
Date:   Mon, 17 May 2021 16:00:32 +0200
Message-Id: <20210517140306.206625365@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517140302.043055203@linuxfoundation.org>
References: <20210517140302.043055203@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit a506bd5756290821a4314f502b4bafc2afcf5260 ]

The commit 1879445dfa7b ("perf/core: Set event's default
::overflow_handler()") set a default event->overflow_handler in
perf_event_alloc(), and replace the check event->overflow_handler with
is_default_overflow_handler(), but one is missing.

Currently, the bp->overflow_handler can not be NULL. As a result,
enable_single_step() is always not invoked.

Comments from Zhen Lei:

 https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210207105934.2001-1-thunder.leizhen@huawei.com/

Fixes: 1879445dfa7b ("perf/core: Set event's default ::overflow_handler()")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Wang Nan <wangnan0@huawei.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/hw_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 08660ae9dcbc..b1423fb130ea 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 			info->trigger = addr;
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (!bp->overflow_handler)
+			if (is_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
-- 
2.30.2



