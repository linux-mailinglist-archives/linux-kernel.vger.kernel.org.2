Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A5328899
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 18:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhCARnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 12:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234851AbhCAQ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:29:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D63C64F46;
        Mon,  1 Mar 2021 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614615753;
        bh=B+Ld0XuKyVjKXlX3fFzNOv4ZOKWwL/kfxhdI4wPMwww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZWP3nxmmp/xJAWb60kXMMZtM939WEhLn2u+MVlD+ki28CouoJJOGaaaz0swnaHSk
         0BtG9KBNdCMo9YjYb9Ayx0h3U48tUbtK7Z7qxrbhqZ1UCPbidU98M6j/uAhV+VoFTG
         CadQoSfsH+Q/kZI+TgLvwmP7MInOtJxkKCTIBa5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 048/134] clk: meson: clk-pll: fix initializing the old rate (fallback) for a PLL
Date:   Mon,  1 Mar 2021 17:12:29 +0100
Message-Id: <20210301161015.936236949@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161013.585393984@linuxfoundation.org>
References: <20210301161013.585393984@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 2f290b7c67adf6459a17a4c978102af35cd62e4a ]

The "rate" parameter in meson_clk_pll_set_rate() contains the new rate.
Retrieve the old rate with clk_hw_get_rate() so we don't inifinitely try
to switch from the new rate to the same rate again.

Fixes: 7a29a869434e8b ("clk: meson: Add support for Meson clock controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20201226121556.975418-2-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 4adc1e89212c9..f9157e7f45f2d 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -145,7 +145,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (parent_rate == 0 || rate == 0)
 		return -EINVAL;
 
-	old_rate = rate;
+	old_rate = clk_hw_get_rate(hw);
 
 	rate_set = meson_clk_get_pll_settings(pll, rate);
 	if (!rate_set)
-- 
2.27.0



