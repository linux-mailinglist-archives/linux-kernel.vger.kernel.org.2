Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEB038988B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhESVXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:23:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34073 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhESVXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:23:42 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14JLM1EZ4187848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 19 May 2021 14:22:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14JLM1EZ4187848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621459330;
        bh=EpnHJpkYzXbGrQZtbfzHZ3wDQrwAHF+A20nxmkjmOc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haaWuRUceAj3FP99GP+ExkG9iTm8UiG53GRSJ/VQr7/M3x9wqbO+TDNqsPwChAnhC
         pMvKQY7vdlit8UMv39+EGBFVIOTmumZIF/p5VSUw6IfMJRmQQAPFlggH8/JM0Hdi5V
         1q59oxTDEjPfo4SZ57hQLZ6yH5E/Myr2XuGbs3ntBLFI+YRjmBiVyfjvE6A3GBlBej
         Rfd4xKsbZ6zDU5qfQeKxhnqp72AksNRg/MFGQDO5OqvuWh8S5zVihXcysIP7AqH78S
         bmzZmPXrXLxe/F5k9TeQ5RPomh6ia3WXLY+lVDyp0kG0fy1pJ8VNxEukFmuI8R049X
         0KmW8mAW2rMUA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/8] x86/traps: add X86_NR_HW_TRAPS to <asm/trapnr.h>
Date:   Wed, 19 May 2021 14:21:47 -0700
Message-Id: <20210519212154.511983-2-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519212154.511983-1-hpa@zytor.com>
References: <20210519212154.511983-1-hpa@zytor.com>
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

