Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD11D450314
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKOLJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:09:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237636AbhKOLI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:08:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D995263221;
        Mon, 15 Nov 2021 11:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636974331;
        bh=5fCH/51HhaXkOh8VQtleNXMxWRoiP7B33co1eOdO33s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mw3x9qw65hz3GvHo5X8bANH1WkRx7u3snILf/4clnQefbD+vPNkf5kk3nqqCQZqvi
         qs/ODpG0HwRFF+rY/RYzCEp8ty8tLuDWELdETYir6kZQd7nt5Zg2hJlw3uVu0Nxno/
         4P1CLJ5CuszXqOOKY3NV90elCcocIT1NtiKGVU5xnzIt5Jdxmg1j6iqYPz+H9r1RZm
         uPaPK5V20iSySsqqyibuN1ECyAStjl//M3pWRVNbur+s5IZVtQKiKtaAD+RVjolNeN
         71OljrAHrWrFynWo36/pA2QQdXBlnER5q1L/IFHulCyVpOcXfr65OOLFtWoU+0q5nb
         i81AEPK2du9MA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 5/7] habanalabs: align debugfs documentation to alphabetical order
Date:   Mon, 15 Nov 2021 13:05:19 +0200
Message-Id: <20211115110521.783103-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115110521.783103-1-ogabbay@kernel.org>
References: <20211115110521.783103-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Move an entry in the debugfs documentation to align with the
alphabetical order which is kept this file.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs        | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index 6085ee506135..2667cbf940f3 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -21,11 +21,11 @@ Description:    Allow the root user to disable/enable in runtime the clock
                 a different engine to disable/enable its clock gating feature.
                 The bitmask is composed of 20 bits:
 
-		=======   ============
+                =======   ============
                 0  -  7   DMA channels
                 8  - 11   MME engines
                 12 - 19   TPC engines
-		=======   ============
+                =======   ============
 
                 The bit's location of a specific engine can be determined
                 using (1 << GAUDI_ENGINE_ID_*). GAUDI_ENGINE_ID_* values
@@ -233,12 +233,6 @@ Description:    Gets the state dump occurring on a CS timeout or failure.
                 Writing an integer X discards X state dumps, so that the
                 next read would return X+1-st newest state dump.
 
-What:           /sys/kernel/debug/habanalabs/hl<n>/timeout_locked
-Date:           Sep 2021
-KernelVersion:  5.16
-Contact:        obitton@habana.ai
-Description:    Sets the command submission timeout value in seconds.
-
 What:           /sys/kernel/debug/habanalabs/hl<n>/stop_on_err
 Date:           Mar 2020
 KernelVersion:  5.6
@@ -246,6 +240,12 @@ Contact:        ogabbay@kernel.org
 Description:    Sets the stop-on_error option for the device engines. Value of
                 "0" is for disable, otherwise enable.
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/timeout_locked
+Date:           Sep 2021
+KernelVersion:  5.16
+Contact:        obitton@habana.ai
+Description:    Sets the command submission timeout value in seconds.
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/userptr
 Date:           Jan 2019
 KernelVersion:  5.1
-- 
2.25.1

