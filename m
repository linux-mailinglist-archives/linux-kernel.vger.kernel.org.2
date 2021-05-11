Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9E37AA20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhEKPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhEKPCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CE2061364;
        Tue, 11 May 2021 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620745297;
        bh=8OWnxyINF4IimotgguBdQhBjBpmBAqKnwiD4LyY/94Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXsjczB4GhzMcA8GGvnc2EEzfWf7T/ilDbptkQWm16omF3hczfD1oHISx0Frvh81Z
         Ro/Pl+asIa5Vn3Mm2apN0gFOGd1o2U9GDjDA4ODNKuLsOHUA6NODDCVSz3zkZO/AYs
         xK8nweN08nDHtFHz8z4s9zLnFeK1zMRCa9NI3TgINQXXCYDUfUneN5yJxhYI/O5IO5
         89+6+B8/rKl2DaI4DJTeVnVMGOdIFCJK9/jEUmosu1nstpIKWmecNxKiBiekEFKfBZ
         laVikX9gGTjzGv/ZNY06sU+J/iGXngGhF3iVa53Nx7RrzTmEMtQbtUSnBD/8ZtDql3
         heG0l3Vx0nykg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgTt7-000k12-Qr; Tue, 11 May 2021 17:01:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] docs: cdrom-standard.rst: get rid of uneeded UTF-8 chars
Date:   Tue, 11 May 2021 17:01:28 +0200
Message-Id: <79c3f482da17ea48d69b6e6ad1b7fb102b9dd7bf.1620744606.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620744606.git.mchehab+huawei@kernel.org>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was converted from a LaTeX one. The conversion used
some UTF-8 characters at the literal blocks. Replace them
by normal ASCII characters.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/cdrom/cdrom-standard.rst | 30 +++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index 70500b189cc8..5845960ca382 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -146,18 +146,18 @@ with the kernel as a block device by registering the following general
 *struct file_operations*::
 
 	struct file_operations cdrom_fops = {
-		NULL,			/∗ lseek ∗/
-		block _read ,		/∗ read—general block-dev read ∗/
-		block _write,		/∗ write—general block-dev write ∗/
-		NULL,			/∗ readdir ∗/
-		NULL,			/∗ select ∗/
-		cdrom_ioctl,		/∗ ioctl ∗/
-		NULL,			/∗ mmap ∗/
-		cdrom_open,		/∗ open ∗/
-		cdrom_release,		/∗ release ∗/
-		NULL,			/∗ fsync ∗/
-		NULL,			/∗ fasync ∗/
-		NULL			/∗ revalidate ∗/
+		NULL,			/* lseek */
+		block _read ,		/* read--general block-dev read */
+		block _write,		/* write--general block-dev write */
+		NULL,			/* readdir */
+		NULL,			/* select */
+		cdrom_ioctl,		/* ioctl */
+		NULL,			/* mmap */
+		cdrom_open,		/* open */
+		cdrom_release,		/* release */
+		NULL,			/* fsync */
+		NULL,			/* fasync */
+		NULL			/* revalidate */
 	};
 
 Every active CD-ROM device shares this *struct*. The routines
@@ -250,12 +250,12 @@ The drive-specific, minor-like information that is registered with
 `cdrom.c`, currently contains the following fields::
 
   struct cdrom_device_info {
-	const struct cdrom_device_ops * ops; 	/* device operations for this major */
+	const struct cdrom_device_ops * ops;	/* device operations for this major */
 	struct list_head list;			/* linked list of all device_info */
 	struct gendisk * disk;			/* matching block layer disk */
 	void *  handle;				/* driver-dependent data */
 
-	int mask; 				/* mask of capability: disables them */
+	int mask;				/* mask of capability: disables them */
 	int speed;				/* maximum speed for reading data */
 	int capacity;				/* number of discs in a jukebox */
 
@@ -569,7 +569,7 @@ the *CDC_CLOSE_TRAY* bit in *mask*.
 
 In the file `cdrom.c` you will encounter many constructions of the type::
 
-	if (cdo->capability & ∼cdi->mask & CDC _⟨capability⟩) ...
+	if (cdo->capability & ~cdi->mask & CDC _<capability>) ...
 
 There is no *ioctl* to set the mask... The reason is that
 I think it is better to control the **behavior** rather than the
-- 
2.30.2

