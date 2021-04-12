Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FEE35CA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbhDLPrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbhDLPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:47:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE5DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:46:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so6484069wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKsJYMfj+mAr/LEo/N+G3J+2p4GxyOGmqg/HnacP+4k=;
        b=jBSdhPsPjekjj+jMPgA0tSeRmZh1lYFavQ7g9j/ygo/Zvue9b3e4oZYn6ZfJYbMHoj
         zhucATVrrCRDWkvTGGOBEyIOuTWE1GYT2NwE3J9H+Zc+I2NZl1hAurIRJyM0lZ2IRfGZ
         85H9T45RTIoxIYBz3cjOL0rlpNkKKKnxwXbODLm6lLT3PTTGrlRLz1B5wkKbC7UCU/vx
         gpOTf4re0wD7tsWukZlvhvofCGEhujCvLiQcryS4sBZ8bpXjUFBhwnvbSZViilUkVztn
         L7ZNQSwApuWa5oXMv9pxMqqaFtb48u7OM7zBvNgFPnwti0vVUsL1L6U7R2BHn5eDpmt3
         ksaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKsJYMfj+mAr/LEo/N+G3J+2p4GxyOGmqg/HnacP+4k=;
        b=GtlqdOJzAu9QhzOm8GGeectk0CUAecON7n7LhNM4TIq3K34YfjP/N1CRVDS2+uqKxN
         PAy7WXE/NXrw51M0JCUWK/TVue9bn1sbMiDamuabkjrypy873ib0dJVav4MHKwKCYoZh
         p+w9EfeUg6foRPa13RYJAIff1GXTLMNcxZvY0+koG2+KX+yM/JtA8GEqS055KDLzt0VE
         jJD6CHm259c7hUBv3tLo60eAn/0r0c5w/gfxzR3U6tNqamIhAnbHygGxCQuRZi0KyB3M
         QTh+somIcXtZfEGAS1lidQMc9wVkmrPX36poHAtt6a1SM2OwmMau1pNu8+vDyv7Fm8mT
         wW2Q==
X-Gm-Message-State: AOAM531YKrtWFI/QB+6Q2cZT+jaQOsPQqVDqpGfqETUbCaeGGjfEOvCt
        Gcn1ACExdqMn7jXnao0uWMttfg==
X-Google-Smtp-Source: ABdhPJx9aeflCvS1STVjTQt+KOuZ4pckqoQmL9pZFHX6R4v9knMtxFlDP5HTOFz9xwD/NNwLOCVCjg==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr27817848wmh.187.1618242418068;
        Mon, 12 Apr 2021 08:46:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id u3sm12647332wmg.48.2021.04.12.08.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:46:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        paul@crapouillou.net, robert.foss@linaro.org
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Phong LE <ple@baylibre.com>
Subject: [PATCH v3 3/3] MAINTAINERS: add it66121 HDMI bridge driver entry
Date:   Mon, 12 Apr 2021 17:46:48 +0200
Message-Id: <20210412154648.3719153-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412154648.3719153-1-narmstrong@baylibre.com>
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=QfcZVt5wD67EB4SM1GoV8Ndq0aCcis+V2maojsn145o=; m=+nVBMIivqLWmhW+4z3eXrpJ2lOG93YvhBxA0eTLsMTE=; p=xpVYdKteOn2lZkFgz3iqfdGphvWJFQwxpv+svO0TUAU=; g=2027a19d792bbe8bc07a2ee56f6cc447a8d26270
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmB0a0sACgkQd9zb2sjISdG76g//Z99 fJBzU/ZJUwtXn2n0EA5UeZH5FBVd6gtdBxoqhXXWe4EUX62pUx2pp3HDfDgcq4cV14bRPOpBtQgRX RE1aF27PVmNtfJLhvBrGAEd9/ZJ2BH41Bpo/8ZAQ6nw8iJlynt30zLdHzSL73tCaniFhlGcn9yUTS cjk3uhCDXb/D3fTnqlcgI8hBTG7c3cvbYSsGsPqQWRBFR3DUQbI41uAttiytauB1zJ6MP/nJys/q/ xP6rqRhXUU0gISeY7Ti+AjP6rPv7siiXdT6dSPA981q1yRHn3sffZ1CaZKDuAQBnUP4+P37esJSyg o6MEtuJt4IZtlmw9l3rr7dxRrr4N9tO6XMf2SzOI61PiYb8D7KyKsx0N8JJNxxRprVHq2hCNih4Tl 9RzHkD47lUr9nkfm1/IOKW2WawqCpg1c4uW0BKv+JRbxKhSBcpJlN06okhq8BMvi0ZkCZqwQrHA5c LwX7/e7w6+xUFI8e9kldNV5vKYPoS2rJOJCY/QFQGqLICp+EA9nf8QbuG2Oan7tz8PgIF9uyUsGH/ droiDn4L5nPH1AvOGuJ6CZ3aG3gvwXhqArXaGxrn6WpKxnrAHf6oldGrF/+R6dxAhWrufVsmt1KTj Jpcky99GagzZNvDm8Wp7dMZfcq7dpnvgMTMpucS3u8IRNfwbAvYXZJxwT2bnd4aw=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong LE <ple@baylibre.com>

Add Neil Armstrong and myself as maintainers

Signed-off-by: Phong LE <ple@baylibre.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ae8444c96b4..ff6450c83049 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9515,6 +9515,14 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/it913x*
 
+ITE IT66121 HDMI BRIDGE DRIVER
+M:	Phong LE <ple@baylibre.com>
+M:	Neil Armstrong <narmstrong@baylibre.com>
+S:	Maintained
+F:	drivers/gpu/drm/bridge/ite-it66121.c
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
+
 IVTV VIDEO4LINUX DRIVER
 M:	Andy Walls <awalls@md.metrocast.net>
 L:	linux-media@vger.kernel.org
-- 
2.25.1

