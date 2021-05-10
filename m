Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A2377F19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEJJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:11:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41253 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhEJJLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:11:14 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14A99o022376794
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 02:09:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14A99o022376794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620637799;
        bh=066xqfwFAZT6S9q2TM+TJZurY7MHKSgdXtUfWm6Czuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QopcG1ssL1S5eoq2aq4q1jwlJwUrDldg/5+Q5gWhJT8M2vFx356WntgUaKB9NvrKK
         7HmXoWsXsIgOQm8SeboOhiG9LO2LCxwk7yngIaLFPl3iS8L687YZT9P+YL6zFok7Cx
         KPGI51ee77g1wiWDhZuI5Kyc78bCuDuPUOeHm6PR3CaK6zFW9GIp0fXb+2jaiFS+bJ
         azeJXYilKR/i+M78HZ/1BqVRPUMnBtyqTdNEDaraRPk4XKZGpaBYwUYZN8+7nkXAGj
         OoyezFGpFxIeHwJMNuTNYlKwKI/iKI9TA+HaogUIptdF4vrbaOil8L6DaFvG1Lvgg6
         2J0T7hnoB4cwA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/3] x86/asm: add _ASM_BYTES() macro for a .byte ... opcode sequence
Date:   Mon, 10 May 2021 02:09:39 -0700
Message-Id: <20210510090940.924953-3-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510090940.924953-1-hpa@zytor.com>
References: <20210510090940.924953-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Make it easy to create a sequence of bytes that can be used in either
assembly proper on in a C asm() statement.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/asm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index c80899ac0192..1a1e22297867 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -13,6 +13,8 @@
 # define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
 #endif
 
+#define _ASM_BYTES(x, ...)	__ASM_FORM(.byte x,##__VA_ARGS__ ;)
+
 #ifndef __x86_64__
 /* 32 bit */
 # define __ASM_SEL(a,b)		__ASM_FORM(a)
-- 
2.31.1

