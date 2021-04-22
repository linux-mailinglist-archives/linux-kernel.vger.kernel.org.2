Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA6368776
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbhDVTyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:54:44 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C243FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:54:08 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q64-20020a632a430000b0290209af2eea25so7054166pgq.18
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ImTLyl0SxzL3xu48ASg//HlItmpFlRZGvY2fvaEcoU8=;
        b=H17ya4YHWRiQmMqm7Yud8M0j8f2kaYPakeRhU9xoRbPeNQSPlLudddQ63QwbMcP++y
         jgPxzgdPmCVWy0LctGN3XR4nay0rZceVuPUv4ofni/UFdp2Vkdd950pwtcJ+fSY00pIg
         WNqV0JXoYfBe14TGy4aaKHd6NU8ak11fLx+Vx4AUQSS4EH0iIR/5DzFlmYR2f9ziqk/h
         zh8wcfOe3XX3jHUW/YmUd9dEJe+UEggxzkOXmugt7qZB8z8gPt0q+XAHw3S+oIjoaO1s
         rlGQwviRsNED/AJ6ORy8ap2Z+8p/iD3Vv6BVbdp677KC65ZEPbgCPpxgq/0srRU7YIR/
         u/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ImTLyl0SxzL3xu48ASg//HlItmpFlRZGvY2fvaEcoU8=;
        b=cM97RUkMmnL8CPjFC6vfmpPrJEAI+3k1A9pGa/KEmR/yYeddgqoL+IZJdO7xkYaoLC
         PkdqtOe/hJB5aPhdRSoDMqofPbKlyuvJlK08NNap8CiXDxEbinpwWROKVb+mUiU57xpG
         8RGxynutyyL44g2Ur7FqYuc+ch2VhsLM3i8cOw4SfxpiqAH+yic8kcOgR/JtENrCWaQ3
         K593+fsecOQJ0KDSIOksCb3ZTkglODXqFbOvP6aWhMTmTTkekSoWLB3hmxM2tzEq0jVL
         bnoLGMAdmRgbrNS6g8QYCkVwqXbjM9mPP6vCTi63k7sd3fBERWgnGYlf1mpVXnJMfJJh
         ECNQ==
X-Gm-Message-State: AOAM532sr6RlUbKSQGszcp8yy41k/YGFw54LYwxlXkYiwmoRd6YBEYDK
        OObz5M2t8PP7ew1TdogFy7tT2BCzJFmXf0YIEVA=
X-Google-Smtp-Source: ABdhPJwy0+XtlTuR9M3dXEQgxOOFMNcgRbs2eHZsHiG99vQoM4mzMjNVufkEnCeVeMuqN1Jiz+inq1aLOvfvQFaA3VU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:9317:2762:871:5f48])
 (user=ndesaulniers job=sendgmr) by 2002:a17:902:8347:b029:e7:4a2d:6589 with
 SMTP id z7-20020a1709028347b02900e74a2d6589mr499050pln.64.1619121247911; Thu,
 22 Apr 2021 12:54:07 -0700 (PDT)
Date:   Thu, 22 Apr 2021 12:54:02 -0700
Message-Id: <20210422195405.4053917-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] powerpc/powernv/pci: remove dead code from !CONFIG_EEH
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at -Wundef warnings, the #if CONFIG_EEH stood out as a
possible candidate to convert to #ifdef CONFIG_EEH, but it seems that
based on Kconfig dependencies it's not possible to build this file
without CONFIG_EEH enabled.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Joe Perches <joe@perches.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/570
Link: https://lore.kernel.org/lkml/67f6cd269684c9aa8463ff4812c3b4605e6739c3.camel@perches.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/platforms/powernv/pci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 9b9bca169275..591480a37b05 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -711,7 +711,6 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-#if CONFIG_EEH
 static bool pnv_pci_cfg_check(struct pci_dn *pdn)
 {
 	struct eeh_dev *edev = NULL;
@@ -734,12 +733,6 @@ static bool pnv_pci_cfg_check(struct pci_dn *pdn)
 
 	return true;
 }
-#else
-static inline pnv_pci_cfg_check(struct pci_dn *pdn)
-{
-	return true;
-}
-#endif /* CONFIG_EEH */
 
 static int pnv_pci_read_config(struct pci_bus *bus,
 			       unsigned int devfn,

base-commit: 16fc44d6387e260f4932e9248b985837324705d8
prerequisite-patch-id: 950233069fb22099a8ff8990f620f5c3586a3cbd
-- 
2.31.1.498.g6c1eba8ee3d-goog

