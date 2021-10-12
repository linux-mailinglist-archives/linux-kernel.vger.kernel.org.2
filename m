Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECF42A1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhJLKR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhJLKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:17:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F2C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 03:15:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g25so18818228wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 03:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6QbSN9AwgyB7YvMXjQ9wGOfwm5L9SfWX6cJ4H4aiOcw=;
        b=I6JH1SD4d+mxJgU41Ukt5Yi7cIner7iuvPmkLYnQE8EuACtOW7bFgFigqbMeJX0THw
         xP/cb89RpE7uokfUFL93RNjkwHW5voE0Gk4eg4LKGaRRonx4Q36UXqSiYUP8NMxXY7MS
         2Ugw+A3pKYhZTrSIXOW5K1vIAjXHnjwBO96YK3wc6eG1rwb1OLs+9bzrJ48y7vHnwZQq
         poPwCunfY9338ddLwYQSwSNpemrUGQQglAkzc2v6DX4tDnshC1My8JvLnJkdi083o7J7
         u2TLx+8LpNa/XY29A28R+V+jZPlrO/crvHVaHqu0W6VqfldPunV/fst+eNjqtNk0lp5E
         NIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6QbSN9AwgyB7YvMXjQ9wGOfwm5L9SfWX6cJ4H4aiOcw=;
        b=kqozrDjiwPgtB5Og3IvcgHdt1KukeR82MW4EoX8Q9+K/vSTOz6wS59/QPF/G94NfHD
         Kv24WyjBsCxPJhWT6IJSVKl8aN51eb2Iwm5rfqDdn5KFR4TgSnIUcnMiPYk/MWDGMcTz
         wedwHHUAUgGocKhYMO0yayjEi+8dNGDlbT6pxDVKrGwEvZdyAmTW45iTPeN1xvCirRk6
         GFXZ5PGhShvldVBsBIXgVSr49maiyxQhbmVGjebjrJ5ahx4bzUN3pU4mlewKoU1Hxpbv
         g4B1aa14ay31Eul+xUngeHLAkrts3wNvSllJGffgUYUgFrUH83Jooh1floySrAHU9OVe
         kz6g==
X-Gm-Message-State: AOAM533nzy9vCK7RlDKN3W48G+UFa+IDUuhVxFfGjFg7oWJ3Lp7hGUIa
        iLpf3CuU0mlze9NuNGougyLnaw==
X-Google-Smtp-Source: ABdhPJwdxCHHOZ/oslBbeIuL0n1JOu3yAprRsBzGm4vMqJrW4NjI0W2onXTmmR87QR8VLNUzEjpS+Q==
X-Received: by 2002:adf:b748:: with SMTP id n8mr30225878wre.133.1634033724575;
        Tue, 12 Oct 2021 03:15:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t21sm2026514wmi.19.2021.10.12.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 03:15:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        guennadi.liakhovetski@linux.intel.com, rander.wang@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: bus: stop dereferencing invalid slave pointer
Date:   Tue, 12 Oct 2021 11:15:21 +0100
Message-Id: <20211012101521.32087-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slave pointer is invalid after end of list iteration, using this
would result in below Memory abort.

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
...
Call trace:
 __dev_printk+0x34/0x7c
 _dev_warn+0x6c/0x90
 sdw_bus_exit_clk_stop+0x194/0x1d0
 swrm_runtime_resume+0x13c/0x238
 pm_generic_runtime_resume+0x2c/0x48
 __rpm_callback+0x44/0x150
 rpm_callback+0x6c/0x78
 rpm_resume+0x314/0x558
 rpm_resume+0x378/0x558
 rpm_resume+0x378/0x558
 __pm_runtime_resume+0x3c/0x88

Use bus->dev instead to print this error message.

Fixes: b50bb8ba369cd ("soundwire: bus: handle -ENODATA errors in clock stop/start sequences")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1b115734a8f6..67369e941d0d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1110,7 +1110,7 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 	if (!simple_clk_stop) {
 		ret = sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM);
 		if (ret < 0)
-			dev_warn(&slave->dev, "clock stop deprepare wait failed:%d\n", ret);
+			dev_warn(bus->dev, "clock stop deprepare wait failed:%d\n", ret);
 	}
 
 	list_for_each_entry(slave, &bus->slaves, node) {
-- 
2.21.0

