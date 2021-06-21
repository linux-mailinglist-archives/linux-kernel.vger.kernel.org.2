Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED8E3AF24A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhFURup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhFURuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:50:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9895460041;
        Mon, 21 Jun 2021 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624297709;
        bh=Sv96UtgUrAL3djAIvQ3JdyrHkmsXZzsWJDyXzJUITG8=;
        h=From:To:Cc:Subject:Date:From;
        b=n2ZM8ijuxERmVmylj3JNex7jQXue7RTKh22qdwwgnavlgT9N8fVc2rGiFfmTeB9u8
         khgGMYzDBWAxjVijpZhB/MBDCuERn88a5VhHG3LPS4zAkyuGSykfZVzrHEunTKbbzs
         uuapYtcGGw/PD5Aoh3DiQH/9NQWJxYi0l+BchuIZ7OR4MWJYExhqeAKazCKVjWvEVZ
         4nJU/gBgYEBJKMHiqR9jCNAFQD5ZBppJzY+rhUtvgGp0fK+d9yS/fMhWzFomFNkIhi
         NuBYQHkhLvvuJJTTNDjhZnfmjQN7I+8sMpyXzEIKszaX9O6Dj+IobpUWs40PLURwrp
         xkmLYV5nyhyDA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH] coccinelle: api: remove kobj_to_dev.cocci script
Date:   Mon, 21 Jun 2021 10:48:08 -0700
Message-Id: <20210621174808.1489111-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using kobj_to_dev() instead of container_of() is not universally
accepted among maintainers as an improvement. The warning leads to
repeated patch submissions that won't be accepted. Remove the script.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Denis Efremov <efremov@linux.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 scripts/coccinelle/api/kobj_to_dev.cocci | 45 ------------------------
 1 file changed, 45 deletions(-)
 delete mode 100644 scripts/coccinelle/api/kobj_to_dev.cocci

diff --git a/scripts/coccinelle/api/kobj_to_dev.cocci b/scripts/coccinelle/api/kobj_to_dev.cocci
deleted file mode 100644
index cd5d31c6fe76..000000000000
--- a/scripts/coccinelle/api/kobj_to_dev.cocci
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-///
-/// Use kobj_to_dev() instead of container_of()
-///
-// Confidence: High
-// Copyright: (C) 2020 Denis Efremov ISPRAS
-// Options: --no-includes --include-headers
-//
-// Keywords: kobj_to_dev, container_of
-//
-
-virtual context
-virtual report
-virtual org
-virtual patch
-
-
-@r depends on !patch@
-expression ptr;
-symbol kobj;
-position p;
-@@
-
-* container_of(ptr, struct device, kobj)@p
-
-
-@depends on patch@
-expression ptr;
-@@
-
-- container_of(ptr, struct device, kobj)
-+ kobj_to_dev(ptr)
-
-
-@script:python depends on report@
-p << r.p;
-@@
-
-coccilib.report.print_report(p[0], "WARNING opportunity for kobj_to_dev()")
-
-@script:python depends on org@
-p << r.p;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING opportunity for kobj_to_dev()")
-- 
2.25.4

