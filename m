Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43103814F6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhEOBpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:45:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33351 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232532AbhEOBpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:45:33 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14F1i7ah3212185
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 May 2021 18:44:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14F1i7ah3212185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621043054;
        bh=EpnHJpkYzXbGrQZtbfzHZ3wDQrwAHF+A20nxmkjmOc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLIFGzqvbiqem1MOz/YUM4+5UDyFxBhHgEE8r3swqDbohpYc4XbqcvW0trAXkW8Iz
         MDwoeUhBe4FJ8nlWzDDIjzPhCXvut6P6bHpkqFduIe5bWaYxLXER9qBkmZop1zq87l
         5Hhado/VstMbXPZkdnn7sb1zfrcvQMsW5txRS7p7RalglNVqgPfopTv6G+6Wj5OEzW
         1VGaG12ZaVbbmE3OBW+hnx7yyf8fcR+DfT7sMbpQX9vm3KdgkyBok8AfTUSRbDYKQp
         +nqss1w00w2DSAhWPhmVAPrQqd0i1Bh870kfBXQe2h/gsPKXqCepEy/8o5C6h9T2K0
         h0AiVkfh2N46w==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/9] x86/traps: add X86_NR_HW_TRAPS to <asm/trapnr.h>
Date:   Fri, 14 May 2021 18:43:53 -0700
Message-Id: <20210515014400.2999028-2-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515014400.2999028-1-hpa@zytor.com>
References: <20210515014400.2999028-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The x86 architecture supports up to 32 trap vectors. Add that constant
to <asm/trapnr.h>.

Acked-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/trapnr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
index f5d2325aa0b7..f0baf92da20b 100644
--- a/arch/x86/include/asm/trapnr.h
+++ b/arch/x86/include/asm/trapnr.h
@@ -27,6 +27,7 @@
 #define X86_TRAP_VE		20	/* Virtualization Exception */
 #define X86_TRAP_CP		21	/* Control Protection Exception */
 #define X86_TRAP_VC		29	/* VMM Communication Exception */
+#define X86_NR_HW_TRAPS		32	/* Max hardware trap number */
 #define X86_TRAP_IRET		32	/* IRET Exception */
 
 #endif
-- 
2.31.1

