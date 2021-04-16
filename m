Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0B361D47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbhDPJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhDPJ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:28:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC631C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:27:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n10-20020a05600c4f8ab0290130f0d3cba3so2081022wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2sUAYapV9tNRdpyx4eKitq/eIA5rKVYEe/d9xJHfMIo=;
        b=O2ZXiCFmleQhG+6wTRzwjgcjsqsqUwRMoVXJCVR3MP6HhYcABYi085jjBpr0eAm5iY
         cyzN0S01yEtnSwdsDSI4UY0CumhvSWEsvjE/U2ZuqsLVS57yuY6+gRSHl5rGTb9t4JuG
         sssbwhVwNEkmKUl0cR6/Ce5Tz75KWGdR2YLRkq+b2goWzDqdpQo7MUYG0onpazmpXh7P
         EqGvTO9tt62tGrnXZqXLhQ9ZWkMayuoyc2oHnkMJ7ELOUpE2zKSC+7RcujR8MQ2/H1IU
         y167+jLmKk9VWHTlxacjHCa8EkSc6RNsUEfIcjOjk1b1cl5ATdaKCkEOS3KfngBuojTH
         jBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2sUAYapV9tNRdpyx4eKitq/eIA5rKVYEe/d9xJHfMIo=;
        b=lRtxQuYMl9HnD7lrBdi+qu+i6rQjO9Zl7T7RXnZgpjpOSFqrHRpokIXTPOl2cx2SfZ
         70JwomjzzmOJQq6X2e6NZ9u1E9m4MO/2RRx/6DvdCAUBCjkr4E01OznckGkH/Zi/CvMl
         +PkSfripbRGtBfjYCr15zRt9KR8kjQzvgt1oHghdbDQ5hZcvsfNIsZaoXA7Q1FNoFyD6
         BvcWpCrVvro0ekhMm4vHxtg5HZCZ54ytdzShvfVDG6TtFzgockt90S2F8jYVuFo/KQLS
         m1lJh8bUvQNSyBIfpHuZOGYRAgdWWNbnVB0Wr0TL6qes4R5/kumR6diDkQU7U3LEIYNg
         MBTQ==
X-Gm-Message-State: AOAM531OLL+AF8uTfkqcM+yciKMU4QFcaK1WYGuUMfPAsrqI2Y4NWeyc
        wN/gZURnekJPu4S6/LcfpUkwmQ==
X-Google-Smtp-Source: ABdhPJyie/neP71DZoVh0xkkR/lSSw/WmzGCmPnhCr1wnRoY5kDS4wX57Io+5eFW0xZoEepPi9JQvg==
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr4774993wmk.25.1618565261256;
        Fri, 16 Apr 2021 02:27:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:6e70:fd4e:dfdb:68d7])
        by smtp.gmail.com with ESMTPSA id h8sm8805156wrt.94.2021.04.16.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 02:27:40 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jonas@kwiboo.se, jernej.skrabec@siol.net, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] drm/bridge: dw-hdmi: disable loading of DW-HDMI CEC sub-driver
Date:   Fri, 16 Apr 2021 11:27:35 +0200
Message-Id: <20210416092737.1971876-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds DW-HDMI driver a glue option to disable loading of the CEC sub-driver.

On some SoCs, the CEC functionality is enabled in the IP config bits, but the
CEC bus is non-functional like on Amlogic SoCs, where the CEC config bit is set
but the DW-HDMI CEC signal is not connected to a physical pin, leading to some
confusion when the DW-HDMI CEC controller can't communicate on the bus.

Jernej Skrabec (1):
  drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC
    driver

Neil Armstrong (1):
  drm/meson: dw-hdmi: disable DW-HDMI CEC sub-driver

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 1 +
 include/drm/bridge/dw_hdmi.h              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.1

