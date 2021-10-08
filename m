Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45CB426736
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhJHJ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:56:32 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:51076
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238329AbhJHJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:56:31 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DC8C940007;
        Fri,  8 Oct 2021 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633686870;
        bh=tqDPxyLPKVPs4yYbJQLMZF/t1CIh6U8zbhA/lGXkiCY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=kgsLUxAqCevBQM563UQkgq9iuUw3Cw40WCLce7KhIz3s2zgWPuTXia2G0HKjchrWM
         42Mjy9/1QZPAzQWzzqs+Qgv/UGEbyDxhD1IaqWZbg+SKsE3WLWQU2CxE1mOxbiqu90
         SRUC3vFiOR8uY+bQAJbKoIyqJOLy5m8bn/hTXBOHYTITfVVqiBt430xWFvQHuDZCGG
         o9pqGu/X4cVHU1XqHNb9WouSEeAXLntit7xd2vIWlIjA8Dgr6E62KPf1757EmdEW8Z
         5dFpVpSPxVpOlvXvoC65mRjAj00MgHQ4cQY53ZiQ+Waf7QxiWIkzQAsa8r+su63cPC
         hoWf58UOE1IOQ==
From:   Colin King <colin.king@canonical.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2][next] ASoC: rockchip: i2s-tdm: Remove call to rockchip_i2s_ch_to_io
Date:   Fri,  8 Oct 2021 10:54:29 +0100
Message-Id: <20211008095430.62680-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to rockchip_i2s_ch_to_io is only useful for its return
value which is not being used. The function call also has no
side effects, the call is effectively useless and can be removed.

Addresses-Coverity: ("Useless call")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index b08b15071993..cc5a2f9d3948 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -848,8 +848,6 @@ static int rockchip_i2s_io_multiplex(struct snd_pcm_substream *substream,
 				to_ch_num(val), usable_chs);
 			return -EINVAL;
 		}
-
-		rockchip_i2s_ch_to_io(val, false);
 	}
 
 	val <<= i2s_tdm->soc_data->grf_shift;
-- 
2.32.0

