Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65683A9A25
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhFPM2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:28:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4813 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhFPM2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:28:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4knW0HxHzXfQB;
        Wed, 16 Jun 2021 20:21:35 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 20:26:36 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 20:26:35 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/3] scripts: add spelling_sanitizer.sh script
Date:   Wed, 16 Jun 2021 20:25:05 +0800
Message-ID: <20210616122507.896-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210616122507.896-1-thunder.leizhen@huawei.com>
References: <20210616122507.896-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file scripts/spelling.txt recorded a large number of spelling
"mistake||correction" pairs. These entries are currently maintained in
order, but the results are not strict. In addition, when someone wants to
add some new pairs, he either sort them manually or write a script, which
is clearly a waste of labor. So add this script. For all spelling
"mistake||correction" pairs, sort based on "correction", then on "mistake",
and remove duplicates. Sorting based on "mistake" first is not chosen
because it is uncontrollable.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 scripts/spelling_sanitizer.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100755 scripts/spelling_sanitizer.sh

diff --git a/scripts/spelling_sanitizer.sh b/scripts/spelling_sanitizer.sh
new file mode 100755
index 000000000000..603bb7e0e66b
--- /dev/null
+++ b/scripts/spelling_sanitizer.sh
@@ -0,0 +1,27 @@
+#!/bin/sh -efu
+# SPDX-License-Identifier: GPL-2.0
+
+# To get the traditional sort order that uses native byte values
+export LC_ALL=C
+
+cd ${0%/*}
+
+src=spelling.txt
+comments=`sed -n '/#/p' $src`
+
+# Convert the format of 'codespell' to the current
+sed -r -i 's/ ==> /||/' $src
+
+# For all spelling "mistake||correction" pairs(non-comment lines):
+# Sort based on "correction", then "mistake", and remove duplicates
+sed -n '/#/!p' $src | sort -u -t '|' -k 3 -k 1 -o $src
+
+# Backfill comment lines
+ln=0
+echo "$comments" | while read line
+do
+	let ln+=1
+	sed -i "$ln i\\$line" $src
+done
+
+cd - > /dev/null
-- 
2.25.1


