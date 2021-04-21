Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5B53662F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhDUATv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhDUATt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:19:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA47C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:19:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 20so16666959pll.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28EYDCuNWEgzn0N/DDDzksKfMnr58lRuBZLjk0Jhsjs=;
        b=Pdu80w7hjJNKzTd9/wtRPCkavr5vuViu0jIhvfpCmdJPuaWSTTXTLxiPjYEUGCM4NT
         EQtU0nxUxSQ7AFLMYymomc8P3aFit5iQoNum6Tkwc5TRfGSG8Md3UF7bdDtXkTrmuydk
         rXj/FFjQ9gYzX7XIkrmkSEi25QphbSu53N+hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28EYDCuNWEgzn0N/DDDzksKfMnr58lRuBZLjk0Jhsjs=;
        b=J655AuNsO23zZ6023TkaaVLUDzCwq73CEI3n42hv1ya4flGvPbMhIt6a3YgDp9W0so
         Dc5eBhXY+9z05pshyTkwtCtFySh1J1fPYZ4A0ji6pBGrqYLvJn6FYxwnkHQ99iUhiBxN
         hEIsTckU3zY1M5/na5Y3NfwSflSlRJBmzQ5+Q1gM+l/E+Vk6svdsIKRfPuuKMN/BSn1G
         KiM9+uIP+7DQjqzt6pmkzCSFRPWLOoYWNWzshWV+UVJRh4U5Y/BkPt0Nyl3ln/XW4TDQ
         UM0rD/QlxrbEPv6yv3u7k+Mk/rRVW+bjzCxCYzB6msPc74ijhS+oaFYH4vCe3BGXQHGQ
         mJCg==
X-Gm-Message-State: AOAM533+N1VfxA7pTnTYP5Wb/wwAKioVB+U1HA2HK6QXycUWPrFw4l8/
        AnkjVXkGVNhMT7yDPl/NxwOOnA==
X-Google-Smtp-Source: ABdhPJycAMpVOiAPk5bNG+ToyEpwyx0jWbEfRCT6RQGX15gR7dVK0eZc8hhwBF+N3WsTLEKL6ICzJg==
X-Received: by 2002:a17:902:9b96:b029:ec:b399:8389 with SMTP id y22-20020a1709029b96b02900ecb3998389mr8067446plp.1.1618964356100;
        Tue, 20 Apr 2021 17:19:16 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:95d2:8c89:b629:ff49])
        by smtp.gmail.com with ESMTPSA id d20sm145494pfn.166.2021.04.20.17.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:19:15 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, hsinyi@chromium.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        hoegsberg@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v12 0/4] drm/panfrost: Add support for mt8183 GPU
Date:   Wed, 21 Apr 2021 08:19:04 +0800
Message-Id: <20210421001908.813625-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is just a rebase of the v11, untested (but it seems like
Neil Armstrong recently tested it), with small changes in
binding and dts. v11 cover follows:

Follow-up on the v5 [1], things have gotten significantly
better in the last year, thanks to the efforts on Bifrost
support by the Collabora team (and probably others I'm not
aware of).

I've been testing this series on a MT8183/kukui device, with a
chromeos-5.10 kernel [2], and got basic Chromium OS UI up with
mesa 20.3.2 (lots of artifacts though).

devfreq is currently not supported, as we'll need:
 - Clock core support for switching the GPU core clock (see 2/4).
 - Platform-specific handling of the 2-regulator (see 3/4).

Since the latter is easy to detect, patch 3/4 just disables
devfreq if the more than one regulator is specified in the
compatible matching table.

[1] https://patchwork.kernel.org/project/linux-mediatek/cover/20200306041345.259332-1-drinkcat@chromium.org/
[2] https://crrev.com/c/2608070

Changes in v12:
 - binding: Fix min/maxItems logic (Rob Herring)
 - Add gpu node to mt8183-pumpkin.dts as well (Neil Armstrong).

Changes in v11:
 - binding: power-domain-names not power-domainS-names
 - mt8183*.dts: remove incorrect supply-names

Changes in v10:
 - Fix the binding to make sure sram-supply property can be provided.

Changes in v9:
 - Explain why devfreq needs to be disabled for GPUs with >1
   regulators.

Changes in v8:
 - Use DRM_DEV_INFO instead of ERROR

Changes in v7:
 - Fix GPU ID in commit message
 - Fix GPU ID in commit message

Changes in v6:
 - Rebased, actually tested with recent mesa driver.
 - Add gpu regulators to kukui dtsi as well.
 - Power domains are now attached to spm, not scpsys
 - Drop R-B.
 - devfreq: New change
 - Context conflicts, reflow the code.
 - Use ARRAY_SIZE for power domains too.

Changes in v5:
 - Rename "2d" power domain to "core2"
 - Rename "2d" power domain to "core2" (keep R-B again).
 - Change power domain name from 2d to core2.

Changes in v4:
 - Add power-domain-names description
   (kept Alyssa's reviewed-by as the change is minor)
 - Add power-domain-names to describe the 3 domains.
   (kept Alyssa's reviewed-by as the change is minor)
 - Add power domain names.

Changes in v3:
 - Match mt8183-mali instead of bifrost, as we require special
   handling for the 2 regulators and 3 power domains.

Changes in v2:
 - Use sram instead of mali_sram as SRAM supply name.
 - Rename mali@ to gpu@.

Nicolas Boichat (4):
  dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
  arm64: dts: mt8183: Add node for the Mali GPU
  drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
  drm/panfrost: Add mt8183-mali compatible string

 .../bindings/gpu/arm,mali-bifrost.yaml        |  30 ++++-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   5 +
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   5 +
 .../boot/dts/mediatek/mt8183-pumpkin.dts      |   5 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  16 ++-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  10 ++
 7 files changed, 172 insertions(+), 4 deletions(-)

-- 
2.31.1.368.gbe11c130af-goog

