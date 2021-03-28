Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0807E34BF81
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 23:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhC1V4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 17:56:21 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:57430 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhC1Vzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 17:55:55 -0400
Received: by sf.home (Postfix, from userid 1000)
        id ECE5D5A22061; Sun, 28 Mar 2021 22:55:50 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: mca: always make IA64_MCA_DEBUG an expression
Date:   Sun, 28 Mar 2021 22:55:49 +0100
Message-Id: <20210328215549.830420-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least ia64_mca_log_sal_error_record() expects some statement:

    static void ia64_mca_log_sal_error_record(int sal_info_type)
    {
        ...
        if (irq_safe)
            IA64_MCA_DEBUG("CPU %d: SAL log contains %s error record\n",
                smp_processor_id(),
                sal_info_type < ARRAY_SIZE(rec_name) ? rec_name[sal_info_type] : "UNKNOWN");
        ...
    }

Instead of fixing all callers the change expicitly makes IA64_MCA_DEBUG
a non-empty expression.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-ia64@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/kernel/mca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 79e76712198c..16088c645e2b 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -109,9 +109,9 @@
 #include "irq.h"
 
 #if defined(IA64_MCA_DEBUG_INFO)
-# define IA64_MCA_DEBUG(fmt...)	printk(fmt)
+# define IA64_MCA_DEBUG(fmt...) printk(fmt)
 #else
-# define IA64_MCA_DEBUG(fmt...)
+# define IA64_MCA_DEBUG(fmt...) do {} while (0)
 #endif
 
 #define NOTIFY_INIT(event, regs, arg, spin)				\
-- 
2.31.1

