Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53F388320
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhERXaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:30:22 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40781 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhERXaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:30:19 -0400
Received: by mail-oi1-f179.google.com with SMTP id s19so11420522oic.7;
        Tue, 18 May 2021 16:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2Mnwda2bA0bR8eHAT1VCSFjs3XmfSjqKvaYT9eR8H0=;
        b=kWRXyPuE6DeB5BBvK9CbS66ooAcj77a0Wi+LB9EJITWI0FYuNsNnSy4an1KqQP8xyB
         kUOtA+TfWcTQt56USIX+OJkYk79iuFTq6B2h5KCo8u2doXwoOC6vcZCwb5QhnnMRr7Uh
         p+cqN2gx9e6uTqCcZDE8bjOb09Sc8QCuh4OMFvThms4CGQcQM3GPNufkt8KQ0RVmcJBo
         Zvyx1wywPzjucqLeujblQ8Xc6aUCmZWCzEB485aNJ665N2ZuIMBdWcFqMS+JTkzR6KKp
         CwMY1qNW3gLQCoaOyWRSphnf5WT5t70oBQH4FSELDX8PHzaYXlyNniLvhY1dFdgBZBhs
         AcgQ==
X-Gm-Message-State: AOAM531IiYRhz88LlRkINmT8Rx4x0X4uPloC/Mk/WrfvcDrcZGA6feF8
        WJlJ15XTsT8I3bAErWSCsa837G0PzA==
X-Google-Smtp-Source: ABdhPJymwlT6WNlhW8gTX0f5PwbFXWyq1QqGXhYr+AZ9T54rc8DwHw6mj5xGTXoG6wFYIJKN2Zz2jA==
X-Received: by 2002:aca:d404:: with SMTP id l4mr5237726oig.160.1621380540051;
        Tue, 18 May 2021 16:29:00 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id d19sm3985608oop.26.2021.05.18.16.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:28:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/6] dt-bindings: Convert mux bindings to schema
Date:   Tue, 18 May 2021 18:28:52 -0500
Message-Id: <20210518232858.1535403-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the mux-controller and some i2c mux bindings to DT
schema. This was a rabbit hole of trying to fix undocumented (by schema)
compatibles (enabled by setting DT_CHECKER_FLAGS=-m). So this is mux
bindings, and then a few others that are used in the mux binding
examples.

The mdio and iio mux bindings still need to be done. Patches welcome.TM

It's probably easiest if I take the whole series.

Rob

Rob Herring (6):
  dt-bindings: mfd: ti,j721e-system-controller: Fix mux node errors
  dt-bindings: rtc: nxp,pcf8563: Convert to DT schema
  dt-bindings: mux: Convert mux controller bindings to schema
  dt-bindings: i2c: Convert i2c-mux bindings to DT schema
  dt-bindings: i2c: i2c-mux-pca954x: Convert to DT schema
  dt-bindings: i2c: maxim,max9286: Use the i2c-mux.yaml schema

 .../bindings/i2c/i2c-demux-pinctrl.txt        |   2 +-
 .../devicetree/bindings/i2c/i2c-mux-gpio.txt  |   4 +-
 .../devicetree/bindings/i2c/i2c-mux-gpmux.txt |  99 ----------
 .../bindings/i2c/i2c-mux-gpmux.yaml           | 124 ++++++++++++
 .../bindings/i2c/i2c-mux-ltc4306.txt          |   4 +-
 .../bindings/i2c/i2c-mux-pca954x.txt          |  74 -------
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 106 ++++++++++
 .../bindings/i2c/i2c-mux-pinctrl.txt          |   4 +-
 .../devicetree/bindings/i2c/i2c-mux-reg.txt   |   4 +-
 .../devicetree/bindings/i2c/i2c-mux.txt       |  73 -------
 .../devicetree/bindings/i2c/i2c-mux.yaml      |  87 +++++++++
 .../iio/multiplexer/io-channel-mux.txt        |   2 +-
 .../bindings/media/i2c/maxim,max9286.yaml     |  23 +--
 .../mfd/ti,j721e-system-controller.yaml       |  19 +-
 .../devicetree/bindings/mtd/ti,am654-hbmc.txt |   2 +-
 .../devicetree/bindings/mux/adi,adg792a.txt   |   2 +-
 .../devicetree/bindings/mux/adi,adgs1408.txt  |   2 +-
 .../devicetree/bindings/mux/gpio-mux.txt      |  69 -------
 .../devicetree/bindings/mux/gpio-mux.yaml     |  92 +++++++++
 .../devicetree/bindings/mux/mux-consumer.yaml |  46 +++++
 .../bindings/mux/mux-controller.txt           | 157 ---------------
 .../bindings/mux/mux-controller.yaml          | 182 ++++++++++++++++++
 .../devicetree/bindings/mux/reg-mux.txt       | 129 -------------
 .../devicetree/bindings/mux/reg-mux.yaml      | 143 ++++++++++++++
 .../bindings/net/mdio-mux-multiplexer.txt     |   2 +-
 .../devicetree/bindings/rtc/nxp,pcf8563.yaml  |  50 +++++
 .../devicetree/bindings/rtc/pcf8563.txt       |  29 ---
 27 files changed, 860 insertions(+), 670 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux.yaml
 delete mode 100644 Documentation/devicetree/bindings/mux/gpio-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/gpio-mux.yaml
 create mode 100644 Documentation/devicetree/bindings/mux/mux-consumer.yaml
 delete mode 100644 Documentation/devicetree/bindings/mux/mux-controller.txt
 create mode 100644 Documentation/devicetree/bindings/mux/mux-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mux/reg-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/reg-mux.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/pcf8563.txt

-- 
2.27.0

