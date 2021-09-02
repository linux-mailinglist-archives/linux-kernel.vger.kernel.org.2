Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6753FF797
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348034AbhIBXEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:04:40 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54511 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347937AbhIBXEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:04:39 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DA9DD3200A07;
        Thu,  2 Sep 2021 19:03:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Sep 2021 19:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=rspByYKuMKIepMHyyNh663Mha1
        e5KFmbBZesXve1h4E=; b=Y0cL7CLS5ViYIqVAo05a015lr+HQYQsd7VYzXNNKWa
        13TZkpDQHih598d6KPLoKVum/DwLmsNGRapKyAVrBnhwDoNo+JEVw770Zj166qIB
        U0OKv2Rt2xR1lSVhV7TjxPoRIa18Xuw9b09ytUuVwmOvbmDrAjeeB/lJqufaJOyb
        ybXI8sybibSFVNXkQACgvAx9gfsoUo9j4G5ritP8Z1GYAJ3i0yNSOWFStkftCKNu
        X8qhFUFjTgVojrNNK7lWzQv909GXhmuyzLRcTwuI++gv1nWWZtzX9ncT3y2S5INm
        yRJI23pveKJ9b2mHw8qCzweArmNVuEM9m08CY0TBdPXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rspByYKuMKIepMHyy
        Nh663Mha1e5KFmbBZesXve1h4E=; b=CkF45+BL10r7keKriqqtoCKGjGVFBfZBb
        qdl+9Ib3UQllupWcKAtr4yQKgw2i0boSqWvwgJjgS9H9OUyNPD2tjoJy29MtNGk1
        UA6VHuYXnMKB7dnY1rCg19oK6LDK94iI0Z8ywRzqQAMFWgXZqxAblyfgsWGpnBHC
        3ifLwumOB3XF6UPTbbeXtfe03cJhFOX8rNyr+Ow8lJOrPowjwleZFasIcJlEpc3i
        Dg++0kDMXyYJq7U/kes5WkZcK1VTozFb5LQAmCvf2P35x7Oib+LxBoZzIOc+NMA/
        29RyA7r6pVEaorlQygb41Tad5sCKwP4Xny87KKNYMBQPB2ga7Xftw==
X-ME-Sender: <xms:SVgxYcFm20vkwbW6gMdojwYOz7k5g2cDhWP83A50KnTx09c0Lr2jfg>
    <xme:SVgxYVVCnsqAMbzBj_ZkdoPipltGve0GX8Uy4gq4Fy5y76MkPtuKV5Ud3VGrVyxOg
    352_8BwMr3gNgFDPw>
X-ME-Received: <xmr:SVgxYWL0tkhYI8macrYRFtCVr3dsm8Ifoh7epl5jjuzPPpB3kLNOBIDQpiAWookF6J-wrY0rZRx8knry96mqtU7X6XlKSdO0oyID1gpxEsXpFJi3zizXWUiAJVpz4JzqIwgh6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddviedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:SVgxYeGFseDuPO56Agdscq92y1TtaNcuKvK-rVl4mli1RNHJnT0XWA>
    <xmx:SVgxYSXrje8pi8NUOvIYTGy9Qc5_N3ZAC1fTHaqES62y1JY81vKyOw>
    <xmx:SVgxYRP5st2ki9bEpabsK0VLPEQ6cof0Ma0TuRigoefvNKRR82anfg>
    <xmx:S1gxYWq5c5iX9-rfuhttO7AuPCX7G5gPfL15kkEpeqjjQ6mqpPwSaw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Sep 2021 19:03:37 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] clk: sunxi-ng: mux: Remove unused 'reg' field
Date:   Thu,  2 Sep 2021 18:03:36 -0500
Message-Id: <20210902230336.29745-1-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses 'reg' from 'struct ccu_common' everywhere, so this
duplicate field is unused and unnecessary. Remove it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu_mux.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index f165395effb5..e31efc509b3d 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -40,7 +40,6 @@ struct ccu_mux_internal {
 	_SUNXI_CCU_MUX_TABLE(_shift, _width, NULL)
 
 struct ccu_mux {
-	u16			reg;
 	u32			enable;
 
 	struct ccu_mux_internal	mux;
-- 
2.31.1

