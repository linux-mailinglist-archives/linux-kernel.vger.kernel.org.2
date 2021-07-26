Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2B3D65BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbhGZQre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbhGZQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:47:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9027BC0068F6;
        Mon, 26 Jul 2021 10:18:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y12so3524509edo.6;
        Mon, 26 Jul 2021 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBMxMyhbgJV7n+sTCKYEUkCtead+H/tnhZXc07MplwM=;
        b=KysArF5dkhIsTPF5BbdXrCDyCOfixYgHX0Of1wne/KYuc9OWsqKrqFy6t7xkxzNrNh
         NQ/9JLy5BNWpJfLTFlV66IW7WsnzibMaWlaHCXpf3ZXZnWY3l/9dZcBlRZW9RYWAJHMw
         52gYS7HRoKcTZ455t9gxLbk2uwBVaYGGqCx28k7nAtCSbY7JmWhR9y6xZMxBbyX8nnCa
         aY+hKICxRc1ySWEpuxpTdqBubYO6tibPHv5NCew9L4bj9wWj0T5dVcujVKJRS9nN9EQH
         GfmEnvDXCNE2G9NTKccf3kYt4nn/k2UL1ELoEfDRPoBj9PIgBA6RMrouUaDiTSJmd82V
         +cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hBMxMyhbgJV7n+sTCKYEUkCtead+H/tnhZXc07MplwM=;
        b=FRIsGVgzGxRlFijbPgTz2UPwG525ngBZF2aUuIqrwGRHmbVcqR8SKdeFA2QNyk2MR3
         Xqs1MaSu5n2jFhCxEnOyc3y/+H1zi29JnQ/v/j8Q2FECkDDK2xA2kpIo7R8qW+I5cKxx
         apbmSuh7rLX81JmF5nC8hvbbruarzLMUJVSPVMc7VB+gK67Gm6HLrWsrkDgd6fj82JER
         uDiGyRo4MHH5u9+2sJM2vUZ0c41+X6DQogn0Aot109nKYQttqZqxUrNvqmDA4gCSPZrJ
         dsnzTUYCBljvTCa7fTXnZ/AdOA31Bgm86KScaKJImAram61Red7WQoBORXAhBc5gRq5K
         M14Q==
X-Gm-Message-State: AOAM533LOoulzct9/lwVnNgF0G8N7DmD/LrTtEhae8uZHe7ZBKI5jV6I
        fWRIogTfooEJCY8d0sohTxk4ctQsMjEf8w==
X-Google-Smtp-Source: ABdhPJwqP4JhStOhqwMnLsEv0c0FOGDAUc1KFddOEQYD4Qvb9AoFB2rfKabWal5ll4dljwzD0D6s7A==
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr15639123edb.302.1627319901240;
        Mon, 26 Jul 2021 10:18:21 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:132c:4c2b:f8ab:5392])
        by smtp.gmail.com with ESMTPSA id e7sm195932edk.3.2021.07.26.10.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 10:18:20 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Samin Guo <samin.guo@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] hwmon: Add StarFive JH7100 temperature sensor
Date:   Mon, 26 Jul 2021 19:18:00 +0200
Message-Id: <20210726171802.1052716-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a driver for the temperature sensor on the JH7100, a RISC-V
SoC by StarFive Technology Co. Ltd., and most likely also the upcoming
JH7110 version.

The SoC is used on the BeagleV Starlight board:
https://github.com/beagleboard/beaglev-starlight

Support for this SoC is not yet upstreamed, but is actively worked on,
so it should only be a matter of time before that happens.

v3:
* Handle timeouts from wait_for_completion_interruptible_timeout
  properly.

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
 drivers/hwmon/sfctemp.c                       | 291 ++++++++++++++++++
 7 files changed, 386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
 create mode 100644 Documentation/hwmon/sfctemp.rst
 create mode 100644 drivers/hwmon/sfctemp.c

-- 
2.32.0

