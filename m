Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C163714CD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhECMBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233796AbhECMAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:00:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C97F611CB;
        Mon,  3 May 2021 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043191;
        bh=FpoHwiCGhyzUbUxY9U1eL9CUuAQM3upWdIJt5TGAnt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEC5xDhMLl3c9IPkIbW+1uvU6RimCQpZVNjSRh8njgn+lHg+X4WHArtprs2xNT0Re
         HrgeeJBG7tUC+57uzyTywxLnCUD+dx5wV5BB8WSJyi2LdbmtAj9uVunYX7rdmT/3fK
         AOmwC4qlMwMom48waz/jsuQczn3b0JegP5pBrjDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 32/69] Revert "ALSA: gus: add a check of the status of snd_ctl_add"
Date:   Mon,  3 May 2021 13:56:59 +0200
Message-Id: <20210503115736.2104747-33-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0f25e000cb4398081748e54f62a902098aa79ec1.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

The original commit did nothing if there was an error, except to print
out a message, which is pointless.  So remove the commit as it gives a
"false sense of doing something".

Cc: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/isa/gus/gus_main.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index afc088f0377c..b7518122a10d 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -77,17 +77,8 @@ static const struct snd_kcontrol_new snd_gus_joystick_control = {
 
 static void snd_gus_init_control(struct snd_gus_card *gus)
 {
-	int ret;
-
-	if (!gus->ace_flag) {
-		ret =
-			snd_ctl_add(gus->card,
-					snd_ctl_new1(&snd_gus_joystick_control,
-						gus));
-		if (ret)
-			snd_printk(KERN_ERR "gus: snd_ctl_add failed: %d\n",
-					ret);
-	}
+	if (!gus->ace_flag)
+		snd_ctl_add(gus->card, snd_ctl_new1(&snd_gus_joystick_control, gus));
 }
 
 /*
-- 
2.31.1

