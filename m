Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A9142AE93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhJLVRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhJLVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:17:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70DFC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 14:15:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c16so2486103lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRMO0z5rTRyoYHGRA8sAjbt4Yk595vyUUqlmV7aHWE4=;
        b=Wa8LeIAT7oIwgjxcaVjMzphzxb+0WJ0kl6XTeqWwLUKqAGwu7E5ZW9OujQ62ge7qyF
         2t6tm75GjISjkKdkhapoD9HutSZ/rMZVrEjTOXjEEsaJjmGt+9035YPLD+Prx309pzoD
         cCc3b9M6XylQ9P9SAeD0bbrA9AA0cWK7byz/DtWr2k40CN1CHDem/yRGWjMZQ5rxByuW
         3lHzsXUM66BFBhoEiL2Kn0lPO1P46M1ooIvzbDg/ayNtPQCWLnM5sG71yhSjevJedAlK
         +esH2VsCqrMcfJWqx7+WMq+2VjNhCyWHGlTsL513eJeXZj51jF4fnmIxEbMZle14/C96
         VbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRMO0z5rTRyoYHGRA8sAjbt4Yk595vyUUqlmV7aHWE4=;
        b=0h24VNihjlCNQ3ZIpHzIlDHHJhBojfExxLvkJ9YsAWion5po7WMx2gUG6BzdUxvY46
         oOiZuAW9shwCD3LUqlV6KapBX8cJr+V21qG+DWPnZ+5wd/Xe/TO/kE+ZaKk0JujplfNP
         r+Bq2tloj+cFye+VIu7gWxtByOnhIK/IKuY1FY2FbP7ycajlPurT5a21drey4lvkVAFa
         iT3C0tvMht+tC+u96q2L52hRFzQbRmxvs8yRxuswb7kKiXdlgq7J2ju0WqELBM4EBEYQ
         n7iLLwGfigq8tzjBVaXS9GGytXAzDIyg0mCpVtABp4QVGB+IckYKz+DXSl+BER/LtKfM
         k16Q==
X-Gm-Message-State: AOAM5304aKQpYycm5e1PHfTHWdFgJ2gZGamlMoQjnGeiYhuc539y/V75
        RqNEcZn99ivgC6tAaS0KHT0=
X-Google-Smtp-Source: ABdhPJzex1DnN+8pV4Yeexc04aFMuXAGDTxNuEP6mVTEyiUgsO4+RF0VzccF5dtADuruU2tVwwjPhA==
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr23476462lji.447.1634073310313;
        Tue, 12 Oct 2021 14:15:10 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-5.NA.cust.bahnhof.se. [158.174.22.5])
        by smtp.gmail.com with ESMTPSA id l23sm1362132ljg.99.2021.10.12.14.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 14:15:09 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: amd: vangogh: constify static struct snd_soc_dai_ops
Date:   Tue, 12 Oct 2021 23:15:06 +0200
Message-Id: <20211012211506.21159-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of acp5x_i2s_dai_ops is to assign its address to the ops
field in the snd_soc_dai_driver struct, which is a pointer to const.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/amd/vangogh/acp5x-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x-i2s.c b/sound/soc/amd/vangogh/acp5x-i2s.c
index 2705e57eb713..002db3971ca9 100644
--- a/sound/soc/amd/vangogh/acp5x-i2s.c
+++ b/sound/soc/amd/vangogh/acp5x-i2s.c
@@ -348,7 +348,7 @@ static int acp5x_i2s_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_dai_ops acp5x_i2s_dai_ops = {
+static const struct snd_soc_dai_ops acp5x_i2s_dai_ops = {
 	.hw_params = acp5x_i2s_hwparams,
 	.trigger = acp5x_i2s_trigger,
 	.set_fmt = acp5x_i2s_set_fmt,
-- 
2.33.0

