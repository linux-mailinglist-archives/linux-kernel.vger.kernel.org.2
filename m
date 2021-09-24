Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4997641873D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhIZICG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 04:02:06 -0400
Received: from ssh248.corpemail.net ([210.51.61.248]:62440 "EHLO
        ssh248.corpemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhIZICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 04:02:05 -0400
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((LNX1044)) with ASMTP (SSL) id UJB00124;
        Sun, 26 Sep 2021 16:00:24 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2308.14; Sun, 26 Sep 2021 16:00:25 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <john.stultz@linaro.org>, <tglx@linutronix.de>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Kai Song <songkai01@inspur.com>
Subject: [PATCH] time:Fix an incorrect function name in the comment
Date:   Sat, 25 Sep 2021 01:43:23 +0800
Message-ID: <20210924174323.20770-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   20219261600240cb5621c8e94d41cac0fab88de25d525
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We fix the following warning when building kernel with W=1:
kernel/time/time.c:479: warning: expecting prototype for set_normalized_timespec(). Prototype was for set_normalized_timespec64() instead

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 kernel/time/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 29923b20e0e4..77bac462b7da 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -462,7 +462,7 @@ struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
 EXPORT_SYMBOL(ns_to_kernel_old_timeval);
 
 /**
- * set_normalized_timespec - set timespec sec and nsec parts and normalize
+ * set_normalized_timespec64 - set timespec sec and nsec parts and normalize
  *
  * @ts:		pointer to timespec variable to be set
  * @sec:	seconds to set
-- 
2.27.0

