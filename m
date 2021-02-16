Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1631CBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBPOYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:24:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhBPOYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:24:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F259164DFF;
        Tue, 16 Feb 2021 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613485447;
        bh=f440vFXJMwGBO7gN3rlecJlKzKGZLlSPsNR3opHweiM=;
        h=From:To:Cc:Subject:Date:From;
        b=un27CtaZjbYINF/8+MuM6B6bA23fovXhoDdC4q3Uclh0fh0U5PYRBcnnFvMRY7EjS
         6c2xhjPyrgWHI7yB9T6RsqlSZZTvSG/pOpgfwwS537Ntkl1UObyvKcUHokwaernjVn
         qNWOoYDV/raHG8OmhDiS4hWoR8N1LGfPrVrcpRKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] driver core: component: remove dentry pointer in "struct master"
Date:   Tue, 16 Feb 2021 15:23:59 +0100
Message-Id: <20210216142400.3759099-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep around a pointer to a dentry when all it is
used for is to remove the debugfs file when tearing things down.  As the
name is simple, have debugfs look up the dentry when removing things,
keeping the logic much simpler.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/component.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index dcfbe7251dc4..272ba42392f0 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -65,7 +65,6 @@ struct master {
 	const struct component_master_ops *ops;
 	struct device *dev;
 	struct component_match *match;
-	struct dentry *dentry;
 };
 
 struct component {
@@ -125,15 +124,13 @@ core_initcall(component_debug_init);
 
 static void component_master_debugfs_add(struct master *m)
 {
-	m->dentry = debugfs_create_file(dev_name(m->dev), 0444,
-					component_debugfs_dir,
-					m, &component_devices_fops);
+	debugfs_create_file(dev_name(m->dev), 0444, component_debugfs_dir, m,
+			    &component_devices_fops);
 }
 
 static void component_master_debugfs_del(struct master *m)
 {
-	debugfs_remove(m->dentry);
-	m->dentry = NULL;
+	debugfs_remove(debugfs_lookup(dev_name(m->dev), component_debugfs_dir));
 }
 
 #else
-- 
2.30.1

