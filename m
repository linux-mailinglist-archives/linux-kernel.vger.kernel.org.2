Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED943664CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 07:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhDUF3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 01:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhDUF3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 01:29:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D79C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 22:29:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y62so3785203pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlaqIWp5Fzquc+zXrvm2JPBL/vMUuB8HIWaERbo23p4=;
        b=b9uo6QVHkt0VV4y2Dg4EHFFElBLjCCyDwSVMIDwkIqTNzjblJgeigtidsR81zNfOKi
         L9BdKCqmzSXE5ap3gH4eJRWiqRq8DRRS9euzxGTLTf1LjmmzIBna0Go87oNJJ+H/tVRB
         9vmQqLh2nvM1a7DwwiGupaXA5Ur6p8XSVXvdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlaqIWp5Fzquc+zXrvm2JPBL/vMUuB8HIWaERbo23p4=;
        b=RIWqvn3Dx8z6A/sfjuPyEKECZEfNfi7r2V0tu1Tq4hznK1ILc+DAwM41V/TM6GVIG4
         GJvgX0mmNKsKt/uzyVI2GpEVENxysLPwK3MHs0yjfwv6QFX5HSw4KNV/QY4rrQ2weESQ
         kFcPGnQlV7Cb+UZ6iE2UZTbzcPf7QFOdikefh2DL01T21RUbBCiWOD4dtHOT9PaXLwzH
         RD4JTub8puZLM5dMbKnQy6o1FkKU2ZLO76pMAlOFQq+dcD1ReCKo1KbqqgUffgdfD86h
         jDV4Zb438tLbGFq7DZtRNg8etOn7Vee2uo+5J6fljPuyj8+16k6WZGbwxVuq1IHi7/nV
         egGw==
X-Gm-Message-State: AOAM533pTb7PnLHTfcGNtFB5EQCUEJb/nQn2l69ZTQ9D56aD71xn30YU
        q9iROAnBMhAMou0dZxo+UsPw6A==
X-Google-Smtp-Source: ABdhPJy/v51axJc4IPprUcfU5wqCBVCs3deVpfNqoQc0PWEDX48zVr/uPgS2uSMuQue7WI3t0o/AXg==
X-Received: by 2002:a62:6202:0:b029:208:f11c:2143 with SMTP id w2-20020a6262020000b0290208f11c2143mr28513587pfb.32.1618982941649;
        Tue, 20 Apr 2021 22:29:01 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:b3e5:49c0:4843:2bbe])
        by smtp.gmail.com with ESMTPSA id b6sm602537pfa.185.2021.04.20.22.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 22:29:01 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, hsinyi@chromium.org, hoegsberg@chromium.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v13 0/4] drm/panfrost: Add support for mt8183 GPU
Date:   Wed, 21 Apr 2021 13:28:51 +0800
Message-Id: <20210421052855.1279713-1-drinkcat@chromium.org>
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

Changes in v13:
 - devfreq: Fix conflict resolution mistake when rebasing, didn't
   even compile. Oops.

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
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |   9 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  10 ++
 7 files changed, 168 insertions(+), 1 deletion(-)

-- 
2.31.1.368.gbe11c130af-goog

