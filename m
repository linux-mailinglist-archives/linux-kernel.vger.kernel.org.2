Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C93E3C8464
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbhGNMWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:22:38 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:14630 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhGNMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1626265186; x=1657801186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nv5nk+ECy/d9fRDzwKxZzJlxuyKt8LLKdgHIZPWRSZw=;
  b=qSP25WcN/OUtTBromxjw9RTWclKkLV3cLea/lUNwhtJQh993+FZkfA9G
   Ax10D4nLEZTsKaBJGFYEwTcEIOWCB9HPP8UVxno1NyJMy0FN30piDR9vh
   7re00SpYaVP3WMXT1HGwfRWgEww1OE7ymwLgQ1agrfu7JtwYMEyuxClKP
   g=;
X-IronPort-AV: E=Sophos;i="5.84,239,1620691200"; 
   d="scan'208";a="126827527"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 14 Jul 2021 12:07:47 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id D05B92208F6;
        Wed, 14 Jul 2021 12:07:46 +0000 (UTC)
Received: from EX13D02ANC003.ant.amazon.com (10.43.157.69) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 14 Jul 2021 12:07:46 +0000
Received: from 147ddabc1818.ant.amazon.com (10.43.162.164) by
 EX13D02ANC003.ant.amazon.com (10.43.157.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 14 Jul 2021 12:07:43 +0000
From:   Takahiro Itazuri <itazur@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Takahiro Itazuri <itazur@amazon.com>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kuniyuki Iwashima" <kuniyu@amazon.co.jp>, <trivial@kernel.org>
Subject: [PATCH] pid: Cleanup the stale comment mentioning pidmap_init().
Date:   Wed, 14 Jul 2021 21:07:13 +0900
Message-ID: <20210714120713.19825-1-itazur@amazon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.164]
X-ClientProxiedBy: EX13D11UWB002.ant.amazon.com (10.43.161.20) To
 EX13D02ANC003.ant.amazon.com (10.43.157.69)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pidmap_init() has already been replaced with pid_idr_init() in the
commit 95846ecf9dac ("pid: replace pid bitmap implementation with
IDR API").
Cleanup the stale comment which still mentions it.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 include/linux/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/threads.h b/include/linux/threads.h
index 18d5a74bcc3d..c34173e6c5f1 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -38,7 +38,7 @@
  * Define a minimum number of pids per cpu.  Heuristically based
  * on original pid max of 32k for 32 cpus.  Also, increase the
  * minimum settable value for pid_max on the running system based
- * on similar defaults.  See kernel/pid.c:pidmap_init() for details.
+ * on similar defaults.  See kernel/pid.c:pid_idr_init() for details.
  */
 #define PIDS_PER_CPU_DEFAULT	1024
 #define PIDS_PER_CPU_MIN	8
-- 
2.31.1

