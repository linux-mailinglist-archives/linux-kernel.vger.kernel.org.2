Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE73D363936
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbhDSB6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:58:48 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:38297 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232013AbhDSB6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:58:46 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 842062071;
        Sun, 18 Apr 2021 21:58:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 18 Apr 2021 21:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=phlNdH6L/nbEsbR+68MJn/qwBE
        EXdmTeMPuDyjBiqu8=; b=n/MLmgQanqv1QIChbd7SxXqvyaHToTdItZv6KzTiWZ
        tfpwWHeRiA00EJgdr+wlEKLwBDPbBEtlj3Akw/8/SGb6tELr63g5UUVYxv22pMEP
        9+9dcjNWUoldBauZNzKD78kLvxSlY4VEn5/DugArn4iW4H2qojyKttISZDlRDZLW
        cRA2YRXqZbstKgc5awM/OpSMRC6Eo2kT+YzvHvTfcaHKSH+vRkIjFBibYggU/5Gu
        SlaXZi+7gBGZnIHSfrDMIxrxYwuSFL9MLUN8/rk81AfthUxGHz8oeaCxJWqr+aY2
        fwxTbJhlpuZYxpQbAOfEV2QSEf3jiNtT5nOgM39CF/Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=phlNdH6L/nbEsbR+6
        8MJn/qwBEEXdmTeMPuDyjBiqu8=; b=KH1US8wxMBCILLZ6ty3BaJ2tV/2O9oRsi
        08QD/dfXXfm3fC/uJd17Pv1GGfVKOXEnhp4AFjgx5Xov2ABnk9jbAXC6kCJh9jwj
        hrvo5DDyN3LvA7HZnBNu7fSxbiYQ+K08fSzoC6G0uSqctI2aGfeA50taMA8DYoAI
        6BF8d3W9ZMNsfCaf6WmMzJlFzrLMhckRU93HefIhFcKcayCnDIMJtBoHrATybMNN
        4I7XvoLe3w+xWnNe/Sug5kajNiQgxQgHFTSTYVjsJDxBPWKUXO9f48Ygk81B33hz
        8zdISoje0lFK2tgUhXhHxXTOdhmu3e0O2TJWfE6b2PJgBmwETkyGg==
X-ME-Sender: <xms:uON8YAWgK5i7rQlNEtmio4Lelx8D9w9Wv5yrzX-6YCvppeqGrZSzmA>
    <xme:uON8YEm86R4wsse4rcVNqiR03KYzWjuJQPQ6PVdxS5_JZ1PrfD2WDzKq8G1GKAkGb
    yRjACLsgEtrXqY9eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:uON8YEYZWwHiQXYs3D6rKM1eDnh69UhvlozdI_SybkpYss8Nz-wwtQ>
    <xmx:uON8YPUS6rEaKayToLsV2xKtdUWsj5UmxXVGHaLddBblMbaQSg5wNg>
    <xmx:uON8YKn00Tnwc7E6OvHALdBPReQe3sChut364cafuQrdL7dstwYG2Q>
    <xmx:ueN8YBsiZPR6Eqp40vTpp0EidfGjP64XoPkggXEydqy2-_FyyQ5N9g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C806624005B;
        Sun, 18 Apr 2021 21:58:15 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH] nvmem: sunxi_sid: Set type to OTP
Date:   Sun, 18 Apr 2021 20:58:15 -0500
Message-Id: <20210419015815.38910-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device currently reports an "Unknown" type in sysfs.
Since it is an eFuse hardware device, set its type to OTP.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/nvmem/sunxi_sid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index e26ef1bbf198..275b9155e473 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -142,6 +142,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 
 	nvmem_cfg->dev = dev;
 	nvmem_cfg->name = "sunxi-sid";
+	nvmem_cfg->type = NVMEM_TYPE_OTP;
 	nvmem_cfg->read_only = true;
 	nvmem_cfg->size = cfg->size;
 	nvmem_cfg->word_size = 1;
-- 
2.26.3

