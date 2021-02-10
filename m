Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB95F315FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhBJGol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:44:41 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13674 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbhBJGog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:44:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602380aa0000>; Tue, 09 Feb 2021 22:43:54 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 06:43:54 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Feb 2021 06:43:50 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/3] Use clocks property in a device node
Date:   Wed, 10 Feb 2021 12:13:38 +0530
Message-ID: <1612939421-19900-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612939434; bh=c19W9Oh8pMdfVc6xnFBZ4UqL8XI7169ntNra7yJITRQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=KQA0fRsQR5FGeoZRbP0CMD9srE2MTT59P5vHyOH12W9OWxY46SqyhYO+703E49cFH
         PQZ+7Avc4joDpvTBGwsaln5yBuQXWXD3OxmUDSo3+k62AjU16b+lRN+WYnsW8tJ9Xq
         ThCMcCg3ppLDIhACt5bOs9/KaFH2baOljFM+YVoEe7iEHVPa/9wmz3ajddt5sDCPDw
         Wxk0zlmJUe+AB/TfEMxmVrptATN5c8VB69UNdFLKADFYjsW/qowLBWN0Hy7mFHt+St
         9usn+irw4KuJGrLARBTtd9gI2YI929YOLjUIBt0o3FYTB+8A9uyVa7NCVi7EZ4nBKM
         /UJLLLHpxQI3w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is recommended to not specifiy clocks property in an endpoint subnode.
This series moves clocks to device node.

However after moving the clocks to device node, the audio playback or
capture fails. The specified clock is not actually getting enabled and
hence the failure is seen. There seems to be a bug in simple-card-utils.c
where clock handle is not assigned when parsing clocks from device node.

Fix the same and revert original change which actually added clocks
property in endpoint subnode. Also update Jetson AGX Xavier DT where the
usage is found.


Sameer Pujar (3):
  ASoC: simple-card-utils: Fix device module clock
  Revert "ASoC: audio-graph-card: Add clocks property to endpoint node"
  arm64: tegra: Move clocks from RT5658 endpoint to device node

 .../devicetree/bindings/sound/audio-graph-port.yaml         |  3 ---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts          |  2 +-
 sound/soc/generic/simple-card-utils.c                       | 13 ++++++-------
 3 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.7.4

