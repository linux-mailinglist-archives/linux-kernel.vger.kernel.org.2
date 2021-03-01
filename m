Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC738329FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574721AbhCBDtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbhCAVfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:35:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8610C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:34:45 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e9so460110pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZAfMZcKzq3iVgCfair2PN2q6u9DIlMNWVwsNBuhJEA=;
        b=d14u1mKhq3NZmuBj7Vb0R/Daexr0DfJbkfthVgdVBT/Cfr6p40CjLMuzq4W5J6xqY3
         ZxIaARnEttaChsGRvVFYvDi6Bs2XwszTQBFzNOQ/CC92yYZil6uuo7fNzCPYGW2N4sDs
         E0OYqDNf9sr5MtDQVDT2wN22UjgaJeay3gsl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZAfMZcKzq3iVgCfair2PN2q6u9DIlMNWVwsNBuhJEA=;
        b=sOm7KZgPv8vhZcdd29ydoXW8jagrn2AiR29aRBzh+fYGjAeNIJgGBBeC4ijyNt0O+M
         I0CNlFBn06zeQjBRRSpzwNHK1qakBRx3os7WO+YacQfy0czgPgDA/f/zX4Nfc4u3dSps
         paqJZwoIyo/CbeNi7vqx0NZjbEJxUEPCOcwhPZw+KXCSJfumLRBUg675hF7EWy3tPDII
         g1hlv/2F0x5ICKFt1kf4+ra6GirY/0ltVYdiS0ojRqMyjsSohXV/UziD1SXEi31PbQo3
         usHeuebOIMxaHbL8u4X0E/3IVEU7JVh2mrkXAvedguypjGckHL330ljqcFDiD2MscLEV
         GmEw==
X-Gm-Message-State: AOAM530/jLwRF+Xn2pavQKNmleImj97AR9BqOZDtAruU7rBEC1of/9cJ
        DqerN0iDivoJ7B5RdIN320PObA==
X-Google-Smtp-Source: ABdhPJx493nOhuYON2I9u2Cc5lTgOfLzHp57kzb0fO1cpAF821IdeMD8iBuooIKpWCoJLKcIzbALFg==
X-Received: by 2002:a17:90a:5d14:: with SMTP id s20mr919409pji.6.1614634485212;
        Mon, 01 Mar 2021 13:34:45 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c086:5f6:85dd:98c8])
        by smtp.gmail.com with ESMTPSA id f13sm790366pjj.1.2021.03.01.13.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:34:44 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13] arm64: dts: qcom: Update sc7180-trogdor variants from downstream
Date:   Mon,  1 Mar 2021 13:34:24 -0800
Message-Id: <20210301213437.4165775-1-dianders@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The point of this series is to catch upstream up to what we have
downstream in terms of sc7180-trogdor variants.  Notably:
- It incorporates minor changes that snuck into the trogdor and lazor
  device tree files since they were posted upstream.
- It adds the "Limozeen" SKU variant of Lazor.
- It adds support the Pompom and CoachZ type trogdor boards.

