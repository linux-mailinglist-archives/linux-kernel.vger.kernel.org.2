Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD84125AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384207AbhITSrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:47:00 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39008
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353270AbhITSnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:43:21 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CE4204018A;
        Mon, 20 Sep 2021 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632163312;
        bh=RJZDrQJzd/PSuwhwBqk2LEL2gE5VbirT5KM+/uoAMZM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=GJt9l1cX84J2OP93j5YuUFiPQVNMKb3ZV1UjuSiApMhiEzNho20YzONtFWFl47Kvj
         KZq6nr7iBQBlyhVu+gpYlXjG20kCNSqxBMxZBdZMi51yhrVV+h/aYL4eAqWjnqlCuD
         WCCTOaFWc4k3zLACjF1atwK1eyKnvR3CfMer690J8IKq6+j4eOXoaqXDOvWRRCgQOy
         x9YAjM1Xj5ihTYbYjSgcyEZ0K53T48Vgk5iF7lYXs0MGoaml9M6w40eq4rPALAMerh
         wwwrD/jCqWjCLOWq8z0mOL3EhLsHzq1MHgG0gstz9yJBLrIsrjanG4bBkJ+RC2yQ3Y
         Qkc/+igRL9p8A==
From:   Colin King <colin.king@canonical.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: Fix spelling mistake "Fronend" -> "Frontend"
Date:   Mon, 20 Sep 2021 19:41:52 +0100
Message-Id: <20210920184152.18109-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the module description. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index ac8f7324e94b..8b664cbf6fa6 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1747,5 +1747,5 @@ static struct platform_driver q6afe_dai_platform_driver = {
 };
 module_platform_driver(q6afe_dai_platform_driver);
 
-MODULE_DESCRIPTION("Q6 Audio Fronend dai driver");
+MODULE_DESCRIPTION("Q6 Audio Frontend dai driver");
 MODULE_LICENSE("GPL v2");
-- 
2.32.0

