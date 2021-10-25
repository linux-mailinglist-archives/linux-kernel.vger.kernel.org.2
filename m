Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0284438DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhJYD5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:57:22 -0400
Received: from prt-mail.chinatelecom.cn ([42.123.76.228]:50820 "EHLO
        chinatelecom.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232054AbhJYD5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:57:21 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Oct 2021 23:57:20 EDT
HMM_SOURCE_IP: 172.18.0.48:38176.619599683
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.11.244 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 4B0AC2800C5;
        Mon, 25 Oct 2021 11:46:36 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id fc96548b531c4225bc9492b7d2703f80 for linux-kernel@vger.kernel.org;
        Mon, 25 Oct 2021 11:46:44 CST
X-Transaction-ID: fc96548b531c4225bc9492b7d2703f80
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com,
        zhouchengming@bytedance.com, Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH 2/2] psi: Add a missing SPDX license header
Date:   Mon, 25 Oct 2021 11:46:26 +0800
Message-Id: <1635133586-84611-2-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing SPDX license header to
include/linux/psi.h
include/linux/psi_types.h
kernel/sched/psi.c

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 include/linux/psi.h       | 1 +
 include/linux/psi_types.h | 1 +
 kernel/sched/psi.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 65eb147..a70ca83 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_PSI_H
 #define _LINUX_PSI_H
 
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300..bf50068 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_PSI_TYPES_H
 #define _LINUX_PSI_TYPES_H
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 526af84..3397fa0 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Pressure stall information for CPU, memory and IO
  *
-- 
1.8.3.1