This series was tested on the "for-next" Qualcomm tree at commit
d242adf2067e ("Merge branch 'arm64-for-5.13' into for-next").
- The patch ("arm64: dts: qcom: sc7180: Use pdc interrupts for USB
  instead of GIC interrupts") [1] just because it reduced diffs and
  seemed ready to go.
- The patch ("arm64: dts: qcom: sc7180: Avoid glitching SPI CS at
  bootup on trogdor") [2] because that's an important bugfix.

With all these changes things are in pretty good shape. Looking at
diffs compared to downstream w/ a few patches [3]:
- I haven't tried to resolve "sound" with upstream, instead stripping
  / leaving as-is any audio related nodes.  Someone with more
  knowledge of the current state of audio needs to take a pass here.
- I haven't tried to resolve DP with upstream.  It's basically not
  there.  Someone who works on this: please help!
- We have a downstream patch to manage power for USB hubs.  Without
  that we have to keep power on all the time for USB.  Matthias is
  still working on trying to get an agreement for how that should
  work.
- Downstream we have an early version of the "sleep stats" driver
  landed.  I believe this is in Maulik's court to re-post.

I have tested this series on "lazor", "lazor-limozeen", "pompom" and
"coachz".  All of them boot to the web browser with this patch series.

[1] https://lore.kernel.org/r/1594235417-23066-4-git-send-email-sanm@codeaurora.org
[2] https://lore.kernel.org/r/20210218145456.1.I1da01a075dd86e005152f993b2d5d82dd9686238@changeid
[3] https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/refs/sandbox/dianders/210225-downstream-dts

Changes in v2:
- Add link to Acked bindings.
- Proper compatible for the "correct" panel (added -ea1 suffix).
- Rebase atop commit 7822de1a2946 ("arm64:...1 for charger temperature")
- Removed "i2c_wlc" as Stephen suggested.
- lazor => trogdor in subject

Abhishek Kumar (1):
  arm64: dts: qcom: sc7180: add GO_LAZOR variant property for lazor

Alexandru M Stan (1):
  arm64: dts: qcom: sc7180-trogdor: Remove fp control pins in prep for
    coachz

Douglas Anderson (6):
  arm64: dts: qcom: Move sc7180 MI2S config to board files and make
    pulldown
  arm64: dts: qcom: Prep sc7180-trogdor trackpad IRQ for new boards
  arm64: dts: qcom: Unify the sc7180-trogdor panel nodes
  arm64: dts: qcom: Add sc7180-lazor-limozeen skus
  arm64: dts: qcom: Add sc7180-trogdor-pompom skus
  arm64: dts: qcom: Add sc7180-trogdor-coachz skus

Matthias Kaehlcke (1):
  arm64: dts: qcom: sc7180: Set up lazor r3+ as sc7180-lite SKUs

Stephen Boyd (3):
  arm64: dts: qcom: sc7180: Update dts for DP phy inside QMP phy
  arm64: dts: qcom: trogdor: Only wakeup from pen eject
  arm64: dts: qcom: Disable camera clk on sc7180-trogdor devices by
    default

Venkata Lakshmi Narayana Gubba (1):
  arm64: dts: qcom: sc7180: Remove clock for bluetooth on Trogdor

 arch/arm64/boot/dts/qcom/Makefile             |  11 +
 .../dts/qcom/sc7180-trogdor-coachz-r1-lte.dts |  18 ++
 .../dts/qcom/sc7180-trogdor-coachz-r1.dts     | 154 ++++++++++
 .../dts/qcom/sc7180-trogdor-coachz-r2-lte.dts |  18 ++
 .../dts/qcom/sc7180-trogdor-coachz-r2.dts     |  15 +
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  | 240 +++++++++++++++
 .../sc7180-trogdor-lazor-limozeen-nots-r4.dts |  34 +++
 .../sc7180-trogdor-lazor-limozeen-nots.dts    |  26 ++
 .../qcom/sc7180-trogdor-lazor-limozeen.dts    |  42 +++
 .../dts/qcom/sc7180-trogdor-lazor-r3-kb.dts   |   5 +-
 .../dts/qcom/sc7180-trogdor-lazor-r3-lte.dts  |   4 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r3.dts |   1 +
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  39 +--
 .../dts/qcom/sc7180-trogdor-pompom-r1-lte.dts |  14 +
 .../dts/qcom/sc7180-trogdor-pompom-r1.dts     |  26 ++
 .../dts/qcom/sc7180-trogdor-pompom-r2-lte.dts |  14 +
 .../dts/qcom/sc7180-trogdor-pompom-r2.dts     |  44 +++
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  | 288 ++++++++++++++++++
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  35 ++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 105 +++----
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  41 +--
 21 files changed, 1064 insertions(+), 110 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r2-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi

-- 
2.30.1.766.gb4fecdf3b7-goog

