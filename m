Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A2E449F99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbhKIAkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhKIAkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:40:32 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C56BC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:37:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u11so17719769plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 16:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=n2y5uM6W39UUewevKc2q7vpt51dJGo4Ea4brCbFJv0w=;
        b=osLlh7wMKgm3zPegAe8U7FuoEoPOCP3zbMR683xR04/0AndAYJl/fjTqoPMtuai56i
         P5aJyfAi9XpG5tjOpfoLaNFSa8N7xGbfQun6YIkOQBvIzthQajl4AU2iYpZorIYFAgxG
         66u0ZJMmh6vE8hbrXFnf0GlYdrpcT/BV7z8Lsr+E7XaXhAdqOI3DpFJ2wxt49dB3dLEd
         1K4Hg6pWVk8MIrceEZogSexwkFzGY+kKipbbTT5zz5CyzF622UUs6SO4nqFPOVqQwJMO
         n/xbFoh49gkB1XnarxC0UatSuyT1wKJd/O46ZTQElmFpIuFw3pnYOUSwaV7uOjeU0pDB
         84wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=n2y5uM6W39UUewevKc2q7vpt51dJGo4Ea4brCbFJv0w=;
        b=GTTWBWQi6nuJQTScAhbjVSvJngTOSk3OltXa9rjsvnFblIDoaONrzJyyl7bJ+VhGkk
         NQ32PHwI/0XdFZFL7uJ8GV4NIhxXohSZGGTNcnNQp2rGKgd126n18/LSCDWETZe60LbL
         aixgwJ5K/KPp5vg/tORHQUU40Z1TC7mtfjmkAYow5YjM9+cMHTl/DFtvJUdmv4gF9CjN
         Aiy1Adu8JzSnvWY1F82jMtyLqv4YhTJtBUKlkm5btcDPBGuM8m0pX5Na8yEec5Qg3MqS
         ivKYjSlAaix8FeVPO+qcy2ZJfQq/p0cnxapj49b/2v/W0Xb5r3AK/KGmd0ExnBz9vbcK
         nyQQ==
X-Gm-Message-State: AOAM5307k9WtYsvRoRjDTcA4zxxHfUUMs3MBi3JbtoXY5BJQt0FKWdlH
        Sx2+bEGvb8kdVRdCUXHzil5+Dr3gz+bzTQ==
X-Google-Smtp-Source: ABdhPJyqVBxYAt7idy0hOca8/rOgyDPasaYfn7MRr9QBPjTtT9TWgAL6hc2NPatJbQrxxcLf1/gbLw==
X-Received: by 2002:a17:902:bcc4:b0:141:bfc4:ada with SMTP id o4-20020a170902bcc400b00141bfc40adamr2990079pls.20.1636418266871;
        Mon, 08 Nov 2021 16:37:46 -0800 (PST)
Received: from raspberrypi ([49.166.114.232])
        by smtp.gmail.com with ESMTPSA id c9sm13308705pgq.58.2021.11.08.16.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 16:37:46 -0800 (PST)
Date:   Tue, 9 Nov 2021 00:37:42 +0000
From:   Austin Kim <austindh.kim@gmail.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        austin.kim@lge.com
Subject: [PATCH] ALSA: missing check for possible NULL after the call to
 kstrdup
Message-ID: <20211109003742.GA5423@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

If kcalloc() return NULL due to memory starvation, it is possible for 
kstrdup() to return NULL in similar case. So add null check after the call 
to kstrdup() is made.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 sound/synth/emux/emux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 49d1976a132c..6dab3c5bac00 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -88,7 +88,7 @@ int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, ch
 	emu->name = kstrdup(name, GFP_KERNEL);
 	emu->voices = kcalloc(emu->max_voices, sizeof(struct snd_emux_voice),
 			      GFP_KERNEL);
-	if (emu->voices == NULL)
+	if ((emu->name == NULL) || (emu->voices == NULL))
 		return -ENOMEM;
 
 	/* create soundfont list */
-- 
2.20.1

