Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A3A426479
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 08:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhJHGKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 02:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJHGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 02:10:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D651C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 23:08:10 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s75so2112084pgs.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=HtNb7Tgg0FX/qljbg4W3bUMaXu11sKsG1sEi11NjGME=;
        b=o/8tZZV19jXhzpFd9tEL7D7fkf1vyjW/yB5Dt7N8fLIVyceFJ/yMvT7IGDOgEhQRxX
         IcwoIYrIPzSIGfhdbM2oHhZh/dNVyQyrLPP6qBB53R61AFkn4zvMp7+nHTg9pnWo3Yfy
         RSdKxJv8TPSSqBI2JLowqewTEyOQcVCIqBomFNLsi9PGEJjEuZq0iJcuA3sKJ1kahumU
         7tIx3tRZp1RXOGXWEm7yDlol9saM1HhMXhJth3ibbH+WLR11HCORkISE9KSAzpCW/Z1E
         SQRKfhQZ3UuqyCD0/ApNOT+YpHngsfxaKuio8XuoYrwOPIYkleECaNEZYyhzFS5tizWH
         +IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=HtNb7Tgg0FX/qljbg4W3bUMaXu11sKsG1sEi11NjGME=;
        b=xMrK3QgOSiOY1VUJtJdRXS6tm+/hhfGSEH8nUE8PcxuIdqN8Qe6Sn6Fk3vBY48ectI
         VqzYPyvgQofeHfnV9dV77oDf2G8CcuPRUzfPEBMW2WjEgVH7FiiTO3Uj5caeY3/F7eJ7
         kcoJ2R2iOm6SDRDrbbwCv5w6EDfwd+nr2MWJdJGfc2VxiKSyS5D/BR1HzMqYBzhAHGOr
         BGow1V3OvXUOQ+Dqp67hfFQf3WQstBwLbMsU9S31F6lX1N772Req6E9oSWSiGXeb6r90
         6CJhTTq8YyzHYOU0nWCyX4OSrlUCTXmnHaMEYpffxag8Q7UdgXECK9uCJEzBv0G6Hwvv
         gOZQ==
X-Gm-Message-State: AOAM533Q/GvzkS3/8B9s22Hnhp+fcqgjxxPmpa3s5h/Yu65D+peOOWzN
        6/qkHwOUKljGW89zo1qucXSIvD310qk=
X-Google-Smtp-Source: ABdhPJy4hFmQBsdpxbQjO045CgwH00G1/mXtBrpeTnm1jkesnohtpQUh8U1VM0aRpuab29bvHKN1hw==
X-Received: by 2002:aa7:9a1d:0:b0:44c:af89:e24 with SMTP id w29-20020aa79a1d000000b0044caf890e24mr8543328pfj.12.1633673290082;
        Thu, 07 Oct 2021 23:08:10 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e20sm1291145pfc.11.2021.10.07.23.08.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 23:08:09 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: [RFC PATCH] arch: ARM64: add isb before enable pan
Date:   Fri,  8 Oct 2021 14:07:49 +0800
Message-Id: <1633673269-15048-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

set_pstate_pan failure is observed in an ARM64 system occasionaly on a reboot
test, which can be work around by a msleep on the sw context. We assume
suspicious on disorder of previous instr of disabling SW_PAN and add an isb here.

PS:
The bootup test failed with a invalid TTBR1_EL1 that equals 0x34000000, which is
alike racing between on chip PAN and SW_PAN.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index efed283..3c0de0d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1663,6 +1663,7 @@ static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 	WARN_ON_ONCE(in_interrupt());
 
 	sysreg_clear_set(sctlr_el1, SCTLR_EL1_SPAN, 0);
+	isb();
 	set_pstate_pan(1);
 }
 #endif /* CONFIG_ARM64_PAN */
-- 
1.9.1

