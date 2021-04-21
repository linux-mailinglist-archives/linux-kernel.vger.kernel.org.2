Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0979366BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbhDUNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235498AbhDUNGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18B3261460;
        Wed, 21 Apr 2021 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010364;
        bh=2SmpOiAckK4r3FH+icD89b5FS1+11HrHz+5UHFlZhbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iePLFhU1ZtY/TfJUOGpmnZOricEnJmMa9OZjUJDihbWMIXm5kSTksmU6P3/S6FyrE
         MXff2gYja6QEqEekZVgNBQWUqT2VGvQHzE84hcjQj7FubH6e0LPnNA2I0m1HhzrY4v
         weS14PXV8Mw3Qrbpk1u+RxJtHh2MQVUrgaUQYFp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 074/190] Revert "drm/gma500: fix memory disclosures due to uninitialized bytes"
Date:   Wed, 21 Apr 2021 14:59:09 +0200
Message-Id: <20210421130105.1226686-75-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ec3b7b6eb8c90b52f61adff11b6db7a8db34de19.

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

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: https
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index 129f87971002..f74041a102d9 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -129,7 +129,6 @@ static bool mrst_sdvo_find_best_pll(const struct gma_limit_t *limit,
 	s32 freq_error, min_error = 100000;
 
 	memset(best_clock, 0, sizeof(*best_clock));
-	memset(&clock, 0, sizeof(clock));
 
 	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
 		for (clock.n = limit->n.min; clock.n <= limit->n.max;
@@ -186,7 +185,6 @@ static bool mrst_lvds_find_best_pll(const struct gma_limit_t *limit,
 	int err = target;
 
 	memset(best_clock, 0, sizeof(*best_clock));
-	memset(&clock, 0, sizeof(clock));
 
 	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
 		for (clock.p1 = limit->p1.min; clock.p1 <= limit->p1.max;
-- 
2.31.1

