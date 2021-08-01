Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE93DCAA4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhHAHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 03:53:08 -0400
Received: from msg-1.mailo.com ([213.182.54.11]:41628 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhHAHxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 03:53:06 -0400
X-Greylist: delayed 1323 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Aug 2021 03:53:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1627803011; bh=4G10nVQJkrQltnOTrznYvxzJZvczMCBK7/8KU1oeR88=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=eBUwieR1Jcmb5GNy2OCAfoRL07rmcEzJrloVfNwd8Su77lb82ETEQucE5RnzTB/RO
         xfWu7A2kYnBkPnUey4Wyw6p5A0BR/trF0X9hCEG10evkCJCeO9swPawWdHctTWwbqI
         QQ8S+PRfLmSnLCmxz2sN7kkdyAljdDeMoghPDWNo=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun,  1 Aug 2021 09:30:11 +0200 (CEST)
X-EA-Auth: ZR/HJzMxTWSmhw2LBY8jJO+wEhwbhSwSmMdyX7IU/oyZLhWZY6TfL/dPrWEE0YA7ybC/EhpxzXNGH1WMdyWhfMlCG/30t8t9bMiEKc0TZ5A=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org, stephan@gerhold.net,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH] ASoC: qcom: apq8016_sbc: Add SEC_MI2S support
Date:   Sun,  1 Aug 2021 09:29:51 +0200
Message-Id: <20210801072951.1403241-1-vincent.knecht@mailoo.org>
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
 sound/soc/qcom/apq8016_sbc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 08a05f0ecad7..53460272eb1e 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -30,6 +30,11 @@ struct apq8016_sbc_data {
 #define MIC_CTRL_QUA_WS_SLAVE_SEL_10	BIT(17)
 #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
 #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
+#define SPKR_CTL_TLMM_MCLK_EN		BIT(1)
+#define SPKR_CTL_TLMM_SCLK_EN		BIT(2)
+#define SPKR_CTL_TLMM_DATA1_EN		BIT(3)
+#define SPKR_CTL_TLMM_WS_OUT_SEL	BIT(6)
+#define SPKR_CTL_TLMM_WS_EN_SEL		BIT(18)
 #define DEFAULT_MCLK_RATE		9600000
 
 static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
@@ -53,6 +58,13 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 			MIC_CTRL_TLMM_SCLK_EN,
 			pdata->mic_iomux);
 		break;
+	case MI2S_SECONDARY:
+		/* Configure the Sec MI2S to TLMM */
+		writel(readl(pdata->spkr_iomux) | SPKR_CTL_TLMM_MCLK_EN |
+			SPKR_CTL_TLMM_SCLK_EN | SPKR_CTL_TLMM_DATA1_EN |
+			SPKR_CTL_TLMM_WS_OUT_SEL | SPKR_CTL_TLMM_WS_EN_SEL,
+			pdata->spkr_iomux);
+		break;
 	case MI2S_TERTIARY:
 		writel(readl(pdata->mic_iomux) | MIC_CTRL_TER_WS_SLAVE_SEL |
 			MIC_CTRL_TLMM_SCLK_EN,
-- 
2.31.1



