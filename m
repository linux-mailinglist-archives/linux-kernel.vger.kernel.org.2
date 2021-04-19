Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40656363C95
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhDSHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbhDSHda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:33:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:33:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p19so17583713wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU2109fDte5QzQTU6OiyUjXeLbUbmc0eLsamxuYgBY4=;
        b=cTal5zic1kcTdzov7ZwC91ZPKRclHTTOlDdHpITvaOaiXUTZfpJ+3usRyKlz6/agC5
         AsrsAN6JFILMF4jU8jK3D9UvjGqaDBxku6qGjZ5sM3hDAeEDN0MfRNp589yZWNrGddou
         FS/3UfSei41sfbcsKB3XSKApmzZSukPylSssmL4dYnIXYQbvppcL5sdbKqDCZ3mBwdHr
         +jNawe+GBs8uecyYHqLh99/F8gGZ3Aj2m0I9fvUklslVj4WxHMQc4eqZgVFkdSNlcY71
         twjMw+3UlmWlHXN/4Fye2Zkv2f43Nnrr9FvIgoko4jtZCKyEhxSD9l1fl9jZQguo3lxD
         cQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU2109fDte5QzQTU6OiyUjXeLbUbmc0eLsamxuYgBY4=;
        b=Nnz5wxHlVl9W5xHk6OXfIpceZ14/IbH/doDk3SolVnf1AVFEN8GY1QRhUqtrWwEBNE
         0HUkFN8XeXpXBbuhSvHMy8qa6aEs/EF3Jt9nXO+hl1uFyyP5JnXdJziACmZl6ET+IIg1
         /jE2effgZXKcfxAaY/A8QVCok94pxS/OCzDQmSNPwunl8Jm0ZIzgo9HKvxiu2TFgrtN0
         CVTyD4xbpbnHWNf6fETRqgz+rugdHIeSfN8yQLiHXXUhwTxXFuJZv/+1TpPb5+yfDy2Y
         F0o6eAGfmcKt01M7zA7UhquYog3beeQ3TEMNj1mERU92bCMtME0a5c45tlNOBcUsJSLj
         vKGQ==
X-Gm-Message-State: AOAM533OQ61H2267rZ2GUUswMhZEfEn5LjkProTXthgiJWHGIkh83Vg8
        ojsSuOdvMq/ylQtnUvbTnoah/Q==
X-Google-Smtp-Source: ABdhPJw3An0kM4uAq/WF0hpG90M8E13eTj8qTaoZc2EbHJ0InBjA6SPO6b4yv0Sqpk1BhQQ9B9DIdA==
X-Received: by 2002:a05:600c:220c:: with SMTP id z12mr19954322wml.92.1618817578964;
        Mon, 19 Apr 2021 00:32:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:2e82:31e6:67f1:4f33])
        by smtp.gmail.com with ESMTPSA id y125sm5492311wmy.34.2021.04.19.00.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:32:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 0/5] mediatek: hdmi: add MT8167 configuration
Date:   Mon, 19 Apr 2021 09:32:39 +0200
Message-Id: <20210419073244.2678688-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8167 SoC have a hard limit on the maximal supported HDMI TMDS clock,
and is not validated and supported for HDMI modes out of HDMI CEA modes.

To achieve this:
- switch the mediatek HDMI bindings to YAML
- add the MT8167 compatible
- add a boolean to discard the non-CEA modes
- add a value to specify mac TMDS supported clock
- add a conf entry for the MT8167 compatible

Changes since v4:
- fixed bindings

Neil Armstrong (5):
  dt-bindings: display: mediatek,hdmi: Convert to use graph schema
  dt-bindings: mediatek: add mt8167 to hdmi, hdmi-ddc and cec bindings
  gpu/drm: mediatek: hdmi: add check for CEA modes only
  gpu/drm: mediatek: hdmi: add optional limit on maximal HDMI mode clock
  gpu/drm: mediatek: hdmi: add MT8167 configuration

 .../display/mediatek/mediatek,cec.yaml        |  52 +++++++
 .../display/mediatek/mediatek,hdmi-ddc.yaml   |  58 ++++++++
 .../display/mediatek/mediatek,hdmi.txt        | 136 ------------------
 .../display/mediatek/mediatek,hdmi.yaml       | 133 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c           |  17 +++
 5 files changed, 260 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml

-- 
2.25.1

