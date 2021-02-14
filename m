Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B731AFA5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 08:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBNHug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 02:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBNHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 02:50:33 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AE2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 23:49:53 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z6so2326473pfq.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 23:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Wih16HSatVXdvXOx66yUm+mckH3unmlIZxuy5E5dQJE=;
        b=GJpdY0oawUtAK48cBfcYCDz1VyS53aaKxJ8gdW3ToveA9MHLzK47OJjUlLZ7scmw+8
         1/JoBnE53pIVzqXAQrqoemBhX+TQuJDqRQOfv8Rh0LnDel36a1LW1fxn4lScPGBQ0Kme
         8AdkaIgduPMEIQjRc56QZBzQiF+CCKrtKtP6QHoHWhJRDLTpXGNiEpSQOYzgs2Livz8O
         B1jF427GpY9ymBKkKZ+2op0tv5VqqsE4FC9BrlqPxIlUgqzQ5PCMHzUBC6vB1FPlmbJy
         /jiuqY2+1uWG7afxSIIzNLF5HujFpDbHqnlbdq/KxFqw53VX+XPcNoTxCPx6muAy8D8i
         T2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wih16HSatVXdvXOx66yUm+mckH3unmlIZxuy5E5dQJE=;
        b=Nn1pwZrttHskKrdu4Uw/R8SlL0U/fQtcgGnH7SZCHrQo75Wjb9ZFjIMKEF5H7p69mP
         dSbRuUyQWSIGV98KhjxoR/OHzPUxSIIV+n3xtBga9NNI6J0ZBjZ6ldG+FwiISgGL8JnV
         S5CQZMNltoUZtOZ/mOR/tWKYcY2vVK1qRQvpzxQCt0r+agEv66Af2ZBQDkhEWn9BYf33
         vLACe4+Y0o9vS5BqYQzNiwqTU3LTczkJVdejmWquAkRc+gm8A8+E/reN9FS9AjisMKib
         hGf6BX4e6v814dsQuPhfQ61fdFbEvHIc+zhc/QPzWGVV2bYn6+jcDDWK5579R6Snr5ul
         Hl5Q==
X-Gm-Message-State: AOAM533p8lVwosIJ59QuGZ8h40LILIu9uJ4+w6Mk1EjIxa3clydqFcz+
        bUoqxIMfKUPMigW3gho9TaOtILo+zzU2wKE44bD0Sg==
X-Google-Smtp-Source: ABdhPJwcXFMdswJMBjyUAd89GLKRnCn9VYLP+vpN8AsbonURO1qrHZyTDs1mgS8gtQDL92mEwQbzdQ==
X-Received: by 2002:a65:4781:: with SMTP id e1mr10671155pgs.30.1613288992040;
        Sat, 13 Feb 2021 23:49:52 -0800 (PST)
Received: from ubuntu.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id h3sm13928394pgm.67.2021.02.13.23.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:49:51 -0800 (PST)
From:   Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        jitao.shi@mediatek.corp-partner.google.com
Cc:     Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH 1/2] dt-bindings: display: tv101wum: Add STARRY 2081101QFH032011-53G
Date:   Sun, 14 Feb 2021 15:49:27 +0800
Message-Id: <20210214074928.31901-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for 10.1" TFT LCD module called STARRY 2081101
QFH032011-53G.

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 38bc1d1b511e..01c2bf7321ae 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -26,6 +26,8 @@ properties:
       - auo,b101uan08.3
         # BOE TV105WUM-NW0 10.5" WUXGA TFT LCD panel
       - boe,tv105wum-nw0
+        # STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
+      - starry,qfh032011_53g
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.17.1

