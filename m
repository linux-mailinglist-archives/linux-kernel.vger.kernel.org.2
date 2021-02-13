Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66F31AAD0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBMKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:20:36 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43915
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhBMKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:20:13 -0500
X-IronPort-AV: E=Sophos;i="5.81,175,1610406000"; 
   d="scan'208";a="372960476"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2021 11:19:14 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 0/4] drop unneeded snd_soc_dai_set_drvdata
Date:   Sat, 13 Feb 2021 11:19:03 +0100
Message-Id: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_dai_set_drvdata is not needed when the set data comes from
snd_soc_dai_get_drvdata or dev_get_drvdata.  

---

 sound/soc/fsl/fsl_micfil.c  |    2 --
 sound/soc/fsl/fsl_sai.c     |    2 --
 sound/soc/fsl/fsl_xcvr.c    |    1 -
 sound/soc/mxs/mxs-saif.c    |   10 ----------
 sound/soc/pxa/mmp-sspa.c    |    1 -
 sound/soc/sunxi/sun4i-i2s.c |    2 --
 6 files changed, 18 deletions(-)
