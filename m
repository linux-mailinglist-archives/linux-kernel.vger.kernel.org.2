Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7334A4D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCZJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:45:27 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:33753 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhCZJpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:45:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UTMseJh_1616751899;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UTMseJh_1616751899)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Mar 2021 17:44:59 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: [PATCH 3/4] mm/page_reporting: Introduce "page_reporting_factor=" boot parameter
Date:   Fri, 26 Mar 2021 17:44:57 +0800
Message-Id: <1616751898-58393-4-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
References: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the default behaviour(value 100) is to do full report,
although we can control it after boot via "page_reporting_factor"
sysfs knob, it could still be late because some amount of memory
has already been reported before operating this knob.

Sometimes we really want it safely off by default and turn it on
as needed at runtime, so "page_reporting_factor=" boot parameter
is that guarantee and meets different default setting requirements.

There's also a real-world problem that I noticed on tiny instances,
it always reports some memory at boot stage before application
starts and uses up memory which retriggers EPT fault after boot.

The following data(right after boot) indicates that 172032KiB pages
were unnecessarily reported and refault in:
 $ cat /sys/kernel/mm/page_reporting/refault_kbytes
 172032
 $ cat /sys/kernel/mm/page_reporting/reported_kbytes
 0

Thus it's reasonable to turn the page reporting off by default and
enable it at runtime as needed.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 mm/page_reporting.c                             | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0454572..46e296c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3524,6 +3524,9 @@
 			off: turn off poisoning (default)
 			on: turn on poisoning
 
+	page_reporting_factor= [KNL] Guest Free Page Reporting percentile.
+			[0, 100]: 0 - off, not report; 100 - default, full report.
+
 	panic=		[KNL] Kernel behaviour on panic: delay <timeout>
 			timeout > 0: seconds before rebooting
 			timeout = 0: wait forever
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 86c6479..6ffedb8 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -524,3 +524,16 @@ static int __init page_reporting_init(void)
 }
 
 module_init(page_reporting_init);
+
+static int __init setup_reporting_factor(char *str)
+{
+	int v;
+
+	if (kstrtoint(str, 10, &v))
+		return -EINVAL;
+	if (v >= 0 && v <= 100)
+		reporting_factor = v;
+
+	return 0;
+}
+__setup("page_reporting_factor=", setup_reporting_factor);
-- 
1.8.3.1

