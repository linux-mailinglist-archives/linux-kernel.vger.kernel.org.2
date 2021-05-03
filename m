Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF893714CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhECMBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233797AbhECMAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:00:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DC5861278;
        Mon,  3 May 2021 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043193;
        bh=SzDGfhquslCwzjzASJiDtvl3gviPMY2fDtU3Wo3Wv+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUqRXbVnLoLTXHBp6lQl+ElucQvl4VCvFOqu02ItwD/TNpEXfp3x9kx5P9pclgRZE
         9mQRUjp8dVwV4kmbltYpon/nJ3FxDLHyfTBXXtMfh7pIFDoIchia1oLRAYol/Vgr0b
         QPpMXk+cfbWYWu/a74UPlNqX9ZHPB4EjqhRp8KBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kurt Manucredo <fuzzybritches0@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 33/69] ALSA: gus: properly handle snd_ctl_add() error
Date:   Mon,  3 May 2021 13:57:00 +0200
Message-Id: <20210503115736.2104747-34-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kurt Manucredo <fuzzybritches0@gmail.com>

snd_gus_init_control() does not properly return any possible error that
might have happened in a call to snd_ctl_add() so resolve this by
propagating the error back up the call change correctly.

Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kurt Manucredo <fuzzybritches0@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/isa/gus/gus_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index b7518122a10d..4c2703ea55fb 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -75,10 +75,11 @@ static const struct snd_kcontrol_new snd_gus_joystick_control = {
 	.put = snd_gus_joystick_put
 };
 
-static void snd_gus_init_control(struct snd_gus_card *gus)
+static int snd_gus_init_control(struct snd_gus_card *gus)
 {
 	if (!gus->ace_flag)
-		snd_ctl_add(gus->card, snd_ctl_new1(&snd_gus_joystick_control, gus));
+		return snd_ctl_add(gus->card, snd_ctl_new1(&snd_gus_joystick_control, gus));
+	return 0;
 }
 
 /*
@@ -386,8 +387,7 @@ static int snd_gus_check_version(struct snd_gus_card * gus)
 	}
 	strcpy(card->shortname, card->longname);
 	gus->uart_enable = 1;	/* standard GUSes doesn't have midi uart trouble */
-	snd_gus_init_control(gus);
-	return 0;
+	return snd_gus_init_control(gus);
 }
 
 int snd_gus_initialize(struct snd_gus_card *gus)
-- 
2.31.1

