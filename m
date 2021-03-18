Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CDA340423
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhCRLDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhCRLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:03:00 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:02:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m186so1453520qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jFROpSYMFSugf/JDJSkj70mXo6rlQvepZUxoikhqvwU=;
        b=SrRsdV2GlRLy1OIZxZ55PGFGPinWJS8RY3CsYUJWNkI9f9akNLQFISG4is4tiwOiYy
         PbV0axfTUM+H6QPcymufLrlWEGjRIT34SnvPNBnpVeRisBnaKVJsbw/jmtv4MokTDjto
         u0mKdPs8zfJHAuB25N4C5U6Tc4vg7QAJJZrdtambLN0VZEpLhZ4JJpkadukGKuXEmmZR
         9En5GdChZ2P4AxCc0/1kK6eTgE3wkwOnVIsffA3P6QgkmRBljjgQAxEZJz59uFjnbXhy
         3XB7l+I7Qw5ljV58BjWdhaWJQGVvXDf8TWGjTCtrCxrclFC7w1K5Ysk1uWjxhjNFGIba
         kNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jFROpSYMFSugf/JDJSkj70mXo6rlQvepZUxoikhqvwU=;
        b=AX12JumSVJDXdDZ3d2UZL45RRcxa6r43nNQupe+yWCN3hLdbe7ir3EdP1edkkGJCef
         ZU6ANe0yrAujYV8EMz6BzwZMQ1rl/27WzLJRbMAYOae+YkfCygobWT13jIZv4xTVwGzT
         kEywoPBRFI/karDfcILRXJ+VfGqTdFTzJlUnny3A63D8DHqByWFhpHvUH19wM1Zlwduy
         qzIaimaq5ap/S9api5/gLs6CjIiLnM8A6bf+Dfd8XGO2WqXHya2z6TVov1i2ilIuVdc7
         jNWojnvaa0sYnHRnjmqodJ16HywB74cQaymt7rKQp9beG/2SWDnDPPcOzBuqCdDEgRUJ
         LRJg==
X-Gm-Message-State: AOAM532NGICyPlWpnxUqX8E3MwvCqMwd0Gyff1LDXuzXHKUftuU/rgMM
        dC0i//k8UCm/JM6oCLipLI4=
X-Google-Smtp-Source: ABdhPJwkDT7cMA31ljW5JM3vw1gfqLU0z9C/0DWpzWCJm9s9ksIWUez9Dg5OON90ZbpVrK8+ajYGSQ==
X-Received: by 2002:a37:7985:: with SMTP id u127mr3644083qkc.333.1616065379130;
        Thu, 18 Mar 2021 04:02:59 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.246])
        by smtp.gmail.com with ESMTPSA id f2sm1407123qko.135.2021.03.18.04.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:02:58 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drm/meson: Fix few typo
Date:   Thu, 18 Mar 2021 16:30:46 +0530
Message-Id: <20210318110046.14830-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/initialy/initially/
s/desined/designed/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 5e2236ec189f..3c55ed003359 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -45,7 +45,7 @@
  * The ENCI is designed for PAl or NTSC encoding and can go through the VDAC
  * directly for CVBS encoding or through the ENCI_DVI encoder for HDMI.
  * The ENCP is designed for Progressive encoding but can also generate
- * 1080i interlaced pixels, and was initialy desined to encode pixels for
+ * 1080i interlaced pixels, and was initially designed to encode pixels for
  * VDAC to output RGB ou YUV analog outputs.
  * It's output is only used through the ENCP_DVI encoder for HDMI.
  * The ENCL LVDS encoder is not implemented.
--
2.26.2

