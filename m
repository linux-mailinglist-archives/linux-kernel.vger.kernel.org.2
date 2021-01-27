Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6773060F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhA0Q0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:26:04 -0500
Received: from mail-m973.mail.163.com ([123.126.97.3]:57874 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhA0QZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hjAQg
        72DsEIZ+Ey6+22wZHDMCqauOkUOV9p7pmt86tc=; b=TTDIHSJ4pXQSWJeic4ZYx
        2JLRhfGhFilQmUx+xtD51UFhtWoi18dmCWznKfzIe4bsEDYyiq1nUJ1vlR4AsZPy
        sLjOC6+6wLjaIr/asu7Q9EtX9j9TJnEOzFjAx6V9c+agAOiCfTSkYnoNZ+U+HM3y
        6/F945dDaXM+6Uesh+N+e4=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp3 (Coremail) with SMTP id G9xpCgBH3MgKIhFgTAg4Uw--.52268S2;
        Wed, 27 Jan 2021 16:19:28 +0800 (CST)
From:   dingsenjie@163.com
To:     akpm@linux-foundation.org, colin.king@canonical.com,
        naoki.hayama@lineo.co.jp, xndchn@gmail.com, sjpark@amazon.de,
        ebiggers@google.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH v2] scripts/spelling.txt: add "allocted" and "exeeds" typo
Date:   Wed, 27 Jan 2021 16:19:19 +0800
Message-Id: <20210127081919.1928-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBH3MgKIhFgTAg4Uw--.52268S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr47urWfuFy3uw1kKryDKFg_yoW3Cwb_u3
        W8twn5WFyDtFsrtwn0yrWFqr4Fg3yUCrW0gF93Ww1fuas8AF4vy3ZxKryUuF47W39FyFn8
        Z39Igr4xKw1IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeEdgJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbipRUnyFUMcFIUcwADsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Increase "allocted" and "exeeds" spelling error check.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 scripts/spelling.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 953f4a2..f326473 100644
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
@@ -574,6 +575,7 @@ excellant||excellent
 execeeded||exceeded
 execeeds||exceeds
 exeed||exceed
+exeeds||exceeds
 exeuction||execution
 existance||existence
 existant||existent
-- 
1.9.1

