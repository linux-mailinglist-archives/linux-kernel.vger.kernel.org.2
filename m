Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA39B3CECFF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348810AbhGSRkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355310AbhGSQgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:36:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC61C09CE7A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 09:44:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i5so31432706lfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=phystech-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVWppwQDa959r4EyoeDttMlnVrR+sUQQyz24Ur+wrSA=;
        b=tm7g4wfvS9xa6UVTvbYV9KLPDGRa6aUi/k23PE4woz3Dhf5Ac4NXE1s2FpUo8mQ2Sz
         m9C/Va+bszZ4/doxhEmtK1yRKir6+fFcQdPL3qZ6ySAMlx4YcAg9s3byPzbjiCte5HmY
         7bgwDxy7KY594A7oU7Ap4kPCpRf0EGl2yvvD0zzGYGle/uqJzNmFvrY5niwCo3EO4bDL
         2fww+l+2QfjlRXjghHjJ/0tRbHhX9BNGsRs6eBRegUGL8NDoLb6ASK8k+tByAOBkFvHY
         9t57Mm9C58xF2cMoRkNIOCePU3TLMQMsMwvHU6712pM08NP4MG5gJTE4d2M+UKsxVwmP
         vHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVWppwQDa959r4EyoeDttMlnVrR+sUQQyz24Ur+wrSA=;
        b=d3go+4pKzmuAxETeaeQQcb2sCVqwZ+uDZNqUHaJTZFKd/qZvwxR86+8bLnpoEFCb9n
         Co1QbPR3GOoUG2yY2v4ZRQaO8kugqCnErlJOUJX/jLxlboW3S7iDpMl5SiW+yuljl7ed
         kK0oSlxVGt4IZK5ec7PIYuMHeD7yFrKmEXJdkBoSMyQ4rQtc5uZKbmPTb6datCumfO6o
         1v0u9cnXJ2es5wRBQk4nOS3H1T9uWgYYejoJAr02W/CM4HBm7Na1Dv+F0zVJo5IZaOHQ
         Ou8CkMHKJjjsh8ZZhjBhdEpF9TUfokCppU7y/BV/jFZ31h7L6O7FMWJAwUdRBxzOJbRf
         qSjw==
X-Gm-Message-State: AOAM533M+IjI1uPxFnq+vlv9rF6En3+77h/fyc5Dcu9ag0s3RGXNevUt
        zZmMV07ufWbHs8DU0ACAqLo08w==
X-Google-Smtp-Source: ABdhPJwwimdpA4JO2EjsZrMxSSoC8I6iX64G5jogsp9iaDmetD1RQFlSh6eqjDiVC6+BuFY2Y0tsUg==
X-Received: by 2002:ac2:5934:: with SMTP id v20mr19008674lfi.353.1626714315893;
        Mon, 19 Jul 2021 10:05:15 -0700 (PDT)
Received: from 192.168.1.3 ([2a00:1370:810e:b7ea:7e3d:4f4b:921e:b1ff])
        by smtp.gmail.com with ESMTPSA id z8sm1330749lfh.119.2021.07.19.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 10:05:15 -0700 (PDT)
From:   Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To:     sean@mess.org, mchehab@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com,
        Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Subject: [PATCH v7 0/2] media: rc: add support for Amlogic Meson IR blaster
Date:   Mon, 19 Jul 2021 20:05:04 +0300
Message-Id: <20210719170506.13539-1-viktor.prutyanov@phystech.edu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a driver for the IR transmitter (also called IR blaster)
available in some Amlogic Meson SoCs.

Viktor Prutyanov (2):
  media: rc: meson-ir-tx: document device tree bindings
  media: rc: introduce Meson IR TX driver

 .../bindings/media/amlogic,meson-ir-tx.yaml   |  60 +++
 drivers/media/rc/Kconfig                      |  10 +
 drivers/media/rc/Makefile                     |   1 +
 drivers/media/rc/meson-ir-tx.c                | 406 ++++++++++++++++++
 4 files changed, 477 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml
 create mode 100644 drivers/media/rc/meson-ir-tx.c

-- 
2.21.0

