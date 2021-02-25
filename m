Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C693E325950
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhBYWOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhBYWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:14:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E2C061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id jx13so897957pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BGyHjBouNSnLUG2Lzfuc7WYlrAHiqSHJ6DI2sOQjym4=;
        b=S4Vi4cVffwjxP1q3GBRpmePU3bNnosfOHW0493up4vtbefnaDjXNrkFPVOOc1kLROO
         wTqoIXJGHgcH4ixg60PUwcK/Wjfuel0+BGx/ZQ1sY6Xg4upWMYLTdshYL+RaNFaOQggR
         Dtsd3kLgKbPKNANEi48PZT4tdnwy/82fvgD/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BGyHjBouNSnLUG2Lzfuc7WYlrAHiqSHJ6DI2sOQjym4=;
        b=jzSJDnRHJzleWBCbkJjwa6EaxbKgO/UQVav4pYwB5zvR0ex72Ygbn/ugaNKBrEPhxJ
         vZEkD5X22WXqq9YcyF1U76YP/+ptpIJ/ona3Lejl5PiqfqpQH/qhF1Y2SehjHxd5cjTt
         0/jqhYYUq2+qLzcprBjxQoNIgUxX6oU+QUicKvJ/3K32peFLSExAm4QkyBmt2m/RgdHZ
         fllrpHYJy6YKUDwY3jj8Uww1aWLiAJ0D5StzbiftsgkpR9OjNid/vK5bP23HLB/f9pA4
         izPsWl2zz2xil+g9QRM36ySdpLNkPoDccC99x7udh/UQPFOlKxgYkx7jic2hbFaEVTuw
         1rRA==
X-Gm-Message-State: AOAM531h8I4DGhgX0mwWs1m/4ApRUxa6tEW4jXwoZlApcb63lSxKncIB
        wKvzmAuclkKFFQ8xUWxlqJJEiQ==
X-Google-Smtp-Source: ABdhPJzRmpl0rRj+D2HGkH0+imXRHUlA3DDnhKov+B+ipXusLMCdPyxG853CyK9kQXZD/AfQjokxIA==
X-Received: by 2002:a17:902:be06:b029:e3:7031:bef with SMTP id r6-20020a170902be06b02900e370310befmr178907pls.19.1614291217144;
        Thu, 25 Feb 2021 14:13:37 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:8414:45a5:94c4:d35d])
        by smtp.gmail.com with ESMTPSA id jt21sm6713301pjb.51.2021.02.25.14.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:13:36 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] arm64: dts: qcom: Update sc7180-trogdor variants from downstream
Date:   Thu, 25 Feb 2021 14:12:57 -0800
Message-Id: <20210225221310.1939599-1-dianders@chromium.org>
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

This series was tested on mainline Linux instead of the Qualcomm tree
since mainline has important bugfixes that are not in the current
Qualcomm tree. Given the current state of the merge window mainline
has all of the relevant Qualcomm device tree files anyway. For
testing, I picked these atop mainline:
- Commit fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
  to keep the GPU from crashing due to the fact that commit
  20fd3b37285b ("arm64: dts: qcom: sc7180: Add support for gpu fuse")
  is in mainline.  This commit is in msm-next.
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

I have confirmed that Matthias's recent charger series [4] applies
atop this with no conflicts, though I haven't looked at exactly which
revs of coachz / pompom need a similar change.  It might be easiest to
just follow up once both series land and we get final confirmation
about exactly which revs will have exactly which thermistor.

[1] https://lore.kernel.org/r/1594235417-23066-4-git-send-email-sanm@codeaurora.org
[2] https://lore.kernel.org/r/20210218145456.1.I1da01a075dd86e005152f993b2d5d82dd9686238@changeid
[3] https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/refs/sandbox/dianders/210225-downstream-dts
[4] https://lore.kernel.org/linux-arm-msm/20210225103330.v2.1.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid/


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
  arm64: dts: qcom: Add sc7180-lazor-pompom skus
  arm64: dts: qcom: Add sc7180-lazor-coachz skus

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
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  | 249 +++++++++++++++
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
 21 files changed, 1073 insertions(+), 110 deletions(-)
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

