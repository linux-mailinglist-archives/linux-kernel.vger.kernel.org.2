Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429163B8FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhGAJnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:43:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60766 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhGAJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:43:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EA4F71F43DDA
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Bilal Wasim <Bilal.Wasim@imgtec.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH 2/3] soc: mediatek: pm-domains: Add domain_supply cap for mfg_async PD
Date:   Thu,  1 Jul 2021 11:40:23 +0200
Message-Id: <20210701114012.RESEND.2.I2e1bf1b589f9138ba6f89791ed9f1e9f3ddd0a5d@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701094024.1273759-1-enric.balletbo@collabora.com>
References: <20210701094024.1273759-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bilal Wasim <Bilal.Wasim@imgtec.com>

The mfg_async power domain in mt8173 is used to power up imgtec
gpu. This domain requires the da9211 regulator to be enabled before
the power domain can be enabled successfully.

Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mt8173-pm-domains.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
index 654c717e5467..714fa92575df 100644
--- a/drivers/soc/mediatek/mt8173-pm-domains.h
+++ b/drivers/soc/mediatek/mt8173-pm-domains.h
@@ -71,6 +71,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = 0,
+		.caps = MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8173_POWER_DOMAIN_MFG_2D] = {
 		.name = "mfg_2d",
-- 
2.30.2

