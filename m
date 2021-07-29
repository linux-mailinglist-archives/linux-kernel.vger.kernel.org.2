Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F823DA619
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbhG2OMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:12:23 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:63101 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbhG2OCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:02:21 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 16TE0RBp024554;
        Thu, 29 Jul 2021 23:00:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 16TE0RBp024554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627567228;
        bh=u6b4AXGUg3yFnIadRXqo5WiC6FwPdXiHB94UaUvbQN4=;
        h=From:To:Cc:Subject:Date:From;
        b=EgTTiA10chfaojkw9B8vkyVnSzSKjfHMlMhzdOQKkvC6564emNoSqMmM1ZZ7hE+qg
         i2K3Ng6V1pGAmzYVTdyAxfjPBYwafn8aByBMtphKb6g91gPXRoe0sVeEhk1+pO9LGe
         iY7VAdvQcl2dOfw8RrCUpfLszWfe061ZAWAAxp92cAXYFcDrFModSx1QwGBYF2IZZv
         Wb+VdjGYyPkPh9c3mEi8GLT+08jLTXzh16RqfeKLYI3hvQ1yJflGdhkokY4rZTmXNG
         b7hVLcWLCKyrpgXC37rOJQlx3++Vt+GF1V0Gpr1Mx2MorhqTkCa3SGGY4f2+ZGK3PJ
         2JccSelt2r8rg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/build: remove the left-over bzlilo target
Date:   Thu, 29 Jul 2021 23:00:22 +0900
Message-Id: <20210729140023.442101-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f279b49f13bd ("x86/boot: Modernize genimage script; hdimage+EFI
support") remove the 'bzlilo' target from arch/x86/boot/Makefile.

Remove the left-over from arch/x86/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 0fa7dc73b5d8..4f784d9ac925 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -275,8 +275,8 @@ endif
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
-PHONY += install bzlilo
-install bzlilo:
+PHONY += install
+install:
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 PHONY += vdso_install
-- 
2.27.0

