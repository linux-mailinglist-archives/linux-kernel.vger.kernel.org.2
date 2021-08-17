Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECA3EE97F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhHQJSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:18:39 -0400
Received: from foss.arm.com ([217.140.110.172]:52822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239791AbhHQJRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:17:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FBAA31B;
        Tue, 17 Aug 2021 02:17:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 253BA3F40C;
        Tue, 17 Aug 2021 02:17:18 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, mark.rutland@arm.com, mingo@kernel.org,
        npiggin@gmail.com
Subject: [PATCH] Documentation/features/vm: correct huge-vmap APIs
Date:   Tue, 17 Aug 2021 10:16:21 +0100
Message-Id: <20210817091621.16799-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit:

  bbc180a5adb05ee8 ("mm: HUGE_VMAP arch support cleanup")

We replaced:

  * ioremap_pud_enabled() with arch_vmap_pud_supported()
  * ioremap_pmd_enabled() with arch_vmap_pmd_supported()

Update the documentation accordingly.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/features/vm/huge-vmap/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index 439fd9069b8b1..bc53905a03069 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -1,7 +1,7 @@
 #
 # Feature name:          huge-vmap
 #         Kconfig:       HAVE_ARCH_HUGE_VMAP
-#         description:   arch supports the ioremap_pud_enabled() and ioremap_pmd_enabled() VM APIs
+#         description:   arch supports the arch_vmap_pud_supported() and arch_vmap_pmd_supported() VM APIs
 #
     -----------------------
     |         arch |status|
-- 
2.11.0

