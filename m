Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3C426715
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhJHJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238284AbhJHJrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:47:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFD146103C;
        Fri,  8 Oct 2021 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633686326;
        bh=uC4W2jWbff4o+8j/4jlq8gabmGnb3ze9ixSc1qm46Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovmuYHnBibd0vBnkLzr8AdxGIe9UdvMWk7Z5F1lRlIYZyfrNf5GwfP/wt7IvnAgR1
         ODumsHwxe5W1Imwm4HrV7iUwhJIhc9cPICAgASxRlhYcCF05MDWgHNcOjSOjvj4o6S
         As343tN6Vjhi/LmLhQbyqd/bQS4gzK2bRiGTWL3BGLnTyP+4inKjDIS37B95LiBq2w
         FefVAZjFLFl2Y2lufEvh45Tq/OyA6xlPm/n6TRinBq8cA03XNPaOELifeXEEE1AJzg
         JZ6qE+8eWzu5x/HAzJmzcDg6mi56FDQzvHd1qoGRe8MFcMS7UMXmdxaoM0Oto8rP8j
         blsphceiKOKOw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Docs/damon/usage: Update for the record feature
Date:   Fri,  8 Oct 2021 09:45:09 +0000
Message-Id: <20211008094509.16179-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008094509.16179-1-sj@kernel.org>
References: <20211008094509.16179-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates the usage document for the record feature of DAMON.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 22 ++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index c0296c14babf..9973dac7101e 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -34,8 +34,8 @@ the reason, this document describes only the debugfs interface
 debugfs Interface
 =================
 
-DAMON exports four files, ``attrs``, ``target_ids``, ``schemes`` and
-``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
+DAMON exports five files, ``attrs``, ``target_ids``, ``record``, ``schemes``
+and ``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
 
 
 Attributes
@@ -74,6 +74,24 @@ check it again::
 Note that setting the target ids doesn't start the monitoring.
 
 
+Record
+------
+
+This debugfs file allows you to record monitored access patterns in a regular
+binary file.  The recorded results are first written in an in-memory buffer and
+flushed to a file in batch.  Users can get and set the size of the buffer and
+the path to the result file by reading from and writing to the ``record`` file.
+For example, below commands set the buffer to be 4 KiB and the result to be
+saved in ``/damon.data``. ::
+
+    # cd <debugfs>/damon
+    # echo "4096 /damon.data" > record
+    # cat record
+    4096 /damon.data
+
+The recording can be disabled by setting the buffer size zero.
+
+
 Schemes
 -------
 
-- 
2.17.1

