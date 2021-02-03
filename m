Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3298330DF54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhBCQL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:11:29 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4638 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhBCQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:10:46 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601acad60000>; Wed, 03 Feb 2021 08:09:58 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Feb
 2021 16:09:58 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 3 Feb 2021 16:09:55 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/2] ASoC: audio-graph: Export graph_remove() function
Date:   Wed, 3 Feb 2021 21:39:34 +0530
Message-ID: <1612368575-25991-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612368575-25991-1-git-send-email-spujar@nvidia.com>
References: <1612368575-25991-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612368598; bh=SdJlxnAHDjMLxiQMLKNnQgJIuXfMEd/CIAOFoyE3phQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=Z2qdRg10P5gHc1yhUu3P9R6yT9NCdU1w9y8wAIt+ZVmTyiDEChdmkwoj5shJKurDE
         JzWB8ECZG2YR+9GbHxdj+I9c8AZws4CehRdkNyFMd31BJxaTxnBTCVKlypzRMUQOyY
         eD/ABHJoq8Dw5G4smYfufNJAOD1EyPRmj8Hg6pvh+R5GCDP4upQ6/Gr0Plz5RUshMp
         J44x0B2qti83BPgZzU5GDFgq0gWCIZfVNE1cx1x0Zh7YCu3UciVTxrkR1L2fAHDTPo
         4sS20fWxbJf+SrvEq2oerhShI3byPpIXk2HDCRLUbJBTFOOwEH49D+FsuorKKWuGKz
         UN0zTR+x3BM9g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio graph based sound card drivers can call graph_remove() function
for cleanups during driver removal. To facilitate this export above
mentioned function.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/sound/graph_card.h           | 2 ++
 sound/soc/generic/audio-graph-card.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/sound/graph_card.h b/include/sound/graph_card.h
index bbb5a13..dfa8e56 100644
--- a/include/sound/graph_card.h
+++ b/include/sound/graph_card.h
@@ -13,4 +13,6 @@ int graph_card_probe(struct snd_soc_card *card);
 
 int graph_parse_of(struct asoc_simple_priv *priv, struct device *dev);
 
+int graph_remove(struct platform_device *pdev);
+
 #endif /* __GRAPH_CARD_H */
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 16a04a6..93f6d57f 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -744,12 +744,13 @@ static int graph_probe(struct platform_device *pdev)
 	return graph_parse_of(priv, dev);
 }
 
-static int graph_remove(struct platform_device *pdev)
+int graph_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
 	return asoc_simple_clean_reference(card);
 }
+EXPORT_SYMBOL_GPL(graph_remove);
 
 static const struct of_device_id graph_of_match[] = {
 	{ .compatible = "audio-graph-card", },
-- 
2.7.4

