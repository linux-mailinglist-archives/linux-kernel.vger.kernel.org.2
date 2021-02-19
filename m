Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5766631FAE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhBSOdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhBSObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:31:18 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81536C061756;
        Fri, 19 Feb 2021 06:30:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id x4so7833388wmi.3;
        Fri, 19 Feb 2021 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bb3V1Yu7DBHP9VMZZbo/rtykgt0+5Ot8UXIdJbaegQM=;
        b=gGoqaivZy0gxXzNKwlorgmFMhb+5wwhFVhkoCb7H0Br5aFDK4jF79w0j3xYesmTzYQ
         9//p4x9n1PgBZxSyx+6TMXUueBscHGyVQEiYxhfCm4fkSXQjLb+vVV6xX3fgODihMmIX
         eKpP4nX+eJfXgT2t2kNbK94gMd286jQK6T96TomU2Mw0MyCqMWja2xvmhXmt31nw30gU
         SiiQwh3HBLuaxQdvmr7eoSxgfZD9vBYg06WY6F4ZgioUGICBsbPtVhwh0kQOoNEc4VIf
         MfCrunIO43qPhRQFFMKOYerCEjemndy2++FlJmqg80mtOC8wLSqRxHkjYrBEFBj5eB+y
         hCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bb3V1Yu7DBHP9VMZZbo/rtykgt0+5Ot8UXIdJbaegQM=;
        b=RwxUZuPD2lgXlJRvTjzjG4K3kR7IztcbPqHlyNW5aD3ptJhAEAEA8+3VKnC9YMUS48
         UeYiTMhIwKJjCtJuHrqUtkCxQVpsgUImmXc1naiqjwppF6hmdsvYx2EVZaMWqvN6EUo6
         zd54KfnELbRDVgZUf8eTfIRyae+AgaJT0wwtOqyeZnmsBzneyfqDBkrS/b7a0JxL1vUF
         MPwMWpwWpowBOuCV9uyUbKSn/QUIOOyTsDEyAnolLP6ddBiQfR7M1Fp/zLZPpA1X4RqJ
         6TjhPiGeeT00ftye4PiZzEtfh/htsKFkv1Y6PkpC0sDXtOhSilp50ftaXa/GLFM16dAd
         wtmw==
X-Gm-Message-State: AOAM532YslLa5qTLzxoXtmNLDLBDpUmfCBj9upuoyfMJJ9LkFZrrDjVo
        L85ocgB/cKvZKAtYGPFJyDr/gqbbkaCUqg==
X-Google-Smtp-Source: ABdhPJzfzCeeAVhHFhjBdCn4Q1UXrnjbaUmLTr6Isu/2hkk5vhs3TfQI1RstvQN4e4e+u35uJWexpQ==
X-Received: by 2002:a7b:c256:: with SMTP id b22mr8136146wmj.108.1613745036244;
        Fri, 19 Feb 2021 06:30:36 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:35 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 0/9] Add peripheral support for imx8mm-nitrogen-r2 board
Date:   Fri, 19 Feb 2021 15:30:19 +0100
Message-Id: <20210219143028.207975-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch set is to add several peripheral support for the
imx8mm-nitrogen-r2 board.

Thanks,

Update in v2:
  - Fix some typo found in v1;
  - Fix UART description

Update in v3
  - Fix wlan vqmcc regulator;
  - Remove useless clock node;
  - Split UART patch

Thanks,

Adrien Grassein (9):
  arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
  arm64: dts: imx8mm-nitrogen-r2: add USB support
  arm64: dts: imx8mm-nitrogen-r2: add espi2 support
  arm64: dts: imx8mm-nitrogen-r2: add UARTs
  arm64: dts: imx8mm-nitrogen-r2: rework UART 2
  arm64: dts: imx8mm-nitrogen-r2: add PWMs
  arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
  arm64: dts: imx8mm-nitrogen-r2: add audio
  arm64: defconfig: Enable wm8960 audio driver.

 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 306 +++++++++++++++++-
 arch/arm64/configs/defconfig                  |   1 +
 2 files changed, 305 insertions(+), 2 deletions(-)

-- 
2.25.1

