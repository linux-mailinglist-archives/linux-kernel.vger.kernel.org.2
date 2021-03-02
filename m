Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6132ADDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360044AbhCBWQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:16:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1836511AbhCBUJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:09:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40A9964F21;
        Tue,  2 Mar 2021 20:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614715728;
        bh=+ZnFHkCt4vxwdfNeetS0nLlA+jw/GbxPFD8wsnXzPjE=;
        h=From:To:Cc:Subject:Date:From;
        b=rFORUmuoN8/sw1fsN52kQIk1QPdI3scUBNK3k0XmymgtXQ5xFn2NROK7ivr4YxPO/
         1eTkyWWTNkjLInsdr8IhmoOHXsuTpbBx/9M4WL0McXGVpD6Hafo56Kv6LT8ipAvIs0
         b2SiRYcRPNQqY2eSit6+3UGuGsf1qSXwGlaYFSJf9CWWl66sWRu/WGSS28vIXtFo3h
         +MvJuST3FMaXUIx1z+fhSSHYL02hvAjPcKgeatebPykL24rjKs1tq1WhLshXJh8xYd
         KqUSN2kvYRBJ18Ub3QEtjr1jW8JDg7Il7ja7K6z6bxjDxOAm97nh/cHMTQSqWj4PwN
         zfC5dn8pWeOSQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] powerpc/prom: Mark identical_pvr_fixup as __init
Date:   Tue,  2 Mar 2021 13:08:29 -0700
Message-Id: <20210302200829.2680663-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0.rc0.75.gec125d1bc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If identical_pvr_fixup() is not inlined, there are two modpost warnings:

WARNING: modpost: vmlinux.o(.text+0x54e8): Section mismatch in reference
from the function identical_pvr_fixup() to the function
.init.text:of_get_flat_dt_prop()
The function identical_pvr_fixup() references
the function __init of_get_flat_dt_prop().
This is often because identical_pvr_fixup lacks a __init
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: modpost: vmlinux.o(.text+0x551c): Section mismatch in reference
from the function identical_pvr_fixup() to the function
.init.text:identify_cpu()
The function identical_pvr_fixup() references
the function __init identify_cpu().
This is often because identical_pvr_fixup lacks a __init
annotation or the annotation of identify_cpu is wrong.

identical_pvr_fixup() calls two functions marked as __init and is only
called by a function marked as __init so it should be marked as __init
as well. At the same time, remove the inline keywork as it is not
necessary to inline this function. The compiler is still free to do so
if it feels it is worthwhile since commit 889b3c1245de ("compiler:
remove CONFIG_OPTIMIZE_INLINING entirely").

Fixes: 14b3d926a22b ("[POWERPC] 4xx: update 440EP(x)/440GR(x) identical PVR issue workaround")
Link: https://github.com/ClangBuiltLinux/linux/issues/1316
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/kernel/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9a4797d1d40d..a8b2d6bfc1ca 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -267,7 +267,7 @@ static struct feature_property {
 };
 
 #if defined(CONFIG_44x) && defined(CONFIG_PPC_FPU)
-static inline void identical_pvr_fixup(unsigned long node)
+static __init void identical_pvr_fixup(unsigned long node)
 {
 	unsigned int pvr;
 	const char *model = of_get_flat_dt_prop(node, "model", NULL);

base-commit: 5c88a17e15795226b56d83f579cbb9b7a4864f79
-- 
2.31.0.rc0.75.gec125d1bc1

