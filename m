Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3039D434A53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhJTLox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJTLot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:44:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A52C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:42:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m42so18263818wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7BaCPl7ldB1ZwnXu9KWBTtfoIsEu4irOp5YwoZvuko=;
        b=u55djidDImSvWmabo3H/RI86RvhRx5S+vRIn6uS3PLai+eMcGfgWgqjAc5X1X7nIRx
         BeCJ+ApJyLT0yLEH7PzBuqKUIJu19kA0ZD6PqO6Zvd4No59psrhLoBHOdtzpKAHeIFLn
         FrtrA5DMr8pA9X8PQJGnb128ahr3EaaLqXn2dsO2GJKUsJCMX8XeBPsvouyPkR3K1opV
         cMTmq6bUXfGXPO7QioREClt4BpjSzNRBWM1/bWUq7yzQREUOyT1fInftpWSnfzuRPqGh
         TPqfC3A2M/RxohNxeXWU/WqrkjOTXeYhEycLtOirzlWR1G4xeRInWTa+ILeKHlFcqnf+
         3s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7BaCPl7ldB1ZwnXu9KWBTtfoIsEu4irOp5YwoZvuko=;
        b=aFZqO34Lo5aGqDEjy43utOPBmQUeLycvb9XntoPjelEjIjb7hEpH44OSGPMe5deZJr
         0RvW5ycchsa7PUeVuH9oQ2ZtwkeTeY6McVakDO/p6/Ap8H0oQN4bvZ0MsE/P+R1Yc0QT
         fLvqxBlnEy9otSW579WCpMx5mD0R72WSC42XV/lkZA++56g4g+D40L8v/grLLNTwm5GT
         IeDJhD0ukKSun4suaZlThAhttidNAAKBjSSsyC5UA39VRpD+myVKCwGJXkbZxKy3J6rl
         p5SZ8ptuDIDysHHEIjPbSq8anKemSNmovDqZC/yvJ+CfCR/N06LCeOxVuH9TtKX3C7kf
         NIxA==
X-Gm-Message-State: AOAM531+u7l6wjqp68ZckrI7SCt0wLfbPZMt96h2Z0p0GExYz+0dmuJv
        Mdgk5soGehh6m0fPZV48aEFrww==
X-Google-Smtp-Source: ABdhPJwXjUAog5s0d+VefQsRYQGeWGpLjSU51iVC7OGHVSZaoxF85rQlqGR/4MByRa8qJpq8pwXZzQ==
X-Received: by 2002:adf:c70f:: with SMTP id k15mr51845987wrg.98.1634730153564;
        Wed, 20 Oct 2021 04:42:33 -0700 (PDT)
Received: from jackdaw.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s14sm1732927wro.76.2021.10.20.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 04:42:33 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 1/2] ASoC: meson: axg-card: make links nonatomic
Date:   Wed, 20 Oct 2021 13:42:16 +0200
Message-Id: <20211020114217.133153-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211020114217.133153-1-jbrunet@baylibre.com>
References: <20211020114217.133153-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non atomic operations need to be performed in the trigger callback
of the TDM interfaces. Those are BEs but what matters is the nonatomic
flag of the FE in the DPCM context. Just set nonatomic for everything so,
at least, it is clear.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 2b77010c2c5c..cbbaa55d92a6 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -320,6 +320,7 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 
 	dai_link->cpus = cpu;
 	dai_link->num_cpus = 1;
+	dai_link->nonatomic = true;
 
 	ret = meson_card_parse_dai(card, np, &dai_link->cpus->of_node,
 				   &dai_link->cpus->dai_name);
-- 
2.33.0

