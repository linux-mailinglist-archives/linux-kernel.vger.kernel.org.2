Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC423B33D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhFXQXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhFXQXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:23:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D1BC061574;
        Thu, 24 Jun 2021 09:21:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hz1so10474315ejc.1;
        Thu, 24 Jun 2021 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NuMe55P+TSN90iFcn8h08HfAcManWaQKAl9XfEn/uQE=;
        b=SZ6LvCUG3OX627cXClI5uJbOeJoJwfiOwRvsofhO740Abe2n2MC49LxNInzn/M4QLo
         MKI5RqzblyGSNDylXAPCeyaGPDlLEgIIa1AiQOBle7IHbD1avIHlYxjjiUdcowYVpg1e
         LggzDQngZIXFxr8gOATwDHzPUjhgyR/GjD30WzEv4lZBP1p7UN3fHeixo0LRc5JVlNUL
         OddmNX0a3hxstQL7SzE0Gegl91q0f3oKiYWnhpx2ez1JyVsIXcgH9PCcprw9xBB4qrAV
         p7HalKtKQwudgikbOQt2RrJRUkf//4xPR4QH1MaTmm6zD2/ti67PX4azbwG5ecPbGzLM
         98Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NuMe55P+TSN90iFcn8h08HfAcManWaQKAl9XfEn/uQE=;
        b=UIp5JBDCvApPZESp4ElEIIS9QC4OcedTqZR+RAfJ1z5XcdodaNC8Sx+RsiQ61pCXys
         UQeeksDGgfls2Zxl4j4hPznoUvea9j4TGQcymi45x7hpGqiQ1HZTQaAX6ZcOQ8NIzARr
         nrizuWfbPWHHP+cTO1HqI+iBx+5SnO2S3MLcsdCTz8PkGnS5AcwoP2a5CKJpC9CeFBxn
         zm7wvy0XLQOXgeywnb8fc2ycYPu43YGvKp5oXWp5OAHDS4tQ4pG0wdpFFjwu3ekpEfnt
         ZyxuDIi709mJ+t1wdNC0LcaiTgZZodSruCcoe89dIRyUVlgR3fqgReycz3dJ5te3O/aD
         U89A==
X-Gm-Message-State: AOAM532PNaK7BdHnMHyJQGkL8gfjo4+dPyR2f2jUJUO7HsLnkEbLLspJ
        cz7pEE2D6TSaGgJRYmmevBKUZBrbJFvo4A==
X-Google-Smtp-Source: ABdhPJwOFIzd6fHW1kJLsiuz7iDdx4PyJmlXzjBpKRA7k2yfodo30VC7JyWWAJ25NYKbmPzl8Jq/ww==
X-Received: by 2002:a17:906:6c97:: with SMTP id s23mr6094625ejr.248.1624551687584;
        Thu, 24 Jun 2021 09:21:27 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id p18sm1332832edu.8.2021.06.24.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:21:27 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Samin Guo <samin.guo@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: Add StarFive JH7100 temperature sensor
Date:   Thu, 24 Jun 2021 18:21:06 +0200
Message-Id: <20210624162108.832518-1-esmil@mailme.dk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

This adds a driver for the temperature sensor on the JH7100, a RISC-V
SoC by StarFive Technology Co. Ltd., and most likely also the upcoming
JH7110 version.

The SoC is used on the BeagleV Starlight board:
https://github.com/beagleboard/beaglev-starlight

Support for this SoC is not yet upstreamed, but is actively worked on,
so it should only be a matter of time before that happens.

v2:
* Fix checkpatch.pl --strict warnings
  - Add myself to MAINTAINERS
  - Fix multiline comments
  - Use proper case and whitespace for #defines
  - Add comment to sfctemp::lock mutex.
* Remaining comments by Guenter Roeck
  - Add Documentation/hwmon/sfctemp.rst
  - Use devm_add_action() and devm_hwmon_device_register_with_info()
    instead of a driver .remove function.
  - Don't do test conversion at probe time.
  - #include <linux/io.h>
  - Remove unused #defines
  - Use int return variable in sfctemp_convert().
* Add Samin's Signed-off-by to patch 2/2

Emil Renner Berthing (2):
  dt-bindings: hwmon: add starfive,jh7100-temp bindings
  hwmon: (sfctemp) Add StarFive JH7100 temperature sensor

 .../bindings/hwmon/starfive,jh7100-temp.yaml  |  43 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/sfctemp.rst               |  32 ++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sfctemp.c                       | 288 ++++++++++++++++++
 7 files changed, 383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
 create mode 100644 Documentation/hwmon/sfctemp.rst
 create mode 100644 drivers/hwmon/sfctemp.c

-- 
2.32.0

