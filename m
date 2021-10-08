Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB0426737
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbhJHJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:56:33 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:51074
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238321AbhJHJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:56:31 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 56EFB40008;
        Fri,  8 Oct 2021 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633686871;
        bh=TuVTrdle0GA/hj731likpqii9Ao75WSiuD/GlabjbTI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=g6Fx4ISKggvBOHcX7uB9bC9mN2rP9e5a7wkPU48MaqVKI1Fnfy8mY+o0cYPtpntzL
         vUSL67MOgzuz8Y0ljrv2meRl2KB/BhnsGvb4zCtmD3lONj3WmjPUh0haHOfyteEHkO
         YTiJBXTvaK+DFBV73JxoeXGdD1VGv4lyu4q6rYDRug0LHUmzNreRv1xARdNY9Rh5H0
         jC1V4o7N7AJDrNvFB8suk2YDml4zT+PUhincACr/EN/YdhMFljHzClBjacAVG34+YK
         7IYdkjuYzUUJTdRcKLuksRqq4gOQAS+Ub5kOF5ovbLBzL0801qHLTumG5SnT9ZGGcc
         YAwUTHyEP1B6w==
From:   Colin King <colin.king@canonical.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][next] ASoC: rockchip: i2s-tdm: Fix error handling on i2s_tdm_prepare_enable_mclk failure
Date:   Fri,  8 Oct 2021 10:54:30 +0100
Message-Id: <20211008095430.62680-2-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211008095430.62680-1-colin.king@canonical.com>
References: <20211008095430.62680-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where the call to i2s_tdm_prepare_enable_mclk fails the
function returns before the error handling goto is executed. Fix this
by removing the return do perform the intended error handling exit.

Fixes: 081068fd6414 ("ASoC: rockchip: add support for i2s-tdm controller")
Addresses-Coverity: ("Structurally dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index cc5a2f9d3948..396277eaa417 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -1736,8 +1736,8 @@ static int rockchip_i2s_tdm_probe(struct platform_device *pdev)
 
 	ret = i2s_tdm_prepare_enable_mclk(i2s_tdm);
 	if (ret) {
-		return dev_err_probe(i2s_tdm->dev, ret,
-				     "Failed to enable one or more mclks\n");
+		ret = dev_err_probe(i2s_tdm->dev, ret,
+				    "Failed to enable one or more mclks\n");
 		goto err_disable_hclk;
 	}
 
-- 
2.32.0

