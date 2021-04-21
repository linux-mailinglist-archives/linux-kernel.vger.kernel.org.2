Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A637366B83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbhDUNC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240205AbhDUNCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B5646145B;
        Wed, 21 Apr 2021 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010132;
        bh=fOU2FDMvsE7xFnzExHkGW7apxotDv7PtnoucnB5KD/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXV5qKXMPP72gLnZFj7htLZFmBUElY7ZxVa7PfJ0qdnJbabC6CFdaQZ1mu8tw9bxG
         mFgP7C5Ymy0bbOXhT9+0vCcY/mGIEtQ06YjRy4UDB9ykup+g7zh/U9cLx+tea9yZui
         y7AvMLliHYNJ13VMaLL+D823a0d2e7kkG1KRQcXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 023/190] Revert "drm/radeon: fix multiple reference count leak"
Date:   Wed, 21 Apr 2021 14:58:18 +0200
Message-Id: <20210421130105.1226686-24-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6f2e8acdb48ed166b65d47837c31b177460491ec.

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
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 607ad5620bd9..ba8885676676 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -879,10 +879,8 @@ radeon_lvds_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0) {
-			pm_runtime_put_autosuspend(connector->dev->dev);
+		if (r < 0)
 			return connector_status_disconnected;
-		}
 	}
 
 	if (encoder) {
@@ -1027,10 +1025,8 @@ radeon_vga_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0) {
-			pm_runtime_put_autosuspend(connector->dev->dev);
+		if (r < 0)
 			return connector_status_disconnected;
-		}
 	}
 
 	encoder = radeon_best_single_encoder(connector);
@@ -1167,10 +1163,8 @@ radeon_tv_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0) {
-			pm_runtime_put_autosuspend(connector->dev->dev);
+		if (r < 0)
 			return connector_status_disconnected;
-		}
 	}
 
 	encoder = radeon_best_single_encoder(connector);
@@ -1253,10 +1247,8 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0) {
-			pm_runtime_put_autosuspend(connector->dev->dev);
+		if (r < 0)
 			return connector_status_disconnected;
-		}
 	}
 
 	if (radeon_connector->detected_hpd_without_ddc) {
@@ -1665,10 +1657,8 @@ radeon_dp_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0) {
-			pm_runtime_put_autosuspend(connector->dev->dev);
+		if (r < 0)
 			return connector_status_disconnected;
-		}
 	}
 
 	if (!force && radeon_check_hpd_status_unchanged(connector)) {
-- 
2.31.1

