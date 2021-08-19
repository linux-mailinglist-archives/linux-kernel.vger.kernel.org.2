Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3013F0FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 03:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhHSBZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 21:25:05 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:49978 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhHSBZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:25:04 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 17J1MtKn011728;
        Thu, 19 Aug 2021 10:22:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 17J1MtKn011728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629336176;
        bh=3+8S5ofcBaxjQr06CdFUTFI1Uyf4bezjNTPm2kYzCXM=;
        h=From:To:Cc:Subject:Date:From;
        b=YvQwBamZOj5/ZYapEPfQkUp/pcpIOWwqWrlJJxY0E405rL1WzM9adDpbDzKTglYVT
         ++8+y47XN/N/Q6TxaW/3em/2Sgg2r4Qou9MZ4tnXasppd5H2Use9I+knPonb7TitON
         4aFGrW8LrfXnotb3RAW7t3lGxR8JbLHcZyb2szhnxySRDEY4yFtVzKbWNHlN2CfeLY
         YWO6GAFHUEm0vf22gVyvX8pkbvM3Qn5A9NlZ616qDvjB0fDU8gDyJuN9CN4wmsxiNw
         O0DRChYibyyc1XE0VXILzv5KndSaY/1S8Tfa78sf3Hv3wIFuTCtDVSpqUufSMdWFiS
         IIVNu1WP3cdrw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build/vdso: fix missing FORCE for *.so build rule
Date:   Thu, 19 Aug 2021 10:22:51 +0900
Message-Id: <20210819012251.708998-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FORCE so that if_changed can detect the command line change.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 05c4abc2fdfd..a2dddcc189f6 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -131,7 +131,7 @@ $(obj)/%-x32.o: $(obj)/%.o FORCE
 targets += vdsox32.lds $(vobjx32s-y)
 
 $(obj)/%.so: OBJCOPYFLAGS := -S --remove-section __ex_table
-$(obj)/%.so: $(obj)/%.so.dbg
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
-- 
2.30.2

