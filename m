Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7B3475CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhCXKUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbhCXKUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:20:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32356C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:20:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k10so31948111ejg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0wDWLXKOGdso8sCX9cYlDgiimLp48jn6EeiRWVhbQHc=;
        b=w0jh6d3IxU4M+f4vLwKoW929zKZl9oRW+TGUP/89uvvijxBBoDo8jAMkm6+s4LWFY7
         JYmvg05MiMWp2dfscl5m8tee4xf6g3RIQ5g0nGYBCkeYhb0fFmZD+ijK14Kuu+RJrNTa
         Fdst67N6wKF36pMeIllgsmWOsCXgSXxaEWJxBK41rhzf3DNqKiL0vrZoKAY6zceRbfge
         dnTKG4A0ngXRAT4Awsls05Isi14zR7zIiaCIEnVnkTn1dEWDM8LzRluyoue5SYRVr+MC
         jyXi0ewff+jp/i+qYpOa9Yas1TsNtOLxTsyIOcnCpPxUTFjEItqyl3gwpkk65orK+TWS
         8ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0wDWLXKOGdso8sCX9cYlDgiimLp48jn6EeiRWVhbQHc=;
        b=kNBIsg3bQg1oH/sn2xf8so695tz+sAhoWdPYagve8U4J66xwfhcwHuNDKrIl5eMpYQ
         6eBOAsomjrr2tkgG50WWOw7whCs+JvyaVRzhIBA6PjrJuiWCIzk17YdoR3O/UJrcBvR+
         lEl+pVVwFyAEPYp9woNyV0U1/xqRLCL+PzZYasGLvTJPtOFeLNRxW/i5agc+eQ+9ZH0A
         B98hp7jniLsmg86PfilMhU/vTA6QjPblFW0CwRcCtZbG44ZYykw2sk/tnMGYIUooWsBT
         Udt/zV+6q5VgbDLtayPD2WIeBmAd5eZ+0VsUST+1FhnrM2Z+JBdIg4m2qufPiCqJx273
         lRjA==
X-Gm-Message-State: AOAM5322X0n7FplouPz8i4r7/c2IW+gEAJi2rG1aBTZ0NVwIHGcppRIM
        zXdBO3dcpkH+opw1otGSxLAd0RbZjZ4OrE2T
X-Google-Smtp-Source: ABdhPJztxf6aLGtNSiYlEgFkaAGJT+dYqO0eXlr6H/5ChhD7NmKhzXAEckNJaYkNiskmDhrJ8QVwnw==
X-Received: by 2002:a17:906:7194:: with SMTP id h20mr2832320ejk.154.1616581231654;
        Wed, 24 Mar 2021 03:20:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2454:3e3:5f00:8dfd:6ac3:6d4d:84c6])
        by smtp.gmail.com with ESMTPSA id i1sm692336ejh.94.2021.03.24.03.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 03:20:31 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1] MAINTAINERS: Update Maintainers of DRM Bridge Drivers
Date:   Wed, 24 Mar 2021 11:20:19 +0100
Message-Id: <20210324102019.1251744-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.31.0.30.g398dba342d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as co-maintainer of DRM Bridge Drivers. Repository
commit access has already been granted.

https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/338

Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Jernej Škrabec <jernej.skrabec@siol.net>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b705ba51c54..16ace8f58649 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5902,6 +5902,7 @@ F:	drivers/gpu/drm/atmel-hlcdc/
 DRM DRIVERS FOR BRIDGE CHIPS
 M:	Andrzej Hajda <a.hajda@samsung.com>
 M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Robert Foss <robert.foss@linaro.org>
 R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
 R:	Jonas Karlman <jonas@kwiboo.se>
 R:	Jernej Skrabec <jernej.skrabec@siol.net>
-- 
2.31.0.30.g398dba342d.dirty

