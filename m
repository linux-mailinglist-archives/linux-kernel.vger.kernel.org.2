Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A50454134
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhKQGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhKQGvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:51:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C2C061570;
        Tue, 16 Nov 2021 22:48:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id np3so1544100pjb.4;
        Tue, 16 Nov 2021 22:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=hyUdzqLjMf42HFA9phwvrLaDcDKECayAihVSEAzzEGw=;
        b=S3k45DaWhM9LeTaa8yoz5lXYOLwd/yzt6nTp5qpPycqeceTe2v7DWC1cTa3oqnhowW
         iPzRf2EGe7YhW0SmncnZMuLc6xCli96L00Y8JsbNfLQXk5mrqJWMQdmrQWx/yF4piThW
         zgUFcbL2IwPwaQ1sMB6NGjvaNt1JFenqzurizX1RRfhgrecvFc8cvaXoV97Ozdi1H2UM
         Lw9Wkfm57/ugguqHngqxa8vhTtGOkl9jh9kldfIOdnfjIg0EsZyYyw/Hxpj99iaEcZkB
         S04eCzgezITM3tP9vPR+Q1iyZOBs4QoDZduzrB+74F0nQ8yoxJFt+3SP6I6hp3bhY+cD
         5lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hyUdzqLjMf42HFA9phwvrLaDcDKECayAihVSEAzzEGw=;
        b=lrlPbjSnKYHbRK49kQ7BuCJeYPU3vBo62IO/aYN6tEbtw5cmCGWCEdkj8aZ5bolEJ0
         I5OxtLXyAyZkxSp3bB1HCsE/xD/iNo+dlMnvpO3CyqWF8ocWT8Yt7THVwlRU/C1woBPn
         YMy7ol4/3PBfhje7r2gYFMZ6pnovsfiF4LyRf6biVb5Mcnakri0Dgx8QRGBYIKKUvxwE
         yL5MyA7aKsQIrnW3FrpApIfUB7F6Oo/tMAzcajeV195aXoX3462vrwI8AwnkS1tIt1qj
         ZERWk8NOFv917pC5mNPuCFeUP52QdQK9UFvIgHQ2R40N4LN00E4oWGYb9hh2Up62uYnA
         avDg==
X-Gm-Message-State: AOAM531xhqreH9JQJHYq0DdEwppOxpvt8WjVp+X/B1Q0Q2aM0NZ5nFEQ
        dLpc4pqOyAstB3mdBD+pcVY=
X-Google-Smtp-Source: ABdhPJyZ90w1ueRZn4DwDrsvkEtvMOJvtZ49a35kavDcgIJTJcGaQyJI6P2AgsXxfqJ0/d9G0Os79g==
X-Received: by 2002:a17:902:6b05:b0:142:83f9:6e29 with SMTP id o5-20020a1709026b0500b0014283f96e29mr54026159plk.32.1637131690777;
        Tue, 16 Nov 2021 22:48:10 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id g1sm20400240pfm.25.2021.11.16.22.48.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Nov 2021 22:48:10 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
X-Google-Original-From: Tony Huang <tony.huang@sunplus.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, Tony Huang <tony.huang@sunplus.com>
Subject: [PATCH 0/2] Add iop driver for Sunplus SP7021
Date:   Wed, 17 Nov 2021 14:48:05 +0800
Message-Id: <1637131687-23000-1-git-send-email-tony.huang@sunplus.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop driver for Sunplus SP7021 SOC

This is a patch series for iop driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: misc: Add iop yaml file for Sunplus SP7021
  misc: Add iop driver for Sunplus SP7021

 .../devicetree/bindings/misc/sunplus-iop.yaml      |   59 +
 MAINTAINERS                                        |    6 +
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/iop/Kconfig                           |   14 +
 drivers/misc/iop/Makefile                          |   13 +
 drivers/misc/iop/hal_iop.c                         |  495 +++
 drivers/misc/iop/hal_iop.h                         |   34 +
 drivers/misc/iop/iop_ioctl.h                       |   24 +
 drivers/misc/iop/iopnormal.c                       | 4106 ++++++++++++++++++++
 drivers/misc/iop/iopstandby.c                      | 1035 +++++
 drivers/misc/iop/reg_iop.h                         |   93 +
 drivers/misc/iop/sunplus_iop.c                     |  611 +++
 drivers/misc/iop/sunplus_iop.h                     |   18 +
 14 files changed, 6510 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/iop/Kconfig
 create mode 100644 drivers/misc/iop/Makefile
 create mode 100644 drivers/misc/iop/hal_iop.c
 create mode 100644 drivers/misc/iop/hal_iop.h
 create mode 100644 drivers/misc/iop/iop_ioctl.h
 create mode 100644 drivers/misc/iop/iopnormal.c
 create mode 100644 drivers/misc/iop/iopstandby.c
 create mode 100644 drivers/misc/iop/reg_iop.h
 create mode 100644 drivers/misc/iop/sunplus_iop.c
 create mode 100644 drivers/misc/iop/sunplus_iop.h

-- 
2.7.4

