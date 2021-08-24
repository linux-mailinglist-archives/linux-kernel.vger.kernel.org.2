Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB293F5BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhHXKRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:17:15 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:53512 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbhHXKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:17:13 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7E506D76D2;
        Tue, 24 Aug 2021 18:16:16 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32763T139760989173504S1629800174340042_;
        Tue, 24 Aug 2021 18:16:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c20bd0ea4a871a28783e80ec160bcf30>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     broonie@kernel.org, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] ASoC: rockchip: spdif: Mark SPDIF_SMPDR as volatile
Date:   Tue, 24 Aug 2021 18:15:59 +0800
Message-Id: <1629800162-12824-2-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks SPDIF_SMPDR as volatile to make it resaonable,
which also requires marking it as readable, even though it isn't.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_spdif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 73226a4..8baa473 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -247,6 +247,7 @@ static bool rk_spdif_rd_reg(struct device *dev, unsigned int reg)
 	case SPDIF_INTCR:
 	case SPDIF_INTSR:
 	case SPDIF_XFER:
+	case SPDIF_SMPDR:
 		return true;
 	default:
 		return false;
@@ -258,6 +259,7 @@ static bool rk_spdif_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case SPDIF_INTSR:
 	case SPDIF_SDBLR:
+	case SPDIF_SMPDR:
 		return true;
 	default:
 		return false;
-- 
2.7.4



