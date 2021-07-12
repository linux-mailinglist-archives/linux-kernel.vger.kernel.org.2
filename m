Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A23C409D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 02:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhGLAyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 20:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhGLAyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 20:54:05 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9432C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 17:51:17 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z12so12676814qtj.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 17:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ntp2N+FnF9cu5TY3c6BDZ2BT3tHEvf2ZI4kcZulyHTY=;
        b=uHRAjl4KstuBPiKhxZ/W2fwEeSj+KSOWzTOs7yoFGqBCagx4RutvdyTA4i9jzSxs6r
         qMeTPktyK+HLKWxe1tFIbZ4vEica8vJqrKnuk5vh98okN7K1OOxKmYWXFdBpsYrv11aL
         VSYymD+OdKs74nc6yPT6P/mGeINh0QMJebIj5hZblC47OyGHWJpJhVRjKr+MuLYStI2J
         PPwNdB6fvbSHB8YAgkX7hJwhpi+z/beYQKDkqY7U5I3hzLBVW4hw5PHsB1nyIcLxweCu
         6IvG0Y4jVRSFUwMTxoqjC7B/MrI23J1jDv6YUQkefqj8hCpDuKkYE8iGZGxL0k25+urj
         GIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ntp2N+FnF9cu5TY3c6BDZ2BT3tHEvf2ZI4kcZulyHTY=;
        b=NqBsEBi4zPxRZGveBEXR42V+YO0a3ST8zNBUHX3kMZft0xS9JHecqT43TTOLI9TW3Q
         of5/IgG6F0IqKhonmljRKq6FHRBh6dfz7VuEWTjCf+7dpF7VXt5AtalT3Iv69aShL+Hn
         G8Z3M3uokhJ/y0DrM7Ls0q+iRHjWcKcNMQs5k/3oAnJg3eDDDHHCpW0sSks54Ib5Jz9W
         qbHdy4NkI7LDAjeqsChRjh2H9snJln7dS1Nfs9g+G5Nd9WVz5yaDcYYT0A620/+mM4Ve
         d84FY9Sv1pRoX2H3ZtPOZ6Ag5E0Dk0k2mbJwFbxP8vdUJiaeVBSr3vq7R4yZRKVNPsBK
         lOAw==
X-Gm-Message-State: AOAM532FUSmk7opnL7QaWZzx9+drBoVJtLWRTRqBTYYCQwurc2fpBKsX
        M4X/EXWbtmpXQ77EIclVlbI=
X-Google-Smtp-Source: ABdhPJzNcone+ITVv7tkPYfnB6EEZgMOxjj87y/qt9w5WIUrmXKgrsDgfl4sb4P2cLPSiGqztPWqmg==
X-Received: by 2002:ac8:7c85:: with SMTP id y5mr43954762qtv.376.1626051076421;
        Sun, 11 Jul 2021 17:51:16 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id x15sm5783823qkm.66.2021.07.11.17.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 17:51:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: rt5631: Fix regcache sync errors on resume
Date:   Mon, 12 Jul 2021 03:50:11 +0300
Message-Id: <20210712005011.28536-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Schwalm <maxim.schwalm@gmail.com>

The ALC5631 does not like multi-write accesses, avoid them. This fixes:

rt5631 4-001a: Unable to sync registers 0x3a-0x3c. -121

errors on resume from suspend (and all registers after the registers in
the error not being synced).

Inspired by commit 2d30e9494f1e ("ASoC: rt5651: Fix regcache sync errors
on resume") from Hans de Geode, which fixed the same errors on ALC5651.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
---
 sound/soc/codecs/rt5631.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 3000bc128b5b..38356ea2bd6e 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1695,6 +1695,8 @@ static const struct regmap_config rt5631_regmap_config = {
 	.reg_defaults = rt5631_reg,
 	.num_reg_defaults = ARRAY_SIZE(rt5631_reg),
 	.cache_type = REGCACHE_RBTREE,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static int rt5631_i2c_probe(struct i2c_client *i2c,
-- 
2.32.0

