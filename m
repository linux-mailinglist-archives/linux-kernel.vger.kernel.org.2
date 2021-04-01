Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEA5350D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhDADcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:32:25 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:39198 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhDADcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:32:04 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 9CFB2E014C;
        Thu,  1 Apr 2021 11:32:01 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Wang Qing <wangqing@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH V2 2/4] doc: watchdog: Delete the explanation about "watchdog/%u".
Date:   Thu,  1 Apr 2021 11:31:32 +0800
Message-Id: <1617247900-23813-3-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617247900-23813-1-git-send-email-wangqing@vivo.com>
References: <1617247900-23813-1-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZShlMTkxCGB5JHU5NVkpNSkxJT0xCSUlISkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjI6Fjo6LT8ISzQcSRwpPSoq
        TEswCQJVSlVKTUpMSU9MQklJTUlCVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFITEpJNwY+
X-HM-Tid: 0a788b7ce8412c17kusn9cfb2e014c
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

