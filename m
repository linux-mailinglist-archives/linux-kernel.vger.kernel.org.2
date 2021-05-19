Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908CC388C02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242176AbhESKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:51:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61318 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhESKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621421384; x=1652957384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Lr/c0wIdQO/BYlrKPGWYp2sU3Q/5O4y2V8HUWSl33I=;
  b=fJG/+nxpXJ5T4xYvnWrJZVrCNvOvCDxE2KW2ndT66uj9yYYbVoX1v8qk
   xMK8mS7IFxuzLjZq91yEmsvqk8vJUev0O7yASOEIs+WJOEfKOHD6JUKAn
   oFnJUfbrgFhtxEwvdQZJCJ2y+IHkwELDMGprSJa+FL2x+yimtzPmYKBpB
   rEiH6QbppOtXX3Hyv9ZqFbRo6LM/IsfIf9q5GGawya6a1s8HTI0pia79A
   IsRojimTbFNtgl1sJAkWN3yokZPoRWcGwY5UgnnTRmBhgiFaPWCnnqpgC
   AFnNQvG43sX1gmqulN9XquCgipMyolCsgZiUY2CR8f1gVB6mgulilZQbT
   A==;
IronPort-SDR: iv4wS1HmxYxkllRHbBAYvgT3VL5/XGK7LASNbdn1EbxlTHp9eco62uz1G74lx2nPQnAUkq9aDh
 dICoGEhrTGNN/J1HqQ7AUij1+/sG0OoVzYHiX5PZpEJy4lVxVXGYaIlKf1TMzil5wrVLGoSI63
 Fw4gvrJOAUqUy2NKL5MPA2WsD7nzBQvDt6PHh2wXyTMeWqQEXJeLKi0ZDd/VyCFuEtq4YxXCGF
 NAsP8QCCjCtJMt1/LP4iHpzyHJ7tcjZs6hkY3EaknBAPViRB0cID1XrCDJMKMrQA1fpQI4+d/2
 TY0=
X-IronPort-AV: E=Sophos;i="5.82,312,1613458800"; 
   d="scan'208";a="118456744"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2021 03:49:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 03:49:43 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 03:49:39 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        <joe@perches.com>, <lgirdwood@gmail.com>, <lars@metafoo.de>,
        <kuninori.morimoto.gx@renesas.com>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 2/6] ALSA: pcm: Export constraints initialization functions
Date:   Wed, 19 May 2021 13:48:38 +0300
Message-ID: <20210519104842.977895-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
References: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the functions needed to initialize the constraints. These functions
will be used in soc-pcm to initialize the BE constraints.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 include/sound/pcm.h     | 3 +++
 sound/core/pcm_native.c | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 025b4d2ba0fe..2907ed2b937f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1021,6 +1021,9 @@ int snd_pcm_hw_rule_add(struct snd_pcm_runtime *runtime,
 			snd_pcm_hw_rule_func_t func, void *private,
 			int dep, ...);
 
+int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream);
+int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream);
+
 /**
  * snd_pcm_hw_constraint_single() - Constrain parameter to a single value
  * @runtime: PCM runtime instance
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 8dbe86cf2e4f..54e0eab2a57e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2400,7 +2400,7 @@ static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }		
 
-static int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
+int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hw_constraints *constrs = &runtime->hw_constraints;
@@ -2523,8 +2523,9 @@ static int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 		return err;
 	return 0;
 }
+EXPORT_SYMBOL(snd_pcm_hw_constraints_init);
 
-static int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
+int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
@@ -2607,6 +2608,7 @@ static int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 
 	return 0;
 }
+EXPORT_SYMBOL(snd_pcm_hw_constraints_complete);
 
 static void pcm_release_private(struct snd_pcm_substream *substream)
 {
-- 
2.27.0

