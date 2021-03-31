Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AFB350291
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhCaOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:44:27 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:33168 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbhCaOoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:44:14 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 12VEhd3C005786;
        Wed, 31 Mar 2021 23:43:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 12VEhd3C005786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617201819;
        bh=C0YVGdmbD9bnQdCRbrJ5QrDoHiPkLL5zZr25U63CJDI=;
        h=From:To:Cc:Subject:Date:From;
        b=PN4/wj6eJE6kLeYCVwldPbxcPpCpY9fQdUJzm09Vn3GadKbFBFbmy6n223OrvNtDo
         cClGecuR9pRDijPgvUj0YxckXTJTqRrMcdvjzYxnC6u4wNluDkyTA0hl1mHhS2hmY3
         V8a+Urekc0971rH1oiRgEV9ELHKCDBoQvaeILQDooA2/ygeH1aALalbIQy7Y9/4f27
         BDcPuojUi8nPC/EZkNAMC+3YszvEkpvvKGnjBKsfNc1UxVf+iV7tbgF8gqEZGemnvS
         Fsj/M2CkXiSiRKlPqJg5kuv09UJn4HWsru/M6EKxtlgqvC/zwO4rsJ+Wx+mxGyoakb
         Qd7C18GkAcZsA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] m68k: remove meaningless $(OS_OBJS)
Date:   Wed, 31 Mar 2021 23:43:35 +0900
Message-Id: <20210331144336.25628-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'git grep OS_OBJS' hits only this line. $(OS_OBJS) is just empty.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/m68k/fpsp040/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m68k/fpsp040/Makefile b/arch/m68k/fpsp040/Makefile
index aab04d372ae7..5537807457fb 100644
--- a/arch/m68k/fpsp040/Makefile
+++ b/arch/m68k/fpsp040/Makefile
@@ -12,5 +12,3 @@ obj-y    := bindec.o binstr.o decbin.o do_func.o gen_except.o get_op.o \
 	    x_unfl.o x_unimp.o x_unsupp.o bugfix.o skeleton.o
 
 EXTRA_LDFLAGS := -x
-
-$(OS_OBJS): fpsp.h
-- 
2.27.0

