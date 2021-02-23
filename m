Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB44322834
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBWJ44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhBWJyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:54:32 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25AEC061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 01:53:51 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:254f:253d:debc:790b])
        by xavier.telenet-ops.be with bizsmtp
        id YZto2400E1v7dkx01Ztort; Tue, 23 Feb 2021 10:53:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lEUO3-0010Q5-Qd; Tue, 23 Feb 2021 10:53:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lEUO2-008yZU-SQ; Tue, 23 Feb 2021 10:53:46 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] powerpc/chrp: Make hydra_init() static
Date:   Tue, 23 Feb 2021 10:53:45 +0100
Message-Id: <20210223095345.2139416-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 407d418f2fd4c20a ("powerpc/chrp: Move PHB discovery") moved the
sole call to hydra_init() to the source file where it is defined, so it
can be made static.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.  My LongTrail died in 2004.
---
 arch/powerpc/include/asm/hydra.h  | 2 --
 arch/powerpc/platforms/chrp/pci.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hydra.h b/arch/powerpc/include/asm/hydra.h
index ae02eb53d6ef8221..d024447283a0cf3c 100644
--- a/arch/powerpc/include/asm/hydra.h
+++ b/arch/powerpc/include/asm/hydra.h
@@ -94,8 +94,6 @@ extern volatile struct Hydra __iomem *Hydra;
 #define HYDRA_INT_EXT7		18	/* Power Off Request */
 #define HYDRA_INT_SPARE		19
 
-extern int hydra_init(void);
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASMPPC_HYDRA_H */
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 8c421dc78b28334b..76e6256cb0a788f4 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -131,8 +131,7 @@ static struct pci_ops rtas_pci_ops =
 
 volatile struct Hydra __iomem *Hydra = NULL;
 
-int __init
-hydra_init(void)
+static int __init hydra_init(void)
 {
 	struct device_node *np;
 	struct resource r;
-- 
2.25.1

