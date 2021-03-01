Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84032930F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbhCAU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:58:27 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47431 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbhCARLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614618675; x=1646154675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=knhW153OooCkMJTOHIu7Y0vxJPYJ6BQCSg+JmTykUSQ=;
  b=lJ1MB21LNNhZkVed/ezgLUgFGErBFexrNnNwx2ZPLKM38Hd9ImhKP/Br
   YAgtwjbpdOk+eoCq0DJidJ/aL1VSiYCs88VEqJXZYkVjwVZ0X8/dB0rSo
   xzZIOpxgAh3KeAoa6lrJuUaYTOE3mPVULaeW1QOCDkoxu7AEyvEQWGuYv
   aqEzZ8BkNViOLv26MhoJVc7vpXArn7L8O21gpOpLkaEO6GrRHpxeo+NsR
   xmIgq92FA/HPaLk5Zh8zpSaMf+uZ0C39k9EykJycX9TtME7ei6GTxgyWa
   i2DAEVA+aKuGDXaP728zeBl30to2biv8/30I9Gd7m2CFBLdNd3Rk7zjL8
   g==;
IronPort-SDR: 6jTzpMK+R9Uhc4uKLcNMv2ll++emto2GNdFi6/xdgoQwaGQ9qTBnOYzp2RBJdre4cVfB+4mg1F
 56BICthPf03UVqGb9q9rvO2eNx4q+jyfvs3Tc8kXd8tjBFARUfWGT6YcrPVKS5jkgpSRzPvw5k
 u7rAW3nh+LYWiQ0adwu5uz8myUzf877wB6Md72mNTspUgxEi19ij1rC0eTcCbDp0EkHC6ta2gM
 Pp6Ui/kkRxN6yPsWS3OQvqhzbbu2Lzkj0AFfEhwb97FeUtjIi5BrdoZQvE/iKkgxchKy/5kFjd
 tXo=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="117058762"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 10:09:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 10:09:34 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 10:09:31 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 0/7] Add I2S-MCC support for Microchip's SAMA7G5
Date:   Mon, 1 Mar 2021 19:08:58 +0200
Message-ID: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
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

Changes in v2:
- moved DT binding conversion patch from the beginning to the end of the
  patch serieses
- patches that update the DT binding are modified to change .txt file
  instead of .yaml

Codrin Ciubotariu (7):
  dt-bindings: mchp,i2s-mcc: Add SAMA7G5 to binding
  ASoC: mchp-i2s-mcc: Add compatible for SAMA7G5
  ASoC: mchp-i2s-mcc: Add multi-channel support for I2S and LEFT_J
    formats
  dt-bindings: mchp,i2s-mcc: Add property to specify pin pair for TDM
  ASoC: mchp-i2s-mcc: Add support to select TDM pins
  ASoC: mchp-i2s-mcc: Add FIFOs support
  ASoC: convert Microchip I2SMCC binding to yaml

 .../bindings/sound/mchp,i2s-mcc.yaml          | 108 ++++++++++++
 .../bindings/sound/mchp-i2s-mcc.txt           |  43 -----
 sound/soc/atmel/Kconfig                       |   3 +
 sound/soc/atmel/mchp-i2s-mcc.c                | 161 +++++++++++++++---
 4 files changed, 252 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt

-- 
2.27.0

