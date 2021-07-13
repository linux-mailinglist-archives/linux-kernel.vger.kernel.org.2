Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9943C79F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbhGMXOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbhGMXOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:14:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A168C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:11:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u1so786831wrs.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3WvoSxwfuOLBE563gnD/WfFxdtzwAqkUgPGYxOHnEQ=;
        b=LmpI7ec22NDr2SdptNqwTAK6ly3heaAtBiZoEoTRno9e3lf9RvZiuIlNOJkBngqioy
         tAkR6UqSYppCzLhbCSjwYOdMgsDNUCYxDeq14U9Ase2ZixCF7vaL2bw1iYrgF6ihD7ML
         BnpXXN5iNGEtA0TMuMzmgXg0cgHX55Eoo1ruDz+5jduDue7j95vbJsK+eFoZ9oM1Bn8H
         Ci9EhyzKgaL2KT7Wvu/kPAAuZclTAq/1S7FQpGzvx4fnBeVCkuDxjFBdjVRdktdc/M3a
         tx8XE0yh205l1XDSz4357x0XPn1I3+PnrnU5SXdS4/5YPyXpecP5ZOkePx/UqQs7FQ0Z
         qdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3WvoSxwfuOLBE563gnD/WfFxdtzwAqkUgPGYxOHnEQ=;
        b=cfKL6zp2uZZ/lgIMKTcljr8Xa3OgjXW6CRQD2U0ClqvWmfvmXzbcyRLVC1JLUf7zML
         FoHhxWabQfTZdaEIPIDQrbc/6t9z1uFq6itKz//Gc4vaQwUObc7fqwZtAKYM2ZEPZEg/
         TbZzrQTaHRF5YFGg7RuFX+JFQUd6mjR36mNrWG8ljox2Afthmh0q4ekqHJiyThLxgYS7
         xWB8GKn8no41Fv5Iv5GbsNz275aV0fxmxloqLH9sIqbhp6bFCWxYPSutU4i0WgKwvbfw
         LnfKjSpSwO2ITO7vo8U8GsT++mbOAiZcB89Z8v20c/l9wd0qkuUdHzGXpvupLRxkpRDj
         C7DQ==
X-Gm-Message-State: AOAM5333diLhnhc9ccLAAq0iDWhrqRD8W7HTwCbu7q1tKrT/0rbw4UZj
        VqfqA19+wBvwk0qhnodwVoY=
X-Google-Smtp-Source: ABdhPJyhSQubExHHk6TVWZrTwqMpNVKNb/QgGSoTDc6PiSUzYGLypXqVrv97Ggl7awnh5UGeINTrQw==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr8943529wrw.228.1626217869751;
        Tue, 13 Jul 2021 16:11:09 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c041-6f00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c041:6f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id y16sm3551608wmq.1.2021.07.13.16.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:11:09 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] Meson8/Meson8b: sound card support
Date:   Wed, 14 Jul 2021 01:11:01 +0200
Message-Id: <20210713231103.2994354-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the AIU audio controller for Meson8 and Meson8b. The
AIU audio controller has been found to work fine with out-of-tree
patches for HDMI audio (over I2S). SPDIF output also works (tested with
a scope).
Endless Mini (EC-100) has an RT5640 audio codec. The driver for this
codec can be selected since commit 08c56cab302a05 ("ASoC: rt5640: Make
codec selectable"), which is part of Linux 5.14-rc1. While support is
not perfect (due to us lacking proper support for configuring
GPIO_BSD_EN) audio output still works fine.

This series is based on my bugfix patch "ARM: dts: meson8: Use a
higher default GPU clock frequency" from [0]


[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20210711214023.2163565-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (2):
  ARM: dts: meson: Add the AIU audio controller
  ARM: dts: meson8b: ec100: wire up the RT5640 audio codec

 arch/arm/boot/dts/meson.dtsi        | 11 +++++
 arch/arm/boot/dts/meson8.dtsi       | 63 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b-ec100.dts | 45 +++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi      | 63 +++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+)

-- 
2.32.0

