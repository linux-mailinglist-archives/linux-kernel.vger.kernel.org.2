Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C553E29F0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245661AbhHFLnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:43:39 -0400
Received: from ip-15.mailobj.net ([213.182.54.15]:52996 "EHLO msg-4.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240091AbhHFLni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1628250147; bh=chhPzgGlHlmsI2aXic5J0cn66W0OA9yfV1Ne08AgXr4=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=LftT4vEUS3JYLqt4eQZJRY2sGHsCJDr3rARelYCOU+2+1h5GOgfw0K+Z4a8IVAEmo
         CVsYTA4cVUkgQc64ZKc4gecrJp+oIjnnM2vw84JUujR6XQGxLgMDCOlMT3CoJY5MrW
         BWtOUhbMm3RUIL/1OzsyyEAAH2fpC+TUc77FAkog=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri,  6 Aug 2021 13:42:27 +0200 (CEST)
X-EA-Auth: 8DhMzZZrEP2yfjEUnkrIZeRAg9eb4SA3Djlt8yEJXqLYwqs+EH5Dgaq3W/ifqIT2E9wwbfOiH+3BpMkUTz/OcJ20/nE7+CBOgyrNnk5SALA=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org, stephan@gerhold.net,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2] ASoC: qcom: apq8016_sbc: Add SEC_MI2S support
Date:   Fri,  6 Aug 2021 13:41:16 +0200
Message-Id: <20210806114116.895473-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds external codec support on secondary mi2s.
It is used for headphones on some devices, eg. alcatel-idol347.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
v1->v2: thanks Srinivas for the review, and Stephan for guidance
- Add _SEC suffix to defines to highlight usage for secondary mi2s
- Clear TLMM_WS_OUT_SEL and TLMM_WS_EN_SEL fields before setting value
---
 sound/soc/qcom/apq8016_sbc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 08a05f0ecad7..ba2a98268ee4 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -30,6 +30,13 @@ struct apq8016_sbc_data {
 #define MIC_CTRL_QUA_WS_SLAVE_SEL_10	BIT(17)
 #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
 #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
+#define SPKR_CTL_TLMM_MCLK_EN		BIT(1)
+#define SPKR_CTL_TLMM_SCLK_EN		BIT(2)
+#define SPKR_CTL_TLMM_DATA1_EN		BIT(3)
+#define SPKR_CTL_TLMM_WS_OUT_SEL_MASK	GENMASK(7, 6)
+#define SPKR_CTL_TLMM_WS_OUT_SEL_SEC	BIT(6)
+#define SPKR_CTL_TLMM_WS_EN_SEL_MASK	GENMASK(19, 18)
+#define SPKR_CTL_TLMM_WS_EN_SEL_SEC	BIT(18)
 #define DEFAULT_MCLK_RATE		9600000
 
 static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
@@ -40,6 +47,7 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_card *card = rtd->card;
 	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
 	int i, rval;
+	u32 value;
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
@@ -53,6 +61,15 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 			MIC_CTRL_TLMM_SCLK_EN,
 			pdata->mic_iomux);
 		break;
+	case MI2S_SECONDARY:
+		/* Clear TLMM_WS_OUT_SEL and TLMM_WS_EN_SEL fields */
+		value = readl(pdata->spkr_iomux) &
+			~(SPKR_CTL_TLMM_WS_OUT_SEL_MASK | SPKR_CTL_TLMM_WS_EN_SEL_MASK);
+		/* Configure the Sec MI2S to TLMM */
+		writel(value | SPKR_CTL_TLMM_MCLK_EN | SPKR_CTL_TLMM_SCLK_EN |
+			SPKR_CTL_TLMM_DATA1_EN | SPKR_CTL_TLMM_WS_OUT_SEL_SEC |
+			SPKR_CTL_TLMM_WS_EN_SEL_SEC, pdata->spkr_iomux);
+		break;
 	case MI2S_TERTIARY:
 		writel(readl(pdata->mic_iomux) | MIC_CTRL_TER_WS_SLAVE_SEL |
 			MIC_CTRL_TLMM_SCLK_EN,
-- 
2.31.1



