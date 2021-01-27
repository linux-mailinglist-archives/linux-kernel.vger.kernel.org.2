Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037A1305738
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhA0JpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:45:00 -0500
Received: from m12-18.163.com ([220.181.12.18]:56947 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234460AbhA0Jnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Qhvx+
        Knp26+i+QuDp7Oc/cuqMXt2WbaoYJqljrF9deI=; b=RMoQMdtrdAuHeBPenVMwj
        k7MDbbL1I4360F/4MfSAfto8+kqHUaVFXUEjAXkPaTdONPvHDnGZd119DaY9xx8k
        /OI2X3eXMRSOV9klnTDnLK1wl1q6MASLEOPfHsRUTU40RfaBCEYQHD/B/lBc09Gd
        MzXWtCM8a7zm1EQ4KvwCTM=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAA3PgJ01xBg1QreRA--.28066S2;
        Wed, 27 Jan 2021 11:01:09 +0800 (CST)
From:   dingsenjie@163.com
To:     akpm@linux-foundation.org, colin.king@canonical.com,
        naoki.hayama@lineo.co.jp, xndchn@gmail.com, sjpark@amazon.de,
        ebiggers@google.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] scripts/spelling.txt: increase error-prone spell checking
Date:   Wed, 27 Jan 2021 11:01:05 +0800
Message-Id: <20210127030105.7244-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAA3PgJ01xBg1QreRA--.28066S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUhSdyUUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbipRUnyFUMcFIUcwAAsD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Increase allocted spelling error check.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 953f4a2..5fa8ec2 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -103,6 +103,7 @@ alloated||allocated
 allocatote||allocate
 allocatrd||allocated
 allocte||allocate
+allocted||allocated
 allpication||application
 alocate||allocate
 alogirhtms||algorithms
-- 
1.9.1


