Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAA5323085
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhBWSVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:21:15 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:18302 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhBWSVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614104473; x=1645640473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GBe+nfolHP1HoMBuIE6VpxRNBdrPXQDsJGxdyHkZzMw=;
  b=WQTeZAZpqgGQSjU+1yl442eHVcP5o51hyrDkmr2CMwdKgCwqjmv+vg60
   hwoHWthqxiMwt7WukOP0CFZtc7mBz+dJwMmWcgz4jVjgfT5dhp/XpXRZC
   qwy55JuUhbfJWZe/515GO93ygLbVJnCZra5zYXvtwf3VhWKuceo96Z5Az
   TzmJTSXpKKkBg1mF9g5HUSgqrZkPAJp+GS6N2kybv8ZbltLjLWKsWXQUo
   Ac567NEFBJHHA9dyFp7e4gQqLHUrI3LuLaCtdWOB0/JiP10i7xYBCVG0N
   d0cUo5cpcyfFAZCTOjoXmFsuq/bd+BzEwn1VrBjK7quuIzyaEfMYUrH6B
   Q==;
IronPort-SDR: z2NKsbUfd3lPqoh1x9m8eFTR6xWDkNnvlGU/ZFnczGZkTKiuP5nY5QRT9qGyULh2h7oyVdnt9E
 5P8WdXAJA6oQ8A5/uD7iRWNb+oFgQqZPEMmc63PEiMmnDoUX83q0Jn3dA6DLEnUKA+OTpFnSik
 WScvrEN0ck2+1L9zZzCGkdatyeqQG2R61KrAE05cei7rhmAJ4lJ9GTAnd43K6OYSbgJidf/Xke
 lOOACTpURXHWG5P/HrUui5LiFl6IfPLXUIDGL/dj+urIez6i7hTgP5uUsmp4cfA1JEEV6/G/d8
 PpQ=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; 
   d="scan'208";a="110827418"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2021 11:19:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:19:57 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:19:54 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 0/7] Add I2S-MCC support for Microchip's SAMA7G5
Date:   Tue, 23 Feb 2021 20:19:22 +0200
Message-ID: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5 includes an updated version of I2S-MCC, found previously on
SAM9X60. This controller includes 8 data pins, 4 for playback and 4 for
capture. For I2S and LEFT_J formats, these pins can be used to
send/receive up to 8 audio channels. For DSP_A, with TDM, any pins pair
(DIN/DOUT) from these 4 can be selected to send/receive data. This
version also includes 2 FIFOs (send and receive).
This patch set starts by moving the driver's bindings to yaml and
continues with adding a new compatible for the SAMA7G5 variant, followed
by the changes needed for I2S/LEFT_J support, TDM pin pair selection and
FIFO support, exclusively for SAMA7G5.

Codrin Ciubotariu (7):
  ASoC: convert Microchip I2SMCC binding to yaml
  dt-bindings: mchp,i2s-mcc: Add SAMA7G5 to binding
  ASoC: mchp-i2s-mcc: Add compatible for SAMA7G5
  ASoC: mchp-i2s-mcc: Add multi-channel support for I2S and LEFT_J
    formats
  dt-bindings: mchp,i2s-mcc: Add property to specify pin pair for TDM
  ASoC: mchp-i2s-mcc: Add support to select TDM pins
  ASoC: mchp-i2s-mcc: Add FIFOs support

 .../bindings/sound/mchp,i2s-mcc.yaml          | 108 ++++++++++++
 .../bindings/sound/mchp-i2s-mcc.txt           |  43 -----
 sound/soc/atmel/Kconfig                       |   3 +
 sound/soc/atmel/mchp-i2s-mcc.c                | 161 +++++++++++++++---
 4 files changed, 252 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt

-- 
2.27.0

