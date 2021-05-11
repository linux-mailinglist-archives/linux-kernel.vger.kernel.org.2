Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D52379BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhEKA5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:57:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50685 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhEKA5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:57:07 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14B0tdw62504247
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 17:55:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14B0tdw62504247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620694549;
        bh=qy1RPLxE9OinSWwKZJeXE4qaevlltN3Sf9Y5raguAv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzeZMrXQRjxhccAi/Nrtfjw1C9SxfbkmxtVfJddn0rBbM9YmMwCWecyu9PTObToUA
         gVU598sQtANEWvq/1St16rfpc8licJN7BypRmclzTljJ2IJjdkr3fCQpmF/Qe1d08o
         qGmyjD8NUUb3tALHyDeFrjLKe8whY8jr5BIbdP/9kj+JOdpivKHGdnVQTB/Dq/Pouo
         UMlOat4d9m+1Gh5BcaiSslZqdj5AoUp5W/x8gDotOZOLnCBynvRHkky4ThxFfU74Sd
         zFYdcRe82WcpmVHxOU1hmeLZLaLhScM6+nx515kJjYj1IIyCTvz/2wDAosH2Aqbuhr
         UxkkDTy1sbudw==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH 1/6] x86/traps: add X86_NR_HW_TRAPS to <asm/trapnr.h>
Date:   Mon, 10 May 2021 17:55:26 -0700
Message-Id: <20210511005531.1065536-2-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511005531.1065536-1-hpa@zytor.com>
References: <20210511005531.1065536-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The x86 architecture supports up to 32 trap vectors. Add that constant
to <asm/trapnr.h>.

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

