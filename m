Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEF6347596
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhCXKNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:13:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35896 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhCXKNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:13:07 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8140A1A27DC;
        Wed, 24 Mar 2021 11:13:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F98E1A1D0A;
        Wed, 24 Mar 2021 11:12:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C03284029B;
        Wed, 24 Mar 2021 11:12:29 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] ASoC: fsl: Don't use devm_regmap_init_mmio_clk
Date:   Wed, 24 Mar 2021 17:58:42 +0800
Message-Id: <1616579928-22428-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is power domain bind with ipg clock,

The call flow:
devm_regmap_init_mmio_clk
    - clk_prepare()
        - clk_pm_runtime_get()

cause the power domain of clock always be enabled after
regmap_init(). which impact the power consumption.

So use devm_regmap_init_mmio instead of
devm_regmap_init_mmio_clk.

Shengjiu Wang (6):
  ASoC: fsl_esai: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_spdif: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_asrc: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_easrc: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_audmix: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_micfil: Don't use devm_regmap_init_mmio_clk

 sound/soc/fsl/fsl_asrc.c   | 57 +++++++++++++++++++++++++++++---------
 sound/soc/fsl/fsl_audmix.c |  3 +-
 sound/soc/fsl/fsl_easrc.c  |  3 +-
 sound/soc/fsl/fsl_esai.c   | 48 ++++++++++++++++++++++++--------
 sound/soc/fsl/fsl_micfil.c | 25 +++++++++++++----
 sound/soc/fsl/fsl_spdif.c  |  3 +-
 6 files changed, 103 insertions(+), 36 deletions(-)

-- 
2.27.0

