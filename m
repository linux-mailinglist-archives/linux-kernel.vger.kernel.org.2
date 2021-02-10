Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F8316C27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhBJRLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhBJRLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:11:30 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:10:48 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d26so1674754pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJV+MEYRICjZ5HpV10ncANYQowHTJOaKXZIikrVEzcc=;
        b=eBjO8Mp+e0jogy5KAtdpVmCbQT7+E94H38P+/sET318KCwdSa9MYraoeqWiUIUWAdo
         WTCreNp5joOqR7uA7CDTSDMPkQ7mrJqdJBA6WblNHhppN17B6HCH2cExTi3vUWxxkfJu
         MPSw+Kk42luJ2FRguWwMopBsZLeKo4/21UTFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJV+MEYRICjZ5HpV10ncANYQowHTJOaKXZIikrVEzcc=;
        b=rpUHGmE+UJNO208QMbsqLaXHSzqZS+IZUAOmj4pWXZZuZTFvWTJt8EAA+i+I9h3nvf
         Ge5PoMxdwXmBGvsgsBkc2u/aqkPQvgpoWbOOEhEZIZU2b2drP9b9gPjyHgACQjS3JpST
         CNgNPjC0jjLLB8EFELxcb420UhNsZkD9FtiaTymyW20GS07LA1T7384+/5tKOru4bQ7K
         mQUBWLiDpr34oJksG8IFKzfCnDlN09ySN1lfN1UV3V2NCH1OsrHMQfoOV9kjFcF8GdTY
         0713LKM2N6LJGoA3NlBFv0oiLCEGWQ+MJbL0m1NwfMJI/IHBsbMsnkTXpgMIVVqlJA95
         kjbA==
X-Gm-Message-State: AOAM530QYAeSLjaqCp7aFKWzSdKVDhPEtmXtr77gYJXKjS5TvxYWNoM4
        2w4dO0vANiyiCa2mSORnGsi5Bg==
X-Google-Smtp-Source: ABdhPJwUpLOFCuA7nZkRLnyPywPsm+Uy2ope7BH7lfMNFNhIZv7LbA3078Lu/PZU9JDAuQw2JUj02g==
X-Received: by 2002:a63:fa0b:: with SMTP id y11mr4048388pgh.35.1612977047929;
        Wed, 10 Feb 2021 09:10:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:d8e6:826a:fc50:2158])
        by smtp.gmail.com with UTF8SMTPSA id m25sm2971739pff.77.2021.02.10.09.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 09:10:46 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Al Cooper <alcooperx@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 0/4] USB: misc: Add onboard_usb_hub driver
Date:   Wed, 10 Feb 2021 09:10:35 -0800
Message-Id: <20210210171040.684659-1-mka@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the onboard_usb_hub_driver, the corresponding
device tree bindings and creation of onboard_usb_hub platform in
the xhci-plat driver during probe().

The main issue the driver addresses is that a USB hub needs to be
powered before it can be discovered. For discrete onboard hubs (an
example for such a hub is the Realtek RTS5411) this is often solved
by supplying the hub with an 'always-on' regulator, which is kind
of a hack. Some onboard hubs may require further initialization
steps, like changing the state of a GPIO or enabling a clock, which
requires even more hacks. This driver creates a platform device
representing the hub which performs the necessary initialization.
Currently it only supports switching on a single regulator, support
for multiple regulators or other actions can be added as needed.
Different initialization sequences can be supported based on the
compatible string.

Besides performing the initialization the driver can be configured
to power the hub off during system suspend. This can help to extend
battery life on battery powered devices which have no requirements
to keep the hub powered during suspend. The driver can also be
configured to leave the hub powered when a wakeup capable USB device
is connected when suspending, and power it off otherwise.

(no changes since v1)

Matthias Kaehlcke (4):
  dt-bindings: usb: Add binding for discrete onboard USB hubs
  USB: misc: Add onboard_usb_hub driver
  usb: host: xhci-plat: Create platform device for onboard hubs in
    probe()
  arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub

 .../bindings/usb/onboard_usb_hub.yaml         |  49 +++
 MAINTAINERS                                   |   7 +
 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts |  15 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts |  11 +-
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  15 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  18 +-
 drivers/usb/host/xhci-plat.c                  |  16 +
 drivers/usb/misc/Kconfig                      |  18 +
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/onboard_usb_hub.c            | 409 ++++++++++++++++++
 include/linux/usb/hcd.h                       |   2 +
 include/linux/usb/onboard_hub.h               |  15 +
 12 files changed, 542 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c
 create mode 100644 include/linux/usb/onboard_hub.h

-- 
2.30.0.478.g8a0d178c01-goog

