Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA1F43C42D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbhJ0Hoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbhJ0Hov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:44:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D3BC061767
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:42:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so4399133pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:in-reply-to:references:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=EvWO9/aP2UYkWDRoMSk+UDHZ7nRats7jMQJQZIEXWAU=;
        b=k0uypuoa/tSMIoB+UArjlA7+U5joF88Bjt7a/jjC+VozJJHJorpHFAPYgUAv3TcPb5
         IooaM7AQRTLfNG1fcIu0e+jKw6OYKnqD2klEG0e6Y1J8UI+NZQso5uCGvvRU8KbsenWu
         sWpWZzr69WDdZI5fvIKdRC3bBZ0E2mpKmANl1KUdnqgL64Yv6QZM14xXeJVHhpdiR5Ix
         A92BxQ8OL9PrwpFB2L9HX6x75a1aDw89wSHnH4B4awmYMA58jqXMF8NHXvL3BFfIDd8S
         11hgRoSD//YWuA8GCLsggL0PkUXx92NPm1AstguVi9m8fPjndlhC6XLGETnX+bzlKyGH
         BFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from:to
         :cc:subject:content-transfer-encoding:mime-version;
        bh=EvWO9/aP2UYkWDRoMSk+UDHZ7nRats7jMQJQZIEXWAU=;
        b=I+pAu1L2GaZvkpdf5B3pig97qtUirN3YSyZGm9Y/FGPocwpE7lDwI8iIiFE8+0E6c+
         hqmxhPhJBj6zpc0t0x3xnOP++3X+fQs1B0esWPHOfsfXgoX5D9M5a1UWAo1ylJZdoxCL
         6YcqF34uFEK5QY0OQZPc5SbjkV7sXQ3t+9+bqxH2UYdX1Tx55DUZEhBxR1a/TgFPr8ct
         NO98pFhV6+ANB3nTpYTBSE3psDOwy0huWTJWKPyJQMSvRTw7z/lKM6yJl9i6/OzkFdtm
         RxQzua34LwyQXAjb3SfSFYHtERraGisd32p2TzP8Rxqk5Q0itTOV51TcHvy/0hCmDPhZ
         2DvA==
X-Gm-Message-State: AOAM530V/Ui3ZmyXUq9B2bOykJiEIlGFVXQYiZuuAh24tpgqIa+UtOOH
        kHLEAZNgM/UYR5UvZ1BZF2eExQ==
X-Google-Smtp-Source: ABdhPJyf8nYG8qW81/yolRdeZUerGGa9z3mseuZofnD2TXanUqJezx9SKGVMO/KNngkgyBfXtZQpCA==
X-Received: by 2002:a17:90a:cc05:: with SMTP id b5mr4099506pju.71.1635320546280;
        Wed, 27 Oct 2021 00:42:26 -0700 (PDT)
Received: from [127.0.1.1] (117-20-69-24.751445.bne.nbn.aussiebb.net. [117.20.69.24])
        by smtp.gmail.com with UTF8SMTPSA id c85sm10272618pfc.146.2021.10.27.00.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:42:25 -0700 (PDT)
Date:   Wed, 27 Oct 2021 07:42:12 +0000
Message-Id: <20211027074212.690611-0-nathan@nathanrossi.com>
In-Reply-To: <20211025025805.618566-0-nathan@nathanrossi.com>
References: <20211025025805.618566-0-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 0/3] Driver for TI INA238 I2C Power Monitor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

Changes in v2:
- Added device tree binding for ti,shunt-gain to specify the target
  ADCRANGE for the ina238
- Reworked ina238 driver to use hwmon_chip_info API, and addressed
  various review comments

Nathan Rossi (3):
  dt-bindings: hwmon: ti,ina2xx: Document ti,ina238 compatible string
  dt-bindings: hwmon: ti,ina2xx: Add ti,shunt-gain property
  hwmon: Driver for Texas Instruments INA238

 .../devicetree/bindings/hwmon/ti,ina2xx.yaml  |   7 +
 Documentation/hwmon/ina238.rst                |  56 ++
 Documentation/hwmon/index.rst                 |   1 +
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/ina238.c                        | 672 ++++++++++++++++++
 6 files changed, 749 insertions(+)
 create mode 100644 Documentation/hwmon/ina238.rst
 create mode 100644 drivers/hwmon/ina238.c
---
2.33.0
