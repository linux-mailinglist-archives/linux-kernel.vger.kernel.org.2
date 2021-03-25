Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763DF3494A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhCYOwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhCYOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:52:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE58C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:52:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l4so3346556ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9BwsVXG91jgXFtlxcwsuCYPu/uAtylFJ/7wlB90EsM=;
        b=ThQwdbB6EHnVPFYmQLl0CNmYhnzSpjXXD3yQ+aMmVyDV64U7e1PFFNZSAJHxe7fRQi
         uO4tachQEOxeGXXeTm5h7K5lAtrcmKGGqeEXjtyN1jRymHgSLERjADD3ir9JV8q8FHkB
         emMkeUnHbQCRZhuTxZKkf8ER03AemaSTdASL6Bek0UeS/9sAhyyGt5CyVJgpkJdD3ntF
         Oo8SkUrpTw70vnnIdWc4mxjUKjLXMQ6D/Ya4U+HNCodLvkcabRpkl6JaBhxGf52aP8qE
         DgZ1tWWfU4jDcu2hpHHMPPN+z4R/6De84YlftsTFY1sLphq7n6Q0pdqxSokRKtm8AdU8
         4rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9BwsVXG91jgXFtlxcwsuCYPu/uAtylFJ/7wlB90EsM=;
        b=uJuZNc5Q5c1gtzVTPzgifWK+nPkzriNDHJb2tEbSRvy4peh8KJ2l4dnv8QoHRjxCfx
         Wy04JVn8F75s9RF8Aj0Up1KpTPzlITaPpheFQn+HmrvbJqbWbHAK+XG1GY7panckyffe
         yPdyr9YG7b+zIyEzXKuALYJWpTf0KVgMvJvSehtmwq8PaXcTHwXCFKGm3ViFRKer/j1T
         JGp8SAmTUjm7hiXE2gMf5nsiup6f+xxnrkF05SkwbnAaTzREJZrqegrmWXMFGiXPWiEK
         GH83PNApLDQc88uGCj5fBER607WM/4MviM4NJcwOSOulsvvbpVQq7BjKX70deEj/Wm6x
         b8mg==
X-Gm-Message-State: AOAM531log5oeoV2LOFGYII1OlmZDUtDnwDR1bPJZjehOjIMV/giWERR
        XjyxQ+IZhwAEaUL8h/pXO37z/oMqmhCB3OFo
X-Google-Smtp-Source: ABdhPJzo2y8llq+CpVkAFkhymReAfRiHhRsSYjPAPr1zopkcSFAtgRWPDwGlOSIm3ab8DaN9HLC7HA==
X-Received: by 2002:a17:906:2dda:: with SMTP id h26mr9891858eji.163.1616683919867;
        Thu, 25 Mar 2021 07:51:59 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id si3sm2569953ejb.90.2021.03.25.07.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:51:59 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        Robert Foss <robert.foss@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2] MAINTAINERS: Update Maintainers of DRM Bridge Drivers
Date:   Thu, 25 Mar 2021 15:51:54 +0100
Message-Id: <20210325145154.1433060-1-robert.foss@linaro.org>
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
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Maxime Ripard <maxime@cerno.tech>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Andrzej Hajda <a.hajda@samsung.com>
---

Add maintainer Acks.

Submitted to follow proper dim workflow.

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

