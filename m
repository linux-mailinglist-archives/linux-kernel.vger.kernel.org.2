Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438C53567D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350039AbhDGJUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:20:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34659 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhDGJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:20:44 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lU4MU-0000wv-8T
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 09:20:34 +0000
Received: by mail-wr1-f72.google.com with SMTP id s10so11464334wre.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YID2bsYvH2/CWmY8DSYomS/2/8KT8mSeECFvq86VPEs=;
        b=DDAQH+QmTRTOefRWUNJpOfyCW3MGfDHIMyKZ1hpM4jNEXn5CyvL8LA/Rfadjva+l3h
         RA+HuGM3rurPa7q0OrmuQZ1Icy+yIOeKb0aRHb8FKMLrmISJP6uU7d34C0QSEsnf0+wQ
         kTCIN+3cQnn0lE3+tnWJbxVdXQsYC5sxnHQwXQwh+VqcG+f/z8lxOpiw+5CWEI5o1prZ
         sDRbzbq3JdpGr+12NSH6DQZhA5HZHMSPMbOYkPklNzEPV0qi0CxxPAFzZhI3pnEVjCaC
         Cd/LRGzIlLYz83JqTA2ITfe6AN2xuYbKUTWDgF6k+AOpH/1hjnV+hF2/iyH+CG2gaWhc
         pdIw==
X-Gm-Message-State: AOAM533nPS65lJBHdt9PZE949g607cwuvD1qRLBwcXpIgTG/PiWNuTqB
        tlWfkGBZIBt79nywh/pYU5Y6U41m6TAc3TY1AhKmVBFc6c1fq5bNdU8Aj/eUrKnrcajuph23DzV
        qXCTeM/aBZMXCx0/HVuCjyG2yTO05RE6x2yv7nCRXWQ==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr3132587wrr.425.1617787234052;
        Wed, 07 Apr 2021 02:20:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBVsnkvl7ghjwOsTlQiU5s2WdUnm19wTlhQJBOdCAhWbe2BHKGnff6kbZMJVrB/GxC1NvDlw==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr3132564wrr.425.1617787233874;
        Wed, 07 Apr 2021 02:20:33 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id r11sm39581743wrm.26.2021.04.07.02.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 02:20:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Colin King <colin.king@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] ASoC: simple-card: fix possible uninitialized single_cpu local variable
Date:   Wed,  7 Apr 2021 11:20:27 +0200
Message-Id: <20210407092027.60769-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'single_cpu' local variable is assigned by asoc_simple_parse_dai()
and later used in a asoc_simple_canonicalize_cpu() call, assuming the
entire function did not exit on errors.

However the first function returns 0 if passed device_node is NULL,
thus leaving the variable uninitialized and reporting success.

Addresses-Coverity: Uninitialized scalar variable
Fixes: 8f7f298a3337 ("ASoC: simple-card-utils: separate asoc_simple_card_parse_dai()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 sound/soc/generic/audio-graph-card.c | 2 +-
 sound/soc/generic/simple-card.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index ee1d924d68e5..76036ea377a9 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -367,7 +367,7 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 	struct device_node *top = dev->of_node;
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
-	int ret, single_cpu;
+	int ret, single_cpu = 0;
 
 	dev_dbg(dev, "link_of (%pOF)\n", cpu_ep);
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 41aa40765a8d..9a05f44fc3a9 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -249,7 +249,7 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	struct device_node *plat = NULL;
 	char prop[128];
 	char *prefix = "";
-	int ret, single_cpu;
+	int ret, single_cpu = 0;
 
 	cpu  = np;
 	node = of_get_parent(np);
-- 
2.25.1

