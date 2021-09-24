Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6A041777B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbhIXP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 11:28:01 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42604
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347103AbhIXP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 11:28:00 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F3F5440192
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632497185;
        bh=BJQ1tcf/UkpkN508ynAJCoG+ggl8X9aVGCS6hw5OEH0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Rt21dhzExhu4+UP+H8ni8+xlIZve3UVePPYd6S2dXYBx+E3lgNYKjUC/Ly6sp+5ys
         tp6kwemrl0gZ/TPqbBAZR7PwjUWkIQD8LjRLCibS82bgt6lTlu4pSkFzVQjb6tlodw
         v39HPN4ts59DEm6jdexIqQ+dYgy+PjjieL1wQgZLZ5NHFX4jcMy0niGMIidk8gRf+v
         4vU++k7e2XfLnOrH+aWbvzlKCuuEx0c08DKxm5krWWATdYFecG28cr0RIdtXIytGrP
         BPoF5QGd1LzFIaq8B7o0jg2D0eR7FFy2z5ICjkarOR99EmjqI33cCQC/B10sLIKClu
         D3S7vg8Rv11yg==
Received: by mail-pj1-f72.google.com with SMTP id j18-20020a17090aeb1200b0019cd0887ea3so6308370pjz.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BJQ1tcf/UkpkN508ynAJCoG+ggl8X9aVGCS6hw5OEH0=;
        b=foAnnrljz55tnysa6URmSPqKIsSs4I7rgwzlLDHP/pdScLHkfT4HhLzWBv5hs9nmwK
         w33YptSHLr91XePMgrWY5Qle0mJceOHAZvVVVtleWTL6L/bjLnz/hL4qso7z7R0Q7grI
         DmhmbVyqck/OG5nH2gV8tkVMXwXkfITy3Jtkc3ioC/31GC3LjQg0CuSznV3EmjF+SZly
         auvSleTqv9Rkxm/h2VtpH5TjdtI3mQQwPwcK4KaFeTiVCAX0TBbl8V7wxohyCH/JnHz5
         aM20KREgks9tOQ6Z+P2vy698wWrUT6k2HcntTQvdYlCoArCGCzTC80nzGbwj7mYA/RoS
         +5BQ==
X-Gm-Message-State: AOAM533eVbNr+ZwBXpPcXTA5G72PkFX/6nniCrX5oL2+ym9/bRaJH5WA
        SUS9//FtulZ/V5S9YrQ+fQpC3g4flxbdMzMKaIbNlyEkqmoxKkqIIujdEoJLRzV+Ape790DrqwA
        8lgFLTomkBd78Qk1BCk7SYnsmM0/CtBE4Ss1xWE1aDg==
X-Received: by 2002:a17:902:76c3:b0:13c:957d:561f with SMTP id j3-20020a17090276c300b0013c957d561fmr9407107plt.27.1632497183529;
        Fri, 24 Sep 2021 08:26:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE5/Uiux7+1UFrhzHCKhGu2VwGC7ehLwJsokzC6lOe3qr+QDJLo84y2if8gaO2xS6nvRF6pw==
X-Received: by 2002:a17:902:76c3:b0:13c:957d:561f with SMTP id j3-20020a17090276c300b0013c957d561fmr9407087plt.27.1632497183286;
        Fri, 24 Sep 2021 08:26:23 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id f16sm9190541pfk.110.2021.09.24.08.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:26:22 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tim.gardner@canonical.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: parade-ps8640: check return values in ps8640_aux_transfer()
Date:   Fri, 24 Sep 2021 09:26:07 -0600
Message-Id: <20210924152607.28580-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains of an unused return code:

CID 120459 (#1 of 1): Unchecked return value (CHECKED_RETURN)
7. check_return: Calling regmap_bulk_write without checking return value (as is
done elsewhere 199 out of 291 times).
204        regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
205                          ARRAY_SIZE(addr_len));

While I was at it I noticed 2 other places where return codes were not being
used, or used incorrectly (which is a real bug).

Fix these errors by correctly using the returned error codes.

Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 3aaa90913bf8..591da962970a 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -201,8 +201,12 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
 	addr_len[PAGE0_SWAUX_LENGTH - base] = (len == 0) ? SWAUX_NO_PAYLOAD :
 					      ((len - 1) & SWAUX_LENGTH_MASK);
 
-	regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
+	ret = regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
 			  ARRAY_SIZE(addr_len));
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to bulk write ADDR_7_0: %d\n", ret);
+		return ret;
+	}
 
 	if (len && (request == DP_AUX_NATIVE_WRITE ||
 		    request == DP_AUX_I2C_WRITE)) {
@@ -218,13 +222,17 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
 		}
 	}
 
-	regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
+	ret = regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to write SEND: %d\n", ret);
+		return ret;
+	}
 
 	/* Zero delay loop because i2c transactions are slow already */
 	regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
 				 !(data & SWAUX_SEND), 0, 50 * 1000);
 
-	regmap_read(map, PAGE0_SWAUX_STATUS, &data);
+	ret = regmap_read(map, PAGE0_SWAUX_STATUS, &data);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to read PAGE0_SWAUX_STATUS: %d\n",
 			      ret);
-- 
2.33.0

