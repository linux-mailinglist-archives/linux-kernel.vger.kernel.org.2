Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0B36E78E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbhD2JFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:05:50 -0400
Received: from mail-m17655.qiye.163.com ([59.111.176.55]:64050 "EHLO
        mail-m17655.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbhD2JFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:05:47 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.229])
        by mail-m17655.qiye.163.com (Hmail) with ESMTPA id 4A7D9400A7;
        Thu, 29 Apr 2021 17:04:57 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Wang Qing <wangqing@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Perches <joe@perches.com>, Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Chouquet-Stringer <me@mathieu.digital>
Subject: [PATCH V2,RESEND 2/4] doc: watchdog: Delete the explanation about "watchdog/%u".
Date:   Thu, 29 Apr 2021 17:04:26 +0800
Message-Id: <1619687073-24686-3-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619687073-24686-2-git-send-email-wangqing@vivo.com>
References: <1619687073-24686-2-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh8aGVZIGUxCSkMeSExNT0NVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006STo6PT8RHklNN0MLFzIe
        NSsKFDRVSlVKTUpCTUNMS0JDSk9KVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUJZV1kIAVlBSE5DQzcG
X-HM-Tid: 0a791cdfc5aeda01kuws4a7d9400a7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"watchdog/%u" threads has be replaced by cpu_stop_work. The current description
is extremely misleading, so delete the explanation about "watchdog/%u".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 .../admin-guide/kernel-per-CPU-kthreads.rst          | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index 531f689..5e51ee5
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -332,23 +332,3 @@ To reduce its OS jitter, do at least one of the following:
 	kthreads from being created in the first place.  However, please
 	note that this will not eliminate OS jitter, but will instead
 	shift it to RCU_SOFTIRQ.
-
-Name:
-  watchdog/%u
-
-Purpose:
-  Detect software lockups on each CPU.
-
-To reduce its OS jitter, do at least one of the following:
-
-1.	Build with CONFIG_LOCKUP_DETECTOR=n, which will prevent these
-	kthreads from being created in the first place.
-2.	Boot with "nosoftlockup=0", which will also prevent these kthreads
-	from being created.  Other related watchdog and softlockup boot
-	parameters may be found in Documentation/admin-guide/kernel-parameters.rst
-	and Documentation/watchdog/watchdog-parameters.rst.
-3.	Echo a zero to /proc/sys/kernel/watchdog to disable the
-	watchdog timer.
-4.	Echo a large number of /proc/sys/kernel/watchdog_thresh in
-	order to reduce the frequency of OS jitter due to the watchdog
-	timer down to a level that is acceptable for your workload.
-- 
2.7.4

