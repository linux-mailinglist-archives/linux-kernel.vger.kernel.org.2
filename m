Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED5E350292
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhCaOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:44:29 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:33178 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbhCaOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:44:15 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 12VEhd3D005786;
        Wed, 31 Mar 2021 23:43:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 12VEhd3D005786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617201820;
        bh=PnpW/bjHoCFxKPSpBRx2jB2EfB2pG/XtBj+ImkglJ1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbautnCM4eb7KLsdrSKx7jcjaV4kxSn/uKhv8nXTnQLRdXAXDHrKpd4W3yYWkgPCm
         9LXnRbb7mZQP/c8lbQB5IY1cmijYoOgboavrXSVzksF5CJ1NDRgyky/mIaTyjh/mqu
         8meDfUjNek+31fUy0d8QyiTdz0hUaPwEg71rIuh1m7LCZLzyVY50agZS1VoQJlP7LI
         roqwfVuIQr+czYNmuonyipPYcSbmJBz+OfamNQN28+1gyyxRMYgGq7dkh1UEX03Ogr
         HWf7NVmCiMNYIT3OEqaLDR8EVwBmezDXLGjoCaPIP9n9MAT62D0yWl9WF7FA55Zb0u
         htv6ughsQ3/NA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] m68k: remove meaningless EXTRA_LDFLAGS
Date:   Wed, 31 Mar 2021 23:43:36 +0900
Message-Id: <20210331144336.25628-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210331144336.25628-1-masahiroy@kernel.org>
References: <20210331144336.25628-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two Makefiles contain only built-in objects (i.e. obj-y), which
are collected by $(AR) into a thin-archive.

EXTRA_LDFLAGS is meaningless because $(LD) is not used here.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/m68k/fpsp040/Makefile  | 2 --
 arch/m68k/ifpsp060/Makefile | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/m68k/fpsp040/Makefile b/arch/m68k/fpsp040/Makefile
index 5537807457fb..834ae9471b88 100644
--- a/arch/m68k/fpsp040/Makefile
+++ b/arch/m68k/fpsp040/Makefile
@@ -10,5 +10,3 @@ obj-y    := bindec.o binstr.o decbin.o do_func.o gen_except.o get_op.o \
 	    ssin.o ssinh.o stan.o stanh.o sto_res.o stwotox.o tbldo.o util.o \
 	    x_bsun.o x_fline.o x_operr.o x_ovfl.o x_snan.o x_store.o \
 	    x_unfl.o x_unimp.o x_unsupp.o bugfix.o skeleton.o
-
-EXTRA_LDFLAGS := -x
diff --git a/arch/m68k/ifpsp060/Makefile b/arch/m68k/ifpsp060/Makefile
index 43b435049452..56b530a96c2f 100644
--- a/arch/m68k/ifpsp060/Makefile
+++ b/arch/m68k/ifpsp060/Makefile
@@ -5,5 +5,3 @@
 # for more details.
 
 obj-y := fskeleton.o iskeleton.o os.o
-
-EXTRA_LDFLAGS := -x
-- 
2.27.0

