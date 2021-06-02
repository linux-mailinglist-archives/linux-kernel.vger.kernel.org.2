Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA602398646
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhFBKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhFBKTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810DBC06138C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p13-20020a05600c358db029019f44afc845so1331779wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tYu84XEdUSREmqYuOdJdmWRVylLsrzssqO4s6Rt4FM=;
        b=dNNpkAf0u21yPj8DOlUixn9NR1aoURLKxFc1WiwjrFPrVxOAKf5UbiJx39t/8Dz5jT
         ZwPGgfft+ER8lPeZzFD1v0CQRDoEl7ehn9dZYXUqD0p79/q0QEgiPE6nWpz7t6BMXhwF
         jfmKtDLhFy3aVmB5LmXG3VgKChzEQbvaMqVy+AGf9cAxW9Sb3QHoYAbdTtjTRlfVRklT
         2yZA7INgiKYonhkPE51/YlJm1FWR2AemX4fpKICC9TYB/LsXBLgd6TYnoj7iGx7gS/Rb
         pPm5qg3b2KzeuErA+NJmw/bUp9pPGeCqF17Ho9D1pc5PXs0aWuLqLn6KGpkdi/1OhhAA
         CdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tYu84XEdUSREmqYuOdJdmWRVylLsrzssqO4s6Rt4FM=;
        b=tc/0bAPYMZhu1CzTjq7jLiJoiYodPi/8feVxg/+QZgDg/d4AWqxysI6eejshwgQqcK
         vM0tnhxNPVGUkZ+sC4J6Eok6gKIWhgpMSOUkpJhkFoQr0iyKz/zvdF26cAsevG2XIFyJ
         398hxyONn2Yap2thrAIoxZ0oJ6j3I8EhYHvjNmsELyYuJ2xo7gksXuXK3F0ummaJtrwg
         OxxndPPZm6jWp3/1K1iKACLHlVRLsNDsJ5wOsKTTjsjE32A+hUUIfP861UoPvC8KM5Ux
         QEaIiT7MU+hzCh/RUAVWLu28o4QNd3wUzr1EkXr7fZZekV4crH5derk028/BP9dpLCPn
         Cq3Q==
X-Gm-Message-State: AOAM532GvHZ+7vLZy8Xjq7HCAzSr/30Lx4izGrHQzJ18Ui+8mEg5IxQJ
        /tf35vkcNVniTNN/XrG6IBITow==
X-Google-Smtp-Source: ABdhPJxBuw05znOQnIu8WhxlpMLB4/v32lhm44FXCUfzaGCOZA2x1XW5M0Hi3oGGlUfoNsjg5AoA/Q==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr4475789wmk.118.1622629069181;
        Wed, 02 Jun 2021 03:17:49 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Scott Snyder <snyder@fnald0.fnal.gov>,
        Erik Andersen <andersee@debian.org>,
        Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
Subject: [PATCH 16/21] ide: ide-cd: Demote kernel-doc abuse
Date:   Wed,  2 Jun 2021 11:17:17 +0100
Message-Id: <20210602101722.2276638-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-cd.c:285: warning: Function parameter or member 'drive' not described in 'cdrom_decode_status'
 drivers/ide/ide-cd.c:285: warning: Function parameter or member 'stat' not described in 'cdrom_decode_status'
 drivers/ide/ide-cd.c:285: warning: expecting prototype for Returns(). Prototype was for cdrom_decode_status() instead

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Scott Snyder <snyder@fnald0.fnal.gov>
Cc: Erik Andersen <andersee@debian.org>
Cc: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-cd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index cffbcc27a34cc..5adbb22116fe1 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -275,7 +275,7 @@ static void ide_cd_free_sense(ide_drive_t *drive)
 	drive->sense_rq_armed = false;
 }
 
-/**
+/*
  * Returns:
  * 0: if the request should be continued.
  * 1: if the request will be going through error recovery.
-- 
2.31.1

