Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F9410D4A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhISUa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhISUaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:30:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53001C061574;
        Sun, 19 Sep 2021 13:29:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso13708936pji.4;
        Sun, 19 Sep 2021 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBjSMPq/tc0MbMsuyhFQ5R0zfd/wCDAa5rcp0EQgEaE=;
        b=lYdbvL9opmTy4v90dyhALAdqgj2jW0gtT5y2fppjGanjkhqQSamb4ZVgE/rHd6DZLR
         qBESeBE8UgGzFjKp2XOGq/6hqha7HEWjt7wihYzM+8HB02ExZxGWuv34y7IrgVofHvev
         lbQJGbhiHrnwc0OTXZp+SyEtcFMv2Xoc5vNqmedcc1GfqVD2cBJ1s266BUj9vORr+CV7
         B1kzKNvuifwAxxXUgYsnmgCso8TOK0VXJmKuI/x1zbKIi7xYHohvW7+cN37Y0c3CZ4J5
         zy+epdlDWbMsyW+krMaQrF0dbWI2c4DcijM50ZSF7RlWa1QpaSf6F4EL231pKrYyrV8a
         Gc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBjSMPq/tc0MbMsuyhFQ5R0zfd/wCDAa5rcp0EQgEaE=;
        b=iphCVDZqabrzJrQZogUaklz4KE4ReO+oW0P5JwzA16jLWyr3cv/j+gZuKiAPBn8mPX
         1exd5B9U110RsFQH2mruUWLg6uRQFTNMOyCntwWVBL0Gsnr5eqsgtYe1UVqo7+b1iSIU
         iJNJglo83qXT6IFhGrqPBd+tEQA2U31EsDs+O7STWea8Ve5SALi8Li94XsdbgLSyWDyz
         W+Daj+NtB/zuZ11rvX6G9knvXnevvlH93EUHf2O8RMCF7MtQV9bkuU1CD0R1X3IaAS0a
         f2tpyFj7Hj2L4WRUwnd+Rp+jYM154lGD3YJqNUBxwWGk4bU5CaPCADgsnw0sX9WMfsf8
         01xg==
X-Gm-Message-State: AOAM530Oh8wOJPrw3IwaIjy5Qm9C/9CV5oh4ia7V+pdImgWR5Ju8BLpb
        i6QyWhnRLNPpoiuDizaNpPSEp1NYp8avuA==
X-Google-Smtp-Source: ABdhPJxoT9VPIS67Ft6batnOOnUBctnyPbP4zsaE4K0N3bJ3Ttj092+S5csLVDH6cJp1W6xUrz7//A==
X-Received: by 2002:a17:90b:3b4f:: with SMTP id ot15mr34599158pjb.243.1632083369891;
        Sun, 19 Sep 2021 13:29:29 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.29])
        by smtp.gmail.com with ESMTPSA id z11sm12663684pff.144.2021.09.19.13.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 13:29:28 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv2 0/3] Fix the pwm regulator supply properties
Date:   Sun, 19 Sep 2021 20:29:08 +0000
Message-Id: <20210919202918.3556-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes PWM supply properties help fix internal link of PWM to
main 12V supply as per the shematics.

V1: https://lkml.org/lkml/2021/6/29/288

Thanks
-Anand

Anand Moon (3):
  arm64: dts: meson-g12a: Fix the pwm regulator supply properties
  arm64: dts: meson-g12b: Fix the pwm regulator supply properties
  arm64: dts: meson-sm1: Fix the pwm regulator supply properties

 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts       | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts      | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi   | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi        | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts   | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts  | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi       | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts        | 2 +-
 10 files changed, 13 insertions(+), 13 deletions(-)

--
2.33.0

