Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A9B3D5057
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 00:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhGYVfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGYVfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 17:35:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24069C061757;
        Sun, 25 Jul 2021 15:16:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bp1so12042960lfb.3;
        Sun, 25 Jul 2021 15:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1DZBEYdDyLJJT2wpyRDVzHNpwXpqcxfHLQtIRbcQfo=;
        b=Su364SznOABhDumPHYeKmjtErtDtj2OYrfWpTcUaC18fYoXko/tQ9oVn+KSH29axG4
         UG6MTx9cfx+ZorqYZuOAL/WSZyBqRRq35FeyoQbN0+fubFjmTCRb25VdKJgF1QQzSGRh
         nc0ydnpgkb3Rw59+xgHSOzqa3upHqim8IPIV68pWhCBXRz4+r/fSPD35EaciWL74LDkw
         hukkyjIYzXXSe2OdUAQysWUW8Rjj4zuYsc7EG1SS4VqPcvLMYjwDi71JefIaLeku4MtB
         +9wCNrXr4lAFGQEQ2xnGXTwJh1abCIq8xMMu+INlEeA7zt5Vy+HXEATCWyabSgBzULHt
         HioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1DZBEYdDyLJJT2wpyRDVzHNpwXpqcxfHLQtIRbcQfo=;
        b=aBAu+bofhzOhJGC29Y0F66Fs5OaJ55DE7Yi6ahjbR5PQylitpb4B/z4MuXExwyVOFy
         wgBI/3DkABq5T1nHbYpX3KyhhKbPOsUoXML+tZY8yoC6JOc4C5PqolIXOiXj6ZymhYwC
         qk+PVG4TBte7gtUh4JJiUpDkUVWuOHMshjwPBI+tXUW6Ztc3mmyGW/V4Q1PO/Skp0DOc
         3+u14/J4uEAGEtaaNRWVFxi4pAyBM1ji3ZojAID/ZeAcyXXEpKI0BaRFh6klsf2LVy1f
         oi7ADbxlLElrP2GzEAWF0c4bb5PTfwV/jaQhuQ2DcXCF4nRLsi0UNKSOnezqiY/V6v9E
         +B7Q==
X-Gm-Message-State: AOAM532lYmQ5xVnHAMHR6nGuVEBN+jkEyaTSfoXuq1LiDheHgnuqSSut
        jQRW6Ja0mbx+LnGlr2cxCfM=
X-Google-Smtp-Source: ABdhPJyF3rNNIkEIYpfHzOuD1bUaOrmlsL12pe6fvHDbnhI3pa955ihaSZPstxz/w8mE9uRwiSUj3Q==
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr10274737lfv.201.1627251359503;
        Sun, 25 Jul 2021 15:15:59 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id z12sm2862647lfu.53.2021.07.25.15.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 15:15:58 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v3 0/3] add Gopher 2b LCD panel
Date:   Mon, 26 Jul 2021 01:15:24 +0300
Message-Id: <20210725221527.1771892-1-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gopher 2b LCD panel is used in Gopher 2b handhelds.
It's simple panel with NewVision NV3047 driver,
but SPI lines are not connected.
It has no specific name, since it's unique to that handhelds.
lot name at AliExpress: 4.3 inch 40PIN TFT LCD Screen COG
NV3047 Drive IC 480(RGB)*272 No Touch 24Bit RGB Interface

Changelog:
v2: remove .num_modes
v3: sort QiShenglong vendor prefix,
	sort qishenglong_gopher2b_lcd_panel_modes struct

Artjom Vejsel (3):
  dt-bindings: Add QiShenglong vendor prefix
  dt-bindings: Add DT bindings for QiShenglong Gopher 2b panel
  drm/panel-simple: add Gopher 2b LCD panel

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/gpu/drm/panel/panel-simple.c          | 43 +++++++++++++++++++
 3 files changed, 47 insertions(+)

--
2.32.0
