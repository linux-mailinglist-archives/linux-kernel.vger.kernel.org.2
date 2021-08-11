Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20563E9642
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhHKQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:44:08 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43296 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHKQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:44:06 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 17BGhElC021169;
        Thu, 12 Aug 2021 01:43:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 17BGhElC021169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628700195;
        bh=Oo0qxzwEX8jTeYTynAg3pP99anNAWJAkg0EUTQi23K4=;
        h=From:To:Cc:Subject:Date:From;
        b=n2XySUou+8cbUywODpS13bHwRWP9tqRutkEVs5P+qKmhg1EaJ1NTWGaVr+hNVGM0H
         +tEz3rXOjD3yEwhRbJWxIlj+XGJAokVCNrSd9uYaxn/OZ6UWHWeiKChRo6WMjZXchf
         qU5bju5ar1gTL8b5yHkZX2Std0TNQXqk+AuXc9bxXHF6h3a0hpJYp1PA5Dwhym81yV
         bZSEySZHs+DHdNixvFt1QW15LCLSXUwClBQt2W7xbyIZEuPx++V88B2n8EJbg/U6zz
         IZPqzG0J2skEAzBOe25eP2mh3Y+5rKQFVYgaU33Q/fyQyKJrm4foMi0eigkHKe1ZsG
         zUmaN119Lct5w==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-ia64@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: move core-y in arch/ia64/Makefile to arch/ia64/Kbuild
Date:   Thu, 12 Aug 2021 01:43:12 +0900
Message-Id: <20210811164312.187226-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use obj-y to clean up Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/ia64/Kbuild   | 2 ++
 arch/ia64/Makefile | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/Kbuild b/arch/ia64/Kbuild
index a4e40e534e6a..e77cc76d228c 100644
--- a/arch/ia64/Kbuild
+++ b/arch/ia64/Kbuild
@@ -1 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-y				+= kernel/ mm/
+obj-$(CONFIG_IA64_SGI_UV)	+= uv/
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 467b7e7f967c..7e548c654a29 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -47,8 +47,6 @@ KBUILD_CFLAGS += $(cflags-y)
 head-y := arch/ia64/kernel/head.o
 
 libs-y				+= arch/ia64/lib/
-core-y				+= arch/ia64/kernel/ arch/ia64/mm/
-core-$(CONFIG_IA64_SGI_UV)	+= arch/ia64/uv/
 
 drivers-y			+= arch/ia64/pci/ arch/ia64/hp/common/
 
-- 
2.30.2

