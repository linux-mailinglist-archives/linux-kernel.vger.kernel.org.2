Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E6142EE53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhJOKFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:05:18 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50767 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234891AbhJOKFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:05:12 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HW1zq0sBZz9sSZ;
        Fri, 15 Oct 2021 12:03:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uy0dESsDVIQY; Fri, 15 Oct 2021 12:03:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HW1zp5vbGz9sSC;
        Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B1F448B763;
        Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sSzxvQmz7fL4; Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.255])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A2B48B78D;
        Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19FA2rYN2627043
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 12:02:53 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19FA2r4l2627042;
        Fri, 15 Oct 2021 12:02:53 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 6/8] powerpc/fsl_booke: Allocate separate TLBCAMs for readonly memory
Date:   Fri, 15 Oct 2021 12:02:47 +0200
Message-Id: <8ca169bc288261a0e0558712f979023c3a960ebb.1634292136.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d1ad9fdd9b27da3fdfa16510bb542ed51fa6e134.1634292136.git.christophe.leroy@csgroup.eu>
References: <d1ad9fdd9b27da3fdfa16510bb542ed51fa6e134.1634292136.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634292165; l=1790; s=20211009; h=from:subject:message-id; bh=GPLh52T+W0mzC2UX9R8EBFDtXmxOTxApVX7K4yTxS6U=; b=g2esoAizBI6LY1HMtyZdbCbuNoPnEKXFfdIey+HcspLzoq0P1sccJYP7gwakIYmzdvcw5a5Zqbob Xae0/NIjAUcwr+o0q7kYWN57bV2mOf1uVcJnZ9YIrDkOmMil1fae
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganise TLBCAM allocation so that when STRICT_KERNEL_RWX is
enabled, TLBCAMs are allocated such that readonly memory uses
different TLBCAMs.

This results in an allocation looking like:

Memory CAM mapping: 4/4/4/1/1/1/1/16/16/16/64/64/64/256/256 Mb, residual: 256Mb

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/fsl_book3e.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/nohash/fsl_book3e.c b/arch/powerpc/mm/nohash/fsl_book3e.c
index 375b2b8238c1..c1bc11f46344 100644
--- a/arch/powerpc/mm/nohash/fsl_book3e.c
+++ b/arch/powerpc/mm/nohash/fsl_book3e.c
@@ -171,15 +171,34 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 {
 	int i;
 	unsigned long amount_mapped = 0;
+	unsigned long boundary;
+
+	if (strict_kernel_rwx_enabled())
+		boundary = (unsigned long)(_sinittext - _stext);
+	else
+		boundary = ram;
 
 	/* Calculate CAM values */
-	for (i = 0; ram && i < max_cam_idx; i++) {
+	for (i = 0; boundary && i < max_cam_idx; i++) {
+		unsigned long cam_sz;
+		pgprot_t prot = PAGE_KERNEL_X;
+
+		cam_sz = calc_cam_sz(boundary, virt, phys);
+		if (!dryrun)
+			settlbcam(i, virt, phys, cam_sz, pgprot_val(prot), 0);
+
+		boundary -= cam_sz;
+		amount_mapped += cam_sz;
+		virt += cam_sz;
+		phys += cam_sz;
+	}
+	for (ram -= amount_mapped; ram && i < max_cam_idx; i++) {
 		unsigned long cam_sz;
+		pgprot_t prot = PAGE_KERNEL_X;
 
 		cam_sz = calc_cam_sz(ram, virt, phys);
 		if (!dryrun)
-			settlbcam(i, virt, phys, cam_sz,
-				  pgprot_val(PAGE_KERNEL_X), 0);
+			settlbcam(i, virt, phys, cam_sz, pgprot_val(prot), 0);
 
 		ram -= cam_sz;
 		amount_mapped += cam_sz;
-- 
2.31.1

