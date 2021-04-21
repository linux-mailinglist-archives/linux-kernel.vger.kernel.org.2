Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D391366B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbhDUNC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240114AbhDUNCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E97EF6142F;
        Wed, 21 Apr 2021 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010110;
        bh=JUrHT5dRqONlWJ7oT4+PvWhdNVh4D7cYT7RYgoCdPco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAm/gUvMJ2hqHIa2T8vNNKKhlCLprmVpiVYedwmGxSoTkwC1mmBbw2Vrok/whth8c
         OxA9OvUfpErIfvos6u+kvpXcqoe7YHtkPHr+GGULzlz+Tl3wThHkoMGjdH7xbxnr32
         vS9vUNpS3UEkD30uXruymcd9NofwZhbbnBKEKP2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 016/190] Revert "drm/nouveau: fix reference count leak in nouveau_debugfs_strap_peek"
Date:   Wed, 21 Apr 2021 14:58:11 +0200
Message-Id: <20210421130105.1226686-17-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8f29432417b11039ef960ab18987c7d61b2b5396.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index c2bc05eb2e54..c8da70e06006 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -54,10 +54,8 @@ nouveau_debugfs_strap_peek(struct seq_file *m, void *data)
 	int ret;
 
 	ret = pm_runtime_get_sync(drm->dev->dev);
-	if (ret < 0 && ret != -EACCES) {
-		pm_runtime_put_autosuspend(drm->dev->dev);
+	if (ret < 0 && ret != -EACCES)
 		return ret;
-	}
 
 	seq_printf(m, "0x%08x\n",
 		   nvif_rd32(&drm->client.device.object, 0x101000));
-- 
2.31.1

