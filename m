Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3642AE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhJLU7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235332AbhJLU7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:59:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C514D60E74;
        Tue, 12 Oct 2021 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634072253;
        bh=ORNIYJ/ALpIy4LLb1oEO8vL255Aanf+O0vLYvdGo9KE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwR97oJDwPuycXUN/pe4D776Nx8CCoEx2iX+uLm3cI2w/M8Rbdt978Kdq2Oz2gJBS
         D1n+iDaxwzVQ89kxPb1k36egvfDtdljoVQOfU8y+ZTv8P6yGAul2zgm0t0FK2PEPmH
         Q250BiqF1jwqEQOnWCP/0CZIVsvMuONgMNfZJZUlIoZgXursb/uxLbizQ6bgfjhkHv
         H8RtMKQzvINEEBHIW5YYBdylPg+wEO8/IuIeYrprst8p8tc6DUFSQFmUSb1/f8Tlvl
         DCubu5oq8nU81LtWLEumZvS+LbqjJEwln0E5/7jTbGZQ90hSU2S7msZ+lWAzy1pfdX
         bLHpxwouiuIWw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] Docs/admin-guide/mm/damon: Document 'init_regions' feature
Date:   Tue, 12 Oct 2021 20:57:07 +0000
Message-Id: <20211012205711.29216-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012205711.29216-1-sj@kernel.org>
References: <20211012205711.29216-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds description of the 'init_regions' feature in the DAMON
usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 41 +++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index c0296c14babf..f7d5cfbb50c2 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -34,8 +34,9 @@ the reason, this document describes only the debugfs interface
 debugfs Interface
 =================
 
-DAMON exports four files, ``attrs``, ``target_ids``, ``schemes`` and
-``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
+DAMON exports five files, ``attrs``, ``target_ids``, ``init_regions``,
+``schemes`` and ``monitor_on`` under its debugfs directory,
+``<debugfs>/damon/``.
 
 
 Attributes
@@ -74,6 +75,42 @@ check it again::
 Note that setting the target ids doesn't start the monitoring.
 
 
+Initial Monitoring Target Regions
+---------------------------------
+
+In case of the debugfs based monitoring, DAMON automatically sets and updates
+the monitoring target regions so that entire memory mappings of target
+processes can be covered.  However, users can want to limit the monitoring
+region to specific address ranges, such as the heap, the stack, or specific
+file-mapped area.  Or, some users can know the initial access pattern of their
+workloads and therefore want to set optimal initial regions for the 'adaptive
+regions adjustment'.
+
+In such cases, users can explicitly set the initial monitoring target regions
+as they want, by writing proper values to the ``init_regions`` file.  Each line
+of the input should represent one region in below form.::
+
+    <target id> <start address> <end address>
+
+The ``target id`` should already in ``target_ids`` file, and the regions should
+be passed in address order.  For example, below commands will set a couple of
+address ranges, ``1-100`` and ``100-200`` as the initial monitoring target
+region of process 42, and another couple of address ranges, ``20-40`` and
+``50-100`` as that of process 4242.::
+
+    # cd <debugfs>/damon
+    # echo "42   1       100
+            42   100     200
+            4242 20      40
+            4242 50      100" > init_regions
+
+Note that this sets the initial monitoring target regions only.  In case of
+virtual memory monitoring, DAMON will automatically updates the boundary of the
+regions after one ``regions update interval``.  Therefore, users should set the
+``regions update interval`` large enough in this case, if they don't want the
+update.
+
+
 Schemes
 -------
 
-- 
2.17.1

