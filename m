Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FDC3ED186
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhHPKAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbhHPKAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:00:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D603C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:00:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k29so22697765wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXtfrlhTvK5I4Q1AcToRyUZbAQ+Zw4tC00SfbVVvbW0=;
        b=s3ToyYAoY23WCoCF6c7fFnVwgRmAsa5SAo30JW235Lg6QeLK2Z63c1kjPVsIGjCZiU
         gJ+keeK0niCAkyDDssO7o9zgEj+CeU9011sowPpALmwzMfjylFCiQvwubhDOX/noeweA
         OZitkIVb8Pr8U50KzUrfqAjcUCaeylgShbm+ySjWFsDKqyZatCtpYqrwm52rWm4yqaT7
         sS326TZlVB+RIJNXACPI1h1Vhkay8IvlwI9YXh7WfxcZN707rHnmoMu8UzcTc6XjL3PV
         6c+rk8HFqer/jR0gAv82tCNBoOxBU9G5WRqBCzkBcOxSjk2hQiJVOZsNjxBW2+9zUt3a
         dFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXtfrlhTvK5I4Q1AcToRyUZbAQ+Zw4tC00SfbVVvbW0=;
        b=t/TNzgtp6S2bwlQ6tPoiG6kIbSlU3DWzGVtJnyx3oM5OlT8LVNJob73R/xJ/eG6IiG
         ykSRKJs+jo+mLODTuaOWZpW0mJBcKGKg7H8YDBRV6jIla+QUzf2hZnbettwAL7vbwkAt
         2KcUhBbw8Vv873HZ40DQKU7+IGYXDlCAJYN54tdHMMVdAClSUPDrh6FyRkiwf2YOt8il
         1w5wv8/F8bhpgNjiZOYVTru0dnsU0lKix1WcDrKCl8felyablKZMvFm5NfDkQ0u0yUAJ
         //HMJr2cj18iteKK4ceaYqm4amn3u+L+LRAFEooJiS/DaiuTDHpTAE28FJJuxk6PATsk
         bgZA==
X-Gm-Message-State: AOAM533B0UbifPVZPmd4Ambgg7e+GRAthhWa125tKrsMdzbwfpG7EVGI
        zGBLJc7QE2wETmSffaPmRJihnQ==
X-Google-Smtp-Source: ABdhPJwDGgULKk6muzbBo58qOdzC2JgP8l7B8Uqpu2dQfFY7AAre2f5xvKhTZVqiO41kMGHvn1DEJg==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr17685059wrq.148.1629108016922;
        Mon, 16 Aug 2021 03:00:16 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:92b1:d3c2:1204:85e2])
        by smtp.gmail.com with ESMTPSA id u10sm1916645wrt.14.2021.08.16.03.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 03:00:16 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH RESEND v3 0/4] input: MT6358 PMIC button support
Date:   Mon, 16 Aug 2021 12:00:09 +0200
Message-Id: <20210816100013.100412-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek MT6358 PMIC has support for two buttons: PWR and HOME.

The interrupt logic is a little different than other PMICs from the
same family:
for MT6323 and MT6397, we have one interrupt source per button
* for MT6358, we have two interrupts lines per button: the press and
* release interrupts are distinct sources.

Changes since original v2 at [1]:
* added 4th patch with device tree enable
* cover letter title prefixed with 'input'

This has been tested with evtest on mt8183-pumpkin on 5.14-rc6

Mattijs Korpershoek (4):
  Input: mtk-pmic-keys - use get_irq_byname() instead of index
  dt-bindings: input: mtk-pmic-keys: add MT6358 binding definition
  Input: mtk-pmic-keys - add support for MT6358
  arm64: dts: mt6358: add mt6358-keys node

 .../bindings/input/mtk-pmic-keys.txt          |  5 +-
 arch/arm64/boot/dts/mediatek/mt6358.dtsi      | 12 ++++
 drivers/input/keyboard/mtk-pmic-keys.c        | 56 +++++++++++++++++--
 3 files changed, 68 insertions(+), 5 deletions(-)

-- 
2.30.2

