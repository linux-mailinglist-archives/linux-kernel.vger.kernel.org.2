Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0C39B3DB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFDH1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhFDH1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:27:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E10C661417;
        Fri,  4 Jun 2021 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622791564;
        bh=QL9r/k6OqX+R2Iy5czp6c6lWgpPMD31+LjAlGMhaXLE=;
        h=Date:From:To:Cc:Subject:From;
        b=coTXexxRGVD7ADaKTg82CksMLypwNkAWbSes/PqCs4C8nkDL8JWt1j6vDg9KulOlu
         ICBX+hWn4XCrDlksJM8IeNofWvYbWvDrmErCB1UhlRo1vU12jtYKjywtnAooTNdcI7
         e+N9Ba6esswRpayjU/gRcBgAcSQjNdDokp8l4V+3wSc30tQlLJNdR5hOJPLPKUw7CR
         i2e928PImS5GG6ccpBJcKxTCRbzmXi4GGDMY/l8cioogy5LzmEMYLS0i+k8ZhCH97W
         IFMhVf5jTt9lYhQew3h0y8cIRmPH6T515BFThbSHCEvgGuGyo0QzSQdT30ZTZhi96D
         G1ll5hreQcMyw==
Date:   Fri, 4 Jun 2021 02:27:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] ASoC: ti: davinci-mcasp: Fix fall-through warning
 for Clang
Message-ID: <20210604072714.GA244640@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a fallthrough; statement.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use fallthrough; instead of break;
 - Update changelog text.
 Link: https://lore.kernel.org/linux-hardening/25941c37-6e38-88ae-3afe-4f5af44380d3@gmail.com/

 sound/soc/ti/davinci-mcasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index b94220306d1a..017a5a5e56cd 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2317,6 +2317,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
+		fallthrough;
 	case -EPROBE_DEFER:
 		goto err;
 	}
-- 
2.27.0

