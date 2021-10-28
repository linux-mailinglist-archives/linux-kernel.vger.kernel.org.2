Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF38443E2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhJ1NyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:54:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23442 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhJ1NyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635429106; x=1666965106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1e48bc5JZElgRkHfAHfYhy1cAbSo9IXyAdueDz1uETk=;
  b=CbPgROhmOk7gT8G8Lxh23Lo2U5qHQw6CJMHMiaVNLaEz+6TpRCputgtG
   UIsjs7pSFSDXrTFMUFZdQ4Iozrrx2U1XEqGXPeAL/1cxjsWN0CbVkWhk5
   Ka6PZNNhavRPaRLU0z3CVeDm3k2ktHgvTfnOsDt91u72+j52WiH01zCTd
   zc+r1qjJd3hM08vmlIEvVsc3gNQJpxjeGeH8EXOctczRNVKYbGpr7GUMu
   i3NiLTVaOfyR5inQA/vnBP5J5ueHZB4OSb4j0ILppUCFw2OLiB0J5tXJ9
   SVFigmcbbYYV8HwfZcSMWAL5ljsIYUX7tyogWobBvtqWVlgG40fmGy/Sa
   g==;
IronPort-SDR: 4CfmDq1/okhjQvCLRFCBDidvOIcGAhxYOvC6Fy0MC3KYJSw+e6M6Sf0pq98EyBIf6tdvB7Lr0U
 NZxD2l2JNFSXh0JpKDbZmb/88mP+FOkjn8yLVewKM3G5Vjz50EadkutES4SyhVfuAEWD+nLyUF
 1hVWjAk255jlv0m8310ybHVCwRnyItII4+/q7CyST9m6Az5ws+hDi+FSL+o0Gs0Tg3fckZUN0/
 6qqhIfh1kVRTdFzkEPNnTB3TQQHxANE/RgYleO05gj3eC/KJqCOp6U1n68jub7JpP4lDe4+Jf0
 D8wPKuJtTKS8R9Z5w83Tri4z
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="134658800"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2021 06:51:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 28 Oct 2021 06:51:44 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 28 Oct 2021 06:51:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lee.jones@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <romain.izard.pro@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/2] mfd: atmel-flexcom: add a fix and code cosmetics
Date:   Thu, 28 Oct 2021 16:51:36 +0300
Message-ID: <20211028135138.3481166-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in this series:
1/2 - use __maybe_unused around PM code
2/2 - fixes the PM

Changes in v2:
- collected tags

Claudiu Beznea (2):
  mfd: atmel-flexcom: remove #ifdef CONFIG_PM_SLEEP
  mfd: atmel-flexcom: use resume_noirq

 drivers/mfd/atmel-flexcom.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.33.0

