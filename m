Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439A6394353
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhE1NTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhE1NTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:19:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A938C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:18:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h12so1603422plf.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RekKeBRuPvOLorDIGSFgCHT4XDxldmZcH/AplJmkZg4=;
        b=Lbqovj2FNhk/oTCo9MepudU1cGkrJPNCJaqnlYyVZnuL/txKOIBaRi1vI8Egu32pvb
         OY6Qv6nGOuvXBdL6Xfe7BuPCEqDahinPHS7yzXuBOBF6ZsrgGGW9OfOpLJaRalJlZCD3
         Wt8rlAYcbY9MhRBL2a8CJtmI8w/HcoTW2XGJWlVGsVJAI7B7moh9ji3ebEi7HGGF7lR3
         Q0IYFc8YPdrwKdLwymCPAguav9spxQ/NQIITTsDLNQZZolBitHOBhFTnQpnGhBc84NNJ
         jnKAO72mn/zGI9L1MCg+StdVbk7DauGnBkDkhPHUO5BLEh8SBP8B04idJ2E8lwV280uu
         lxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RekKeBRuPvOLorDIGSFgCHT4XDxldmZcH/AplJmkZg4=;
        b=LWR99Xv8ZgQp6qSMriRltJh0mi+X6lcu/5iU/1l5bxgL1xSuTpqFX+HYxr4tLXGRRZ
         bALL9t/c4oY7exoJz7LiG79YuojiioPzIhpA0rfSGRZWIKs8yEwmHOsbhfrQqouTfarM
         RY5AfPZ5PxWDHW0HHQLLtNiLFF9dZJB4bHTgXMHUcS0n6leeyJ1eHE9JPA7QRV1VBMDQ
         A4bJF0uKb2fc1VIi0vKwKABZLFDXlG7lGuoKYz4s3SjlpFKS7sj4cc/bMpfXhwSEDQEk
         BK86Ws5QofZAMxf6JvSc+ftf54E62hg8AfqUgtKR2z3OlIMmGgP7cpeJV1L4kWziVqqC
         xRdA==
X-Gm-Message-State: AOAM533L1dMMirgXePKSsvtxqNTrz9p7JActNtnenfv6ifbSnyKChScd
        iVOTrJn4LSZ/gaapkpallE8=
X-Google-Smtp-Source: ABdhPJzryubmTPDP2z1b/tbJbHKXZ2rBe/YITBtt9HuUVeIwQ3mYeeGMwEngIKawI/ISHIrHdgoO1A==
X-Received: by 2002:a17:902:70c2:b029:ee:b4e5:64d5 with SMTP id l2-20020a17090270c2b02900eeb4e564d5mr7957845plt.77.1622207890484;
        Fri, 28 May 2021 06:18:10 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.113])
        by smtp.gmail.com with ESMTPSA id cu2sm4246045pjb.43.2021.05.28.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:18:09 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, dan.carpenter@oracle.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Subject: [PATCH] ALSA: control led: fix memory leak in snd_ctl_led_register
Date:   Fri, 28 May 2021 21:17:57 +0800
Message-Id: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snd_ctl_led_sysfs_add and snd_ctl_led_sysfs_remove should contain
the refcount operations in pair. However, snd_ctl_led_sysfs_remove fails
to decrease the refcount to zero, which causes device_release never to
be invoked. This leads to memory leak to some resources, like struct
device_private.

Fix this by calling put_device at the end of snd_ctl_led_sysfs_remove

Reported-by: syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Fixes: a135dfb5de1 ("ALSA: led control - add sysfs kcontrol LED marking layer")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 sound/core/control_led.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 25f57c14f294..fff2688b5019 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -371,6 +371,10 @@ static void snd_ctl_led_disconnect(struct snd_card *card)
 	snd_ctl_led_refresh();
 }
 
+static void snd_ctl_led_release(struct device *dev)
+{
+}
+
 /*
  * sysfs
  */
@@ -663,6 +667,7 @@ static void snd_ctl_led_sysfs_add(struct snd_card *card)
 		led_card->number = card->number;
 		led_card->led = led;
 		device_initialize(&led_card->dev);
+		led_card->dev.release = snd_ctl_led_release;
 		if (dev_set_name(&led_card->dev, "card%d", card->number) < 0)
 			goto cerr;
 		led_card->dev.parent = &led->dev;
@@ -701,6 +706,7 @@ static void snd_ctl_led_sysfs_remove(struct snd_card *card)
 		sysfs_remove_link(&card->ctl_dev.kobj, link_name);
 		sysfs_remove_link(&led_card->dev.kobj, "card");
 		device_del(&led_card->dev);
+		put_device(&led_card->dev);
 		kfree(led_card);
 		led->cards[card->number] = NULL;
 	}
-- 
2.25.1

