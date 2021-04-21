Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E2366BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbhDUNKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241166AbhDUNH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19F436145F;
        Wed, 21 Apr 2021 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010412;
        bh=tXhwHrQjM/MUkGAK74GpiMqgStymNpSE9Hz33q2RfeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dubXe1aOdyLVr/SGMikvFUEyM6lmacEaluFHhDEqQZmde8WQNIH7mz0zBeufONOIH
         nJeNhtS97hYM5kP4HR1HxNrZZ9MK+jzQ/9fQUHur2G+UPVXNS0WdgmEG3aFDzVOL/k
         NTCRxEsqC2sv228P3KKmmR9DRI8D8+Ay6YPpr/IA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 127/190] Revert "ALSA: sb8: add a check for request_region"
Date:   Wed, 21 Apr 2021 15:00:02 +0200
Message-Id: <20210421130105.1226686-128-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit dcd0feac9bab901d5739de51b3f69840851f8919.

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
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/isa/sb/sb8.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index 6c9d534ce8b6..95290ffe5c6e 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -95,10 +95,6 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 
 	/* block the 0x388 port to avoid PnP conflicts */
 	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");
-	if (!acard->fm_res) {
-		err = -EBUSY;
-		goto _err;
-	}
 
 	if (port[dev] != SNDRV_AUTO_PORT) {
 		if ((err = snd_sbdsp_create(card, port[dev], irq[dev],
-- 
2.31.1

