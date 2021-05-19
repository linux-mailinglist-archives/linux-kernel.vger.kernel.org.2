Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672D8388C05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbhESKvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:51:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22960 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242409AbhESKvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621421389; x=1652957389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JFFkX404BkwfG05MFFIzO0jx0zElPnJrPWEORZ4DJVg=;
  b=iGaqMcu0RbNE3eJFio0qRix956TvnpIBxD0VqLAt2bQ17EpeSDfIlM1Y
   0mP208RZQS4KwztIqlJy8/AQoIZxb3nTdE/jlSnuN9vd9QbrOQsrvibDl
   8A/AtcSgwPOZahU09W7bFbQnaGdgVU7JIpS199eyl5pGoJFtrdfuY0P6p
   gmUHgsZXiKYe8F98OMdTG8Y6AiPsDvDpovnGXdd90RckN8WSJMuk4DaXx
   cYkkGYStIFA3HL9sZQiwU3PCGwhhoxpPLZrc2t1vUCt1/bgDKMRcfypz8
   P/G5bR0wZfxOVNU6DhgFwsosfUTuD8udltFTnTgURDrR+Rka2BdCHOlun
   g==;
IronPort-SDR: A/6enPl3sXMuDKOC3o/+zfU14TticU+tncYhfLbTamWSpR5eMnWc3wtu5mZB3VjjhXi/mVxdNL
 1km9NLBeIHuYy0QDtdGk9NTlYd6S+yE3NHWFfSdOwYj6EA2wrkx5e4e5wFRtDXoyMDqdJ9PhN0
 us2V+/I6F6tNJVldJ3Qit8hLeBo/P0KrmHpSBw05mrhNzgwWI+fHzYAi2RO5XUmS1V6MkvAhQ9
 4jfJ9MtVjje/THdvakFvFA6WLfRadchGBJFSHXcU95PVBcRk5MhoRqN5Zuz69yT6lEbA594gfa
 BsQ=
X-IronPort-AV: E=Sophos;i="5.82,312,1613458800"; 
   d="scan'208";a="128651226"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2021 03:49:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 03:49:34 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 03:49:29 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        <joe@perches.com>, <lgirdwood@gmail.com>, <lars@metafoo.de>,
        <kuninori.morimoto.gx@renesas.com>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 0/6] soc-pcm: Add separate snd_pcm_runtime for BEs
Date:   Wed, 19 May 2021 13:48:36 +0300
Message-ID: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a different snd_pcm_runtime in the BE's substream,
replacing the FE's snd_pcm_runtime. With a different structure, the BE
HW capabilities and constraints will no longer merge with the FE ones.
This allows for error detection if the be_hw_params_fixup() applies HW
parameters not supported by the BE DAIs. Also, it calculates values
needed for mem-to-dev/dev-to-mem DMA transfers, such as buffer size and
period size, if needed.

The first 4 patches are preparatory patches, that just group and export
functions used to allocate and initialize the snd_pcm_runtime. Also, the
functions that set and apply the HW constraints are exported.
The 5th patch does (almost) everything need to create the new snd_pcm_runtime
for BEs, which includes allocation, initializing the HW capabilities,
HW constraints and HW parameters. The BE HW parameters are no longer
copied from the FE. They are recalculated, based on HW capabilities,
constraints and the be_hw_params_fixup() callback.
The 6th and last patch basically adds support for the PCM generic
dmaengine to be used as a platform driver for BE DAI links. It allocates
a buffer, needed by the DMA transfers that do not support dev-to-dev
transfers between FE and BE DAIs.

This is a superset of
https://mailman.alsa-project.org/pipermail/alsa-devel/2021-March/182630.html
which only handles the BE HW constraints. This patchset aims to be more
complete, defining a a snd_pcm_runtime between each FE and BE and can
be used between any DAI link connection. I am sure I am not handling all
the needed members of snd_pcm_runtime (such as handling
struct snd_pcm_mmap_status *status), but I would like to have your
feedback regarding this idea.

Codrin Ciubotariu (6):
  ALSA: core: pcm: Create helpers to allocate/free struct
    snd_pcm_runtime
  ALSA: pcm: Export constraints initialization functions
  ALSA: pcm: Check for substream->ops before substream->ops->mmap
  ALSA: pcm: Create function for snd_pcm_runtime initialization
  ASoC: soc-pcm: Create new snd_pcm_runtime for BE DAIs
  ASoC: dmaengine: Allocate buffer if substream is unmanaged

 include/sound/pcm.h                   |   7 ++
 sound/core/pcm.c                      |  82 ++++++++++-------
 sound/core/pcm_native.c               | 116 +++++++++++++-----------
 sound/soc/soc-generic-dmaengine-pcm.c |  18 ++++
 sound/soc/soc-pcm.c                   | 126 ++++++++++++++++++--------
 5 files changed, 229 insertions(+), 120 deletions(-)

-- 
2.27.0

