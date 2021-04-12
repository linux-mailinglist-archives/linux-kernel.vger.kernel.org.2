Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37D735C776
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhDLNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbhDLNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:23:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:23:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 12so6800825wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RMmYYuU+0a6526L101Df6MPF+9Ne8jsB4VHTPjDRzM=;
        b=leYZC5OwyHfO+RaQtnO/IKGmFzshm9oxi3w2NmGmISXC7k2l1T62GS4Bx/F8ZaLMVZ
         3JNoFy3P1JTddEIe4Strnc4tmO1uDoHo8175fq6gvRdxkUGbirbrl6f31CrrsIxY6+RK
         ijPqP27AxPt2vFD2Dc9ixPtj5vvWliqTUvGXeC+SgZQdkyPMl3JxmETIpwJfzSFcPzRI
         YKFVU2QROjlhjB0z84C2N6svOqF746FuPS4yIATzwziTj5OJx4tOUm2v6yfDtsfbhIGr
         nvbvVaAvtJ8HP0wrPV4WuT8o/SUKNqwAcIywHCL/89AJWC3o2a43FhwGpVVLhNqza5HP
         JyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RMmYYuU+0a6526L101Df6MPF+9Ne8jsB4VHTPjDRzM=;
        b=MEde+mExiaYrtqL5/wlTAYqEd1Csk2wrx1GnyR/imtg0jowd2X9Vsje20dSDPpc46V
         +yA6byNSKAOrO1ZlxMDMFbw5Afa/0W3ejyixRw+SLbC0W5DM4AQC8TTCO4RusrADbtFw
         cOyPeOg+7Neh9exIN6XPx6/6kzg4XBu/FBWG9OTncMuqpE21oiZId+4UM95F1q7B0nNJ
         u8rY2DITWGAe1BeK9i8+ijOSMj3GZ3hUBbsDBUkBqMe79HzZN5eRO65ZSFpGFhnMJQv2
         PpAaQtY1roeUq9OCufEDdTSOa6MzSe1O6nIzfKw9TvDcdB8SjnBHlhJMErFeoXO7UfQZ
         Nl1g==
X-Gm-Message-State: AOAM531X0XD857u84D3qW/uHXNjjsVgMFkeNiZDGjtP/qT20isTM9kAQ
        RRg9pzpPt8+SDIqLB1HXSnln2A==
X-Google-Smtp-Source: ABdhPJzNv3NwebTHH2w3RT/SGRTxA+8oIWytylSgXkx7m6KWVzab7qUkugTYfCASOXGAQqhsy3VDAA==
X-Received: by 2002:a1c:e309:: with SMTP id a9mr8576793wmh.63.1618233787571;
        Mon, 12 Apr 2021 06:23:07 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id a4sm16624761wrx.86.2021.04.12.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 06:23:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] ASoC: meson: axg-frddr: fix fifo depth on g12 and sm1
Date:   Mon, 12 Apr 2021 15:22:56 +0200
Message-Id: <20210412132256.89920-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous fifo depth patch was only tested on axg, not g12 or sm1.
Of course, while adding hw_params dai callback for the axg, I forgot to do
the same for g12 and sm1, leaving the depth unset and breaking playback on
these SoCs.

Add hw_params callback to the g12 dai_ops to fix the problem.

Fixes: 6f68accaa864 ("ASoC: meson: axg-frddr: set fifo depth according to the period")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-frddr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index 8ed114de0bdf..37f4bb3469b5 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -171,6 +171,7 @@ static const struct axg_fifo_match_data axg_frddr_match_data = {
 
 static const struct snd_soc_dai_ops g12a_frddr_ops = {
 	.prepare	= g12a_frddr_dai_prepare,
+	.hw_params	= axg_frddr_dai_hw_params,
 	.startup	= axg_frddr_dai_startup,
 	.shutdown	= axg_frddr_dai_shutdown,
 };
-- 
2.30.2

