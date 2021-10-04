Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE6421A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 00:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhJDWrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 18:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhJDWrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 18:47:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74526C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 15:45:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so77443276lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fTrk1dW8VO/fRgbo8lmAbv0WNCdJdQpjahpQhXw3cY=;
        b=Szce5aG+lkjTfx8P23BIkknnmzUBy0ojGErEWMGW0tLncAEngrdCMSfDdDLu4Js5TP
         akObS7LCrpIMi1UbExMI5aq+/Ma4Dznc1+Tf51tdADhbJnqm1u/znDKiM1/oW+LIMVfo
         36z9DtIuy+ilb8fW6l+oIUjeYZUL0+Vr5ZUDQPOOs4DKdDn09V8R5+FJXokKU6gsrwlh
         LzBKMKiTC+5fSlKXkMiKyTb+lyeAL0wY/UV8YkdSJqZZ6BwFAIKcsrxHMYQnHc4uwccd
         eh1MtOKFCzTM2EdViSoh9lf0eVU6WmLAfJL1iJOqWe3MLUCCx4yBtYJlVjferbRagmKu
         peMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fTrk1dW8VO/fRgbo8lmAbv0WNCdJdQpjahpQhXw3cY=;
        b=oKSlEOuUmJPJEHSohtCJodE6PJxWXnPftIfsY1e8YDC/yKb0C56qMyJ66QmG5C+wEo
         G/iaXNawF4AtEy3pUQ3qytV+SkPe/UMjLA7oo0njL4ak2i0nLlEEHlOs3DYE4/cy718t
         lCLOidsA/U16OkglG98zgmacjE20BrOcPDV1Ur7G9AFoyoxSEK1NX/WvfaZbGNwIpBht
         +qViLH8cfBdZOHdvgsw9l++FmXoEXCE7JmUx5wQ+noKyvJWnZGD4QwlK1LVVXLO9bdkD
         Lkl05KuZD51EOibVdEuudzJ1ijYjOuyVIgMuCzmkMH3vRH+pPKfLpoXGq2QEs1FN+91S
         Rbzw==
X-Gm-Message-State: AOAM530c3V0Hg0DQwNA8wiTgaLkC8iOnavrJ7EphZPnso+voeeDpdh6x
        MGNDhc48vLoM1qjIBCoti1M=
X-Google-Smtp-Source: ABdhPJw/eo3ZUEJXOWiwbikfAkOgWmD2T/BAhSqeKEUiKOpHOs3rl+0zJ5FkzWbKzTuFipjeGLkp+w==
X-Received: by 2002:a2e:b162:: with SMTP id a2mr1133204ljm.330.1633387517889;
        Mon, 04 Oct 2021 15:45:17 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id d4sm1747360ljl.98.2021.10.04.15.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 15:45:17 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: amd: acp-rt5645: Constify static snd_soc_ops
Date:   Tue,  5 Oct 2021 00:45:14 +0200
Message-Id: <20211004224514.8783-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct cz_aif1_ops is only assigned to the ops field in the
snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/amd/acp-rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-rt5645.c b/sound/soc/amd/acp-rt5645.c
index d6ba94677ac2..6d5c547a32de 100644
--- a/sound/soc/amd/acp-rt5645.c
+++ b/sound/soc/amd/acp-rt5645.c
@@ -91,7 +91,7 @@ static int cz_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_ops cz_aif1_ops = {
+static const struct snd_soc_ops cz_aif1_ops = {
 	.hw_params = cz_aif1_hw_params,
 };
 
-- 
2.33.0

