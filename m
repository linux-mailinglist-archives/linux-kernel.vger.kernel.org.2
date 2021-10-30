Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4025F440AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJ3SBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 14:01:05 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:35619 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJ3SBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 14:01:03 -0400
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 19UHvPwZ014662;
        Sun, 31 Oct 2021 02:57:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 19UHvPwZ014662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1635616645;
        bh=etJG8fgowiRm3GZBJo0k5ncCkc10kCvpPeV0z+hvBdU=;
        h=From:To:Cc:Subject:Date:From;
        b=y9dgb8lGfMUT+gIx5mp2BTUxDNIzFax40lwd3ja8SD4Zis4GZp++3FUL7MziEgHv2
         B6MVzJ5LR7zUnyjKXPdPaw+SOpFHK1v8OChLNIqc61O4Wcd3UA3vbeV49sesg7npkK
         m+/MlgA+zXPtfp+rKxYUDZOSQbcLGWzlad0ynqawwDkj6ge5ldDkU8PrH7fv0TnlOr
         lnmy161WTJUZNRNx0k3CYaXtRSBiSbOIRzx+7hCBM3luJA8gDkA6gTPXmRnffI6eN8
         X0DFMZPFWk5Qk/RxSQ0npsgoAcjlduSs5P86UgKlagCX4vsKSXWzukC5MShBJ3zWWm
         h9n56Hk/xcfDw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-parisc@vger.kernel.org, patches@arm.linux.org.uk
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] parisc: decompressor: remove repeated depenency of misc.o
Date:   Sun, 31 Oct 2021 02:57:20 +0900
Message-Id: <20211030175721.1716841-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same dependency

    $(obj)/misc.o: $(obj)/sizes.h

... appears twice, at line 29 and line 55 in this Makefile.

Remove the second one.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/boot/compressed/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 9fe54878167d..f7ed79e23c2c 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -52,8 +52,6 @@ $(obj)/real2.o: $(obj)/real2.S
 $(obj)/real2.S: $(srctree)/arch/$(SRCARCH)/kernel/real2.S
 	$(call cmd,shipped)
 
-$(obj)/misc.o: $(obj)/sizes.h
-
 CPPFLAGS_vmlinux.lds += -I$(objtree)/$(obj) -DBOOTLOADER
 $(obj)/vmlinux.lds: $(obj)/sizes.h
 
-- 
2.30.2

