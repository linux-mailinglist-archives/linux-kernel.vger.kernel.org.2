Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BC4571A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhKSPhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhKSPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:37:03 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:34:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 239861F47554
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637336040; bh=oBj7QbVGHlYfnfMUOtd1HZT668Gjf5aMJe4be82ORbo=;
        h=From:To:Cc:Subject:Date:From;
        b=LU1D/2znRnmWQq9S9C99bWFA/kPVCKSRmdq6IEpjNr/rKOJ4bFAO3EQ2mLbFD0TP/
         PlOdn37gYW6Uquu+IGHXIg04zDysKrMQgoR8P+UJ8FGWNAxgKbd00zRG2r7hqQZtsa
         0TtEArzfJ6/8/a0yJ5y1xg8qI0QcAcyK8h1+A+FYGLxkLFT/Tt/ayZIlJOLDEjEC2v
         5v/EY0JnOPiVMeR5EavyjjUDwy8Sw3Q9IV2zfUDPaYUJtQJvzuV0b29l0ZlpDKaimj
         lAUIfOpTh2FmOrTcVSToFOwkzS3NbFST9BvuKJdoirPFTV0ExeGt2bt7Ps+ZIYZlRh
         jJR0rwu89STRQ==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bkylerussell@gmail.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com
Subject: [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
Date:   Fri, 19 Nov 2021 12:32:43 -0300
Message-Id: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tlv320aic31xx codec allows using BCLK as the input clock for PLL,
deriving all the frequencies through a set of divisors.

In this case, codec sysclk is determined by the hwparams sample
rate/format. So its frequency must be updated from the codec itself when
these are changed.

This patchset modifies the tlv320aic31xx driver to update its sysclk if
BCLK is used as the input clock. This allows to be used by the generic
fsl-asoc-card, without having to add a specific driver.

Ariel D'Alessandro (5):
  ASoC: tlv320aic31xx: Fix typo in BCLK clock name
  ASoC: tlv320aic31xx: Add support for pll_r coefficient
  ASoC: tlv320aic31xx: Add divs for bclk as clk_in
  ASoC: tlv320aic31xx: Handle BCLK set as PLL input configuration
  ASoC: fsl-asoc-card: Support fsl,imx-audio-tlv320aic31xx codec

 sound/soc/codecs/tlv320aic31xx.c | 105 ++++++++++++++++++++-----------
 sound/soc/codecs/tlv320aic31xx.h |   2 +-
 sound/soc/fsl/fsl-asoc-card.c    |  12 ++++
 3 files changed, 83 insertions(+), 36 deletions(-)

-- 
2.30.2

