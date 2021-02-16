Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C231CF85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhBPRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:47:18 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:22028 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhBPRoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1613497460; x=1645033460;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OcPgLAZB2X4iUeaTMzqq/ozxg6kXR5s7XcrehmquhAQ=;
  b=qUV/lzQMCEcaJpml6L6smCTd2S+HWalXbObRYBY4mT5FBJIDMuhASY9D
   y/6xanRpTl6PDjfVVAyDL8qi6U465Ux5/ifyvBi9Fb75IDHeOf+n3VTSg
   rWVRGVEfhSTvRoIJdk6BstclHQmgsqmVc09qhZsE/KPIdKTGIt+UNnMHW
   w=;
X-IronPort-AV: E=Sophos;i="5.81,184,1610409600"; 
   d="scan'208";a="86690269"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Feb 2021 17:43:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 697FCA1D0D;
        Tue, 16 Feb 2021 17:43:35 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Feb 2021 17:43:34 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Feb 2021 17:43:34 +0000
Received: from dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (172.22.152.76)
 by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 16 Feb 2021 17:43:34 +0000
Received: by dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (Postfix, from userid 13116433)
        id C18CE45897; Tue, 16 Feb 2021 17:43:34 +0000 (UTC)
Date:   Tue, 16 Feb 2021 17:43:34 +0000
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <fllinden@amazon.com>, <benh@amazon.com>, <shaoyi@amazon.com>
Subject: [PATCH] arm64 module: set plt* section addresses to 0x0
Message-ID: <20210216174334.GA19885@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These plt* and .text.ftrace_trampoline sections specified for arm64 have 
non-zero addressses. Non-zero section addresses in a relocatable ELF would 
confuse GDB when it tries to compute the section offsets and it ends up 
printing wrong symbol addresses. Therefore, set them to zero, which mirrors 
the change in commit 5d8591bc0fba ("module: set ksymtab/kcrctab* section 
addresses to 0x0").

Reported-by: Frank van der Linden <fllinden@amazon.com>
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/module.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index 691f15af788e..810045628c66 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -1,7 +1,7 @@
 #ifdef CONFIG_ARM64_MODULE_PLTS
 SECTIONS {
-	.plt (NOLOAD) : { BYTE(0) }
-	.init.plt (NOLOAD) : { BYTE(0) }
-	.text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
+	.plt 0 (NOLOAD) : { BYTE(0) }
+	.init.plt 0 (NOLOAD) : { BYTE(0) }
+	.text.ftrace_trampoline 0 (NOLOAD) : { BYTE(0) }
 }
 #endif
-- 
2.16.6

