Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48E37479D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhEESBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhEESA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:00:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9CEC04BE41
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 10:34:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c22so2987334edn.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJ1W6dTWWHtI+YV1jN0NDAOjA6XeSudj0gtCQFJVcpY=;
        b=Mo+OwjaECSYnxRrJeKTWwwKisdJ/VScet+wVhwt/N4GHAXcVn5qlbjODOyDyRLKi+m
         ah0pVYtZSJWIygXTl+XitKM5re9ioxTK2bPW3bzuIMKDLspwfUIXhjemFmke/rZjZnIv
         okpwZUSXphkSlSZb+Fdu9h7A9+YhP89OfYfqwqqMTS3nVUTmdzpkCK/ozRzgKmBLmdxz
         tNCvpLNEhscB6RRxyBOlgC1eABW9Qj2WPm+5xt6JrrfbBztslT/jinPDNF6xPI/erxn8
         y6fBDin9Vrv20E/0gOu+K6BhWPHD9tWVrsiB4FvQUBoA5S0I9cqKrhJ4MV2jk/EhFkDA
         lQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJ1W6dTWWHtI+YV1jN0NDAOjA6XeSudj0gtCQFJVcpY=;
        b=n3FZ4aLxhr4Lyeq9XO1qgXOw38TRT+3agZ/nhgUUMIjzEwA0dGqDIvmjQCHurdLGN0
         gz6RF3BS9+58YreS4Eyt3Pzfa55KwFWlm2mTwWwKlgcfajO2u41P1Os8NndcbUjr3tJq
         H1KaSDjPe6E6NmTS2bZcfvYOzdV9vTF3yEB/8WxNs85fGEtPqW5/yw57kuhgZIg4ByLd
         KUjvGAUZvyYtxAML9pDQBAn7DxN3akA3CR8ZcutL+7ALTt+biEYH40W/9vmfAX0Vsjkm
         fKJuCLRKZcGnVxdZiWvF3xiGHeb65OBD35JvpcfHI75UWECJfO0h0HkM/z/TMV/SwQXC
         sH8A==
X-Gm-Message-State: AOAM532yn4Cr+V2NxYvADpOUCspsmmF7dunEiUkWj9RB+IwwViy70RZi
        nPFbgURJ0B4H7brMpF+kxXs=
X-Google-Smtp-Source: ABdhPJwKeTtUO3jshq7tIjvyWeBmkyFAT54clpQqAh37mhPIzZYeomirMN/Zd/TXExTZCBwuo4FkNw==
X-Received: by 2002:a50:f0d6:: with SMTP id a22mr168468edm.354.1620236057609;
        Wed, 05 May 2021 10:34:17 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id e11sm16334522edq.76.2021.05.05.10.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:34:16 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com
Subject: [PATCH] MAINTAINERS: Update my e-mail
Date:   Wed,  5 May 2021 19:33:35 +0200
Message-Id: <20210505173335.1483575-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old e-mail address doesn't work anymore, update it to new one.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .mailmap    |  1 +
 MAINTAINERS | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 3e2bff9137e9..ce6c497767e2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -160,6 +160,7 @@ Jeff Layton <jlayton@kernel.org> <jlayton@primarydata.com>
 Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
 Jens Axboe <axboe@suse.de>
 Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
+Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
 Jiri Slaby <jirislaby@kernel.org> <jirislaby@gmail.com>
 Jiri Slaby <jirislaby@kernel.org> <jslaby@novell.com>
 Jiri Slaby <jirislaby@kernel.org> <jslaby@suse.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index efeaebe1bcae..a10ff471ef53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1578,7 +1578,7 @@ F:	drivers/clk/sunxi/
 ARM/Allwinner sunXi SoC support
 M:	Maxime Ripard <mripard@kernel.org>
 M:	Chen-Yu Tsai <wens@csie.org>
-R:	Jernej Skrabec <jernej.skrabec@siol.net>
+R:	Jernej Skrabec <jernej.skrabec@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
@@ -5099,7 +5099,7 @@ S:	Maintained
 F:	drivers/net/fddi/defza.*
 
 DEINTERLACE DRIVERS FOR ALLWINNER H3
-M:	Jernej Skrabec <jernej.skrabec@siol.net>
+M:	Jernej Skrabec <jernej.skrabec@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
@@ -5642,7 +5642,7 @@ F:	include/linux/power/smartreflex.h
 DRM DRIVER FOR ALLWINNER DE2 AND DE3 ENGINE
 M:	Maxime Ripard <mripard@kernel.org>
 M:	Chen-Yu Tsai <wens@csie.org>
-R:	Jernej Skrabec <jernej.skrabec@siol.net>
+R:	Jernej Skrabec <jernej.skrabec@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -6033,7 +6033,7 @@ M:	Neil Armstrong <narmstrong@baylibre.com>
 M:	Robert Foss <robert.foss@linaro.org>
 R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
 R:	Jonas Karlman <jonas@kwiboo.se>
-R:	Jernej Skrabec <jernej.skrabec@siol.net>
+R:	Jernej Skrabec <jernej.skrabec@gmail.com>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/bridge/
@@ -15812,7 +15812,7 @@ F:	include/uapi/linux/rose.h
 F:	net/rose/
 
 ROTATION DRIVER FOR ALLWINNER A83T
-M:	Jernej Skrabec <jernej.skrabec@siol.net>
+M:	Jernej Skrabec <jernej.skrabec@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-- 
2.31.1

